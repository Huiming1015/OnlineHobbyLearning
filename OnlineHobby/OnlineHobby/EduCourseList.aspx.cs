using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class EduCourseList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void dlCourse_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "viewModify")
            {
                Response.Redirect("ViewCourse.aspx?courseId=" + e.CommandArgument.ToString());
            }
        }

    }
}