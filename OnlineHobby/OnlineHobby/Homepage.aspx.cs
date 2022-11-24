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
    public partial class Homepage : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con2;
        string strCon2 = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            Boolean check;
            if (!IsPostBack)
            {
                string strQGetPrice, strQGetDiscount, strQModify, strQModifyPayment, strGetOrderId;
                DateTime today = DateTime.Today;
                con2 = new SqlConnection(strCon2);
                con2.Open();
                strGetOrderId = "SELECT orderId FROM MaterialOrder WHERE DATEADD(day, 3, orderDate) < @today AND orderStatus='pending'";
                SqlCommand comOrderID = new SqlCommand(strGetOrderId, con2);
                comOrderID.Parameters.AddWithValue("@today", today);
                SqlDataReader drID = comOrderID.ExecuteReader();
                while (drID.Read())
                {
                    double subtotal = 0, refundAmount = 0, discount = 0;
                    string strOrderId = "", strPaymentId = "";
                    strOrderId = drID["orderId"].ToString();
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQGetPrice = "SELECT unitPrice, quantity FROM OrderDetails WHERE orderId=@OrderId";
                    SqlCommand com = new SqlCommand(strQGetPrice, con);
                    com.Parameters.AddWithValue("@OrderId", strOrderId);
                    SqlDataReader dr = com.ExecuteReader();
                    while (dr.Read())
                    {
                        subtotal += Convert.ToDouble(dr["unitPrice"]) * Convert.ToDouble(dr["quantity"]);
                    }
                    dr.Close();
                    con.Close();

                    con = new SqlConnection(strCon);
                    con.Open();
                    strQGetDiscount = "SELECT Payment.paymentId, Payment.discountAmount FROM Payment INNER JOIN MaterialOrder ON Payment.paymentId=MaterialOrder.paymentId WHERE orderId=@OrderId";
                    SqlCommand comDiscount = new SqlCommand(strQGetDiscount, con);
                    comDiscount.Parameters.AddWithValue("@OrderId", strOrderId);
                    SqlDataReader drPay = comDiscount.ExecuteReader();
                    while (drPay.Read())
                    {
                        discount = Convert.ToDouble(drPay["discountAmount"]);
                        strPaymentId = drPay["paymentId"].ToString();
                    }
                    drPay.Close();
                    con.Close();

                    refundAmount = subtotal - discount;

                    con = new SqlConnection(strCon);
                    con.Open();
                    strQModifyPayment = "UPDATE Payment SET paymentStatus='refund', refundAmount=refundAmount+@RefundAmount WHERE paymentId=@PaymentId";
                    SqlCommand comModifyPay = new SqlCommand(strQModifyPayment, con);
                    comModifyPay.Parameters.AddWithValue("@PaymentId", strPaymentId);
                    comModifyPay.Parameters.AddWithValue("@RefundAmount", refundAmount);
                    int j = comModifyPay.ExecuteNonQuery();
                    con.Close();

                    con = new SqlConnection(strCon);
                    con.Open();
                    strQModify = "UPDATE MaterialOrder SET orderStatus='cancelled', cancelReason='Educator did not confirm the order within 3 days of order made.' WHERE orderId=@OrderId";
                    SqlCommand comModify = new SqlCommand(strQModify, con);
                    comModify.Parameters.AddWithValue("@OrderId", strOrderId);
                    int k = comModify.ExecuteNonQuery();
                    con.Close();
                }
                drID.Close();
                con2.Close();

                do
                {
                    string strQSchedule;
                    con2 = new SqlConnection(strCon2);
                    con2.Open();
                    strQSchedule = "SELECT scheduleId FROM CourseSchedule";
                    SqlCommand com = new SqlCommand(strQSchedule, con2);
                    SqlDataReader dr = com.ExecuteReader();
                    while (dr.Read())
                    {
                        string strScheduleId;
                        string strQLastDate, strQModifyEnrol, strQFirstDate, strQModifyCourse;

                        strScheduleId = dr["scheduleId"].ToString();
                        con = new SqlConnection(strCon);
                        con.Open();
                        strQLastDate = "SELECT TOP 1 date FROM ScheduleList WHERE scheduleId='" + strScheduleId + "' ORDER BY scheduleListId DESC";
                        SqlCommand comDate = new SqlCommand(strQLastDate, con);
                        DateTime lastDate = Convert.ToDateTime(comDate.ExecuteScalar());
                        con.Close();

                        con.Open();
                        strQFirstDate = "SELECT TOP 1 date FROM ScheduleList WHERE scheduleId='" + strScheduleId + "'";
                        SqlCommand comFirst = new SqlCommand(strQFirstDate, con);
                        DateTime firstDate = Convert.ToDateTime(comFirst.ExecuteScalar());
                        con.Close();
                        if (firstDate < today)
                        {
                            con.Open();
                            strQModifyCourse = "UPDATE CourseSchedule SET availability='started' WHERE scheduleId='" + strScheduleId + "'";
                            SqlCommand comUpdate1 = new SqlCommand(strQModifyCourse, con);
                            int k = comUpdate1.ExecuteNonQuery();
                            con.Close();
                        }

                        if (lastDate < today)
                        {
                            con.Open();
                            strQModifyEnrol = "UPDATE EnrolDetails SET enrolStatus='Completed' WHERE scheduleId='" + strScheduleId + "' AND enrolStatus='Enrolled'";
                            SqlCommand comUpdate = new SqlCommand(strQModifyEnrol, con);
                            int k = comUpdate.ExecuteNonQuery();
                            con.Close();
                        }
                    }
                    dr.Close();
                    con2.Close();
                    check = true;
                } while (check == false);
            }
        }
    }
}