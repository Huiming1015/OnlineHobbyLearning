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
    public partial class AdminCompletedEduSignUpDetails : System.Web.UI.Page
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
                string cmd = "Select eduAppId,eduName,eduEmail,courseCategory,teachingExperience,driveLink,dateApproval,apprStatus,adminId from EduApplication where eduAppId =" + Request.QueryString["id"];
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                SqlDataReader dr = cmdSelect.ExecuteReader();
                while (dr.Read())
                {
                    lblAppId.Text = dr.GetValue(0).ToString();
                    lblName.Text = dr.GetValue(1).ToString();
                    lblEmail.Text = dr.GetValue(2).ToString();
                    lblCategory.Text = dr.GetValue(3).ToString();
                    lblTeaching.Text = dr.GetValue(4).ToString();
                    lblQualification.Text = dr.GetValue(5).ToString();
                    lblDate.Text = dr.GetValue(6).ToString();
                    status = dr.GetValue(7).ToString();
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

                    adminId = dr.GetValue(8).ToString();


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
            Response.Redirect("AdminCompletedEduSignUp.aspx");
        }
    }
}