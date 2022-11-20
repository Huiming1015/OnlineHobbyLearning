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
    public partial class OrderDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        String role, strOrderId;
        string orderStatus = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            strOrderId = Request.QueryString["orderId"].ToString();
            if (Session["Role"] != null)
            {
                role = Session["Role"].ToString();
            }
            foreach (DataListItem dl in dlOrderDetails.Items)
            {
                Label lblOrderId = dl.FindControl("lblOrderId") as Label;
                con = new SqlConnection(strCon);
                con.Open();
                string strQ = "SELECT paymentId, orderStatus FROM MaterialOrder WHERE orderId=@OrderId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@OrderId", lblOrderId.Text.ToString());
                SqlDataReader dr = com.ExecuteReader();

                while (dr.Read())
                {
                    Session["paymentId"] = dr["paymentId"].ToString();
                    orderStatus = dr["orderStatus"].ToString();
                }
                dr.Close();
                con.Close();
            }

            if (!IsPostBack)
            {
                if (dlOrderDetails.Items.Count <= 0)
                {
                    btnCancel.Visible = false;
                    lblEmpty.Visible = true;
                }
                else
                {
                    btnCancel.Visible = true;
                    lblEmpty.Visible = false;
                }

                if (role != "edu")
                {
                    btnConfirm.Visible = false;
                }

                if (orderStatus == "cancelling" || orderStatus == "cancelled" || orderStatus == "confirmed")
                {
                    btnCancel.Visible = false;
                    btnConfirm.Visible = false;
                }

                if (orderStatus == "cancelling" && role == "edu")
                {
                    btnApprove.Visible = true;
                    btnReject.Visible = true;
                }
                else
                {
                    btnApprove.Visible = false;
                    btnReject.Visible = false;
                }
            }
        }

        protected void dlOrderDetails_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DataList dlMaterial = e.Item.FindControl("dlMaterial") as DataList;
                Label lblExpress = e.Item.FindControl("lblExpress") as Label;
                DropDownList ddlExpress = e.Item.FindControl("ddlExpress") as DropDownList;
                Label lblTrackingNum = e.Item.FindControl("lblTrackingNum") as Label;
                Label lblOrderId = e.Item.FindControl("lblOrderId") as Label;
                Label lblCancel = e.Item.FindControl("lblCancel") as Label;
                Label lblCancelReason = e.Item.FindControl("lblCancelReason") as Label;

                if (orderStatus == "cancelling" || orderStatus == "cancelled")
                {
                    lblCancel.Visible = true;
                    lblCancelReason.Visible = true;
                    ddlExpress.Visible = false;
                    lblExpress.Visible = true;
                }
                else
                {
                    lblCancel.Visible = false;
                    lblCancelReason.Visible = false;
                    con = new SqlConnection(strCon);
                    con.Open();
                    string strQ = "SELECT expressCompany, trackingNum FROM Shipment WHERE orderId=@OrderId";
                    SqlCommand com = new SqlCommand(strQ, con);
                    com.Parameters.AddWithValue("@OrderId", lblOrderId.Text.ToString());
                    SqlDataReader dr = com.ExecuteReader();

                    while (dr.Read())
                    {
                        if (dr["expressCompany"].ToString() != "-" && dr["trackingNum"].ToString() != "-")
                        {
                            lblExpress.Visible = true;
                            ddlExpress.Visible = false;
                            lblExpress.Text = dr["expressCompany"].ToString();
                            lblTrackingNum.Text = dr["trackingNum"].ToString();
                            btnCancel.Visible = false;
                        }
                        else
                        {
                            if (role == "stud")
                            {
                                lblExpress.Visible = true;
                                ddlExpress.Visible = false;
                            }
                            else
                            {
                                lblExpress.Visible = false;
                                ddlExpress.Visible = true;
                            }
                        }
                    }
                    dr.Close();
                    con.Close();
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            foreach (DataListItem dl in dlOrderDetails.Items)
            {
                Label lblOrderId = dl.FindControl("lblOrderId") as Label;
                DropDownList ddlExpress = dl.FindControl("ddlExpress") as DropDownList;
                if (role == "stud")
                {
                    Session["orderCancel"] = strOrderId;
                    mp1.Show();
                }
                else if (role == "edu")
                {
                    try
                    {
                        string strQModify;
                        con = new SqlConnection(strCon);
                        con.Open();
                        strQModify = "UPDATE MaterialOrder SET orderStatus='cancelled', cancelReason='Order has been cancelled by educator.' WHERE orderId=@OrderId";
                        SqlCommand comModify = new SqlCommand(strQModify, con);
                        comModify.Parameters.AddWithValue("@OrderId", Request.QueryString["orderId"].ToString());
                        int k = comModify.ExecuteNonQuery();

                        if (k != 0)
                        {
                            MsgBox("The order has been cancelled successfully!", this.Page, this);
                            ScriptManager.RegisterStartupScript(this, GetType(), "", "window.location = '" + Page.ResolveUrl("~/OrderDetails.aspx?orderId=" + strOrderId) + "';", true);
                        }
                        con.Close();
                    }
                    catch
                    {
                        MsgBox("Please insert the valid data into all required field!", this.Page, this);
                    }
                }
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            foreach (DataListItem dl in dlOrderDetails.Items)
            {
                Label lblOrderId = dl.FindControl("lblOrderId") as Label;
                DropDownList ddlExpress = dl.FindControl("ddlExpress") as DropDownList;
                string strValueExpress = ddlExpress.SelectedValue.ToString();
                string strExpressChar, strRanNum, strTrackingNum, strExpressCompany;
                Boolean track = false;

                if (strValueExpress == "posLaju")
                {
                    strExpressChar = "PL-";
                    strExpressCompany = "Pos Laju";
                }
                else if (strValueExpress == "jAndT")
                {
                    strExpressChar = "JT-";
                    strExpressCompany = "J&T Express";
                }
                else
                {
                    strExpressChar = "GD-";
                    strExpressCompany = "GDex Express";
                }

                do
                {
                    Random r = new Random();
                    strRanNum = r.Next().ToString();
                    strTrackingNum = strExpressChar + strRanNum;

                    con = new SqlConnection(strCon);
                    con.Open();
                    string strQ = "SELECT trackingNum FROM Shipment";
                    SqlCommand com = new SqlCommand(strQ, con);
                    SqlDataReader dr = com.ExecuteReader();
                    while (dr.Read())
                    {
                        if (dr["trackingNum"].ToString() == strTrackingNum)
                        {
                            track = false;
                        }
                        else
                        {
                            track = true;
                        }
                    }
                    con.Close();

                } while (track == false);

                if (track == true)
                {
                    string strQModifyShip, strQModifyOrder;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQModifyShip = "UPDATE Shipment SET expressCompany=@ExpressCompany, trackingNum=@TrackingNum WHERE orderId=@OrderId";
                    SqlCommand comShip = new SqlCommand(strQModifyShip, con);
                    comShip.Parameters.AddWithValue("@ExpressCompany", strExpressCompany);
                    comShip.Parameters.AddWithValue("@TrackingNum", strTrackingNum);
                    comShip.Parameters.AddWithValue("@OrderId", strOrderId);
                    int k = comShip.ExecuteNonQuery();
                    con.Close();

                    con = new SqlConnection(strCon);
                    con.Open();
                    strQModifyOrder = "UPDATE MaterialOrder SET orderStatus='confirmed' WHERE orderId=@OrderId";
                    SqlCommand comOrder = new SqlCommand(strQModifyOrder, con);
                    comOrder.Parameters.AddWithValue("@OrderId", strOrderId);
                    int j = comOrder.ExecuteNonQuery();
                    con.Close();

                    if (k != 0 && j != 0)
                    {
                        MsgBox("The order has been confirmed, please ship out the order within 1 week!", this.Page, this);
                        ScriptManager.RegisterStartupScript(this, GetType(), "", "window.location = '" + Page.ResolveUrl("~/OrderDetails.aspx?orderId=" + strOrderId) + "';", true);
                    }
                }
            }
        }

        protected void btnReject_Click(object sender, EventArgs e)
        {
            try
            {
                string strQModify;
                con = new SqlConnection(strCon);
                con.Open();
                strQModify = "UPDATE MaterialOrder SET orderStatus='pending' WHERE orderId=@OrderId";
                SqlCommand comModify = new SqlCommand(strQModify, con);
                comModify.Parameters.AddWithValue("@OrderId", Request.QueryString["orderId"].ToString());
                int k = comModify.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Cancellation request has been rejected successfully!", this.Page, this);
                    ScriptManager.RegisterStartupScript(this, GetType(), "", "window.location = '" + Page.ResolveUrl("~/OrderDetails.aspx?orderId=" + strOrderId) + "';", true);
                }
                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        protected void btnApprove_Click(object sender, EventArgs e)
        {
            double discount = 0, subtotal = 0, refundAmount = 0;
            string paymentId = "";
            try
            {
                string strQGetPrice, strQGetDiscount, strQModify, strQModifyPayment;
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
                    paymentId = drPay["paymentId"].ToString();
                }
                dr.Close();
                con.Close();

                refundAmount = subtotal - discount;

                con = new SqlConnection(strCon);
                con.Open();
                strQModifyPayment = "UPDATE Payment SET paymentStatus='refund', refundAmount=refundAmount+@RefundAmount WHERE paymentId=@PaymentId";
                SqlCommand comModifyPay = new SqlCommand(strQModifyPayment, con);
                comModifyPay.Parameters.AddWithValue("@PaymentId", paymentId);
                comModifyPay.Parameters.AddWithValue("@RefundAmount", refundAmount);
                int j = comModifyPay.ExecuteNonQuery();
                con.Close();

                con = new SqlConnection(strCon);
                con.Open();
                strQModify = "UPDATE MaterialOrder SET orderStatus='cancelled' WHERE orderId=@OrderId";
                SqlCommand comModify = new SqlCommand(strQModify, con);
                comModify.Parameters.AddWithValue("@OrderId", strOrderId);
                int k = comModify.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Cancellation request has been approved successfully! The refund amount will be RM " + refundAmount.ToString(), this.Page, this);
                    ScriptManager.RegisterStartupScript(this, GetType(), "", "window.location = '" + Page.ResolveUrl("~/OrderDetails.aspx?orderId=" + strOrderId) + "';", true);
                }
                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
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