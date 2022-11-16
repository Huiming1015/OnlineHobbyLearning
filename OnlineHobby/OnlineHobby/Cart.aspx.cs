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
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                double subtotal = 0;
                if (dlCartCourse.Items.Count <= 0 && dlCartMaterial.Items.Count <= 0)
                {
                    imgCartEmpty.Visible = true;
                    lblNoItem.Visible = true;
                    lblTitleSub.Visible = false;
                    lblSubTotal.Visible = false;
                    btnCheckout.Visible = false;
                    lblTitleCourse.Visible = false;
                    lblTitleMaterial.Visible = false;
                }
                else
                {
                    if (dlCartCourse.Items.Count <= 0)
                    {
                        lblTitleCourse.Visible = false;
                    }
                    else
                    {
                        foreach (DataListItem course in dlCartCourse.Items)
                        {
                            Label lblCoursePrice = course.FindControl("lblCoursePrice") as Label;
                            subtotal += Convert.ToDouble(lblCoursePrice.Text);
                        }

                    }
                    if (dlCartMaterial.Items.Count <= 0)
                    {
                        lblTitleMaterial.Visible = false;
                    }
                    else
                    {
                        foreach (DataListItem material in dlCartMaterial.Items)
                        {
                            Label lblMaterialPrice = material.FindControl("lblMaterialPrice") as Label;
                            Label lblQuantity = material.FindControl("lblQuantity") as Label;
                            subtotal += Convert.ToDouble(lblMaterialPrice.Text) * Convert.ToDouble(lblQuantity.Text);
                        }
                    }
                }
                lblSubTotal.Text = subtotal.ToString("0.00");
            }
        }

        protected void dlCartCourse_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "modify")
            {
                Label lblCourseId = e.Item.FindControl("lblCourseId") as Label;
                Session["cartCourseId"] = lblCourseId.Text.ToString();
                Session["modifyCartCourse"] = "yes";
                Session["cartId"] = e.CommandArgument.ToString();
                mp1.Show();
            }
            if (e.CommandName == "remove")
            {
                try
                {
                    string strQDelete;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQDelete = "DELETE FROM Cart WHERE cartId=@CartId";
                    SqlCommand comRemoveDiscount = new SqlCommand(strQDelete, con);
                    comRemoveDiscount.Parameters.AddWithValue("@CartId", e.CommandArgument.ToString());
                    int k = comRemoveDiscount.ExecuteNonQuery();
                    if (k != 0)
                    {
                        Response.Redirect("Cart.aspx");
                    }
                    con.Close();
                }
                catch
                {

                }
            }
        }

        protected void btnClosePopUp_Click(object sender, EventArgs e)
        {
            mp1.Hide();
            Response.Redirect("Cart.aspx");
        }

        protected void dlCartMaterial_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Label lblQuantity = e.Item.FindControl("lblQuantity") as Label;
            Label lblStock = e.Item.FindControl("lblStock") as Label;
            int stock = Convert.ToInt16(lblStock.Text);
            int quantity = Convert.ToInt16(lblQuantity.Text);
            if (e.CommandName == "minus")
            {
                if (quantity > 1)
                {
                    try
                    {
                        string strQModify;
                        con = new SqlConnection(strCon);
                        con.Open();
                        strQModify = "UPDATE Cart SET quantity=@Quantity WHERE cartId=@CartId";
                        SqlCommand comMinusQuantity = new SqlCommand(strQModify, con);
                        comMinusQuantity.Parameters.AddWithValue("@CartId", e.CommandArgument.ToString());
                        comMinusQuantity.Parameters.AddWithValue("@Quantity", quantity - 1);
                        int k = comMinusQuantity.ExecuteNonQuery();
                        if (k != 0)
                        {
                            Response.Redirect("Cart.aspx");
                        }
                        con.Close();
                    }
                    catch
                    {

                    }
                }
            }

            if (e.CommandName == "plus")
            {
                try
                {
                    if (quantity + 1 <= stock)
                    {
                        string strQModify;
                        con = new SqlConnection(strCon);
                        con.Open();
                        strQModify = "UPDATE Cart SET quantity=@Quantity WHERE cartId=@CartId";
                        SqlCommand comAddQuantity = new SqlCommand(strQModify, con);
                        comAddQuantity.Parameters.AddWithValue("@CartId", e.CommandArgument.ToString());
                        comAddQuantity.Parameters.AddWithValue("@Quantity", quantity + 1);
                        int k = comAddQuantity.ExecuteNonQuery();
                        if (k != 0)
                        {
                            Response.Redirect("Cart.aspx");
                        }
                        con.Close();
                    }
                    else
                    {
                        MsgBox("The selected quantity has reached the maximum stock quantity!", this.Page, this);
                    }
                }
                catch
                {

                }
            }

            if (e.CommandName == "remove")
            {
                try
                {
                    string strQDelete;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQDelete = "DELETE FROM Cart WHERE cartId=@CartId";
                    SqlCommand comRemoveDiscount = new SqlCommand(strQDelete, con);
                    comRemoveDiscount.Parameters.AddWithValue("@CartId", e.CommandArgument.ToString());
                    int k = comRemoveDiscount.ExecuteNonQuery();
                    if (k != 0)
                    {
                        Response.Redirect("Cart.aspx");
                    }
                    con.Close();
                }
                catch
                {

                }
            }
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            int matchMaterial = 0, matchCourse = 0;
            foreach (DataListItem dl in dlCartMaterial.Items)
            {
                Label lblStock = dl.FindControl("lblStock") as Label;
                Label lblQuantity = dl.FindControl("lblQuantity") as Label;
                Label lblAvailability = dl.FindControl("lblAvailability") as Label;
                int stock = Convert.ToInt16(lblStock.Text);
                int quantity = Convert.ToInt16(lblQuantity.Text);
                string availability = lblAvailability.Text.ToString();

                if (stock < quantity || availability != "available")
                {
                    matchMaterial += 1;
                }
            }

            foreach (DataListItem dl in dlCartCourse.Items)
            {
                Label lblMaxStud = dl.FindControl("lblMaxStud") as Label;
                Label lblNumEnrolled = dl.FindControl("lblNumEnrolled") as Label;
                Label lblAvailability = dl.FindControl("lblAvailability") as Label;
                int maxStud = Convert.ToInt16(lblMaxStud.Text);
                int numEnrolled = Convert.ToInt16(lblNumEnrolled.Text);
                string availability = lblAvailability.Text.ToString();

                if (numEnrolled + 1 > maxStud || availability != "available")
                {
                    matchCourse += 1;
                }
            }

            if (matchMaterial <= 0 && matchCourse <= 0)
            {
                Response.Redirect("CheckOut.aspx");
            }
            else if (matchMaterial > 0 && matchCourse <= 0)
            {
                MsgBox("Some of the material kits in the cart are out of stock or unavailable!", this.Page, this);
            }
            else if (matchMaterial <= 0 && matchCourse > 0)
            {
                MsgBox("Some of the course in cart reached the maximum enrolled student or unavailable!", this.Page, this);
            }
            else
            {
                MsgBox("Some of the material kits in the cart are out of stock and course in cart reached the maximum enrolled student or unavailable!", this.Page, this);
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