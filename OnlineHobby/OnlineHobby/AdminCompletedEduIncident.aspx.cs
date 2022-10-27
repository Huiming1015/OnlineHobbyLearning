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
    public partial class AdminCompletedEduIncident : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] != null)
            {
                con = new SqlConnection(strCon);
                con.Open();
                string cmd = "Select * from Complaint where apprStatus=@status or apprStatus=@status2";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@status", "Approve");
                cmdSelect.Parameters.AddWithValue("@status2", "Reject");

                DataTable dt = new DataTable();
                SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
                sda.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    con.Close();
                    PanelTableHeader.Visible = false;
                    Repeater1.Visible = false;
                    MsgNotice.Visible = true;
                    Panel1.Visible = true;
                    Panel2.Visible = true;
                }

                if (dt.Rows.Count == 1 || dt.Rows.Count == 2 || dt.Rows.Count == 3)
                {
                    con.Close();
                    Panel1.Visible = true;
                    Panel2.Visible = true;
                }

                if (dt.Rows.Count == 4 || dt.Rows.Count == 5 || dt.Rows.Count == 6)
                {
                    con.Close();
                    Panel2.Visible = true;
                }
            }
            else
            {
                Response.Redirect("AdminLogin.aspx");
            }
               
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                Response.Redirect("AdminCompletedEduIncidentDetails.aspx?id=" + e.CommandArgument.ToString());
            }
        }

        protected void btnPending_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminPendingEduIncident.aspx");
        }

        protected void btnCompleted_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminCompletedEduIncident.aspx");
        }
    }
}