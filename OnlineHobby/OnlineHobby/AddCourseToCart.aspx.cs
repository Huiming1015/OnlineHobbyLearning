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
    public partial class AddCourseToCart : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void dlSchedule_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Label lblNumEnrolled = e.Item.FindControl("lblNumEnrolled") as Label;
            Label lblMaxStud = e.Item.FindControl("lblMaxStud") as Label;
            int numEnrolled = Convert.ToInt16(lblNumEnrolled.Text);
            int maxStud = Convert.ToInt16(lblMaxStud.Text);

            if (e.CommandName == "addToCart")
            {
                if (checkEnrolled(e) == false)
                {
                    if (numEnrolled + 1 <= maxStud)
                    {
                        if (Session["modifyCartCourse"] != null)
                        {
                            if (checkScheduleInCart(e) == true)
                            {
                                modifyCart(e);
                            }
                        }
                        else
                        {
                            if (checkScheduleInCart(e) == true)
                            {
                                addToCart(e);
                            }
                        }
                    }
                    else
                    {
                        MsgBox("The maximum number of students enrolled in this course has been reached!", this.Page, this);
                    }
                }
            }
        }

        private Boolean checkScheduleInCart(DataListCommandEventArgs e)
        {
            Boolean inCart;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "SELECT * FROM Cart WHERE scheduleId=@ScheduleId AND studId=@StudId";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@ScheduleId", e.CommandArgument);
            com.Parameters.AddWithValue("@StudId", Session["UserId"]);
            SqlDataReader dr = com.ExecuteReader();

            if (dr.HasRows)
            {
                MsgBox("The course already in cart!", this.Page, this);
                inCart = false;
            }
            else
            {
                inCart = true;
            }
            dr.Close();
            con.Close();
            return inCart;
        }

        private Boolean checkEnrolled(DataListCommandEventArgs e)
        {
            Boolean enrolled;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "SELECT * FROM EnrolledCourse INNER JOIN EnrolDetails ON EnrolledCourse.enrollmentId=EnrolDetails.enrollmentId WHERE EnrolDetails.scheduleId=@ScheduleId AND EnrolledCourse.studId=@StudId";
            SqlCommand comEnrolled = new SqlCommand(strQ, con);
            comEnrolled.Parameters.AddWithValue("@ScheduleId", e.CommandArgument);
            comEnrolled.Parameters.AddWithValue("@StudId", Session["UserId"]);
            SqlDataReader dr = comEnrolled.ExecuteReader();

            if (dr.HasRows)
            {
                MsgBox("The course has been enrolled!", this.Page, this);
                enrolled = true;
            }
            else
            {
                enrolled = false;
            }
            dr.Close();
            con.Close();
            return enrolled;
        }

        private void addToCart(DataListCommandEventArgs e)
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Cart](cartId, studId, scheduleId, quantity) VALUES (@CartId, @StudId, @ScheduleId, @Quantity)";
                SqlCommand comAddToCart = new SqlCommand(strQAdd, con);
                comAddToCart.Parameters.AddWithValue("@CartId", GenerateID());
                comAddToCart.Parameters.AddWithValue("@StudId", Session["UserId"].ToString());
                comAddToCart.Parameters.AddWithValue("@ScheduleId", e.CommandArgument.ToString());
                comAddToCart.Parameters.AddWithValue("@Quantity", 1);
                int k = comAddToCart.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Add to cart successfully!", this.Page, this);
                }
                con.Close();
            }
            catch
            {
                MsgBox("Add to cart unsuccessful!", this.Page, this);
            }
        }

        private void modifyCart(DataListCommandEventArgs e)
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "UPDATE Cart SET scheduleId=@ScheduleId WHERE cartId=@CartId";
                SqlCommand comAddToCart = new SqlCommand(strQAdd, con);
                comAddToCart.Parameters.AddWithValue("@CartId", Session["cartId"].ToString());
                comAddToCart.Parameters.AddWithValue("@ScheduleId", e.CommandArgument.ToString());
                int k = comAddToCart.ExecuteNonQuery();
                if (k != 0)
                {
                    Session["modifyCartCourse"] = null;
                    Session["cartId"] = null;
                    MsgBox("Modify cart successfully!", this.Page, this);

                }
                con.Close();
            }
            catch
            {
                MsgBox("Modify cart unsuccessful!", this.Page, this);
            }
        }

        private Int32 GenerateID()
        {
            Int32 cartId;
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(cartId),0) from Cart", con);
            cartId = Convert.ToInt32(cmd.ExecuteScalar()) + 1;
            con.Close();
            return cartId;
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

    }
}