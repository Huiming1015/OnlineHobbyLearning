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
    public partial class LogInAdmin : System.Web.UI.Page
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
                string cmd = "Select * from Admin where adminEmail=@adminEmail and adminPassword=@adminPassword";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@adminEmail", txtLoginEmail.Text);
                cmdSelect.Parameters.AddWithValue("@adminPassword", txtLoginPassword.Text);

                DataTable dt = new DataTable();
                SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
                sda.Fill(dt);

                if (dt.Rows.Count != 0)
                {
                    //Session save email
                    Session["UserEmail"] = txtLoginEmail.Text;
                    string GetUserEmail = Session["UserEmail"].ToString();

                    //Session save id
                    string cmd2 = "Select adminId from Admin where adminEmail=@adminEmail";
                    SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                    cmdSelect2.Parameters.AddWithValue("@adminEmail", GetUserEmail);
                    DataTable dt2 = new DataTable();
                    SqlDataAdapter sda2 = new SqlDataAdapter(cmdSelect2);
                    sda2.Fill(dt2);
                    Int64 UserId = Convert.ToInt64(dt2.Rows[0][0]);
                    Session["UserId"] = UserId.ToString();

                    //Session save name
                    string cmd3 = "Select adminName from Admin where adminEmail=@adminEmail";
                    SqlCommand cmdSelect3 = new SqlCommand(cmd3, con);
                    cmdSelect3.Parameters.AddWithValue("@adminEmail", GetUserEmail);
                    string UserName = cmdSelect3.ExecuteScalar().ToString();
                    Session["UserName"] = UserName.ToString();
                    con.Close();

                    //Session save role
                    Session["Role"] = "admin";

                    //Response.Redirect("Homepage.aspx");
                    Response.Write("<script>alert('" + Session["UserEmail"] + Session["UserId"] + Session["UserName"] + Session["Role"] + "') </script>");
                }
                else
                {
                    con.Close();
                    MsgError.Visible = true;
                }
            }
            else
            {
                MsgRequired.Visible = true;
            }
        }
    }
}