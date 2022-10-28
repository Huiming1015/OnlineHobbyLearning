using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class AddCourse : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        String strCourseID;
        int intCountID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            strCourseID = GenerateID();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            try
            {
                string strQAdd;
                string strImage = "";
                string fileName = Path.GetFileName(imageUpload.PostedFile.FileName);

                string fileExtension = Path.GetExtension(fileName);
                imageUpload.SaveAs(Request.PhysicalApplicationPath + "images/" + imageUpload.FileName.ToString());

                strImage = "images/" + fileName;

                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Course](courseId, eduId, courseName, category, description, learningOutcome, totalClass, minutePerClass, minAge, maxAge, courseImage, availability) VALUES (@CourseId, @EduId, @CourseName, @Category, @Description, @LearningOutcome, @TotalClass, @MinutePerClass, @MinAge, @MaxAge, @CourseImage, @Availability)";
                SqlCommand comAddCourse = new SqlCommand(strQAdd, con);
                comAddCourse.Parameters.AddWithValue("@CourseId", strCourseID);
                comAddCourse.Parameters.AddWithValue("@EduId", Session["UserId"]);
                comAddCourse.Parameters.AddWithValue("@CourseName", txtName.Text);
                comAddCourse.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue.ToString());
                comAddCourse.Parameters.AddWithValue("@Description", txtDescription.Text);
                comAddCourse.Parameters.AddWithValue("@LearningOutcome", txtOutcome.Text);
                comAddCourse.Parameters.AddWithValue("@TotalClass", txtTotalClass.Text);
                comAddCourse.Parameters.AddWithValue("@MinAge", txtMinAge.Text);
                comAddCourse.Parameters.AddWithValue("@MaxAge", txtMaxAge.Text);
                comAddCourse.Parameters.AddWithValue("@MinutePerClass", txtDuration.Text);
                comAddCourse.Parameters.AddWithValue("@CourseImage", strImage);
                comAddCourse.Parameters.AddWithValue("@Availability", "available");
                int k = comAddCourse.ExecuteNonQuery();

                if (k != 0)
                {
                    //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                //"swal('Good job!', 'You clicked Success button!', 'success')", true);
                    Session["CourseID"] = strCourseID;
                    Clear();
                    Response.Redirect("AddSchedule.aspx?");
                }
                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        private string GenerateID()
        {
            string id = "";
            String strQCourse;
            con = new SqlConnection(strCon);
            con.Open();
            strQCourse = "Select courseId from Course";
            SqlCommand comID = new SqlCommand(strQCourse, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["courseId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            con.Close();
            return "C" + intCountID.ToString("0000");
        }


        private void Clear()
        {
            txtName.Text = "";
            txtDescription.Text = "";
            txtDuration.Text = "";
            txtMinAge.Text = "";
            txtMaxAge.Text = "";
            txtTotalClass.Text = "";
            txtOutcome.Text = "";
            ddlCategory.ClearSelection();
            imageUpload = new FileUpload();
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Clear();
        }
    }
}