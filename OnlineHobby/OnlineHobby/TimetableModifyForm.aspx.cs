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
    public partial class TimetableModifyForm : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        Int16 duration;
        protected void Page_Load(object sender, EventArgs e)
        {
            con = new SqlConnection(strCon);
            string scheduleId = "";

            if (!IsPostBack)
            {
                List<ListItem> items = new List<ListItem>();
                con.Open();
                string cmd = "SELECT scheduleId FROM EnrolDetails WHERE enrolDetailId=@enrolDetailId";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@enrolDetailId", Session["enrolDetailsId"]);
                scheduleId = cmdSelect.ExecuteScalar().ToString();
                con.Close();
                con.Open();
                string strQ = "Select scheduleListId, date, DATEDIFF(MINUTE, startTime , endTime) AS MinuteDiff from ScheduleList WHERE scheduleId='" + scheduleId + "'";
                SqlCommand com = new SqlCommand(strQ, con);
                SqlDataReader dr = com.ExecuteReader();
                if (dr.HasRows)
                {
                    int i = 0;
                    while (dr.Read())
                    {
                        duration = Convert.ToInt16(dr["MinuteDiff"]);
                        string dateSchedule = Convert.ToDateTime(dr["date"]).ToShortDateString();
                        if (Convert.ToDateTime(dateSchedule) > DateTime.Today)
                        {
                            ddlDate.Items.Add(new ListItem(dateSchedule, dr["scheduleListId"].ToString()));
                            i++;
                        }
                    }
                }
                dr.Close();
                con.Close();
            }
            con.Open();
            string strQ1 = "Select DATEDIFF(MINUTE, startTime , endTime) AS MinuteDiff from ScheduleList WHERE scheduleListId=@ScheduleListId";
            SqlCommand com1 = new SqlCommand(strQ1, con);
            com1.Parameters.AddWithValue("@scheduleListId", ddlDate.SelectedValue.ToString());
            SqlDataReader dr1 = com1.ExecuteReader();
            if (dr1.HasRows)
            {
                while (dr1.Read())
                {
                    duration = Convert.ToInt16(dr1["MinuteDiff"]);
                }
            }
            dr1.Close();
            con.Close();
            if (ddlDate.Items.Count <= 0)
            {
                lblCantModify.Visible = true;
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Session["enrolDetailsId"] != null)
            {
                if (Convert.ToDateTime(txtNewDate.Text) <= DateTime.Today)
                {
                    MsgBox("The new date should not be today or before today!", this.Page, this);
                }
                else
                {
                    try
                    {
                        con = new SqlConnection(strCon);
                        con.Open();
                        string cmd2 = "Insert into ModificationRequest(modificationId,enrolDetailId,scheduleListId,newStartTime,newEndTime,newDate,modificationStatus) Values(@modificationId,@enrolDetailId,@scheduleListId,@newStartTime,@newEndTime,@newDate,@modificationStatus)";
                        SqlCommand comInsert = new SqlCommand(cmd2, con);
                        comInsert.Parameters.AddWithValue("@modificationId", GenerateID());
                        comInsert.Parameters.AddWithValue("@enrolDetailId", Session["enrolDetailsId"]);
                        comInsert.Parameters.AddWithValue("@scheduleListId", ddlDate.SelectedValue.ToString());
                        comInsert.Parameters.AddWithValue("@newStartTime", Convert.ToDateTime(txtNewTime.Text).ToShortTimeString());
                        comInsert.Parameters.AddWithValue("@newEndTime", Convert.ToDateTime(txtNewTime.Text).AddMinutes(duration).ToShortTimeString());
                        comInsert.Parameters.AddWithValue("@newDate", Convert.ToDateTime(txtNewDate.Text).ToShortDateString());
                        comInsert.Parameters.AddWithValue("@modificationStatus", "Pending");
                        int k = comInsert.ExecuteNonQuery();
                        con.Close();
                        if (k != 0)
                        {
                            MsgBox("Your request has been sent successfully!" + duration.ToString(), this.Page, this);
                            ClientScript.RegisterStartupScript(this.GetType(), "RefreshParent", "<script language='javascript'>RefreshParent()</script>");
                        }
                    }
                    catch
                    {
                        MsgBox("Please insert the valid data into all required field!", this.Page, this);
                    }
                }
            }
        }

        private Int64 GenerateID()
        {
            Int64 id;
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(modificationId),0) from ModificationRequest", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();
            return id;
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }
    }
}