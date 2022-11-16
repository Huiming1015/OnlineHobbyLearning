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
    public partial class CancelForm : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            string strOrderId;
            if (Session["orderCancel"] != null)
            {
                try
                {
                    strOrderId = Session["orderCancel"].ToString();
                    string strQModify;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQModify = "UPDATE MaterialOrder SET orderStatus='cancelling', cancelReason=@CancelReason WHERE orderId=@OrderId";
                    SqlCommand comModify = new SqlCommand(strQModify, con);
                    comModify.Parameters.AddWithValue("@CancelReason", txtReason.Text.ToString());
                    comModify.Parameters.AddWithValue("@OrderId", strOrderId);
                    int k = comModify.ExecuteNonQuery();

                    if (k != 0)
                    {
                        MsgBox("The cancellation request has been sent successfully, please wait for the educator to reply!", this.Page, this);
                        ClientScript.RegisterStartupScript(this.GetType(), "RefreshParent", "<script language='javascript'>RefreshParent()</script>");
                    }
                    con.Close();
                }
                catch
                {
                    MsgBox("Please insert the valid data into all required field!", this.Page, this);
                }
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