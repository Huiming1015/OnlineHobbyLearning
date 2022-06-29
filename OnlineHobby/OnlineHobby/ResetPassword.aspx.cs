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
    public partial class ResetPassword : System.Web.UI.Page
    {
        string GUIDValue;
        string role;
        int UserId;
        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                GUIDValue = Request.QueryString["id"];
                String NotUsed = "Not Used";

                if (GUIDValue != null)
                {
                    SqlCommand cmd = new SqlCommand("Select * from ForgotPassword where id=@id and linkStatus=@linkStatus", con);
                    con.Open();
                    cmd.Parameters.AddWithValue("@id", GUIDValue);
                    cmd.Parameters.AddWithValue("@linkStatus", NotUsed);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);

                    sda.Fill(dt);
                    if (dt.Rows.Count != 0)
                    {
                        UserId = Convert.ToInt32(dt.Rows[0][1]);
                    }
                    else
                    {
                        MsgError.Visible = true;
                    }
                }
            }

            if (IsPostBack)
            {
                string Password = txtNewRPassword.Text;
                txtNewRPassword.Attributes.Add("value", Password);

                string Password2 = txtConfirmRPassword.Text;
                txtConfirmRPassword.Attributes.Add("value", Password2);
            }

        }

        protected void ImageButton1_Click1(object sender, ImageClickEventArgs e)
        {
            if (txtNewRPassword.TextMode == TextBoxMode.Password)
            {
                txtNewRPassword.TextMode = TextBoxMode.SingleLine;
                ImageButton1.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtNewRPassword.TextMode = TextBoxMode.Password;
                ImageButton1.ImageUrl = "Resources/passwordShow.png";
            }
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            if (txtConfirmRPassword.TextMode == TextBoxMode.Password)
            {
                txtConfirmRPassword.TextMode = TextBoxMode.SingleLine;
                ImageButton2.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtConfirmRPassword.TextMode = TextBoxMode.Password;
                ImageButton2.ImageUrl = "Resources/passwordShow.png";
            }
        }

        private void clr()
        {
            txtNewRPassword.Text = "";
            txtConfirmRPassword.Text = "";
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            btnLogin.Enabled = false; //after update success then enabled
            MsgRequired.Visible = false;
            MsgError.Visible = false;
            MsgErrorConfirmPswd.Visible = false;
            MsgErrorPswd.Visible = false;
            MsgSuccess.Visible = false;

            int error = 0;

            role = Request.QueryString["role"];

            if (txtNewRPassword.Text != "" && txtConfirmRPassword.Text != "")
            {
                if (!validatePassword(txtNewRPassword.Text))
                {
                    error += 1;
                    MsgErrorPswd.Visible = true;
                }

                if (!(txtNewRPassword.Text == txtConfirmRPassword.Text))
                {
                    error += 1;
                    MsgErrorConfirmPswd.Visible = true;
                }

                if (error == 0)
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        if (role == "stud")
                        {
                            con.Open();
                            SqlCommand cmd = new SqlCommand("Update Student set studPassword=@studPassword where studId=@studId", con);
                            cmd.Parameters.AddWithValue("@studPassword", txtNewRPassword.Text);
                            cmd.Parameters.AddWithValue("@studId", UserId);
                            cmd.ExecuteNonQuery();
                        }
                        else
                        {
                            con.Open();
                            SqlCommand cmd2 = new SqlCommand("Update Educator set eduPassword=@eduPassword where eduId=@eduId", con);
                            cmd2.Parameters.AddWithValue("@eduPassword", txtNewRPassword.Text);
                            cmd2.Parameters.AddWithValue("@eduId", UserId);
                            cmd2.ExecuteNonQuery();
                        }

                        string Invalid = "Invalid";
                        SqlCommand cmd3 = new SqlCommand("Update ForgotPassword set linkStatus=@linkStatus where id='" + GUIDValue + "'", con);
                        cmd3.Parameters.AddWithValue("@LinkStatus", Invalid);
                        cmd3.ExecuteNonQuery();

                        MsgSuccess.Visible = true;
                        clr();
                        btnLogin.Enabled = true;
                        

                    }

                }
            }
            else
            {
                MsgRequired.Visible = true;
            }

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LogIn.aspx");
        }

        private Boolean validatePassword(string password)
        {
            Regex regex = new Regex("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$");
            Match match = regex.Match(password);
            if (match.Success)
                return true;
            else
                return false;
        }

        private Boolean validateConfirmPassword(string password, string confirmPassword)
        {
            if (password == confirmPassword)
                return true;
            else
                return false;
        }


    }
}