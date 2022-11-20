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
    public partial class ViewStudNameList : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        String courseId;
        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Request.QueryString["courseId"].ToString();

            if (!IsPostBack)
            {
                lblCourseId.Text = "Course ID : " + courseId;
                con = new SqlConnection(strCon);
                con.Open();
                string strQ = "SELECT TOP 1 scheduleId FROM CourseSchedule WHERE courseId=@CourseId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@CourseId", courseId);
                string scheduleId = com.ExecuteScalar().ToString();
                con.Close();

                showNameList(scheduleId);

            }
        }

        protected void dlSchedule_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                string scheduleId = e.CommandArgument.ToString();
                showNameList(scheduleId);
            }
        }

        private void showNameList(string scheduleId)
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQNameList = "SELECT Student.studId, Student.studName, Student.studEmail FROM Student INNER JOIN EnrolledCourse ON Student.studId = EnrolledCourse.studId INNER JOIN EnrolDetails ON EnrolledCourse.enrollmentId = EnrolDetails.enrollmentId WHERE(EnrolDetails.scheduleId = @ScheduleId) AND (EnrolDetails.enrolStatus!='Withdrew')";
            SqlCommand comNameList = new SqlCommand(strQNameList, con);
            comNameList.Parameters.AddWithValue("@ScheduleId", scheduleId);
            SqlDataAdapter adpt = new SqlDataAdapter(comNameList);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            gvNameList.DataSource = dt;
            gvNameList.DataBind();
            con.Close();
        }
    }
}