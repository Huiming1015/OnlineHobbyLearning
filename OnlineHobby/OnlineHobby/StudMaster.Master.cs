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
    public partial class StudMaster : System.Web.UI.MasterPage
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                //login success
                lbtnLogin.Visible = false;
                lbtnSignUp.Visible = false;
                lbtnLogout.Visible = true;
                divider.Visible = true;
                lbtnMyProfile.Visible = true;
                lbtnMyOrder.Visible = true;
                lbtnChats.Visible = true;
                lbtnCourseTimetable.Visible = true;

                Int64 UserId = Convert.ToInt64(Session["UserId"]);
                string role = Session["Role"].ToString();

                con = new SqlConnection(strCon);

                if (role == "stud")
                {
                    con.Open();
                    string cmd = "Select profileImg from Student where studId =" + UserId;
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    SqlDataReader dr = cmdSelect.ExecuteReader();
                    while (dr.Read())
                    {
                        if (dr.GetValue(0) == DBNull.Value)
                        {
                            imgProfile.ImageUrl = "~/Resources/profile_orange.png";
                        }
                        else
                        {
                            imgProfile.ImageUrl = dr.GetValue(0).ToString();
                        }

                    }
                }
                else
                {
                    con.Open();
                    string cmd = "Select profileImg from Educator where eduId =" + UserId;
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    SqlDataReader dr = cmdSelect.ExecuteReader();
                    while (dr.Read())
                    {
                        if (dr.GetValue(0) == DBNull.Value)
                        {
                            imgProfile.ImageUrl = "~/Resources/profile_orange.png";
                        }
                        else
                        {
                            imgProfile.ImageUrl = dr.GetValue(0).ToString();
                        }

                    }

                }
            }
            else
            {
                //no login, just a guest
                lbtnLogin.Visible = true;
                lbtnSignUp.Visible = true;
                lbtnLogout.Visible = false;
                divider.Visible = false;
                lbtnMyProfile.Visible = false;
                lbtnMyOrder.Visible = false;
                lbtnChats.Visible = false;
                lbtnCourseTimetable.Visible = false;

            }
        }

        protected void lbtnLogout_Click(object sender, EventArgs e)
        {
            //Session["UserEmail"] = null;
            //Session["Role"] = null;
            Session.RemoveAll();
            Response.Redirect("Homepage.aspx");
        }

        protected void lbtnSignUp_Click(object sender, EventArgs e)
        {
            Response.Redirect("SignUpStud.aspx");
        }

        protected void lbtnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("LogIn.aspx");
        }

        protected void lbtnMyProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        } 
    }
}