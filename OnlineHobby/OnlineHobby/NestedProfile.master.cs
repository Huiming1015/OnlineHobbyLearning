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
    public partial class NestedProfile : System.Web.UI.MasterPage
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            string role = Session["Role"].ToString();

            con = new SqlConnection(strCon);

            if (role == "stud")
            {
                lblRateCoursesWord.Text = "Courses";
                lblFllwWord.Text = "Following";
                pnlFollowing.Visible = true;
                pnlFollowers.Visible = false;
                pnlDashboard.Visible = false;
                pnlAchivements.Visible = false;

                con.Open();
                string cmd = "Select studName,profileImg from Student where studId =" + UserId;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                SqlDataReader dr = cmdSelect.ExecuteReader();
                while (dr.Read())
                {

                    lblName.Text = dr.GetValue(0).ToString();
                    if (dr.GetValue(1) == DBNull.Value)
                    {
                        imgProfile.ImageUrl = "~/Resources/profile_orange.png";
                    }
                    else
                    {
                        imgProfile.ImageUrl = dr.GetValue(1).ToString();
                    }

                }
            }
            else
            {
                lblRateCoursesWord.Text = "Ratings";
                lblFllwWord.Text = "Followers";
                pnlFollowing.Visible = false;
                pnlFollowers.Visible = true;
                pnlAddressBook.Visible = false;

                con.Open();
                string cmd = "Select eduName,profileImg from Educator where eduId =" + UserId;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                SqlDataReader dr = cmdSelect.ExecuteReader();
                while (dr.Read())
                {

                    lblName.Text = dr.GetValue(0).ToString();
                    if (dr.GetValue(1) == DBNull.Value)
                    {
                        imgProfile.ImageUrl = "~/Resources/profile_orange.png";
                    }
                    else
                    {
                        imgProfile.ImageUrl = dr.GetValue(1).ToString();
                    }

                }

            }

        }
        
    }
}