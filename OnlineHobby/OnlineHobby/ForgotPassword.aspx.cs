using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            MsgSend.Visible = false;
            MsgError.Visible = false;


            con = new SqlConnection(strCon);
            //stud
            con.Open();
            string cmd = "Select * from Student where studEmail=@studEmail";
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            cmdSelect.Parameters.AddWithValue("@studEmail", txtFPEmail.Text);
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
            sda.Fill(dt);


            if (dt.Rows.Count != 0)
            {
                string myGUID = Guid.NewGuid().ToString();
                int UserId = Convert.ToInt32(dt.Rows[0][0]);
                string Email = dt.Rows[0][2].ToString();

                //pass user role 
                SqlCommand cmd1 = new SqlCommand("Insert into ForgotPassword values('" + myGUID + "','" + UserId + "','" + Email + "','Not Used')", con);
                cmd1.ExecuteNonQuery();

                string ToEmailAddress = dt.Rows[0][2].ToString();
                string UserName = dt.Rows[0][1].ToString();
                string EmailBody = "Dear " + UserName + ",<br/><br/>Please click the link below to reset your password.<br/> <br/> http://localhost:56927/ResetPassword.aspx?id=" + myGUID + "&role=" + "stud";

                MailMessage PassRecMail = new MailMessage("simhm-wm19@student.tarc.edu.my", ToEmailAddress);

                PassRecMail.Body = EmailBody;
                PassRecMail.IsBodyHtml = true;
                PassRecMail.Subject = "ReLife Password Reset";

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
                con.Close();
                MsgSend.Visible = true;
                //Response.Write("<script>alert('Reset password link has been sent. Please check your inbox.');</script>");

            }
            else
            {
                //edu
                con.Close();
                con.Open();
                string cmd2 = "Select * from Educator where eduEmail=@eduEmail";
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                cmdSelect2.Parameters.AddWithValue("@eduEmail", txtFPEmail.Text);
                DataTable dt2 = new DataTable();
                SqlDataAdapter sda2 = new SqlDataAdapter(cmdSelect2);
                sda2.Fill(dt2);


                if (dt2.Rows.Count != 0)
                {
                    string myGUID = Guid.NewGuid().ToString();
                    int UserId = Convert.ToInt32(dt2.Rows[0][0]);
                    string Email = dt2.Rows[0][2].ToString();

                    SqlCommand cmd3 = new SqlCommand("Insert into ForgotPassword values('" + myGUID + "','" + UserId + "','" + Email + "','Not Used')", con);
                    cmd3.ExecuteNonQuery();

                    string ToEmailAddress = dt2.Rows[0][2].ToString();
                    string UserName = dt2.Rows[0][1].ToString();
                    string EmailBody = "Dear " + UserName + ",<br/><br/>Please click the link below to reset your password.<br/> <br/> http://localhost:56927/ResetPassword.aspx?id=" + myGUID + "&role=" + "edu";

                    MailMessage PassRecMail = new MailMessage("simhm-wm19@student.tarc.edu.my", ToEmailAddress);

                    PassRecMail.Body = EmailBody;
                    PassRecMail.IsBodyHtml = true;
                    PassRecMail.Subject = "ReLife Password Reset";

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
                    con.Close();
                    MsgSend.Visible = true;

                }
                else
                {
                    con.Close();
                    MsgError.Visible = true;
                }

            }
            con.Close();

        }
    }

}