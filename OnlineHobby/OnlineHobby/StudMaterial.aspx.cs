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
    public partial class StudMaterial : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                displayAll();
                if (dtMaterial.Items.Count <= 0)
                {
                    lblMessage.Visible = true;
                }
                else { lblMessage.Visible = false; }
            }

        }

        protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string category = ddlCategory.SelectedValue;
            if (category == "all")
            {
                displayAll();
            }
            else
            {
                string strQCategory;
                con = new SqlConnection(strCon);
                con.Open();

                strQCategory = "SELECT materialId, materialName, materialImage, price, stock FROM MaterialKit Where (availability = 'available') AND (category = @Category)";

                SqlCommand com = new SqlCommand(strQCategory, con);
                SqlDataAdapter sda = new SqlDataAdapter(com);
                com.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                dtMaterial.DataSource = dt;
                dtMaterial.DataBind();
                con.Close();
            }
            if (dtMaterial.Items.Count <= 0)
            {
                lblMessage.Visible = true;
            }
            else { lblMessage.Visible = false; }
        }

        public void displayAll()
        {
            string strQ = "SELECT materialId, materialName, materialImage, price, stock FROM MaterialKit WHERE availability = 'available'";
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand com = new SqlCommand(strQ, con);
            SqlDataAdapter sda = new SqlDataAdapter(com);

            DataTable dt = new DataTable();
            sda.Fill(dt);
            dtMaterial.DataSource = dt;
            dtMaterial.DataBind();
            con.Close();
        }

        protected void dtMaterial_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("viewMaterial.aspx?id=" + e.CommandArgument.ToString());
            }

            if (e.CommandName == "addToCart")
            {
                Label lblStock = e.Item.FindControl("lblStock") as Label;

                String strQ;
                Int32 cartId = 0, quantity = 0, stock = 0;
                stock = Convert.ToInt16(lblStock.Text);
                con = new SqlConnection(strCon);
                con.Open();
                strQ = "SELECT * FROM Cart WHERE materialId=@MaterialId AND studId=@StudId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@MaterialId", e.CommandArgument.ToString());
                com.Parameters.AddWithValue("@StudId", Session["UserId"].ToString());
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

        protected void dtMaterial_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                ImageButton btnAddToCart = e.Item.FindControl("btnAddToCart") as ImageButton;
                if (Session["UserEmail"] != null)
                {
                    string role = Session["Role"].ToString();
                    if (role == "edu")
                    {
                        btnAddToCart.Visible = false;
                    }
                    else
                    {
                        btnAddToCart.Visible = true;
                    }
                }
                else
                {
                    btnAddToCart.Visible = false;
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