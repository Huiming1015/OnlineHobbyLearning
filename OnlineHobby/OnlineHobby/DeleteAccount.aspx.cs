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
    public partial class DeleteAccount : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            btnDelete.Enabled = false;
        }

        protected void txtVerify_TextChanged(object sender, EventArgs e)
        {
            if (txtVerify.Text == "delete my account")
            {
                btnDelete.Enabled = true;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
                Int64 UserId = Convert.ToInt64(Session["UserId"]);
                string role = Session["Role"].ToString();

                con = new SqlConnection(strCon);

                if (role == "stud")
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("Update Student set status=@status where studId=@UserId", con);
                    cmd.Parameters.AddWithValue("@status", "inactive");
                    cmd.Parameters.AddWithValue("@UserId", UserId);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
                else
                {
                    con.Open();
                    SqlCommand cmd2 = new SqlCommand("Update Educator set status=@status where eduId=@UserId", con);
                    cmd2.Parameters.AddWithValue("@status", "inactive");
                    cmd2.Parameters.AddWithValue("@UserId", UserId);
                    cmd2.ExecuteNonQuery();
                    con.Close();
                }

                Session.RemoveAll();
                Response.Redirect("Homepage.aspx");
        }
    }
}