using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                if (IsPostBack)
                {
                    string Password = txtPCurrentPasword.Text;
                    txtPCurrentPasword.Attributes.Add("value", Password);

                    string Password2 = txtPNewPassword.Text;
                    txtPNewPassword.Attributes.Add("value", Password2);

                    string Password3 = txtPConfirmPassword.Text;
                    txtPConfirmPassword.Attributes.Add("value", Password3);
                }
            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }
           
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (txtPCurrentPasword.TextMode == TextBoxMode.Password)
            {
                txtPCurrentPasword.TextMode = TextBoxMode.SingleLine;
                ImageButton1.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtPCurrentPasword.TextMode = TextBoxMode.Password;
                ImageButton1.ImageUrl = "Resources/passwordShow.png";
            }
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            if (txtPNewPassword.TextMode == TextBoxMode.Password)
            {
                txtPNewPassword.TextMode = TextBoxMode.SingleLine;
                ImageButton1.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtPNewPassword.TextMode = TextBoxMode.Password;
                ImageButton1.ImageUrl = "Resources/passwordShow.png";
            }
        }

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            if (txtPConfirmPassword.TextMode == TextBoxMode.Password)
            {
                txtPConfirmPassword.TextMode = TextBoxMode.SingleLine;
                ImageButton1.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtPConfirmPassword.TextMode = TextBoxMode.Password;
                ImageButton1.ImageUrl = "Resources/passwordShow.png";
            }
        }


        private Boolean validateCurrentPassword()
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            string role = Session["Role"].ToString();

            con = new SqlConnection(strCon);

            if (role == "stud")
            {
                con.Open();
                string cmd = "Select studPassword from Student where studId =" + UserId;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                string UserPassword = cmdSelect.ExecuteScalar().ToString();
                if (UserPassword == txtPCurrentPasword.Text)
                {
                    con.Close();
                    return true;
                }
                else
                {
                    con.Close();
                    return false;
                }
            }
            else
            {
                con.Open();
                string cmd = "Select eduPassword from Educator where eduId =" + UserId;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                string UserPassword = cmdSelect.ExecuteScalar().ToString();
                if (UserPassword == txtPCurrentPasword.Text)
                {
                    con.Close();
                    return true;
                }
                else
                {
                    con.Close();
                    return false;
                }
            }

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

        private void clr()
        {
            txtPCurrentPasword.Text = "";
            txtPNewPassword.Text = "";
            txtPConfirmPassword.Text = "";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgSuccess.Visible = false;
            MsgRequired.Visible = false;
            MsgError.Visible = false;

            MsgError.InnerHtml = " ";
            int error = 0;

            if (txtPCurrentPasword.Text != "" && txtPNewPassword.Text != "" && txtPConfirmPassword.Text != "")
            {
                if (!validateCurrentPassword())
                {
                    error += 1;
                    if (MsgError.InnerHtml == " ")
                    {
                        MsgError.InnerHtml = "Current password not matched.";
                    }
                    else
                    {
                        MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Current password not matched.";
                    }
                }


                if (!validatePassword(txtPNewPassword.Text))
                {
                    error += 1;
                    if (MsgError.InnerHtml == " ")
                    {
                        MsgError.InnerHtml = "Password must contains min 8 characters, at least 1 uppercase, 1 lowercase, 1 digit.";
                    }
                    else
                    {
                        MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Password must contains min 8 characters, at least 1 uppercase, 1 lowercase, 1 digit.";
                    }

                }

                if (!validateConfirmPassword(txtPNewPassword.Text, txtPConfirmPassword.Text))
                {
                    error += 1;
                    if (MsgError.InnerHtml == " ")
                    {
                        MsgError.InnerHtml = "New password and confirm password does not matched.";
                    }
                    else
                    {
                        MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "New password and confirm password does not matched.";
                    }

                }

                if (error != 0)
                {
                    MsgError.Visible = true;
                }
                else
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);
                    string role = Session["Role"].ToString();

                    con = new SqlConnection(strCon);

                    if (role == "stud")
                    {
                        con.Open();
                        SqlCommand cmd = new SqlCommand("Update Student set studPassword=@Password where studId=@UserId", con);
                        cmd.Parameters.AddWithValue("@Password", txtPNewPassword.Text);
                        cmd.Parameters.AddWithValue("@UserId", UserId);
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    else
                    {
                        con.Open();
                        SqlCommand cmd2 = new SqlCommand("Update Educator set eduPassword=@Password where eduId=@UserId", con);
                        cmd2.Parameters.AddWithValue("@Password", txtPNewPassword.Text);
                        cmd2.Parameters.AddWithValue("@UserId", UserId);
                        cmd2.ExecuteNonQuery();
                        con.Close();
                    }

                    MsgSuccess.Visible = true;
                    clr();
                }
            }
            else
            {
                MsgRequired.Visible = true;
            }
        }
    }
}