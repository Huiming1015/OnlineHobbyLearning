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
    public partial class CreditCard : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        SqlConnection con2;
        string strCon2 = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        String strShipName, strShipPhone, strShipAddress;
        String strEnrollmentId, strOrderId, strPaymentId;
        String date, time;
        Int32 studId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["shipName"] != null && Session["shipPhone"] != null && Session["shipAddress"] != null && Session["totalPrice"] != null && Session["UserId"] != null)
            {
                strShipName = Session["shipName"].ToString();
                strShipPhone = Session["shipPhone"].ToString();
                strShipAddress = Session["shipAddress"].ToString();
                studId = Convert.ToInt32(Session["UserId"]);
                lblTotalPrice.Text = Convert.ToDouble(Session["totalPrice"]).ToString("0.00");
            }

        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            time = DateTime.Now.ToShortTimeString();
            date = DateTime.Now.ToShortDateString();
            String strQmaterial, strQCourse, strQEdu, strQCourse2, strQEdu2;

            while (checkIsEmpty() == true)
            {
                List<string> listMaterial = new List<string>();
                List<string> listCourse = new List<string>();
                int matchCourse = 0, matchMaterial = 0, discountRate = 0;
                double discount = 0, totalPrice = 0, coursePrice = 0, materialPrice = 0;

                Int32 strEduID = 0;
                con = new SqlConnection(strCon);
                con.Open();
                strQEdu = "SELECT TOP 1 MaterialKit.eduId AS eduId FROM Cart INNER JOIN MaterialKit ON Cart.materialId = MaterialKit.materialId WHERE (Cart.studId = @StudId)";
                SqlCommand comEdu = new SqlCommand(strQEdu, con);
                comEdu.Parameters.AddWithValue("@StudId", studId);
                strEduID = Convert.ToInt32(comEdu.ExecuteScalar());
                con.Close();

                if (strEduID == 0)
                {
                    con2 = new SqlConnection(strCon2);
                    con2.Open();
                    strQEdu2 = "SELECT TOP 1 Course.eduId FROM Cart INNER JOIN CourseSchedule ON Cart.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId WHERE Cart.studId = @StudId";
                    SqlCommand comEdu2 = new SqlCommand(strQEdu2, con2);
                    comEdu2.Parameters.AddWithValue("@StudId", studId);
                    strEduID = Convert.ToInt32(comEdu2.ExecuteScalar());
                    con2.Close();
                }

                strPaymentId = GeneratePaymentID();
                con = new SqlConnection(strCon);
                con.Open();

                strQmaterial = "SELECT Cart.materialId, Cart.quantity, MaterialKit.price FROM Cart INNER JOIN MaterialKit ON MaterialKit.materialId = Cart.materialId WHERE Cart.studId=@StudId AND MaterialKit.eduId=@EduId";
                SqlCommand comMaterial = new SqlCommand(strQmaterial, con);
                comMaterial.Parameters.AddWithValue("@StudId", studId);
                comMaterial.Parameters.AddWithValue("@EduId", strEduID);
                SqlDataReader dr = comMaterial.ExecuteReader();
                if (dr.HasRows)
                {
                    strOrderId = GenerateOrderID();
                    addOrder();
                    addShipment();
                    while (dr.Read())
                    {
                        listMaterial.Add(dr["materialId"].ToString());
                        materialPrice += Convert.ToDouble(dr["quantity"]) * Convert.ToDouble(dr["price"]);
                        addOrderDetails(dr["materialId"].ToString(), Convert.ToInt32(dr["quantity"]), Convert.ToDouble(dr["price"]));
                    }
                }
                dr.Close();
                con.Close();

                int courseEmpty = 0;
                con = new SqlConnection(strCon);
                con.Open();
                strQCourse = "SELECT scheduleId FROM Cart WHERE studId=@StudId";
                SqlCommand comCourse = new SqlCommand(strQCourse, con);
                comCourse.Parameters.AddWithValue("@StudId", studId);
                SqlDataReader drCourse = comCourse.ExecuteReader();
                if (drCourse.HasRows)
                {
                    courseEmpty += 1;
                }
                drCourse.Close();
                con.Close();

                if (courseEmpty >= 1)
                {
                    con2 = new SqlConnection(strCon2);
                    con2.Open();
                    strQCourse2 = "SELECT Cart.scheduleId, CourseSchedule.price, CourseSchedule.courseId FROM CourseSchedule INNER JOIN Course ON CourseSchedule.courseId = Course.courseId INNER JOIN Cart ON CourseSchedule.scheduleId = Cart.scheduleId WHERE Course.eduId=@EduId AND Cart.studId=@StudId";
                    SqlCommand comCourse2 = new SqlCommand(strQCourse2, con2);
                    comCourse2.Parameters.AddWithValue("@StudId", studId);
                    comCourse2.Parameters.AddWithValue("@EduId", strEduID);
                    SqlDataReader drCourse2 = comCourse2.ExecuteReader();
                    if (drCourse2.HasRows)
                    {
                        strEnrollmentId = GenerateEnrollmentID();
                        addCourseEnrolled();
                        while (drCourse2.Read())
                        {
                            listCourse.Add(drCourse2["scheduleId"].ToString());
                            coursePrice += Convert.ToDouble(drCourse2["price"]);
                            addEnrolDetails(drCourse2["scheduleId"].ToString(), Convert.ToDouble(drCourse2["price"]));
                        }
                    }
                    drCourse2.Close();
                    con2.Close();
                }

                String[] material = listMaterial.ToArray();
                String[] course = listCourse.ToArray();
                if (course.Length > 0 && material.Length > 0)
                {
                    double unitCourse = 0, unitMaterial = 0;
                    String strQ;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQ = "SELECT * FROM Discount";
                    SqlCommand com = new SqlCommand(strQ, con);
                    SqlDataReader drDiscount = com.ExecuteReader();
                    while (drDiscount.Read())
                    {

                        foreach (string courseId in course)
                        {
                            String strQUnitCourse;
                            con2 = new SqlConnection(strCon2);
                            con2.Open();
                            strQUnitCourse = "SELECT price, courseId FROM CourseSchedule WHERE scheduleId=@ScheduleId";
                            SqlCommand comUC = new SqlCommand(strQUnitCourse, con2);
                            comUC.Parameters.AddWithValue("@ScheduleId", courseId);
                            SqlDataReader drUnitCourse = comUC.ExecuteReader();
                            if (drUnitCourse.HasRows)
                            {
                                while (drUnitCourse.Read())
                                {
                                    if (drUnitCourse["courseId"].ToString() == drDiscount["courseId"].ToString())
                                    {
                                        matchCourse += 1;
                                        unitCourse = Convert.ToDouble(drUnitCourse["price"]);
                                    }
                                }
                            }
                            drUnitCourse.Close();
                            con2.Close();
                        }


                        foreach (string materialId in material)
                        {
                            if (materialId == drDiscount["materialId"].ToString())
                            {
                                String strQUnit;
                                con2 = new SqlConnection(strCon2);
                                con2.Open();
                                strQUnit = "SELECT price FROM MaterialKit WHERE materialId=@MaterialId";
                                SqlCommand comUM = new SqlCommand(strQUnit, con2);
                                comUM.Parameters.AddWithValue("@MaterialId", materialId);
                                unitMaterial = Convert.ToDouble(comUM.ExecuteScalar());
                                matchMaterial += 1;
                                con2.Close();
                            }
                        }

                        if (matchMaterial >= 1 && matchCourse >= 1)
                        {
                            discountRate = Convert.ToInt32(drDiscount["discountRate"].ToString());
                            discount = ((unitCourse + unitMaterial) * Convert.ToDouble(discountRate) / 100);
                        }
                        matchCourse = 0;
                        matchMaterial = 0;
                    }
                    drDiscount.Close();
                    con.Close();
                }
                totalPrice = (coursePrice + materialPrice) - discount;
                addPayment(discount, totalPrice);
            }

        }

        private Boolean checkIsEmpty()
        {
            Boolean check = false;
            try
            {
                string strQ;

                con2 = new SqlConnection(strCon2);
                con2.Open();
                strQ = "SELECT * FROM Cart WHERE studId=@StudId";
                SqlCommand comMaterial = new SqlCommand(strQ, con2);
                comMaterial.Parameters.AddWithValue("@StudId", studId);
                SqlDataReader dr = comMaterial.ExecuteReader();

                if (dr.HasRows)
                {
                    check = true;
                }
                else
                {
                    check = false;
                    MsgBox("Your payment is successful!", this.Page, this);
                    ScriptManager.RegisterStartupScript(this, GetType(), "", "window.location = '" + Page.ResolveUrl("~/OrderList.aspx") + "';", true);
                }

                dr.Close();
                con2.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
            return check;
        }

        private void addPayment(double discount, double totalPrice)
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Payment](paymentId, studId, paymentAmount, paymentTime, paymentDate, discountAmount, paymentStatus, refundAmount) VALUES (@paymentId, @studId, @paymentAmount, @paymentTime, @paymentDate, @discountAmount, @paymentStatus, @refundAmount)";
                SqlCommand comAdd = new SqlCommand(strQAdd, con);
                comAdd.Parameters.AddWithValue("@paymentId", strPaymentId);
                comAdd.Parameters.AddWithValue("@studId", studId);
                comAdd.Parameters.AddWithValue("@paymentAmount", totalPrice);
                comAdd.Parameters.AddWithValue("@paymentTime", time);
                comAdd.Parameters.AddWithValue("@paymentDate", date);
                comAdd.Parameters.AddWithValue("@discountAmount", discount);
                comAdd.Parameters.AddWithValue("@paymentStatus", "paid");
                comAdd.Parameters.AddWithValue("@refundAmount", 0);
                int k = comAdd.ExecuteNonQuery();

                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        private void addOrder()
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [MaterialOrder](orderId, paymentId, studId, orderDate, orderTime, orderStatus) VALUES (@orderId, @paymentId, @studId, @orderDate, @orderTime, @orderStatus)";
                SqlCommand comAdd = new SqlCommand(strQAdd, con);
                comAdd.Parameters.AddWithValue("@orderId", strOrderId);
                comAdd.Parameters.AddWithValue("@paymentId", strPaymentId);
                comAdd.Parameters.AddWithValue("@studId", studId);
                comAdd.Parameters.AddWithValue("@orderDate", date);
                comAdd.Parameters.AddWithValue("@orderTime", time);
                comAdd.Parameters.AddWithValue("@orderStatus", "pending");
                int k = comAdd.ExecuteNonQuery();

                con.Close();
            }
            catch
            {
                MsgBox("Something wrong!", this.Page, this);
            }
        }

        private void addOrderDetails(string materialId, Int32 quantity, double price)
        {
            try
            {
                string strQAdd, strQ, strQminus;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [OrderDetails](orderDetailId, orderId, materialId, quantity, unitPrice) VALUES (@orderDetailId, @orderId, @materialId, @quantity, @unitPrice)";
                SqlCommand comAdd = new SqlCommand(strQAdd, con);
                comAdd.Parameters.AddWithValue("@orderDetailId", GenerateOrderDetailsID());
                comAdd.Parameters.AddWithValue("@orderId", strOrderId);
                comAdd.Parameters.AddWithValue("@materialId", materialId);
                comAdd.Parameters.AddWithValue("@quantity", quantity);
                comAdd.Parameters.AddWithValue("@unitPrice", price);
                int k = comAdd.ExecuteNonQuery();

                if (k != 0)
                {
                    con2 = new SqlConnection(strCon2);
                    con2.Open();
                    strQ = "DELETE FROM Cart WHERE materialId='" + materialId + "'";
                    SqlCommand com = new SqlCommand(strQ, con2);
                    int j = com.ExecuteNonQuery();
                    con2.Close();

                    con2 = new SqlConnection(strCon2);
                    con2.Open();
                    strQminus = "UPDATE MaterialKit SET stock=(stock-@Quantity) WHERE materialId=@MaterialId";
                    SqlCommand comMinus = new SqlCommand(strQminus, con2);
                    comMinus.Parameters.AddWithValue("@MaterialId", materialId);
                    comMinus.Parameters.AddWithValue("@Quantity", quantity);
                    int m = comMinus.ExecuteNonQuery();
                    con2.Close();
                }
                con.Close();
            }
            catch
            {
                MsgBox("Something wrong!", this.Page, this);
            }
        }

        private void addShipment()
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Shipment](shipmentId, orderId, shipName, shipPhone, shipAddress, expressCompany, trackingNum) VALUES (@shipmentId, @orderId, @shipName, @shipPhone, @shipAddress, @expressCompany, @trackingNum)";
                SqlCommand comAddDiscount = new SqlCommand(strQAdd, con);
                comAddDiscount.Parameters.AddWithValue("@shipmentId", GenerateShipmentID());
                comAddDiscount.Parameters.AddWithValue("@orderId", strOrderId);
                comAddDiscount.Parameters.AddWithValue("@shipName", strShipName);
                comAddDiscount.Parameters.AddWithValue("@shipPhone", strShipPhone);
                comAddDiscount.Parameters.AddWithValue("@shipAddress", strShipAddress);
                comAddDiscount.Parameters.AddWithValue("@expressCompany", "-");
                comAddDiscount.Parameters.AddWithValue("@trackingNum", "-");
                int k = comAddDiscount.ExecuteNonQuery();

                if (k != 0)
                {
                    Session["shipName"] = null;
                    Session["shipPhone"] = null;
                    Session["shipAddress"] = null;
                }
                con.Close();
            }
            catch
            {
                MsgBox("Something wrong!", this.Page, this);
            }
        }

        private void addCourseEnrolled()
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [EnrolledCourse](enrollmentId, paymentId, studId, enrolTime, enrolDate) VALUES (@enrollmentId, @paymentId, @studId, @enrolTime, @enrolDate)";
                SqlCommand comAdd = new SqlCommand(strQAdd, con);
                comAdd.Parameters.AddWithValue("@enrollmentId", strEnrollmentId);
                comAdd.Parameters.AddWithValue("@paymentId", strPaymentId);
                comAdd.Parameters.AddWithValue("@studId", studId);
                comAdd.Parameters.AddWithValue("@enrolTime", time);
                comAdd.Parameters.AddWithValue("@enrolDate", date);
                int k = comAdd.ExecuteNonQuery();

                con.Close();
            }
            catch
            {
                MsgBox("Something wrong!", this.Page, this);
            }
        }

        private void addEnrolDetails(string scheduleId, double price)
        {
            try
            {
                string strQ, strQminus;
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [EnrolDetails](enrolDetailId, enrollmentId, scheduleId, unitPrice, enrolStatus) VALUES (@enrolDetailId, @enrollmentId, @scheduleId, @unitPrice, @enrolStatus)";
                SqlCommand comAdd = new SqlCommand(strQAdd, con);
                comAdd.Parameters.AddWithValue("@enrolDetailId", GenerateEnrolDetailsID());
                comAdd.Parameters.AddWithValue("@enrollmentId", strEnrollmentId);
                comAdd.Parameters.AddWithValue("@scheduleId", scheduleId);
                comAdd.Parameters.AddWithValue("@unitPrice", price);
                comAdd.Parameters.AddWithValue("@enrolStatus", "enrolled");
                int k = comAdd.ExecuteNonQuery();

                if (k != 0)
                {
                    con2 = new SqlConnection(strCon2);
                    con2.Open();
                    strQ = "DELETE FROM Cart WHERE scheduleId=@ScheduleId";
                    SqlCommand com = new SqlCommand(strQ, con2);
                    com.Parameters.AddWithValue("@ScheduleId", scheduleId);
                    int j = com.ExecuteNonQuery();
                    con2.Close();

                    con2 = new SqlConnection(strCon2);
                    con2.Open();
                    strQminus = "UPDATE CourseSchedule SET numEnrolled=(numEnrolled + 1) WHERE scheduleId=@ScheduleId";
                    SqlCommand comMinus = new SqlCommand(strQminus, con2);
                    comMinus.Parameters.AddWithValue("@ScheduleId", scheduleId);
                    int m = comMinus.ExecuteNonQuery();
                    con2.Close();
                }
                con.Close();
            }
            catch
            {
                MsgBox("Something wrong!", this.Page, this);
            }
        }

        private string GeneratePaymentID()
        {
            string id = "";
            int intCountID = 0;
            String strQPayment;
            con = new SqlConnection(strCon);
            con.Open();
            strQPayment = "Select paymentId from Payment";
            SqlCommand comID = new SqlCommand(strQPayment, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["paymentId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            dr.Close();
            con.Close();
            return "P" + intCountID.ToString("0000");
        }

        private string GenerateOrderID()
        {
            string id = "";
            int intCountID = 0;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "Select orderId from MaterialOrder";
            SqlCommand comID = new SqlCommand(strQ, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["orderId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            dr.Close();
            con.Close();
            return "O" + intCountID.ToString("0000");
        }

        private string GenerateEnrollmentID()
        {
            string id = "";
            int intCountID = 0;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "Select enrollmentId from EnrolledCourse";
            SqlCommand comID = new SqlCommand(strQ, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["enrollmentId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            dr.Close();
            con.Close();
            return "E" + intCountID.ToString("0000");
        }

        private string GenerateShipmentID()
        {
            string id = "";
            int intCountID = 0;
            String strQMaterial;
            con = new SqlConnection(strCon);
            con.Open();
            strQMaterial = "Select shipmentId from Shipment";
            SqlCommand comID = new SqlCommand(strQMaterial, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["shipmentId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            dr.Close();
            con.Close();
            return "Z" + intCountID.ToString("0000");
        }

        private Int32 GenerateOrderDetailsID()
        {
            Int32 id;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "Select IsNull(max(orderDetailId),0) from OrderDetails";
            SqlCommand comID = new SqlCommand(strQ, con);
            id = Convert.ToInt32(comID.ExecuteScalar()) + 1;
            con.Close();
            return id;
        }

        private Int32 GenerateEnrolDetailsID()
        {
            Int32 id;
            String strQ;
            con = new SqlConnection(strCon);
            con.Open();
            strQ = "Select IsNull(max(enrolDetailId),0) from EnrolDetails";
            SqlCommand comID = new SqlCommand(strQ, con);
            id = Convert.ToInt32(comID.ExecuteScalar()) + 1;
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
