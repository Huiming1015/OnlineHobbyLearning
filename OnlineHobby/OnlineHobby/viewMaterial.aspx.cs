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
    public partial class viewMaterial : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] != null)
                {
                    string role = Session["Role"].ToString();
                    foreach (DataListItem dl in dlMaterial.Items)
                    {
                        Button btnAddToCart = dl.FindControl("btnAddToCart") as Button;
                        Button btnRemove = dl.FindControl("btnRemove") as Button;
                        Button btnModify = dl.FindControl("btnModify") as Button;
                        if (role == "edu")
                        {
                            btnAddToCart.Visible = false;
                            btnRemove.Visible = true;
                            btnModify.Visible = true;
                        }
                        else
                        {
                            btnAddToCart.Visible = true;
                            btnRemove.Visible = false;
                            btnModify.Visible = false;
                        }
                    }
                }
                else
                {
                    foreach (DataListItem dl in dlMaterial.Items)
                    {
                        Button btnAddToCart = dl.FindControl("btnAddToCart") as Button;
                        Button btnRemove = dl.FindControl("btnRemove") as Button;
                        Button btnModify = dl.FindControl("btnModify") as Button;
                        btnAddToCart.Visible = false;
                        btnRemove.Visible = false;
                        btnModify.Visible = false;
                    }
                }
            }
        }

        protected void dlMaterial_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "modify")
            {
                Response.Redirect("AddMaterial.aspx?id=" + e.CommandArgument.ToString());
            }

            if (e.CommandName == "remove")
            {
                string confirmValue = Request.Form["confirm_value"];
                if (confirmValue == "Yes")
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string strQRemove = "Update MaterialKit set availability=@availability where materialId=@materialId";
                    SqlCommand comRemoveMaterial = new SqlCommand(strQRemove, con);
                    comRemoveMaterial.Parameters.AddWithValue("@materialId", e.CommandArgument.ToString());
                    comRemoveMaterial.Parameters.AddWithValue("@availability", "unavailable");
                    int k = comRemoveMaterial.ExecuteNonQuery();

                    if (k != 0)
                    {
                        //ClientScript.RegisterStartupScript(this.GetType(), "aa", "SuccessRemoveAlert()", true);
                        MsgBox("Your material kit has been successfully removed!", this.Page, this);
                        Response.Redirect("EduMaterial.aspx?");
                    }
                    con.Close();
                }
            }

            if (e.CommandName == "addToCart")
            {
                String strQ;
                Label lblStock = e.Item.FindControl("lblStock") as Label;
                Int32 cartId = 0, quantity = 0, stock = 0;
                stock = Convert.ToInt16(lblStock.Text);
                con = new SqlConnection(strCon);
                con.Open();
                strQ = "SELECT * FROM Cart WHERE materialId=@MaterialId AND studId=@StudId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@MaterialId", e.CommandArgument);
                com.Parameters.AddWithValue("@StudId", Session["UserId"]);
                SqlDataReader dr = com.ExecuteReader();

                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        cartId = Convert.ToInt32(dr["cartId"].ToString());
                        quantity = Convert.ToInt32(dr["quantity"].ToString());
                    }
                    if (quantity + 1 <= stock)
                    {
                        modifyCartQuantity(cartId, quantity);
                    }
                    else
                    {
                        MsgBox("The quantity of this material kit in cart has reached the maximum stock quantity!", this.Page, this);
                    }
                }
                else
                {
                    if (stock >= 1)
                    {
                        addToCart(e);
                    }
                    else
                    {
                        MsgBox("The stock for this material kit is empty now!", this.Page, this);
                    }
                }
            }

            if (e.CommandName == "viewEdu")
            {
                Session["EduDetailsId"] = e.CommandArgument.ToString();
                Response.Redirect("EduDetails.aspx");
            }
        }

        private void addToCart(DataListCommandEventArgs e)
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Cart](cartId, studId, materialId, quantity) VALUES (@CartId, @StudId, @MaterialId, @Quantity)";
                SqlCommand comAddToCart = new SqlCommand(strQAdd, con);
                comAddToCart.Parameters.AddWithValue("@CartId", GenerateCartID());
                comAddToCart.Parameters.AddWithValue("@StudId", Session["UserId"].ToString());
                comAddToCart.Parameters.AddWithValue("@MaterialId", e.CommandArgument.ToString());
                comAddToCart.Parameters.AddWithValue("@Quantity", 1);
                int k = comAddToCart.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Add to cart successfully!", this.Page, this);
                }
                con.Close();
            }
            catch
            {
                MsgBox("Add to cart unsuccessful!", this.Page, this);
            }
        }

        private void modifyCartQuantity(Int32 cartId, Int32 quantity)
        {
            try
            {
                string strQModify;
                con = new SqlConnection(strCon);
                con.Open();
                strQModify = "UPDATE Cart SET quantity=@Quantity WHERE cartId=@CartId";
                SqlCommand comModifyDiscount = new SqlCommand(strQModify, con);
                comModifyDiscount.Parameters.AddWithValue("@CartId", cartId);
                comModifyDiscount.Parameters.AddWithValue("@Quantity", quantity + 1);
                int k = comModifyDiscount.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Add to cart successfully!", this.Page, this);
                }
                con.Close();
            }
            catch
            {
                MsgBox("Add to cart unsuccessful!", this.Page, this);
            }
        }

        private Int32 GenerateCartID()
        {
            Int32 cartId;
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(cartId),0) from Cart", con);
            cartId = Convert.ToInt32(cmd.ExecuteScalar()) + 1;
            con.Close();
            return cartId;
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        protected void dlMaterial_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Button btnAddToCart = e.Item.FindControl("btnAddToCart") as Button;
                Button btnModify = e.Item.FindControl("btnModify") as Button;
                Button btnRemove = e.Item.FindControl("btnRemove") as Button;
                if (Session["UserEmail"] != null)
                {
                    string role = Session["Role"].ToString();
                    if (role == "edu")
                    {
                        btnAddToCart.Visible = false;
                        btnRemove.Visible = true;
                        btnModify.Visible = true;
                    }
                    else
                    {
                        btnAddToCart.Visible = true;
                        btnRemove.Visible = false;
                        btnModify.Visible = false;
                    }
                }
                else
                {

                    btnAddToCart.Visible = false;
                    btnRemove.Visible = false;
                    btnModify.Visible = false;
                }
            }
        }
    }
}