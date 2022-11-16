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

        String strCourseID, strQueryId;
        int intCountID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            strQueryId = Request.QueryString["courseId"];

            if (strQueryId != null)
            {
                if (!IsPostBack)
                {
                    lblTitle.Text = "MODIFY COURSE";
                    String strQ;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQ = "Select * from Course where courseId = '" + strQueryId + "'";
                    SqlCommand comID = new SqlCommand(strQ, con);
                    SqlDataReader dr = comID.ExecuteReader();
                    while (dr.Read())
                    {
                        string outcome = dr["learningOutcome"].ToString().Replace("<br />", "\r\n").Replace("<br />", "\n");
                        strCourseID = dr["courseId"].ToString();
                        imgCourse.ImageUrl = dr["courseImage"].ToString();
                        requireImage.Enabled = false;
                        txtName.Text = dr["courseName"].ToString();
                        txtDescription.Text = dr["description"].ToString();
                        txtOutcome.Text = outcome;
                        txtTotalClass.Text = dr["totalClass"].ToString();
                        // if change the total class, how about schedule
                        txtTotalClass.Enabled = false;
                        txtMinAge.Text = dr["minAge"].ToString();
                        txtMaxAge.Text = dr["maxAge"].ToString();
                        ddlCategory.SelectedValue = dr["category"].ToString();
                    }
                    con.Close();
                }
            }
            else
            {
                lblTitle.Text = "ADD COURSE";
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (strQueryId != null)
            {
                modifyCourse();
            }
            else
            {
                strCourseID = GenerateID();
                addCourse();
            }

        }

        private void addCourse()
        {
            try
            {
                string strQAdd;
                string strImage = "";
                string fileName = Path.GetFileName(imageUpload.PostedFile.FileName);

                string fileExtension = Path.GetExtension(fileName);
                imageUpload.SaveAs(Request.PhysicalApplicationPath + "images/" + imageUpload.FileName.ToString());

                strImage = "images/" + fileName;
                string outcome = txtOutcome.Text.Replace("\r\n", "<br />").Replace("\n", "<br />");
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Course](courseId, eduId, courseName, category, description, learningOutcome, totalClass, minAge, maxAge, courseImage, availability) VALUES (@CourseId, @EduId, @CourseName, @Category, @Description, @LearningOutcome, @TotalClass, @MinAge, @MaxAge, @CourseImage, @Availability)";
                SqlCommand comAddCourse = new SqlCommand(strQAdd, con);
                comAddCourse.Parameters.AddWithValue("@CourseId", strCourseID);
                comAddCourse.Parameters.AddWithValue("@EduId", Session["UserId"]);
                comAddCourse.Parameters.AddWithValue("@CourseName", txtName.Text);
                comAddCourse.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue.ToString());
                comAddCourse.Parameters.AddWithValue("@Description", txtDescription.Text);
                comAddCourse.Parameters.AddWithValue("@LearningOutcome", outcome);
                comAddCourse.Parameters.AddWithValue("@TotalClass", txtTotalClass.Text);
                comAddCourse.Parameters.AddWithValue("@MinAge", txtMinAge.Text);
                comAddCourse.Parameters.AddWithValue("@MaxAge", txtMaxAge.Text);
                comAddCourse.Parameters.AddWithValue("@CourseImage", strImage);
                comAddCourse.Parameters.AddWithValue("@Availability", "available");
                int k = comAddCourse.ExecuteNonQuery();

                if (k != 0)
                {
                    //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                    //"swal('Good job!', 'You clicked Success button!', 'success')", true);
                    //Session["CourseID"] = strCourseID;
                    Clear();
                    Response.Redirect("AddSchedule.aspx?courseId=" + strCourseID);
                }
                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        private void modifyCourse()
        {
            try
            {
                string outcome = txtOutcome.Text.Replace("\r\n", "<br />").Replace("\n", "<br />");
                string strImage = "";
                if (imageUpload.HasFile != false)
                {
                    imageUpload.SaveAs(Request.PhysicalApplicationPath + "images/" + imageUpload.FileName.ToString());
                    strImage = "images/" + imageUpload.FileName.ToString();
                }
                else
                {
                    strImage = imgCourse.ImageUrl.ToString();
                }
                con = new SqlConnection(strCon);
                con.Open();
                string strQModify = "Update Course set courseName=@courseName, category=@category, description=@description, learningOutcome=@learningOutcome, totalClass=@totalClass, minAge=@minAge, maxAge=@maxAge, courseImage=@courseImage where courseId=@courseId";
                SqlCommand comModifyCourse = new SqlCommand(strQModify, con);

                comModifyCourse.Parameters.AddWithValue("@courseId", strQueryId);
                comModifyCourse.Parameters.AddWithValue("@courseName", txtName.Text.ToString());
                comModifyCourse.Parameters.AddWithValue("@category", ddlCategory.SelectedValue.ToString());
                comModifyCourse.Parameters.AddWithValue("@description", txtDescription.Text.ToString());
                comModifyCourse.Parameters.AddWithValue("@learningOutcome", outcome);
                comModifyCourse.Parameters.AddWithValue("@totalClass", txtTotalClass.Text);
                comModifyCourse.Parameters.AddWithValue("@minAge", txtMinAge.Text);
                comModifyCourse.Parameters.AddWithValue("@maxAge", txtMaxAge.Text);
                comModifyCourse.Parameters.AddWithValue("@courseImage", strImage);

                int k = comModifyCourse.ExecuteNonQuery();

                if (k != 0)
                {
                    Response.Redirect("AddSchedule.aspx?modifyCourseId=" + strQueryId);
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