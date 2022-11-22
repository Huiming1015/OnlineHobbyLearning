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
                string cmd = "select * from MaterialOrder MO INNER JOIN OrderDetails OD ON MO.orderId=OD.orderId INNER JOIN MaterialKit MK ON OD.materialId=MK.materialId where MK.eduId ='" + Session["UserId"] + "' and month(MO.orderDate)=" + ddlMonth.SelectedValue + "and year(MO.orderDate)=" + ddlYear.SelectedValue;
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
                    string sql = "select * from MaterialOrder MO INNER JOIN OrderDetails OD ON MO.orderId=OD.orderId INNER JOIN MaterialKit MK ON OD.materialId=MK.materialId where MK.eduId ='" + Session["UserId"] + "' and month(MO.orderDate)=" + ddlMonth.SelectedValue + "and year(MO.orderDate)=" + ddlYear.SelectedValue;
                    DataSet ds = new DataSet();
                    SqlDataAdapter adp = new SqlDataAdapter(sql, con);
                    adp.Fill(ds);

                    ReportDocument crystalReport = new ReportDocument();
                    crystalReport.Load(Server.MapPath("~/CrystalReportTotalIncome.rpt"));
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