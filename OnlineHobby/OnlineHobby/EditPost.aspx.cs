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
    public partial class EditPost : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                if (!IsPostBack)
                {
                    Session["postUpdateImg"] = null;
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);

                    con = new SqlConnection(strCon);

                    con.Open();
                    string cmd2 = "Select postContents,postImg from Posts where eduId =" + UserId + "and postId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                    SqlDataReader dr = cmdSelect2.ExecuteReader();
                    while (dr.Read())
                    {
                        txtDesc.Text = dr.GetValue(0).ToString();
                        imgPostImage.ImageUrl = dr.GetValue(1).ToString();
                    }
                }
            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }

            if (fileUploadImg.PostedFile != null && fileUploadImg.PostedFile.ContentLength > 0) { UploadAndDisplayImage(); }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);

            con = new SqlConnection(strCon);
            con.Open();
            string cmd = "Delete from Posts where eduId =" + UserId + "and postId =" + Request.QueryString["id"];
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            cmdSelect.ExecuteNonQuery();
            con.Close();

            Response.Redirect("Posts.aspx");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgRequired.Visible = false;
            MsgSuccess.Visible = false;
            MsgImage.Visible = false;

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            if (txtDesc.Text != "")
            {
                if (Session["postUpdateImg"] != null)
                {
                    con.Open();
                    string cmd = "Update Posts set postContents=@desc,postImg=@postImg where eduId =" + UserId + "and postId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@desc", txtDesc.Text);
                    cmdSelect.Parameters.AddWithValue("@postImg", Session["postUpdateImg"]);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();


                    MsgSuccess.Visible = true;
                    Session["postUpdateImg"] = null;
                }
                else
                {
                    con.Open();
                    string cmd = "Update Posts set postContents=@desc where eduId =" + UserId + "and postId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@desc", txtDesc.Text);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();


                    MsgSuccess.Visible = true;
                }
            }
            else
            {
                MsgRequired.Visible = true;
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
                    string filepath = "Assets/postImg/" + fileUploadImg.FileName;
                    fileUploadImg.SaveAs(Server.MapPath("~/Assets/postImg/") + filename);
                    imgPostImage.ImageUrl = "~/" + filepath;
                    Session["postUpdateImg"] = filepath;
                }
                else
                {
                    MsgImage.Visible = true;
                }
            }
        }
    }

}