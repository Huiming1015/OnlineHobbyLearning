using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class AdminPendingEduSignUpDetails : System.Web.UI.Page
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
                string cmd = "Select eduAppId,eduName,eduEmail,courseCategory,teachingExperience,driveLink from EduApplication where eduAppId =" + Request.QueryString["id"];
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


                }
                con.Close();
            }
            else
            {
                Response.Redirect("AdminLogin.aspx");
            }
                
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgRequired.Visible = false;

            Int64 AdminId = Convert.ToInt64(Session["AdminId"]);

            DateTime now = DateTime.Now;
            //Response.Write("<script>alert('" + now + "') </script>");

            string name = lblName.Text;
            int index = name.IndexOf(' ');
            string result;

            if (index != -1)
            {
                result = name.Substring(0, index);
            }
            else
            {
                result = lblName.Text;
            }
            string tempPswd = result + "1234";
            string tempEmail = result.ToLower() + "@relife.com";
            string tempAbout = "Hi, I am " + name + ".";

            //Response.Write("<script>alert('" + tempPswd + tempEmail + "') </script>");

            if (rblApprovalAction.SelectedIndex != -1)
            {
                if (rblApprovalAction.SelectedValue == "Approve")
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string cmd = "Update EduApplication set dateApproval=@date,apprStatus=@status,adminId=@adminId where eduAppId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@date", now);
                    cmdSelect.Parameters.AddWithValue("@status", rblApprovalAction.SelectedValue);
                    cmdSelect.Parameters.AddWithValue("@adminId", AdminId);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();

                    AutoGenerateUserID();

                    con.Open();
                    string cmd2 = "Insert into Educator(eduId,eduName,eduEmail,eduPassword,joinedDate,courseCategory,about,status) Values(@id,@name,@email,@password,@date,@category,@about,@status)";
                    SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                    cmdSelect2.Parameters.AddWithValue("@id", id);
                    cmdSelect2.Parameters.AddWithValue("@name", lblName.Text);
                    cmdSelect2.Parameters.AddWithValue("@email", tempEmail);
                    cmdSelect2.Parameters.AddWithValue("@password", tempPswd);
                    cmdSelect2.Parameters.AddWithValue("@date", now);
                    cmdSelect2.Parameters.AddWithValue("@category", lblCategory.Text);
                    cmdSelect2.Parameters.AddWithValue("@about", tempAbout);
                    cmdSelect2.Parameters.AddWithValue("@status", "active");
                    cmdSelect2.ExecuteNonQuery();
                    con.Close();

                    string ToEmailAddress = lblEmail.Text;
                    string UserName = lblName.Text;
                    string EmailBody = "Dear " + UserName + ",<br/><br/>Congratulations! Your sign up application as a ReLife educator has been approved. <br/>The following is the login email and temporary password." +
                    "<br/><br/>Email Address: " + tempEmail + "<br/>Temporary Password: " + tempPswd + "<br/><br/>For security purpose, you are encouraged to create a new password once successfully signed in.<br/>Thank you. ";

                    MailMessage PassRecMail = new MailMessage();
                    PassRecMail.From = new MailAddress("simhm-wm19@student.tarc.edu.my", "ReLife");
                    PassRecMail.To.Add(new MailAddress(ToEmailAddress));

                    PassRecMail.Body = EmailBody;
                    PassRecMail.IsBodyHtml = true;
                    PassRecMail.Subject = "ReLife Educator Sign Up Application - Approved";

                    using (SmtpClient client = new SmtpClient())
                    {
                        client.EnableSsl = true;
                        client.UseDefaultCredentials = false;
                        client.Credentials = new NetworkCredential("simhm-wm19@student.tarc.edu.my", "simhm1015");
                        client.Host = "smtp.gmail.com";
                        client.Port = 587;
                        client.DeliveryMethod = SmtpDeliveryMethod.Network;

                        client.Send(PassRecMail);
                    }

                    Response.Redirect("AdminCompletedEduSignUp.aspx");
                }
                else
                {
                    con.Open();
                    string cmd = "Update EduApplication set dateApproval=@date,apprStatus=@status,adminId=@adminId where eduAppId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@date", now);
                    cmdSelect.Parameters.AddWithValue("@status", rblApprovalAction.SelectedValue);
                    cmdSelect.Parameters.AddWithValue("@adminId", AdminId);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();

                    string ToEmailAddress = lblEmail.Text;
                    string UserName = lblName.Text;
                    string EmailBody = "Dear " + UserName + ",<br/><br/>Thank you for taking the time to consider ReLife. Our team reviewed your application and we'd like to inform you that your sign up application as a ReLife educator has been rejected. " +
                                                           "Please ensure all the details are completed and correct before submitting. " + "<br/><br/>Please email to <b>relife.help@gmail.com</b> if you wish to communicate with us regarding the application.<br/>Thank you. ";

                    MailMessage PassRecMail = new MailMessage();
                    PassRecMail.From = new MailAddress("simhm-wm19@student.tarc.edu.my", "ReLife");
                    PassRecMail.To.Add(new MailAddress(ToEmailAddress));

                    PassRecMail.Body = EmailBody;
                    PassRecMail.IsBodyHtml = true;
                    PassRecMail.Subject = "ReLife Educator Sign Up Application - Rejected";

                    using (SmtpClient client = new SmtpClient())
                    {
                        client.EnableSsl = true;
                        client.UseDefaultCredentials = false;
                        client.Credentials = new NetworkCredential("simhm-wm19@student.tarc.edu.my", "simhm1015");
                        client.Host = "smtp.gmail.com";
                        client.Port = 587;
                        client.DeliveryMethod = SmtpDeliveryMethod.Network;

                        client.Send(PassRecMail);
                    }

                    Response.Redirect("AdminCompletedEduSignUp.aspx");
                }
            }
            else
            {
                MsgRequired.Visible = true;
            }
        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(eduId),0) from Educator", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminPendingEduSignUp.aspx");

        }
    }
}