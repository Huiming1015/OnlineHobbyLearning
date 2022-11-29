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
    public partial class EduReports : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnViewTotalIncome_Click(object sender, EventArgs e)
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
                string cmd = "Select * from Payment P inner join MaterialOrder MO on P.paymentId=MO.paymentId inner join EnrolledCourse EC ON P.paymentId=EC.paymentId INNER JOIN OrderDetails OD On MO.orderId = OD.orderId INNER JOIN MaterialKit MK ON OD.materialId = MK.materialId inner join EnrolDetails ED On ED.enrollmentId = EC.enrollmentId INNER JOIN CourseSchedule CS ON ED.scheduleId = CS.scheduleId INNER JOIN Course C ON CS.courseId = C.courseId WHERE (MK.eduId = '" + Session["UserId"] + "' OR C.eduId ='" + Session["UserId"] + "') and month(P.paymentDate)=" + ddlMonth.SelectedValue + "and year(P.paymentDate)=" + ddlYear.SelectedValue;
                SqlCommand cmdSelect = new SqlCommand(cmd, con);

                DataTable dt = new DataTable();
                SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
                sda.Fill(dt);

                if (dt.Rows.Count <= 0)
                {
                    con.Close();
                    MsgNotice.Visible = true;
                }
                else
                {
                    string sqlMaterial = "Select P.discountAmount, OD.materialId, MK.materialName, OD.quantity, OD.unitPrice as priceMaterial from Payment P inner join MaterialOrder MO on P.paymentId = MO.paymentId INNER JOIN OrderDetails OD On MO.orderId = OD.orderId INNER JOIN MaterialKit MK ON OD.materialId = MK.materialId WHERE MK.eduId ='" + Session["UserId"] + "' and month(P.paymentDate)=" + ddlMonth.SelectedValue + "and year(P.paymentDate)=" + ddlYear.SelectedValue;
                    DataSet ds = new DataSet();
                    SqlDataAdapter adp = new SqlDataAdapter(sqlMaterial, con);
                    
                    adp.Fill(ds);
                    
                    string sqlCourse = "Select P.discountAmount, C.courseId, C.courseName, ED.unitPrice as priceCourse from Payment P inner join EnrolledCourse EC ON P.paymentId = EC.paymentId inner join EnrolDetails ED On ED.enrollmentId = EC.enrollmentId INNER JOIN CourseSchedule CS ON ED.scheduleId = CS.scheduleId INNER JOIN Course C ON CS.courseId = C.courseId WHERE C.eduId = '"+Session["UserId"]+ "'and month(P.paymentDate)=" + ddlMonth.SelectedValue + "and year(P.paymentDate)=" + ddlYear.SelectedValue;
                    SqlDataAdapter adp2 = new SqlDataAdapter(sqlCourse, con);
                    adp2.Fill(ds);

                    con.Close();

                    ReportDocument crystalReport = new ReportDocument();
                    crystalReport.Load(Server.MapPath("~/CrystalReportIncomeEdu.rpt"));
                    crystalReport.SetDataSource(ds.Tables["table"]);
                    crystalReport.SetParameterValue("month", ddlMonth.SelectedItem.Text);
                    crystalReport.SetParameterValue("year", ddlYear.SelectedItem.Text);
                    CrystalReportViewer1.ReportSource = crystalReport;
                    crystalReport.ExportToHttpResponse(ExportFormatType.PortableDocFormat, Response, false, "Report of Total Income");
                }
            }
        }
    }
}