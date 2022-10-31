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
                con.Close();
                getFollowing();
                //getCourses();
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
                con.Close();
                getFollowers();
                getRatings();

            }

        }

        private void getFollowing()
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);

            con = new SqlConnection(strCon);

            con.Open();
            string cmd3 = "SELECT COUNT(fllwId) FROM Follower where studId=" + UserId;
            SqlCommand cmdSelect3 = new SqlCommand(cmd3, con);

            Int64 count = Convert.ToInt64(cmdSelect3.ExecuteScalar());
            if (count > 0)
            {
                lblFllw.Text = count.ToString();
            }
            else
            {
                lblFllw.Text = "0";
            }
            con.Close();
        }

        private void getCourses()
        {
            //nothing
        }

        private void getFollowers()
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);

            con = new SqlConnection(strCon);

            con.Open();
            string cmd3 = "SELECT COUNT(fllwId) FROM Follower where eduId=" + UserId;
            SqlCommand cmdSelect3 = new SqlCommand(cmd3, con);
            Int64 count = Convert.ToInt64(cmdSelect3.ExecuteScalar());
            if (count > 0)
            {
                lblFllw.Text = count.ToString();
            }
            else
            {
                lblFllw.Text = "0";
            }
            con.Close();
        }

        private void getRatings()
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);

            double totalRating = 0.0;
            int ratingCount = 0;
            double ratings = 0.0;
            con = new SqlConnection(strCon);

            //con.Open();
            string cmd = "Select * from Ratings where eduId=" + UserId;
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
            sda.Fill(dt);

            if (dt.Rows.Count != 0)
            {
                con.Open();
                string cmd2 = "Select rate from Ratings where eduId=" + UserId;
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                SqlDataReader dr = cmdSelect2.ExecuteReader();
                while (dr.Read())
                {
                    totalRating += Convert.ToDouble(dr["rate"]);
                    ratingCount++;
                }
                ratings = totalRating / (double)ratingCount;
                lblRateOrCourses.Text = String.Format("{0:N1}", ratings);
                con.Close();
            }
            else
            {
                lblRateOrCourses.Text = "0.0";
            }
            con.Close();
        }

    }
}