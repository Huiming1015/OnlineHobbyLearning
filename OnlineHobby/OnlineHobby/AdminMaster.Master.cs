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
            }
            else
            {
                //no login, just a guest
                lbtnLogout.Visible = false;
            }
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            Session["UserEmail"] = null;
            Session["Role"] = null;
            Response.Redirect("AdminLogIn.aspx");
        }
    }
}