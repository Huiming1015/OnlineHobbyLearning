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
    public partial class ModificationDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con2;
        string strCon2 = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void dlModification_ItemCommand(object source, DataListCommandEventArgs e)
        {
            con = new SqlConnection(strCon);
            con2 = new SqlConnection(strCon2);
            if (e.CommandName == "approve")
            {
                try
                {
                    string strQModify, toEmailStud = "", toEmailEdu = "", date = "", startTime = "", endTime = "", meetingLink = "";
                    con.Open();
                    strQModify = "UPDATE ModificationRequest SET modificationStatus='Approved' WHERE modificationId=@ModificationId";
                    SqlCommand comModify = new SqlCommand(strQModify, con);
                    comModify.Parameters.AddWithValue("@ModificationId", e.CommandArgument.ToString());
                    int k = comModify.ExecuteNonQuery();

                    if (k != 0)
                    {
                        con2.Open();
                        string strQSelect = "Select M.newDate, M.newStartTime, M.newEndTime, S.studEmail, CS.meetingLink FROM ModificationRequest M INNER JOIN EnrolDetails ED ON M.enrolDetailId=ED.enrolDetailId INNER JOIN EnrolledCourse EC ON ED.enrollmentId=EC.enrollmentId INNER JOIN Student S ON EC.studId=S.studId INNER JOIN ScheduleList SL ON M.scheduleListId=SL.scheduleListId INNER JOIN CourseSchedule CS ON SL.scheduleId=CS.scheduleId WHERE modificationId=@ModificationId";
                        SqlCommand comSelect = new SqlCommand(strQSelect, con2);
                        comSelect.Parameters.AddWithValue("@ModificationId", e.CommandArgument.ToString());
                        SqlDataReader dr = comSelect.ExecuteReader();
                        while (dr.Read())
                        {
                            toEmailStud = dr["studEmail"].ToString();
                            date = Convert.ToDateTime(dr["newDate"].ToString()).ToShortDateString();
                            startTime = Convert.ToDateTime(dr["newStartTime"].ToString()).ToShortTimeString();
                            endTime = Convert.ToDateTime(dr["newEndTime"].ToString()).ToShortTimeString();
                            meetingLink = dr["meetingLink"].ToString();
                        }
                        dr.Close();
                        con2.Close();

                        con2.Open();
                        string strQSelect2 = "Select eduEmail from Educator WHERE eduId='" + Session["UserId"] + "'";
                        SqlCommand comSelect2 = new SqlCommand(strQSelect2, con2);
                        SqlDataReader dr2 = comSelect2.ExecuteReader();
                        while (dr2.Read())
                        {
                            toEmailEdu = dr2["eduEmail"].ToString();
                        }
                        dr.Close();
                        con2.Close();
                        string EmailBody = "Dear student and educator:<br/><br/>The timetable modification request have been approved by the educator.<br/>Below is the new meeting information: <br/> <br/>   Date: " + date.ToString() + "<br/>   Time: " + startTime.ToString() + " to " + endTime.ToString() + "<br/>   Meeting Link: " + meetingLink.ToString();

                        MailMessage PassRecMail = new MailMessage();
                        PassRecMail.From = new MailAddress("simhm-wm19@student.tarc.edu.my", "ReLife");
                        PassRecMail.To.Add(new MailAddress(toEmailStud));
                        PassRecMail.To.Add(new MailAddress(toEmailEdu));

                        PassRecMail.Body = EmailBody;
                        PassRecMail.IsBodyHtml = true;
                        PassRecMail.Subject = "Timetable Modified Successfully";

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
                        MsgBox("The modification request has been approved successfully!", this.Page, this);
                        Response.Redirect("ModificationDetails.aspx?modificationId=" + e.CommandArgument.ToString());
                    }
                    con.Close();
                }
                catch
                {
                    MsgBox("The modification request approved unsuccessful!", this.Page, this);
                }
            }

            if (e.CommandName == "reject")
            {
                try
                {
                    string strQModify, toEmailStud = "";
                    con.Open();
                    strQModify = "UPDATE ModificationRequest SET modificationStatus='Rejected' WHERE modificationId=@ModificationId";
                    SqlCommand comModify = new SqlCommand(strQModify, con);
                    comModify.Parameters.AddWithValue("@ModificationId", e.CommandArgument.ToString());
                    int k = comModify.ExecuteNonQuery();

                    if (k != 0)
                    {
                        con2.Open();
                        string strQSelect = "Select S.studEmail FROM ModificationRequest M INNER JOIN EnrolDetails ED ON M.enrolDetailId=ED.enrolDetailId INNER JOIN EnrolledCourse EC ON ED.enrollmentId=EC.enrollmentId INNER JOIN Student S ON EC.studId=S.studId WHERE modificationId=@ModificationId";
                        SqlCommand comSelect = new SqlCommand(strQSelect, con2);
                        comSelect.Parameters.AddWithValue("@ModificationId", e.CommandArgument.ToString());
                        SqlDataReader dr = comSelect.ExecuteReader();
                        while (dr.Read())
                        {
                            toEmailStud = dr["studEmail"].ToString();
                        }
                        dr.Close();
                        con2.Close();

                        string EmailBody = "Dear student:<br/><br/>The timetable modification request have been rejected by the educator.<br/>You can communicate with the educator and send a modification request again.";

                        MailMessage PassRecMail = new MailMessage();
                        PassRecMail.From = new MailAddress("simhm-wm19@student.tarc.edu.my", "ReLife");
                        PassRecMail.To.Add(new MailAddress(toEmailStud));

                        PassRecMail.Body = EmailBody;
                        PassRecMail.IsBodyHtml = true;
                        PassRecMail.Subject = "Timetable Modified Unsuccessfully";

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
                        MsgBox("The modification request has been rejected successfully!", this.Page, this);
                        Response.Redirect("ModificationDetails.aspx?modificationId=" + e.CommandArgument.ToString());
                    }
                    con.Close();
                }
                catch
                {
                    MsgBox("The modification request rejected unsuccessful!", this.Page, this);
                }
            }
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        protected void dlModification_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblModificationStatus = e.Item.FindControl("lblModificationStatus") as Label;
                Button btnApprove = e.Item.FindControl("btnApprove") as Button;
                Button btnReject = e.Item.FindControl("btnReject") as Button;

                if (lblModificationStatus.Text.ToString() == "Pending")
                {
                    btnApprove.Visible = true;
                    btnReject.Visible = true;
                }
                else
                {
                    btnApprove.Visible = false;
                    btnReject.Visible = false;
                }
            }
        }
    }
}