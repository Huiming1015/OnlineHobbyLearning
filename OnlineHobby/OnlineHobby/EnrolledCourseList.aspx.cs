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
    public partial class EnrolledCourseList : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        Int64 UserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserId = Convert.ToInt64(Session["UserId"]);
            if (!IsPostBack)
            {
                showAll();
            }
        }

        protected void gvEnrolledList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Session["enrolDetailsId"] = e.CommandArgument.ToString();
                Response.Redirect("MyCourseDetails.aspx?enrolDetailId=" + e.CommandArgument.ToString());
            }
        }

        protected void btnTimetable_Click(object sender, EventArgs e)
        {
            Response.Redirect("TimetableStud.aspx");
        }

        protected void ddlEnrolStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlEnrolStatus.SelectedValue.ToString() == "All")
            {
                showAll();
            }
            else
            {
                showCourseList(ddlEnrolStatus.SelectedValue.ToString());
            }
        }

        private void showCourseList(string enrolStatus)
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "SELECT EnrolDetails.enrolDetailId, CourseSchedule.day, Course.courseName, Educator.eduName, Course.courseImage, EnrolDetails.scheduleId FROM EnrolDetails INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId = EnrolledCourse.enrollmentId INNER JOIN CourseSchedule ON EnrolDetails.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON Course.courseId = CourseSchedule.courseId INNER JOIN Educator ON Course.eduId = Educator.eduId WHERE (EnrolledCourse.studId = @StudId) AND (EnrolDetails.enrolStatus=@EnrolStatus)";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@StudId", UserId);
            com.Parameters.AddWithValue("@EnrolStatus", enrolStatus);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvEnrolledList.DataSource = ds;
            gvEnrolledList.DataBind();
            con.Close();
        }

        private void showAll()
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "SELECT EnrolDetails.enrolDetailId, CourseSchedule.day, Course.courseName, Educator.eduName, Course.courseImage, EnrolDetails.scheduleId FROM EnrolDetails INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId = EnrolledCourse.enrollmentId INNER JOIN CourseSchedule ON EnrolDetails.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON Course.courseId = CourseSchedule.courseId INNER JOIN Educator ON Course.eduId = Educator.eduId WHERE (EnrolledCourse.studId = @StudId)";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@StudId", UserId);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvEnrolledList.DataSource = ds;
            gvEnrolledList.DataBind();
            con.Close();
        }
    }
}