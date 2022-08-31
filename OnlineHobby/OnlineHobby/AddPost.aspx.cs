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
    public partial class AddPost : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {
            MsgSuccess.Visible = false;
            MsgImage.Visible = false;
            MsgRequired.Visible = false;

            if (!IsPostBack)
            {
                Session["postImg"] = null;
            }

            if (Session["UserEmail"] != null)
            {
                if (!IsPostBack)
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);
                    string role = Session["Role"].ToString();

                    con = new SqlConnection(strCon);

                    if (role == "stud")
                    {
                        Response.Redirect("Profile.aspx");
                    }
                }

            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }

            if (fileUploadImg.PostedFile != null && fileUploadImg.PostedFile.ContentLength > 0) { UploadAndDisplayImage(); }
        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(postId),0) from Posts", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgSuccess.Visible = false;
            MsgImage.Visible = false;
            MsgRequired.Visible = false;

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            //both text & img are required
            if (txtDesc.Text != "" && Session["postImg"] != null)
            {
                //if (Session["postImg"] != null)
                //{

                DateTime time = DateTime.Now;
                AutoGenerateUserID();

                con.Open();
                string cmd = "Insert into Posts(postId, eduId, postDateTime, postContents, postImg) Values(@id, @edu, @date, @content, @img)";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@id", id);
                cmdSelect.Parameters.AddWithValue("@edu", UserId);
                cmdSelect.Parameters.AddWithValue("@date", time);
                cmdSelect.Parameters.AddWithValue("@content", txtDesc.Text);
                cmdSelect.Parameters.AddWithValue("@img", Session["postImg"]);
                cmdSelect.ExecuteNonQuery();
                con.Close();

                MsgSuccess.Visible = true;
                clr();
                Session["postImg"] = null;
            }
            else
            {
                MsgRequired.Visible = true;
            }

            //}
            //else
            //{
            //    DateTime now = DateTime.Now;
            //    AutoGenerateUserID();

            //    con.Open();
            //    string cmd = "Insert into Posts(postId, eduId, postDateTime, postContents) Values(@id, @edu, @date, @content)";
            //    SqlCommand cmdSelect = new SqlCommand(cmd, con);
            //    cmdSelect.Parameters.AddWithValue("@id", id);
            //    cmdSelect.Parameters.AddWithValue("@edu", UserId);
            //    cmdSelect.Parameters.AddWithValue("@date", now);
            //    cmdSelect.Parameters.AddWithValue("@content", txtDesc.Text);
            //    cmdSelect.ExecuteNonQuery();
            //    con.Close();


            //    MsgSuccess.Visible = true;
            //    clr();

            //}
        }

        private void UploadAndDisplayImage()
        {
            string extenssion = System.IO.Path.GetExtension(fileUploadImg.FileName);
            string filename = fileUploadImg.PostedFile.FileName;
            if (fileUploadImg.PostedFile != null && fileUploadImg.PostedFile.FileName != "")
            {
                if (extenssion == ".jpg" || extenssion == ".png")
                {
                    string filepath = "Assets/postImg/" + fileUploadImg.FileName;
                    fileUploadImg.SaveAs(Server.MapPath("~/Assets/postImg/") + filename);
                    imgPostImage.ImageUrl = "~/" + filepath;
                    Session["postImg"] = filepath;
                }
                else
                {
                    MsgImage.Visible = true;
                }
            }
        }

        private void clr()
        {
            txtDesc.Text = "";
            imgPostImage.ImageUrl = "";


        }
    }
}