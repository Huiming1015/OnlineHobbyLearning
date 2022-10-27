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
    public partial class AdminCompletedEduIncidentDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        string status;
        string adminId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] != null)
            {
                con = new SqlConnection(strCon);

                con.Open();
                string cmd = "Select complaintId,dateComplaint,studId,studName,eduId,eduName,incidentType,description,dateApproval,apprStatus,adminId from Complaint where complaintId =" + Request.QueryString["id"];
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
                    lblDate.Text = dr.GetValue(8).ToString();
                    status = dr.GetValue(9).ToString();
                    if (status == "Approve")
                    {
                        lblStatus.Text = "Approved";
                        lblStatus.CssClass = "badge badge-success";
                        lblApprovalPpl.Text = "Approved by:";
                        lblApprovalDate.Text = "Approved on:";
                    }
                    else
                    {
                        lblStatus.Text = "Rejected";
                        lblStatus.CssClass = "badge badge-danger";
                        lblApprovalPpl.Text = "Rejected by:";
                        lblApprovalDate.Text = "Rejected on:";
                    }

                    adminId = dr.GetValue(10).ToString();


                }
                con.Close();
                //get admin Name
                con.Open();
                string cmd2 = "Select adminName from Admin where adminId =" + adminId;
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                string adminName = cmdSelect2.ExecuteScalar().ToString();
                lblAdmin.Text = adminName.ToString();
                con.Close();
            }
            else
            {
                Response.Redirect("AdminLogin.aspx");
            }
              
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminCompletedEduIncident.aspx");
        }
    }
}