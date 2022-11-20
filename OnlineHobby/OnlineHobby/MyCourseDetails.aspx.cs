using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class MyCourseDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con2;
        string strCon2 = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        String strScheduleId, strEnrolDetailId;
        protected void Page_Load(object sender, EventArgs e)
        {
            strEnrolDetailId = Request.QueryString["enrolDetailId"].ToString();
            foreach (DataListItem dl in dlCourseInfo.Items)
            {
                Label lblScheduleId = dl.FindControl("lblScheduleId") as Label;
                Label lblCourseId = dl.FindControl("lblCourseId") as Label;
                strScheduleId = lblScheduleId.Text.ToString();
                Session["courseId"] = lblCourseId.Text.ToString();
            }
        }

        protected void btnWithdraw_Click(object sender, EventArgs e)
        {
            DateTime date;
            double price;
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                con = new SqlConnection(strCon);
                con.Open();
                string strQ = "SELECT TOP 1 ScheduleList.date FROM ScheduleList WHERE scheduleId=@ScheduleId";
                SqlCommand comCourse = new SqlCommand(strQ, con);
                comCourse.Parameters.AddWithValue("@ScheduleId", strScheduleId);
                date = Convert.ToDateTime(comCourse.ExecuteScalar());
                con.Close();

                con = new SqlConnection(strCon);
                con.Open();
                string strQPrice = "SELECT EnrolDetails.unitPrice FROM EnrolDetails INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId=EnrolledCourse.enrollmentId WHERE EnrolledCourse.studId=@StudId AND EnrolDetails.scheduleId=@ScheduleId";
                SqlCommand comPrice = new SqlCommand(strQPrice, con);
                comPrice.Parameters.AddWithValue("@StudId", Session["UserId"]);
                comPrice.Parameters.AddWithValue("@ScheduleId", strScheduleId);
                price = Convert.ToDouble(comPrice.ExecuteScalar());
                con.Close();

                if (date <= DateTime.Today.AddDays(14))
                {
                    MsgBox("Sorry, you can only withdraw the course before two weeks of the course begin!", this.Page, this);
                }
                else
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string strQEnrolDetails = "UPDATE EnrolDetails SET enrolStatus='Withdrew' WHERE scheduleId=@ScheduleId";
                    SqlCommand com = new SqlCommand(strQEnrolDetails, con);
                    com.Parameters.AddWithValue("@ScheduleId", strScheduleId);
                    int j = com.ExecuteNonQuery();
                    con.Close();

                    con = new SqlConnection(strCon);
                    con.Open();
                    string strQCourseSchedule = "UPDATE CourseSchedule SET numEnrolled=numEnrolled-1 WHERE scheduleId=@ScheduleId";
                    SqlCommand com2 = new SqlCommand(strQCourseSchedule, con);
                    com2.Parameters.AddWithValue("@ScheduleId", strScheduleId);
                    int k = com2.ExecuteNonQuery();
                    con.Close();

                    con = new SqlConnection(strCon);
                    con.Open();
                    string strQPayment = "UPDATE Payment SET Payment.refundAmount=Payment.refundAmount+@Price FROM Payment INNER JOIN EnrolledCourse ON Payment.paymentId = EnrolledCourse.paymentId INNER JOIN EnrolDetails ON EnrolledCourse.enrollmentId = EnrolDetails.enrollmentId WHERE EnrolledCourse.StudId=@StudId AND EnrolDetails.scheduleId=@ScheduleId";
                    SqlCommand com3 = new SqlCommand(strQPayment, con);
                    com3.Parameters.AddWithValue("@StudId", Session["UserId"]);
                    com3.Parameters.AddWithValue("@ScheduleId", strScheduleId);
                    com3.Parameters.AddWithValue("@Price", price);
                    int l = com3.ExecuteNonQuery();
                    con.Close();

                    if (j != 0 && k != 0 && l != 0)
                    {
                        MsgBox("The course has been successfully withdrew!", this.Page, this);
                    }
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

        protected void dlCourseInfo_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblEnrolStatus = e.Item.FindControl("lblEnrolStatus") as Label;
                Label lblCourseId = e.Item.FindControl("lblCourseId") as Label;
                Label lblScheduleId = e.Item.FindControl("lblScheduleId") as Label;
                //GridView gvScheduleList = e.Item.FindControl("gvScheduleList") as GridView;

                con = new SqlConnection(strCon);
                //con2 = new SqlConnection(strCon2);
                //con2.Open();
                //string strQ1 = "SELECT scheduleListId FROM ModificationRequest WHERE enrolDetailId=@EnrolDetailId";
                //SqlCommand com1 = new SqlCommand(strQ1, con2);
                //com1.Parameters.AddWithValue("@EnrolDetailId", strEnrolDetailId);
                //SqlDataReader dr1 = com1.ExecuteReader();
                //if (dr1.HasRows)
                //{
                //    while (dr1.Read())
                //    {
                //        con.Open();
                //        string strQBind = "SELECT scheduleListId, startTime, endTime, date FROM ScheduleList WHERE scheduleId=@ScheduleId AND scheduleListId!=@ScheduleListId union select M.scheduleListId as scheduleListId, M.newStartTime as startTime, M.newEndTime as endTime, M.newDate as date from ModificationRequest M INNER JOIN EnrolDetails E ON M.enrolDetailId = E.enrolDetailId WHERE M.scheduleListId = @ScheduleListId AND E.scheduleId = @ScheduleId AND E.enrolDetailId = @EnrolDetailId";
                //        SqlCommand comBind = new SqlCommand(strQBind, con);
                //        comBind.Parameters.AddWithValue("@ScheduleId", lblScheduleId.Text.ToString());
                //        comBind.Parameters.AddWithValue("@ScheduleListId", dr1["scheduleListId"].ToString());
                //        comBind.Parameters.AddWithValue("@EnrolDetailId", strEnrolDetailId);
                //        SqlDataAdapter adpt = new SqlDataAdapter(comBind);
                //        DataTable dt = new DataTable();
                //        adpt.Fill(dt);
                //        gvScheduleList.DataSource = dt;
                //        gvScheduleList.DataBind();
                //        con.Close();
                //    }
                //}
                //else
                //{
                //    con.Open();
                //    string strQBind = "SELECT scheduleListId, startTime, endTime, date FROM ScheduleList WHERE scheduleId=@ScheduleId";
                //    SqlCommand comBind = new SqlCommand(strQBind, con);
                //    comBind.Parameters.AddWithValue("@ScheduleId", lblScheduleId.Text.ToString());
                //    SqlDataAdapter adpt = new SqlDataAdapter(comBind);
                //    DataTable dt = new DataTable();
                //    adpt.Fill(dt);
                //    gvScheduleList.DataSource = dt;
                //    gvScheduleList.DataBind();
                //    con.Close();
                //}
                //con2.Close();


                if (lblEnrolStatus.Text == "Withdrew" || lblEnrolStatus.Text == "Completed" || lblEnrolStatus.Text == "Cancelled")
                {
                    btnWithdraw.Visible = false;
                    btnModify.Visible = false;
                }
                if (lblEnrolStatus.Text == "Completed" && Session["Role"].ToString() == "stud")
                {
                    string strRate = "Rating : ";
                    string strComment = "Comment: ";
                    con.Open();
                    string cmd2 = "Select * from CourseRating WHERE studId=@StudId AND enrolDetailsId=@EnrolDetailsId";
                    SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                    cmdSelect2.Parameters.AddWithValue("@studId", Session["UserId"]);
                    cmdSelect2.Parameters.AddWithValue("@EnrolDetailsId", Session["enrolDetailsId"].ToString());
                    SqlDataReader dr = cmdSelect2.ExecuteReader();
                    if (dr.HasRows)
                    {
                        btnRate.Visible = false;
                        lblRate.Visible = true;
                        lblComment.Visible = true;
                        while (dr.Read())
                        {
                            lblRate.Text = strRate + dr["rating"].ToString();
                            lblComment.Text = strComment + dr["comment"].ToString();
                        }
                    }
                    else
                    {
                        btnRate.Visible = true;
                    }
                    dr.Close();
                    con.Close();
                }
                else
                {
                    btnRate.Visible = false;
                }
            }
        }

    }
}