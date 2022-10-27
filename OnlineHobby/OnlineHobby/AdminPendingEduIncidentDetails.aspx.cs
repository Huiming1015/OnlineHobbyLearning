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
    public partial class AdminPendingEduIncidentDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] != null)
            {
                con = new SqlConnection(strCon);

                con.Open();
                string cmd = "Select complaintId,dateComplaint,studId,studName,eduId,eduName,incidentType,description from Complaint where complaintId =" + Request.QueryString["id"];
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                SqlDataReader dr = cmdSelect.ExecuteReader();
                while (dr.Read())
                {
                    lblComplaintId.Text = dr.GetValue(0).ToString();
                    lblIncidentDate.Text = dr.GetValue(1).ToString();
                    lblStudId.Text = dr.GetValue(2).ToString();
                    lblStudName.Text = dr.GetValue(3).ToString();
                    lblEduId.Text = dr.GetValue(4).ToString();
                    lblEduName.Text = dr.GetValue(5).ToString();
                    lblIncidentType.Text = dr.GetValue(6).ToString();
                    lblDesc.Text = dr.GetValue(7).ToString();


                }
                con.Close();
            }
            else
            {
                Response.Redirect("AdminLogin.aspx");
            }
               
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminPendingEduIncident.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgRequired.Visible = false;

            Int64 AdminId = Convert.ToInt64(Session["AdminId"]);

            DateTime now = DateTime.Now;

            if (rblApprovalAction.SelectedIndex != -1)
            {
                if (rblApprovalAction.SelectedValue == "Approve")
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string cmd = "Update Complaint set dateApproval=@date,apprStatus=@status,adminId=@adminId where complaintId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@date", now);
                    cmdSelect.Parameters.AddWithValue("@status", rblApprovalAction.SelectedValue);
                    cmdSelect.Parameters.AddWithValue("@adminId", AdminId);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();

                    con.Open();
                    string cmd2 = "Update Educator set status=@status where eduId =" + Convert.ToInt64(lblEduId.Text);
                    SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                    cmdSelect2.Parameters.AddWithValue("@status", "inactive");
                    cmdSelect2.ExecuteNonQuery();
                    con.Close();

                    Response.Redirect("AdminCompletedEduIncident.aspx");
                }
                else
                {
                    con.Open();
                    string cmd = "Update Complaint set dateApproval=@date,apprStatus=@status,adminId=@adminId where complaintId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@date", now);
                    cmdSelect.Parameters.AddWithValue("@status", rblApprovalAction.SelectedValue);
                    cmdSelect.Parameters.AddWithValue("@adminId", AdminId);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();

                    Response.Redirect("AdminCompletedEduIncident.aspx");
                }
            }
            else
            {
                MsgRequired.Visible = true;
            }
        }
    }
}