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
    public partial class EnrollmentDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (DataListItem dl in dlEnrollmentDetails.Items)
            {
                Label lblEnrollmentId = dl.FindControl("lblEnrollmentId") as Label;
                con = new SqlConnection(strCon);
                con.Open();
                string strQ = "SELECT paymentId FROM EnrolledCourse WHERE enrollmentId=@EnrollmentId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@EnrollmentId", lblEnrollmentId.Text.ToString());
                Session["paymentId"] = com.ExecuteScalar().ToString();
                con.Close();
            }
            if (!IsPostBack)
            {
                if (dlEnrollmentDetails.Items.Count <= 0)
                {
                    lblEmpty.Visible = true;
                }
                else
                {
                    lblEmpty.Visible = false;
                }
            }
        }
    }
}