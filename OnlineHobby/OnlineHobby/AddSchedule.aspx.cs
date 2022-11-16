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
    public partial class AddSchedule : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        string strCourseId, strScheduleID;
        int intCountID;
        string scheduleSelected;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["modifyCourseId"] != null)
            {
                strCourseId = Request.QueryString["modifyCourseId"];
            }
            else
            {
                strCourseId = Request.QueryString["courseId"];
            }
            getScheduleData();
            strScheduleID = GenerateScheduleID();
        }

        protected void btnAddSchedule_Click(object sender, EventArgs e)
        {
            DateTime day;
            day = DateTime.Parse(txtStartDate.Text.ToString());

            try
            {
                string strQAddSchedule;
                con = new SqlConnection(strCon);
                con.Open();
                strQAddSchedule = "INSERT INTO [CourseSchedule](scheduleId, courseId, tutoringMode, meetingLink, maxStud, price, day, numEnrolled) VALUES (@ScheduleId, @CourseId, @TutoringMode, @MeetingLink, @MaxStud, @Price, @Day, @NumEnrolled)";
                SqlCommand comAdd = new SqlCommand(strQAddSchedule, con);
                comAdd.Parameters.AddWithValue("@ScheduleId", strScheduleID);
                comAdd.Parameters.AddWithValue("@CourseId", strCourseId);
                comAdd.Parameters.AddWithValue("@TutoringMode", ddlTutoringMode.SelectedItem.Text.ToString());
                comAdd.Parameters.AddWithValue("@MeetingLink", txtMeetLink.Text.ToString());
                comAdd.Parameters.AddWithValue("@MaxStud", Convert.ToInt64(txtMaxStud.Text.ToString()));
                comAdd.Parameters.AddWithValue("@Price", decimal.Parse(txtPrice.Text.ToString()));
                comAdd.Parameters.AddWithValue("@Day", day.ToString("dddd"));
                comAdd.Parameters.AddWithValue("@NumEnrolled", 0);
                int k = comAdd.ExecuteNonQuery();

                for (Int64 i = 0; i < GetTotalClass(); i++)
                {
                    string strQAddList;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQAddList = "INSERT INTO [ScheduleList](scheduleListId, scheduleId, date, startTime, endTime) VALUES (@ScheduleListId, @ScheduleId, @Date, @StartTime, @EndTime)";
                    SqlCommand comAddList = new SqlCommand(strQAddList, con);
                    comAddList.Parameters.AddWithValue("@ScheduleListId", GenerateScheduleListID());
                    comAddList.Parameters.AddWithValue("@ScheduleId", strScheduleID);
                    comAddList.Parameters.AddWithValue("@Date", day.ToShortDateString());
                    comAddList.Parameters.AddWithValue("@StartTime", DateTime.Parse(txtTime.Text).ToShortTimeString());
                    comAddList.Parameters.AddWithValue("@EndTime", DateTime.Parse(txtTime.Text).AddMinutes(double.Parse(ddlDuration.SelectedValue)).ToShortTimeString());
                    int m = comAddList.ExecuteNonQuery();
                    if (m != 0)
                    {
                        getListData();
                        day = day.AddDays(7);
                    }
                    con.Close();
                }
                if (k != 0)
                {
                    getScheduleData();
                    Clear();
                }

                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        protected void gvCourseSchedule_SelectedIndexChanged(object sender, EventArgs e)
        {
            scheduleSelected = gvCourseSchedule.SelectedRow.Cells[1].Text;
            String strQGet;
            con = new SqlConnection(strCon);
            con.Open();
            strQGet = "SELECT * FROM [ScheduleList] where scheduleId = @ScheduleId";
            SqlCommand com = new SqlCommand(strQGet, con);
            com.Parameters.AddWithValue("@ScheduleId", scheduleSelected);
            SqlDataReader dr = com.ExecuteReader();
            gvScheduleList.DataSource = dr;
            gvScheduleList.DataBind();
            con.Close();
        }

        protected void gvCourseSchedule_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string strQRemoveSchedule, strQRemoveList;
            con = new SqlConnection(strCon);
            con.Open();
            strQRemoveSchedule = "DELETE FROM CourseSchedule WHERE scheduleId = @ScheduleId";
            SqlCommand comRemoveSchedule = new SqlCommand(strQRemoveSchedule, con);
            comRemoveSchedule.Parameters.AddWithValue("@ScheduleId", gvCourseSchedule.DataKeys[e.RowIndex].Values[0].ToString());
            int k = comRemoveSchedule.ExecuteNonQuery();

            strQRemoveList = "DELETE FROM ScheduleList WHERE scheduleId =  @ScheduleId";
            SqlCommand comRemoveList = new SqlCommand(strQRemoveList, con);
            comRemoveList.Parameters.AddWithValue("@ScheduleId", gvCourseSchedule.DataKeys[e.RowIndex].Values[0].ToString());
            int m = comRemoveList.ExecuteNonQuery();

            if (k != 0)
            {
                getScheduleData();
                getListData();
            }
            con.Close();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            String strQSchedule;
            int count = 0;
            con = new SqlConnection(strCon);
            con.Open();
            strQSchedule = "Select courseId from CourseSchedule where courseId = @CourseId";
            SqlCommand com = new SqlCommand(strQSchedule, con);
            com.Parameters.AddWithValue("@CourseId", strCourseId);
            SqlDataReader dr = com.ExecuteReader();
            while (dr.Read())
            {
                count += 1;
            }
            con.Close();
            if (count >= 1)
            {
                Response.Redirect("LinkMaterial.aspx?courseId=" + strCourseId);
            }
            else
            {
                MsgBox("Please add at least one schedule for the course!", this.Page, this);
            }

        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        private void getScheduleData()
        {
            String strQGet;
            con = new SqlConnection(strCon);
            con.Open();
            strQGet = "Select * from [CourseSchedule] where courseId = @CourseId";
            SqlCommand com = new SqlCommand(strQGet, con);
            com.Parameters.AddWithValue("@CourseId", strCourseId);
            SqlDataReader dr = com.ExecuteReader();
            gvCourseSchedule.DataSource = dr;
            gvCourseSchedule.DataBind();
            con.Close();
        }

        private void getListData()
        {
            String strQGet;
            con = new SqlConnection(strCon);
            con.Open();
            strQGet = "SELECT * FROM [ScheduleList] where scheduleId = @ScheduleId";
            SqlCommand com = new SqlCommand(strQGet, con);
            com.Parameters.AddWithValue("@ScheduleId", strScheduleID);
            SqlDataReader dr = com.ExecuteReader();
            gvScheduleList.DataSource = dr;
            gvScheduleList.DataBind();
            con.Close();
        }

        protected void ddlTutoringMode_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (ddlTutoringMode.SelectedValue.ToString() == "oneToOne")
            {
                txtMaxStud.Text = "1";
                txtMaxStud.Enabled = false;
            }
            else
            {
                txtMaxStud.Text = "";
                txtMaxStud.Enabled = true;
            }
        }

        private void Clear()
        {
            txtMaxStud.Text = "";
            txtMeetLink.Text = "";
            txtPrice.Text = "";
            txtStartDate.Text = "";
            txtTime.Text = "";
            ddlTutoringMode.SelectedValue = "oneToMany";
        }

        private string GenerateScheduleID()
        {
            string id = "";
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "Select scheduleId from CourseSchedule";
            SqlCommand comID = new SqlCommand(strQ, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["scheduleId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            con.Close();
            return "S" + intCountID.ToString("0000");
        }

        private Int64 GenerateScheduleListID()
        {
            Int64 id;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "Select IsNull(max(scheduleListId),0) from ScheduleList";
            SqlCommand comID = new SqlCommand(strQ, con);
            id = Convert.ToInt64(comID.ExecuteScalar()) + 1;
            con.Close();
            return id;
        }

        private Int64 GetTotalClass()
        {
            Int64 num;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "Select totalClass from Course where courseId = @CourseId";

            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@CourseId", strCourseId);
            num = Convert.ToInt64(com.ExecuteScalar());
            con.Close();
            return num;
        }
    }
}