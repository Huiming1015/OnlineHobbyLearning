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
    public partial class AddAchivement : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                if (!IsPostBack)
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);
                    string role = Session["Role"].ToString();

                    con = new SqlConnection(strCon);

                    if (role == "stud")
                    {
                        Response.Redirect("Profile.aspx");
                    }
                }

            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }
        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(achievementId),0) from Achievements", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgRequired.Visible = false;
            MsgSuccess.Visible = false;

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            if (txtTitle.Text != "" && txtIssueOrg.Text != "" && ddlMonth.SelectedItem.Text != "Month" && ddlYear.SelectedItem.Text != "Year" && txtCredentialURL.Text != "")
            {
                AutoGenerateUserID();

                con.Open();
                string cmd = "Insert into Achievements(achievementId, eduId, title, issueOrg, issueMonth, issueYear, credentialURL) Values('" + id + "', '" + UserId + "', '" + txtTitle.Text + "', '" + txtIssueOrg.Text + "', '" + ddlMonth.SelectedItem.Text + "', '" + ddlYear.SelectedItem.Text + "', '" + txtCredentialURL.Text + "')";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.ExecuteNonQuery();
                con.Close();

                MsgSuccess.Visible = true;
                clr();
            }
            else
            {
                MsgRequired.Visible = true;
            }


        }

        private void clr()
        {
            txtTitle.Text = "";
            txtIssueOrg.Text = "";
            ddlMonth.SelectedItem.Text = "Month";
            ddlYear.SelectedItem.Text = "Year";
            txtCredentialURL.Text = "";
        }
    }
}