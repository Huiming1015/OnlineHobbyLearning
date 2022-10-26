using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class SignUpEducator : System.Web.UI.Page
    {

        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(eduAppId),0) from EduApplication", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();
        }

        private void clr()
        {
            txtSUName.Text = "";
            txtSUEmail.Text = "";
            ddlSUCourse.SelectedIndex = -1;
            rblSUExperience.SelectedIndex = -1;
            txtSUQualification.Text = "";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgSuccess.Visible = false;
            MsgRequired.Visible = false;
            MsgSignUpFail.Visible = false;

            if (txtSUName.Text != "" && txtSUEmail.Text != "" && ddlSUCourse.SelectedIndex != -1 && rblSUExperience.SelectedIndex != -1 && txtSUQualification.Text != "")
            {
                con = new SqlConnection(strCon);
                con.Open();
                SqlCommand cmd = new SqlCommand("Select * from EduApplication where eduEmail=@Email", con);
                cmd.Parameters.AddWithValue("@Email", txtSUEmail.Text);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    MsgSignUpFail.Visible = true;
                }
                else
                {
                    AutoGenerateUserID();

                    con = new SqlConnection(strCon);
                    con.Open();
                    string cmd2 = "Insert into EduApplication(eduAppId,eduName,eduEmail,courseCategory,teachingExperience,driveLink,apprStatus) Values('" + id + "','" + txtSUName.Text + "','" + txtSUEmail.Text + "','" + ddlSUCourse.SelectedValue + "','" + rblSUExperience.SelectedValue + "','" + txtSUQualification.Text + "','" + "pending" + "')";
                    SqlCommand cmdSelect = new SqlCommand(cmd2, con);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();

                    string ToEmailAddress = txtSUEmail.Text;
                    string UserName = txtSUName.Text;
                    string EmailBody = "Dear " + UserName + ",<br/><br/>We have received your application and will be processing it soon.<br/>Please email to <b>relife.help@gmail.com</b> if you wish to communicate with us regarding the application.<br/>Thank you. ";

                    MailMessage PassRecMail = new MailMessage();
                    PassRecMail.From = new MailAddress("simhm-wm19@student.tarc.edu.my", "ReLife");
                    PassRecMail.To.Add(new MailAddress(ToEmailAddress));

                    PassRecMail.Body = EmailBody;
                    PassRecMail.IsBodyHtml = true;
                    PassRecMail.Subject = "ReLife Educator Sign Up Application - Received";

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

                    MsgSuccess.Visible = true;
                    clr();
                }

            }
            else
            {
                MsgRequired.Visible = true;
            }
        }
    }
}