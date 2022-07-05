using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class AdminMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                //login success
                lbtnLogout.Visible = true;
                lbtnReports.Visible = true;
                lbtnApplication.Visible = true;
                lbtnEduSU.Visible = true;
                lbtnNewCourse.Visible = true;
                lbtnEduIncidents.Visible = true;
            }
            else
            {
                //no login, just a guest
                lbtnLogout.Visible = false;
                lbtnReports.Visible = false;
                lbtnApplication.Visible = false;
                lbtnEduSU.Visible = false;
                lbtnNewCourse.Visible = false;
                lbtnEduIncidents.Visible = false;
            }
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session.RemoveAll();
            Response.Redirect("AdminLogIn.aspx");
        }
    }
}