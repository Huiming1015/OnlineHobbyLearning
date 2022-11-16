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
    public partial class EnrollmentList : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        Int64 UserId;
        String role;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserId = Convert.ToInt64(Session["UserId"]);

            if (Session["Role"] != null)
            {
                role = Session["Role"].ToString();
                if (!IsPostBack)
                {
                    if (role == "stud")
                    {
                        showStudList();
                    }
                    else
                    {
                        showEduList();
                    }
                }

            }
        }

        private void showStudList()
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "Select * From EnrolledCourse where studId=@StudId";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@StudId", UserId);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvEnrollmentList.DataSource = ds;
            gvEnrollmentList.DataBind();
            con.Close();
        }

        private void showEduList()
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "SELECT distinct EnrolledCourse.enrollmentId, EnrolledCourse.enrolDate, EnrolledCourse.enrolTime FROM EnrolledCourse INNER JOIN EnrolDetails ON EnrolledCourse.enrollmentId = EnrolDetails.enrollmentId INNER JOIN CourseSchedule ON EnrolDetails.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId=Course.courseId WHERE (Course.eduId = @EduId)";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@EduId", UserId);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvEnrollmentList.DataSource = ds;
            gvEnrollmentList.DataBind();
            con.Close();
        }

        protected void gvEnrollmentList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("EnrollmentDetails.aspx?enrollmentId=" + e.CommandArgument.ToString());
            }
        }
    }
}