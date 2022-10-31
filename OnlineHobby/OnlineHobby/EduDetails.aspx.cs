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
    public partial class EduDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        //Int64 EduDetailsId = Request.QueryString["id"];   //get queryString fr course page, set to session
        //Int64 EduDetailsId = 201; //for testing purpose

        string studName;
        Int64 idFllw, idChat;

        //link to course details page, set Session[EduDetailsId] & get userId
        // message btn
        //get courses
        //check if student of edu or not(rate & report btn visibility)

        //fllw ok le

        protected void Page_Load(object sender, EventArgs e)
        {
            //read edu details
            getEduDetails();
            //read ratings
            getRatings();
            //read followers
            getFollowers();
            //read courses
            //getCourses();
            //read achievements
            getAchievements();

            if (Session["UserEmail"] == null)
            {
                //as guest
                btnFllw.Visible = false;
                btnMsg.Visible = false;
                Panel3.Visible = false;
            }
            else
            {
                string role = Session["Role"].ToString();

                if (role == "edu")
                {
                    //as edu
                    btnFllw.Visible = false;
                    btnMsg.Visible = false;
                    Panel3.Visible = false;
                }
                else
                {
                    //as stud
                    getStudName();

                    //check if stud is the student of edu
                    //btnRate.Visible = false;
                    //btnReport.Visible = false;

                    //check if user follow edu
                    verifyIsFollow();
                }

            }
        }

        //set session["EduDetailsId"] here, so eduComplaint can get it
        private void getEduDetails()
        {
            Int64 EduDetailsId = Convert.ToInt64(Request.QueryString["id"]);
            Session["EduDetailsId"] = EduDetailsId.ToString();
            con = new SqlConnection(strCon);

            con.Open();
            string cmd = "Select eduName,profileImg,joinedDate,about from Educator where eduId =" + EduDetailsId;
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
                lblJoined.Text = String.Format("{0:MMM d, yyyy}", dr.GetValue(2));
                lblAbout.Text = dr.GetValue(3).ToString();

            }
            con.Close();
        }

        private void getRatings()
        {
            Int64 EduDetailsId = Convert.ToInt64(Request.QueryString["id"]);

            double totalRating = 0.0;
            int ratingCount = 0;
            double ratings = 0.0;
            con = new SqlConnection(strCon);

            //con.Open();
            string cmd = "Select * from Ratings where eduId=" + EduDetailsId;
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
            sda.Fill(dt);

            if (dt.Rows.Count != 0)
            {
                con.Open();
                string cmd2 = "Select rate from Ratings where eduId=" + EduDetailsId;
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                SqlDataReader dr = cmdSelect2.ExecuteReader();
                while (dr.Read())
                {
                    totalRating += Convert.ToDouble(dr["rate"]);
                    ratingCount++;
                }
                ratings = totalRating / (double)ratingCount;
                lblRate.Text = String.Format("{0:N1}", ratings);
                con.Close();
            }
            else
            {
                lblRate.Text = "0.0";
            }
            con.Close();
        }

        private void getFollowers()
        {
            Int64 EduDetailsId = Convert.ToInt64(Request.QueryString["id"]);

            con = new SqlConnection(strCon);

            con.Open();
            string cmd3 = "SELECT COUNT(fllwId) FROM FollowEngagement where eduId=" + EduDetailsId;
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

        private void getAchievements()
        {
            Int64 EduDetailsId = Convert.ToInt64(Request.QueryString["id"]);

            con = new SqlConnection(strCon);

            con.Open();
            string cmd5 = "Select * from Achievements where eduId =" + EduDetailsId;
            SqlCommand cmdSelect5 = new SqlCommand(cmd5, con);

            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmdSelect5);
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                Panel1.Visible = false;
            }
            else
            {
                Panel1.Visible = true;
            }
            con.Close();
        }

        private void getStudName()
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);

            con.Open();
            string cmd3 = "SELECT studName FROM Student where studId=" + UserId;
            SqlCommand cmdSelect3 = new SqlCommand(cmd3, con);
            studName = Convert.ToString(cmdSelect3.ExecuteScalar());
        }

        private void verifyIsFollow()
        {
            Int64 EduDetailsId = Convert.ToInt64(Request.QueryString["id"]);
            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            con.Open();
            string cmd = "Select * from FollowEngagement where eduId=" + EduDetailsId + "and studId=" + UserId;
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
            sda.Fill(dt);

            if (dt.Rows.Count != 0)
            {
                btnFllw.InnerHtml = "Following";
            }
            con.Close();
        }

        protected void lbtnEduAbout_Click(object sender, EventArgs e)
        {
            Response.Redirect("EduDetails.aspx");
        }

        protected void lbtnEduDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("EduDetails2.aspx");
        }

        protected void functionFollow(object sender, EventArgs e)
        {
            Int64 EduDetailsId = Convert.ToInt64(Request.QueryString["id"]);

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            if (btnFllw.InnerText == "Following")
            {
                con.Open();
                string cmd = "Delete from FollowEngagement where eduId=" + EduDetailsId + "and studId=" + UserId;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.ExecuteNonQuery();
                con.Close();

                //btn text back to icon + follow
                Response.Redirect("EduDetails.aspx");
            }
            else
            {
                AutoGenerateUserIDFollow();

                con.Open();
                string cmd2 = "Insert into FollowEngagement(fllwId,studId,studName,eduId,eduName) Values('" + idFllw + "','" + UserId + "','" + studName + "','" + EduDetailsId + "','" + lblName.Text + "')";
                SqlCommand cmdSelect = new SqlCommand(cmd2, con);
                cmdSelect.ExecuteNonQuery();
                con.Close();

                btnFllw.InnerText = "Following";
                Response.Redirect("EduDetails.aspx");

            }
        }

        protected void functionMessage(object sender, EventArgs e)
        {
            Int64 EduDetailsId = Convert.ToInt64(Request.QueryString["id"]);
            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            con.Open();
            string cmd = "Select * from Chat where eduId=" + EduDetailsId + "and studId=" + UserId;
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                AutoGenerateUserIDChat();

                con.Open();
                string cmd2 = "Insert into Chat(chatId,studId,studName,eduId,eduName) Values('" + idChat + "','" + UserId + "','" + studName + "','" + EduDetailsId + "','" + lblName.Text + "')";
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                cmdSelect2.ExecuteNonQuery();
                con.Close();

                Response.Redirect("Chat.aspx"); //go chat Details page
            }
            else
            {
                Response.Redirect("Chat.aspx"); //go chat Details page
            }
            con.Close();

        }

        private void AutoGenerateUserIDFollow()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(fllwId),0) from FollowEngagement", con);
            idFllw = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();
        }

        private void AutoGenerateUserIDChat()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(chatId),0) from Chat", con);
            idChat = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();
        }
        
    }
}