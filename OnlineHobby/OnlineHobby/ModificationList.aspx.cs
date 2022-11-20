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
    public partial class ModificationList : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChangeList();
            }
        }

        protected void btnTimetable_Click(object sender, EventArgs e)
        {
            Response.Redirect("TimetableEdu.aspx");
        }

        protected void gvModification_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("ModificationDetails.aspx?modificationId=" + e.CommandArgument.ToString());
            }
        }

        private void ChangeList()
        {
            con = new SqlConnection(strCon);
            if (ddlStatus.SelectedItem.Text.ToString() != "All")
            {

                con.Open();
                string strQ = "SELECT ModificationRequest.modificationId, ModificationRequest.modificationStatus, Course.courseName FROM ModificationRequest INNER JOIN ScheduleList ON ModificationRequest.scheduleListId = ScheduleList.scheduleListId INNER JOIN CourseSchedule ON ScheduleList.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId WHERE (Course.eduId = @EduId) AND (ModificationRequest.modificationStatus=@ModificationStatus)";
                SqlCommand comBind = new SqlCommand(strQ, con);
                comBind.Parameters.AddWithValue("@EduId", Session["UserId"]);
                comBind.Parameters.AddWithValue("@ModificationStatus", ddlStatus.SelectedItem.Text.ToString());
                SqlDataAdapter adpt = new SqlDataAdapter(comBind);
                DataTable dt = new DataTable();
                adpt.Fill(dt);
                gvModification.DataSource = dt;
                gvModification.DataBind();
                con.Close();
            }
            else
            {
                con.Open();
                string strQ = "SELECT ModificationRequest.modificationId, ModificationRequest.modificationStatus, Course.courseName FROM ModificationRequest INNER JOIN ScheduleList ON ModificationRequest.scheduleListId = ScheduleList.scheduleListId INNER JOIN CourseSchedule ON ScheduleList.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId WHERE (Course.eduId = @EduId)";
                SqlCommand comBind = new SqlCommand(strQ, con);
                comBind.Parameters.AddWithValue("@EduId", Session["UserId"]);
                SqlDataAdapter adpt = new SqlDataAdapter(comBind);
                DataTable dt = new DataTable();
                adpt.Fill(dt);
                gvModification.DataSource = dt;
                gvModification.DataBind();
                con.Close();
            }

        }

        protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            ChangeList();
        }
    }
}