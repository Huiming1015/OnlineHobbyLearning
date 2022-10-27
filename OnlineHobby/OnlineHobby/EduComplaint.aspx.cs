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
    public partial class EduComplaint : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(complaintId),0) from Complaint", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblRequired.Visible = false;
            MsgSuccess.Visible = false;

            //Int64 EduDetailsId = Convert.ToInt64(Session["EduDetailsId"]);
            Int64 EduDetailsId = 201;
            //Int64 UserId = 101;
            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            DateTime now = DateTime.Now;

            if (rblIncidentType.SelectedIndex != -1 && txtReportDesc.Text != "")
            {
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
                string cmd2 = "Insert into Complaint(complaintId,dateComplaint,studId,studName,eduId,eduName,incidentType,description,apprStatus) Values(@id,@date,@studId,@studName,@eduId,@eduName,@incident,@desc,@status)";
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                cmdSelect2.Parameters.AddWithValue("@id", id);
                cmdSelect2.Parameters.AddWithValue("@date", now);
                cmdSelect2.Parameters.AddWithValue("@studId", UserId);
                cmdSelect2.Parameters.AddWithValue("@studName", studName);
                cmdSelect2.Parameters.AddWithValue("@eduId", EduDetailsId);
                cmdSelect2.Parameters.AddWithValue("@eduName", eduName);
                cmdSelect2.Parameters.AddWithValue("@incident", rblIncidentType.SelectedValue);
                cmdSelect2.Parameters.AddWithValue("@desc", txtReportDesc.Text);
                cmdSelect2.Parameters.AddWithValue("@status", "Pending");
                cmdSelect2.ExecuteNonQuery();
                con.Close();

                //Response.Redirect("EduDetails.aspx");
                MsgSuccess.Visible = true;
                clr();
            }
            else
            {
                lblRequired.Visible = true;
            }
        }

        private void clr()
        {
            rblIncidentType.SelectedIndex = -1;
            txtReportDesc.Text = "";
        }
    }
}