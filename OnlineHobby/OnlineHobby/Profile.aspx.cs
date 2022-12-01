using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                if (!IsPostBack)
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);
                    string role = Session["Role"].ToString();

                    con = new SqlConnection(strCon);

                    if (role == "stud")
                    {
                        con.Open();
                        string cmd = "Select studName,studEmail,profileImg from Student where studId =" + UserId;
                        SqlCommand cmdSelect = new SqlCommand(cmd, con);
                        SqlDataReader dr = cmdSelect.ExecuteReader();
                        while (dr.Read())
                        {

                            txtPName.Text = dr.GetValue(0).ToString();
                            txtPEmail.Text = dr.GetValue(1).ToString();
                            if (dr.GetValue(2) == DBNull.Value)
                            {
                                imgProfile.ImageUrl = "~/Resources/profile_orange.png";
                            }
                            else
                            {
                                imgProfile.ImageUrl = dr.GetValue(2).ToString();
                            }

                        }
                        dr.Close();
                        con.Close();
                    }
                    else
                    {
                        con.Open();
                        string cmd2 = "Select eduName,eduEmail,profileImg,about from Educator where eduId =" + UserId;
                        SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                        SqlDataReader dr = cmdSelect2.ExecuteReader();
                        while (dr.Read())
                        {
                            txtPName.Text = dr.GetValue(0).ToString();
                            txtPEmail.Text = dr.GetValue(1).ToString();
                            if (dr.GetValue(2) == DBNull.Value)
                            {
                                imgProfile.ImageUrl = "~/Resources/profile_orange.png";
                            }
                            else
                            {
                                imgProfile.ImageUrl = dr.GetValue(2).ToString();
                            }
                            txtPAbout.Text = dr.GetValue(3).ToString();
                            Panel1.Visible = true;

                        }
                        dr.Close();
                        con.Close();
                    }

                }
            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }


            if (fileUploadImg.PostedFile != null && fileUploadImg.PostedFile.ContentLength > 0) { UploadAndDisplayImage(); }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgSuccess.Visible = false;
            MsgRequired.Visible = false;
            MsgError.Visible = false;
            MsgImage.Visible = false;
            MsgRequired2.Visible = false;

            MsgError.InnerHtml = " ";
            int error = 0;

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            string role = Session["Role"].ToString();

            con = new SqlConnection(strCon);

            if (role == "stud")
            {
                if (txtPName.Text != "")
                {
                    if (!validateName(txtPName.Text))
                    {
                        error += 1;
                        if (MsgError.InnerHtml == " ")
                        {
                            MsgError.InnerHtml = "Name should include letters only.";
                        }
                        else
                        {
                            MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Name should include letters only.";
                        }
                    }

                    if (error != 0)
                    {
                        MsgError.Visible = true;
                    }
                    else
                    {
                        if (Session["profileImg"] != null)
                        {

                            con.Open();
                            string cmd = "Update Student set studName=@Name,profileImg=@Image where studId =" + UserId;
                            SqlCommand cmdSelect = new SqlCommand(cmd, con);
                            cmdSelect.Parameters.AddWithValue("@Name", txtPName.Text);
                            cmdSelect.Parameters.AddWithValue("@Image", Session["profileImg"]);
                            cmdSelect.ExecuteNonQuery();
                            con.Close();

                            Session["profileImg"] = null;
                            Response.Redirect("Profile.aspx");
                            MsgSuccess.Visible = true;

                        }
                        else
                        {
                            con.Open();
                            string cmd = "Update Student set studName=@Name where studId =" + UserId;
                            SqlCommand cmdSelect = new SqlCommand(cmd, con);
                            cmdSelect.Parameters.AddWithValue("@Name", txtPName.Text);
                            cmdSelect.ExecuteNonQuery();
                            con.Close();


                            MsgSuccess.Visible = true;

                        }
                    }
                }
                else
                {
                    MsgRequired.Visible = true;
                }
            }
            else
            {
                if (txtPName.Text != "" && txtPAbout.Text != "")
                {
                    if (!validateName(txtPName.Text))
                    {
                        error += 1;
                        if (MsgError.InnerHtml == " ")
                        {
                            MsgError.InnerHtml = "Name should include letters only.";
                        }
                        else
                        {
                            MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Name should include letters only.";
                        }
                    }

                    if (error != 0)
                    {
                        MsgError.Visible = true;
                    }
                    else
                    {
                        if (Session["profileImg"] != null)
                        {
                            con.Open();
                            string cmd = "Update Educator set eduName=@Name,profileImg=@Image,about=@About where eduId =" + UserId;
                            SqlCommand cmdSelect = new SqlCommand(cmd, con);
                            cmdSelect.Parameters.AddWithValue("@Name", txtPName.Text);
                            cmdSelect.Parameters.AddWithValue("@Image", Session["profileImg"]);
                            cmdSelect.Parameters.AddWithValue("@About", txtPAbout.Text);
                            cmdSelect.ExecuteNonQuery();
                            con.Close();

                            Session["profileImg"] = null;
                            Response.Redirect("Profile.aspx");
                            MsgSuccess.Visible = true;

                        }
                        else
                        {
                            con.Open();
                            string cmd = "Update Educator set eduName=@Name,about=@About where eduId =" + UserId;
                            SqlCommand cmdSelect = new SqlCommand(cmd, con);
                            cmdSelect.Parameters.AddWithValue("@Name", txtPName.Text);
                            cmdSelect.Parameters.AddWithValue("@About", txtPAbout.Text);
                            cmdSelect.ExecuteNonQuery();
                            con.Close();

                            MsgSuccess.Visible = true;
                        }
                    }
                }
                else
                {
                    MsgRequired2.Visible = true;
                }
            }
        }

        private void UploadAndDisplayImage()
        {
            string extenssion = System.IO.Path.GetExtension(fileUploadImg.FileName);
            string filename = fileUploadImg.PostedFile.FileName;
            if (fileUploadImg.PostedFile != null && fileUploadImg.PostedFile.FileName != "")
            {
                if (extenssion == ".jpg" || extenssion == ".png")
                {
                    string filepath = "Assets/profileImg/" + fileUploadImg.FileName;
                    fileUploadImg.SaveAs(Server.MapPath("~/Assets/profileImg/") + filename);
                    imgProfile.ImageUrl = "~/" + filepath;
                    Session["profileImg"] = filepath;
                }
                else
                {
                    MsgImage.Visible = true;
                }
            }
        }

        private Boolean validateName(string name)
        {
            Regex regex = new Regex("^[a-zA-Z][a-zA-Z ]*$");
            Match match = regex.Match(name);
            if (match.Success)
                return true;
            else
                return false;
        }
        
    }
}