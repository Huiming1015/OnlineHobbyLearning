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
    public partial class OrderList : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        Int64 UserId;
        String role;

        protected void Page_Load(object sender, EventArgs e)
        {
            UserId = Convert.ToInt64(Session["UserId"]);

            if (Session["Role"] != null)
            {
                role = Session["Role"].ToString();
                if (!IsPostBack)
                {
                    if (role == "stud")
                    {
                        StudList();

                    }
                    else
                    {
                        EduList();
                    }
                }

            }
        }

        private void StudList()
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "Select * From MaterialOrder where studId=@StudId";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@StudId", UserId);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvOrderList.DataSource = ds;
            gvOrderList.DataBind();
            con.Close();
        }

        private void EduList()
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "SELECT distinct MaterialOrder.orderId, MaterialOrder.orderDate, MaterialOrder.orderTime FROM MaterialOrder INNER JOIN OrderDetails ON MaterialOrder.orderId = OrderDetails.orderId INNER JOIN MaterialKit ON OrderDetails.materialId = MaterialKit.materialId WHERE (MaterialKit.eduId = @EduId)";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@EduId", UserId);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvOrderList.DataSource = ds;
            gvOrderList.DataBind();
            con.Close();
        }

        private void showStudList(string orderStatus)
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "Select * From MaterialOrder where studId=@StudId AND orderStatus=@OrderStatus";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@StudId", UserId);
            com.Parameters.AddWithValue("@OrderStatus", orderStatus);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvOrderList.DataSource = ds;
            gvOrderList.DataBind();
            con.Close();
        }

        private void showEduList(string orderStatus)
        {
            con = new SqlConnection(strCon);
            con.Open();
            string strQ = "SELECT distinct MaterialOrder.orderId, MaterialOrder.orderDate, MaterialOrder.orderTime FROM MaterialOrder INNER JOIN OrderDetails ON MaterialOrder.orderId = OrderDetails.orderId INNER JOIN MaterialKit ON OrderDetails.materialId = MaterialKit.materialId WHERE (MaterialKit.eduId = @EduId) AND (MaterialOrder.orderStatus = @OrderStatus)";
            SqlCommand com = new SqlCommand(strQ, con);
            com.Parameters.AddWithValue("@EduId", UserId);
            com.Parameters.AddWithValue("@OrderStatus", orderStatus);
            SqlDataAdapter sda = new SqlDataAdapter(com);
            DataSet ds = new DataSet();
            sda.Fill(ds);
            gvOrderList.DataSource = ds;
            gvOrderList.DataBind();
            con.Close();
        }

        protected void gvOrderList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("OrderDetails.aspx?orderId=" + e.CommandArgument.ToString());
            }
        }

        protected void ddlOrderStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (role == "stud")
            {
                if (ddlOrderStatus.SelectedValue != "all")
                {
                    showStudList(ddlOrderStatus.SelectedValue.ToString());
                }
                else
                {
                    StudList();
                }
            }
            else
            {
                if (ddlOrderStatus.SelectedValue != "all")
                {
                    showEduList(ddlOrderStatus.SelectedValue.ToString());
                }
                else
                {
                    EduList();
                }
            }
        }
    }
}