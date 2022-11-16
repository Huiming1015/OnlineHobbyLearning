using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class PurchaseSellMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnOrderList_Click(object sender, EventArgs e)
        {
            Response.Redirect("OrderList.aspx?");
        }

        protected void btnEnrollmentList_Click(object sender, EventArgs e)
        {
            Response.Redirect("EnrollmentList.aspx?");
        }
    }
}