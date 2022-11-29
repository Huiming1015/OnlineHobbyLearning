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
    public partial class SignUp : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string Password = txtSUPassword.Text;
                txtSUPassword.Attributes.Add("value", Password);

                string Password2 = txtSUConfirmPassword.Text;
                txtSUConfirmPassword.Attributes.Add("value", Password2);

            }

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (txtSUPassword.TextMode == TextBoxMode.Password)
            {
                txtSUPassword.TextMode = TextBoxMode.SingleLine;
                ImageButton1.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtSUPassword.TextMode = TextBoxMode.Password;
                ImageButton1.ImageUrl = "Resources/passwordShow.png";
            }
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            if (txtSUConfirmPassword.TextMode == TextBoxMode.Password)
            {
                txtSUConfirmPassword.TextMode = TextBoxMode.SingleLine;
                ImageButton2.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtSUConfirmPassword.TextMode = TextBoxMode.Password;
                ImageButton2.ImageUrl = "Resources/passwordShow.png";
            }
        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(studId),0) from Student", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();
        }

        private void clr()
        {
            txtSUName.Text = "";
            txtSUEmail.Text = "";
            this.txtSUPassword.Attributes.Add("value", "");
            this.txtSUConfirmPassword.Attributes.Add("value", "");
        }
        
        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            MsgSignUpFail.Visible = false;
            MsgSignUpSuccess.Visible = false;
            MsgRequired.Visible = false;
            MsgError.Visible = false;

            MsgError.InnerHtml = " ";
            int error = 0;


            if (txtSUName.Text != "" && txtSUEmail.Text != "" && txtSUPassword.Text != "" && txtSUConfirmPassword.Text != "")
            {
                if (!validateName(txtSUName.Text))
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

                if (!validateEmail(txtSUEmail.Text))
                {
                    error += 1;
                    if (MsgError.InnerHtml == " ")
                    {
                        MsgError.InnerHtml = "Please enter a valid email address.";
                    }
                    else
                    {
                        MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Please enter a valid email address.";
                    }
                }

                if (!validatePassword(txtSUPassword.Text))
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

                if (!validateConfirmPassword(txtSUPassword.Text, txtSUConfirmPassword.Text))
                {
                    error += 1;
                    if (MsgError.InnerHtml == " ")
                    {
                        MsgError.InnerHtml = "Password and confirm password does not matched.";
                    }
                    else
                    {
                        MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Password and confirm password does not matched.";
                    }

                }

                if (error != 0)
                {
                    MsgError.Visible = true;
                }
                else
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("Select * from Student where studEmail=@Email", con);
                    cmd.Parameters.AddWithValue("@Email", txtSUEmail.Text);
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count != 0)
                    {
                        MsgSignUpFail.Visible = true;
                    }
                    else
                    {
                        AutoGenerateUserID();

                        con.Open();
                        string cmd2 = "Insert into Student(studId,studName,studEmail,studPassword,profileImg,status) Values('" + id + "','" + txtSUName.Text + "','" + txtSUEmail.Text + "','" + txtSUPassword.Text + "','" + "~/Resources/profile_orange.png" + "','" + "active" + "')";
                        SqlCommand cmdSelect = new SqlCommand(cmd2, con);
                        cmdSelect.ExecuteNonQuery();
                        con.Close();

                        MsgSignUpSuccess.Visible = true;
                        clr();
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

        private Boolean validateName(string name)
        {
            Regex regex = new Regex("^[a-zA-Z][a-zA-Z ]*$");
            Match match = regex.Match(name);
            if (match.Success)
                return true;
            else
                return false;
        }

        private Boolean validateEmail(string email)
        {
            Regex regex = new Regex(@"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$");
            Match match = regex.Match(email);
            if (match.Success)
                return true;
            else
                return false;
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