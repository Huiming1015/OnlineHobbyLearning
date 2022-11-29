using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
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
    public partial class AdminReports : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminId"] != null)
            {
                DateTime now = DateTime.Now;
                //Response.Write("<script>alert('" + today + now + "') </script>");
                lblReportFllwDate.Text = now.ToShortDateString();
            }
            else
            {
                Response.Redirect("AdminLogin.aspx");
            }
        }

        protected void btnTopFollwer_Click(object sender, EventArgs e)
        {
            MsgNotice.Visible = false;

            con = new SqlConnection(strCon);

            con.Open();
            string cmd = "select * from Follower";
            SqlCommand cmdSelect = new SqlCommand(cmd, con);

            DataTable dt = new DataTable();
            SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
            sda.Fill(dt);

            if (dt.Rows.Count == 0)
            {
                con.Close();
                MsgNotice.Visible = true;
            }
            else
            {
                string sql = " select * from Follower ";
                DataSet ds = new DataSet();
                SqlDataAdapter adp = new SqlDataAdapter(sql, con);
                adp.Fill(ds);

                ReportDocument crystalReport = new ReportDocument();
                crystalReport.Load(Server.MapPath("~/CrystalReportTop5MostFollowed.rpt"));
                crystalReport.SetDataSource(ds.Tables["table"]);
                CrystalReportViewer1.ReportSource = crystalReport;
                crystalReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "Report of Top 5 Most-Followed Educators");
            }
        }

        protected void btnNewEduJoined_Click(object sender, EventArgs e)
        {
            lblMonthRequired.Visible = false;
            lblYearRequired.Visible = false;
            MsgNotice.Visible = false;

            con = new SqlConnection(strCon);

            if (ddlMonth.SelectedIndex == 0)
            {
                lblMonthRequired.Visible = true;
            }

            if (ddlYear.SelectedIndex == 0)
            {
                lblYearRequired.Visible = true;
            }
            //Select S.studName, C.courseId, C.courseName from Student S inner join EnrolledCourse EC on S.studId=EC.studId inner join EnrolDetails ED on EC.enrollmentId=ED.enrollmentId inner join CourseSchedule CS on ED.scheduleId=CS.scheduleId inner join Course C on CS.courseId=C.courseId

            if (ddlMonth.SelectedIndex != 0 && ddlYear.SelectedIndex != 0)
            {
                con.Open();
                string cmd = "select * from Educator where month(joinedDate)=" + ddlMonth.SelectedValue + "and year(joinedDate)=" + ddlYear.SelectedValue;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);

                DataTable dt = new DataTable();
                SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
                sda.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    con.Close();
                    MsgNotice.Visible = true;
                }
                else
                {
                    string sql = "select * from Educator where month(joinedDate)=" + ddlMonth.SelectedValue + "and year(joinedDate)=" + ddlYear.SelectedValue;
                    DataSet ds = new DataSet();
                    SqlDataAdapter adp = new SqlDataAdapter(sql, con);
                    adp.Fill(ds);

                    ReportDocument crystalReport = new ReportDocument();
                    crystalReport.Load(Server.MapPath("~/CrystalReportNewEduJoined.rpt"));
                    crystalReport.SetDataSource(ds.Tables["table"]);
                    crystalReport.SetParameterValue("month", ddlMonth.SelectedItem.Text);
                    crystalReport.SetParameterValue("year", ddlYear.SelectedItem.Text);
                    CrystalReportViewer2.ReportSource = crystalReport;
                    crystalReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "Report of Monthly New Educator Joined");
                }
            }
        }

        protected void btnCommissionReport_Click(object sender, EventArgs e)
        {
            lblMonthRequired.Visible = false;
            lblYearRequired.Visible = false;
            MsgNotice.Visible = false;

            con = new SqlConnection(strCon);

            if (ddlMonth.SelectedIndex == 0)
            {
                lblMonthRequired.Visible = true;
            }

            if (ddlYear.SelectedIndex == 0)
            {
                lblYearRequired.Visible = true;
            }

            if (ddlMonth.SelectedIndex != 0 && ddlYear.SelectedIndex != 0)
            {
                con.Open();
                string cmd = "select * from Payment where month(paymentDate)=" + ddlMonth.SelectedValue + "and year(paymentDate)=" + ddlYear.SelectedValue;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);

                DataTable dt = new DataTable();
                SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
                sda.Fill(dt);

                if (dt.Rows.Count == 0)
                {
                    con.Close();
                    MsgNotice.Visible = true;
                }
                else
                {
                    string sqlPayment = "Select Distinct P.paymentId , P.refundAmount, P.discountAmount, P.paymentAmount, E.eduId, E.eduName, E.eduEmail from Payment P inner join MaterialOrder MO on P.paymentId=MO.paymentId inner join EnrolledCourse EC ON P.paymentId=EC.paymentId INNER JOIN OrderDetails OD On MO.orderId = OD.orderId INNER JOIN MaterialKit MK ON OD.materialId = MK.materialId inner join EnrolDetails ED On ED.enrollmentId = EC.enrollmentId INNER JOIN CourseSchedule CS ON ED.scheduleId = CS.scheduleId INNER JOIN Course C ON CS.courseId = C.courseId INNER JOIN Educator E ON (MK.eduId=E.eduId or C.eduId=E.eduId) WHERE month(P.paymentDate)=" + ddlMonth.SelectedValue + " and year(P.paymentDate)=" + ddlYear.SelectedValue + "";
                    DataSet ds = new DataSet();
                    SqlDataAdapter adp = new SqlDataAdapter(sqlPayment, con);

                    adp.Fill(ds);

                    con.Close();
                    // string sql = "Select SUM(P.paymentAmount-P.refundAmount) as totalReceived, MAX(MK.eduId) as eduId, MAX(E.eduName) as eduName, MAX(E.eduEmail) as eduEmail from Payment P inner join MaterialOrder MO on P.paymentId=MO.paymentId INNER JOIN OrderDetails OD On MO.orderId = OD.orderId INNER JOIN MaterialKit MK ON OD.materialId = MK.materialId inner join EnrolledCourse EC ON P.paymentId = EC.paymentId inner join EnrolDetails ED On ED.enrollmentId = EC.enrollmentId INNER JOIN CourseSchedule CS ON ED.scheduleId = CS.scheduleId INNER JOIN Course C ON CS.courseId = C.courseId INNER JOIN Educator E ON (MK.eduId=E.eduId OR C.eduId=E.eduId) WHERE month(P.paymentDate)='" + ddlMonth.SelectedValue + "' and year(P.paymentDate)='" + ddlYear.SelectedValue + "' GROUP BY E.eduId";
                    //DataSet ds = new DataSet();
                    // SqlDataAdapter adp = new SqlDataAdapter(sql, con);
                    //adp.Fill(ds);
                    ReportDocument crystalReport = new ReportDocument();
                    crystalReport.Load(Server.MapPath("~/CrystalReportCommission.rpt"));
                    crystalReport.SetDataSource(ds.Tables["table"]);
                    crystalReport.SetParameterValue("month", ddlMonth.SelectedItem.Text);
                    crystalReport.SetParameterValue("year", ddlYear.SelectedItem.Text);
                    CrystalReportViewer3.ReportSource = crystalReport;
                    crystalReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "Report of Monthly Commission");
                }
            }
        }
    }
}