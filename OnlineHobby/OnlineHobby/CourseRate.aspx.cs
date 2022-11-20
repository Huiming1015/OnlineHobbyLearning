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
    public partial class CourseRate : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        Decimal ratingValue;
        String courseId;
        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Session["courseId"].ToString();
        }

        protected void Rating1_Click(object sender, AjaxControlToolkit.RatingEventArgs e)
        {
            ratingValue = Convert.ToDecimal(e.Value.ToString());
            Session["RatingValue"] = ratingValue;
        }

        protected void btnRate_Click(object sender, EventArgs e)
        {
            ratingValue = Convert.ToDecimal(Session["RatingValue"]);
            if (ratingValue <= 0)
            {
                MsgBox("Please click the star to rate the course!", this.Page, this);
            }
            else
            {
                string comment;
                if (txtComment.Text.ToString() != "")
                {
                    comment = txtComment.Text.ToString();
                }
                else
                {
                    comment = "The student didn't give any comments...";
                }
                con = new SqlConnection(strCon);
                con.Open();
                string cmd2 = "Insert into CourseRating(courseRatingId,studId,enrolDetailsId,courseId,rating,comment) Values(@courseRatingId,@studId,@enrolDetailsId,@courseId,@rating,@comment)";
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                cmdSelect2.Parameters.AddWithValue("@courseRatingId", GenerateID());
                cmdSelect2.Parameters.AddWithValue("@studId", Session["UserId"]);
                cmdSelect2.Parameters.AddWithValue("@enrolDetailsId", Session["enrolDetailsId"].ToString());
                cmdSelect2.Parameters.AddWithValue("@courseId", courseId);
                cmdSelect2.Parameters.AddWithValue("@rating", ratingValue);
                cmdSelect2.Parameters.AddWithValue("@comment", comment);
                int k = cmdSelect2.ExecuteNonQuery();
                con.Close();
                if (k != 0)
                {
                    MsgBox("Thank you for your feedback!", this.Page, this);
                    ClientScript.RegisterStartupScript(this.GetType(), "RefreshParent", "<script language='javascript'>RefreshParent()</script>");
                }
            }
        }

        private Int64 GenerateID()
        {
            Int64 id;
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(courseRatingId),0) from CourseRating", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();
            return id;
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