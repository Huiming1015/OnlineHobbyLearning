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
	public partial class EduRate : System.Web.UI.Page
	{
        Int64 id;

        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
		{

		}

        protected void Rating1_Click(object sender, AjaxControlToolkit.RatingEventArgs e)
        {
            lblRatingStatus.Visible = false;

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            Int64 EduDetailsId = Convert.ToInt64(Session["EduDetailsId"]);

            con = new SqlConnection(strCon);

            //get stud Name
            con.Open();
            string cmd = "Select studName from Student where studId =" + UserId;
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            string studName = cmdSelect.ExecuteScalar().ToString();
            con.Close();

            //get edu name
            con.Open();
            string cmd1 = "Select eduName from Educator where eduId =" + EduDetailsId;
            SqlCommand cmdSelect1 = new SqlCommand(cmd1, con);
            string eduName = cmdSelect1.ExecuteScalar().ToString();
            con.Close();

            AutoGenerateUserID();

            con.Open();
            string cmd2 = "Insert into Ratings(ratingId,studId,studName,eduId,eduName,rate) Values(@id,@studId,@studName,@eduId,@eduName,@rate)";
            SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
            cmdSelect2.Parameters.AddWithValue("@id", id);
            cmdSelect2.Parameters.AddWithValue("@studId", UserId);
            cmdSelect2.Parameters.AddWithValue("@studName", studName);
            cmdSelect2.Parameters.AddWithValue("@eduId", EduDetailsId);
            cmdSelect2.Parameters.AddWithValue("@eduName", eduName);
            cmdSelect2.Parameters.AddWithValue("@rate", Convert.ToDecimal(e.Value.ToString()));
            cmdSelect2.ExecuteNonQuery();
            con.Close();


            lblRatingStatus.Text = "*Your rating is " + e.Value.ToString() + ". Thank you for your feedback.";
            lblRatingStatus.Visible = true;
        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(ratingId),0) from Ratings", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();

        }
    }
}