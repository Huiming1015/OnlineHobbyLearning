using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class PaymentDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["paymentId"] == null)
            {
                Session["paymentId"] = Request.QueryString["paymentId"].ToString();
            }
        }

        protected void dlPaymentDetails_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblSubTotal = e.Item.FindControl("lblSubTotal") as Label;
                Label lblDiscount = e.Item.FindControl("lblDiscount") as Label;
                Label lblTotalPayment = e.Item.FindControl("lblTotalPayment") as Label;
                Label lblRefundAmount = e.Item.FindControl("lblRefundAmount") as Label;
                Label lblRefundTitle = e.Item.FindControl("lblRefundTitle") as Label;
                Label lblRefundTitle2 = e.Item.FindControl("lblRefundTitle2") as Label;
                double refundAmount = Convert.ToDouble(lblRefundAmount.Text);
                if (refundAmount <= 0)
                {
                    lblRefundTitle.Visible = false;
                    lblRefundTitle2.Visible = false;
                    lblRefundAmount.Visible = false;
                }
                else
                {
                    lblRefundTitle.Visible = true;
                    lblRefundTitle2.Visible = true;
                    lblRefundAmount.Visible = true;
                }
                lblSubTotal.Text = (Convert.ToDouble(lblTotalPayment.Text) - Convert.ToDouble(lblDiscount.Text)).ToString("0.00");
            }
        }
    }
}