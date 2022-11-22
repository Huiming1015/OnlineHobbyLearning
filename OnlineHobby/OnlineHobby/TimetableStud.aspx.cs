﻿using System;
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
    public partial class TimetableStud : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlDate.Items.Add(new ListItem(DateTime.Today.ToShortDateString(), DateTime.Today.ToShortDateString()));
                List<ListItem> items = new List<ListItem>();
                con = new SqlConnection(strCon);
                con.Open();
                string strQ = "Select Distinct ScheduleList.date from ScheduleList INNER JOIN CourseSchedule ON ScheduleList.scheduleId = CourseSchedule.scheduleId INNER JOIN EnrolDetails ON EnrolDetails.scheduleId = CourseSchedule.scheduleId INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId = EnrolledCourse.enrollmentId WHERE (EnrolledCourse.studId = '" + Session["UserId"] + "') AND (EnrolDetails.enrolStatus!='Withdrew')";
                SqlCommand com = new SqlCommand(strQ, con);
                SqlDataReader dr = com.ExecuteReader();
                if (dr.HasRows)
                {
                    int i = 0;
                    while (dr.Read())
                    {
                        string dateSchedule = Convert.ToDateTime(dr["date"]).ToShortDateString();
                        if (Convert.ToDateTime(dateSchedule) > DateTime.Today)
                        {
                            ddlDate.Items.Add(new ListItem(dateSchedule, dateSchedule));
                            i++;
                        }
                    }
                }
                dr.Close();
                con.Close();
                ChangeTimetable();
            }
        }

        protected void btnMyCourse_Click(object sender, EventArgs e)
        {
            Response.Redirect("EnrolledCourseList.aspx");
        }

        protected void gvEnrolledList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "join")
            {
                Response.Redirect(e.CommandArgument.ToString());

            }
        }

        private void ChangeTimetable()
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQBind = "SELECT ScheduleList.startTime, ScheduleList.endTime, CourseSchedule.meetingLink, Course.courseName, CourseSchedule.scheduleId FROM CourseSchedule INNER JOIN EnrolDetails ON CourseSchedule.scheduleId = EnrolDetails.scheduleId INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId = EnrolledCourse.enrollmentId INNER JOIN ScheduleList ON CourseSchedule.scheduleId = ScheduleList.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId WHERE (EnrolledCourse.studId = @StudId) AND (ScheduleList.date=@Date) AND EnrolDetails.enrolStatus!='Withdrew'";
            SqlCommand comBind = new SqlCommand(strQBind, con);
            comBind.Parameters.AddWithValue("@StudId", Session["UserId"]);
            comBind.Parameters.AddWithValue("@Date", ddlDate.SelectedItem.Text.ToString());
            SqlDataAdapter adpt = new SqlDataAdapter(comBind);
            DataTable dt = new DataTable();
            adpt.Fill(dt);
            gvEnrolledList.DataSource = dt;
            gvEnrolledList.DataBind();
            con.Close();

            if (gvEnrolledList.Rows.Count <= 0)
            {
                lblNoClass.Visible = true;
                gvEnrolledList.Visible = false;
            }
            else
            {
                lblNoClass.Visible = false;
                gvEnrolledList.Visible = true;
            }
        }

        protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e)
        {
            ChangeTimetable();
        }
    }
}