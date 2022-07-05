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
using System.Web.Security;

namespace OnlineHobby
{
    public partial class LogIn : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string Password = txtLoginPassword.Text;
                txtLoginPassword.Attributes.Add("value", Password);
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            if (txtLoginPassword.TextMode == TextBoxMode.Password)
            {
                txtLoginPassword.TextMode = TextBoxMode.SingleLine;
                ImageButton1.ImageUrl = "Resources/passwordHide.png";
            }
            else
            {
                txtLoginPassword.TextMode = TextBoxMode.Password;
                ImageButton1.ImageUrl = "Resources/passwordShow.png";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            MsgRequired.Visible = false;
            MsgError.Visible = false;

            if (txtLoginEmail.Text != "" && txtLoginPassword.Text != "")
            {
                con = new SqlConnection(strCon);
                con.Open();
                string cmd = "Select * from Student where studEmail=@studEmail and studPassword=@studPassword";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@studEmail", txtLoginEmail.Text);
                cmdSelect.Parameters.AddWithValue("@studPassword", txtLoginPassword.Text);

                DataTable dt = new DataTable();
                SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
                sda.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    //Student
                    //Check if acc is active (inactive for delete acc)
                    string cmd7 = "Select status from Student where studEmail=@studEmail";
                    SqlCommand cmdSelect7 = new SqlCommand(cmd7, con);
                    cmdSelect7.Parameters.AddWithValue("@studEmail", txtLoginEmail.Text);
                    string UserStatus = cmdSelect7.ExecuteScalar().ToString();

                    if (UserStatus == "active")
                    {
                        //Session save email
                        Session["UserEmail"] = txtLoginEmail.Text;
                        string GetUserEmail = Session["UserEmail"].ToString();

                        //Session save id
                        string cmd2 = "Select studId from Student where studEmail=@studEmail";
                        SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                        cmdSelect2.Parameters.AddWithValue("@studEmail", GetUserEmail);
                        DataTable dt2 = new DataTable();
                        SqlDataAdapter sda2 = new SqlDataAdapter(cmdSelect2);
                        sda2.Fill(dt2);
                        Int64 UserId = Convert.ToInt64(dt2.Rows[0][0]);
                        Session["UserId"] = UserId.ToString();

                        //Session save name
                        string cmd3 = "Select studName from Student where studEmail=@studEmail";
                        SqlCommand cmdSelect3 = new SqlCommand(cmd3, con);
                        cmdSelect3.Parameters.AddWithValue("@studEmail", GetUserEmail);
                        string UserName = cmdSelect3.ExecuteScalar().ToString();
                        Session["UserName"] = UserName.ToString();
                        con.Close();

                        //Session save role
                        Session["Role"] = "stud";

                        Response.Redirect("Homepage.aspx");
                       // Response.Write("<script>alert('" + Session["UserEmail"] + Session["UserId"] + Session["UserName"] + Session["Role"] + "') </script>");
                    }
                    else
                    {
                        con.Close();
                        MsgError.Visible = true;
                    }

                }
                else
                {
                    con.Close();
                    //Educator
                    con.Open();
                    string cmd4 = "Select * from Educator where eduEmail=@eduEmail and eduPassword=@eduPassword";
                    SqlCommand cmdSelect4 = new SqlCommand(cmd4, con);
                    cmdSelect4.Parameters.AddWithValue("@eduEmail", txtLoginEmail.Text);
                    cmdSelect4.Parameters.AddWithValue("@eduPassword", txtLoginPassword.Text);

                    DataTable dt4 = new DataTable();
                    SqlDataAdapter sda4 = new SqlDataAdapter(cmdSelect4);
                    sda4.Fill(dt4);

                    if (dt4.Rows.Count != 0)
                    {
                        //Check if acc is active (inactive if stud report edu, approve then blocked)
                        string cmd8 = "Select status from Educator where eduEmail=@eduEmail";
                        SqlCommand cmdSelect8 = new SqlCommand(cmd8, con);
                        cmdSelect8.Parameters.AddWithValue("@eduEmail", txtLoginEmail.Text);
                        string UserStatus = cmdSelect8.ExecuteScalar().ToString();

                        if (UserStatus == "active")
                        {
                            //Session save email
                            Session["UserEmail"] = txtLoginEmail.Text;
                            string GetUserEmail = Session["UserEmail"].ToString();

                            //Session save id
                            string cmd5 = "Select eduId from Educator where eduEmail=@eduEmail";
                            SqlCommand cmdSelect5 = new SqlCommand(cmd5, con);
                            cmdSelect5.Parameters.AddWithValue("@eduEmail", GetUserEmail);
                            DataTable dt5 = new DataTable();
                            SqlDataAdapter sda5 = new SqlDataAdapter(cmdSelect5);
                            sda5.Fill(dt5);
                            Int64 UserId = Convert.ToInt64(dt5.Rows[0][0]);
                            Session["UserId"] = UserId.ToString();

                            //Session save name
                            string cmd6 = "Select eduName from Educator where eduEmail=@eduEmail";
                            SqlCommand cmdSelect6 = new SqlCommand(cmd6, con);
                            cmdSelect6.Parameters.AddWithValue("@eduEmail", GetUserEmail);
                            string UserName = cmdSelect6.ExecuteScalar().ToString();
                            Session["UserName"] = UserName.ToString();
                            con.Close();

                            //Session save role
                            Session["Role"] = "stud";

                            Response.Redirect("Homepage.aspx");
                            //Response.Write("<script>alert('" + Session["UserEmail"] + Session["UserId"] + Session["UserName"] + "') </script>");
                        }
                        else
                        {
                            con.Close();
                            MsgError.Visible = true;
                        }

                    }
                    else
                    {
                        con.Close();
                        MsgError.Visible = true;
                    }
                }
            }
            else
            {
                MsgRequired.Visible = true;
            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUpStud.aspx");
        }
        
    }
}