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

        }

        protected void gvEnrolledList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("MyCourseDetails.aspx?enrolDetailId=" + e.CommandArgument.ToString());
            }
        }

        protected void btnTimetable_Click(object sender, EventArgs e)
        {
            Response.Redirect("TimetableStud.aspx");
        }
    }
}