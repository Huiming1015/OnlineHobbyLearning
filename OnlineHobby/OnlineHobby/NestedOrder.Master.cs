using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class NestedOrder : System.Web.UI.MasterPage
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        Int64 UserId;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnOrderDetails_Click(object sender, EventArgs e)
        {
            if (Session["paymentId"] != null)
            {
                String id = "";
                con = new SqlConnection(strCon);
                con.Open();
                string strQ = "SELECT orderId FROM MaterialOrder WHERE paymentId=@PaymentId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@PaymentId", Session["paymentId"].ToString());
                if (com.ExecuteScalar() != null)
                {
                    id = com.ExecuteScalar().ToString();
                }
                con.Close();
                Response.Redirect("OrderDetails.aspx?OrderId=" + id);
            }
        }

        protected void btnEnrolDetails_Click(object sender, EventArgs e)
        {
            if (Session["paymentId"] != null)
            {
                String id = "";
                con = new SqlConnection(strCon);
                con.Open();
                string strQ = "SELECT enrollmentId FROM EnrolledCourse WHERE paymentId=@PaymentId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@PaymentId", Session["paymentId"].ToString());
                if (com.ExecuteScalar() != null)
                {
                    id = com.ExecuteScalar().ToString();
                }

                con.Close();
                Response.Redirect("EnrollmentDetails.aspx?enrollmentId=" + id);
            }
        }

        protected void btnPaymentDetails_Click(object sender, EventArgs e)
        {
            if (Session["paymentId"] != null)
            {
                Response.Redirect("PaymentDetails.aspx?paymentId=" + Session["paymentId"].ToString());
            }
        }
    }
}