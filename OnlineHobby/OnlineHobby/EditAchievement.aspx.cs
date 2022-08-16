using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class EditAchievement : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                if (!IsPostBack)
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);

                    con = new SqlConnection(strCon);

                    con.Open();
                    string cmd2 = "Select title,issueOrg,issueMonth,issueYear,credentialURL from Achievements where eduId =" + UserId + "and achievementId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                    SqlDataReader dr = cmdSelect2.ExecuteReader();
                    while (dr.Read())
                    {
                        txtTitle.Text = dr.GetValue(0).ToString();
                        txtIssueOrg.Text = dr.GetValue(1).ToString();
                        ddlMonth.SelectedItem.Text = dr.GetValue(2).ToString();
                        ddlYear.SelectedItem.Text = dr.GetValue(3).ToString();
                        txtCredentialURL.Text = dr.GetValue(4).ToString();
                    }
                }
            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgRequired.Visible = false;
            MsgSuccess.Visible = false;

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            if (txtTitle.Text != "" && txtIssueOrg.Text != "" && ddlMonth.SelectedItem.Text != "Month" && ddlYear.SelectedItem.Text != "Year" && txtCredentialURL.Text != "")
            {
                con.Open();
                string cmd = "Update Achievements set title=@title,issueOrg=@issueOrg,issueMonth=@issueMonth,issueYear=@issueYear,credentialURL=@credentialURL where eduId =" + UserId + "and achievementId =" + Request.QueryString["id"];
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@title", txtTitle.Text);
                cmdSelect.Parameters.AddWithValue("@issueOrg", txtIssueOrg.Text);
                cmdSelect.Parameters.AddWithValue("@issueMonth", ddlMonth.SelectedItem.Text);
                cmdSelect.Parameters.AddWithValue("@issueYear", ddlYear.SelectedItem.Text);
                cmdSelect.Parameters.AddWithValue("@credentialURL", txtCredentialURL.Text);
                cmdSelect.ExecuteNonQuery();
                con.Close();


                MsgSuccess.Visible = true;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);

            con = new SqlConnection(strCon);
            con.Open();
            string cmd = "Delete from Achievements  where eduId =" + UserId + "and achievementId =" + Request.QueryString["id"];
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            cmdSelect.ExecuteNonQuery();
            con.Close();

            Response.Redirect("Achievements.aspx");
        }
    }
}