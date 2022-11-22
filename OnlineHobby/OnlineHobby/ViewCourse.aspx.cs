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
    public partial class ViewCourse : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con2;
        string strCon2 = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con3;
        string strCon3 = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        String strCourseId;
        protected void Page_Load(object sender, EventArgs e)
        {
            strCourseId = Request.QueryString["courseId"];
            Session["cartCourseId"] = strCourseId;
            if (!IsPostBack)
            {
                if (Session["Role"] != null)
                {
                    string role = Session["Role"].ToString();
                    if (role == "edu")
                    {
                        btnAddToCart.Visible = false;
                        btnRemove.Visible = true;
                        btnModify.Visible = true;
                        lbtnNameList.Visible = true;
                    }
                    else
                    {
                        btnAddToCart.Visible = true;
                        btnRemove.Visible = false;
                        btnModify.Visible = false;
                        lbtnNameList.Visible = false;
                    }
                }
                else
                {
                    btnAddToCart.Visible = false;
                    btnRemove.Visible = false;
                    btnModify.Visible = false;
                    lbtnNameList.Visible = false;
                }
                if (dlCourse.Items.Count == 0)
                {
                    lblNoRate.Visible = true;
                }
            }
            if (dlMaterialKit.Items.Count == 0)
            {
                lblTitleMaterial.Visible = false;
            }

            int i = 0;
            double rating = 0, average = 0;
            foreach (DataListItem dl in dlRating.Items)
            {
                Label lblRating = dl.FindControl("lblRating") as Label;
                i++;
                rating += Convert.ToDouble(lblRating.Text);
            }
            average = rating / i;
            lblAverage.Text = "(" + average.ToString("0.00") + ")";
            
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            int i = 0, j = 0, k = 0, l = 0;
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                con = new SqlConnection(strCon);
                con2 = new SqlConnection(strCon2);
                con3 = new SqlConnection(strCon3);
                con.Open();
                string cmd = "Select scheduleId from CourseSchedule WHERE courseId=@CourseId";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@CourseId", strCourseId);
                SqlDataReader dr = cmdSelect.ExecuteReader();
                while (dr.Read())
                {

                    con3.Open();
                    string strQU = "Update CourseSchedule set availability='unavailable' where scheduleId=@scheduleId";
                    SqlCommand comU = new SqlCommand(strQU, con3);
                    comU.Parameters.AddWithValue("@scheduleId", dr["scheduleId"].ToString());
                    i = comU.ExecuteNonQuery();
                    con3.Close();

                    con2.Open();
                    string cmd2 = "Select EnrolledCourse.paymentId, EnrolDetails.unitPrice from EnrolledCourse INNER JOIN EnrolDetails ON EnrolledCourse.enrollmentId=EnrolDetails.enrollmentId WHERE (scheduleId=@scheduleId) AND (enrolStatus='Enrolled')";
                    SqlCommand cmdSelect2 = new SqlCommand(cmd2, con2);
                    cmdSelect2.Parameters.AddWithValue("@scheduleId", dr["scheduleId"].ToString());
                    SqlDataReader dr2 = cmdSelect2.ExecuteReader();
                    while (dr2.Read())
                    {
                        con3.Open();
                        string strQRefund = "Update Payment set refundAmount=refundAmount+@amount, paymentStatus='refund' where paymentId=@paymentId";
                        SqlCommand comRefund = new SqlCommand(strQRefund, con3);
                        comRefund.Parameters.AddWithValue("@amount", dr2["unitPrice"]);
                        comRefund.Parameters.AddWithValue("@paymentId", dr2["paymentId"].ToString());
                        k = comRefund.ExecuteNonQuery();
                        con3.Close();
                    }
                    dr2.Close();
                    con2.Close();

                    con3.Open();
                    string strQCancel = "Update EnrolDetails set enrolStatus='Cancelled' where scheduleId=@scheduleId";
                    SqlCommand comCancel = new SqlCommand(strQCancel, con3);
                    comCancel.Parameters.AddWithValue("@scheduleId", dr["scheduleId"].ToString());
                    j = comCancel.ExecuteNonQuery();
                    con3.Close();
                }
                dr.Close();
                con.Close();

                con.Open();
                string strQRemove = "Update Course set availability=@availability where courseId=@courseId";
                SqlCommand comRemoveMaterial = new SqlCommand(strQRemove, con);
                comRemoveMaterial.Parameters.AddWithValue("@courseId", strCourseId);
                comRemoveMaterial.Parameters.AddWithValue("@availability", "unavailable");
                l = comRemoveMaterial.ExecuteNonQuery();

                if (i != 0 && j != 0 && k != 0 && l != 0)
                {
                    MsgBox("Your course has been successfully removed!", this.Page, this);
                    Response.Redirect("EduCourseList.aspx?");
                }
                con.Close();
            }
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        protected void btnModify_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCourse.aspx?courseId=" + Request.QueryString["courseId"]);
        }

        protected void dlMaterialKit_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Response.Redirect("viewMaterial.aspx?id=" + e.CommandArgument.ToString());
        }

        protected void lbtnNameList_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewStudNameList.aspx?courseId=" + Request.QueryString["courseId"]);
        }
    }
}