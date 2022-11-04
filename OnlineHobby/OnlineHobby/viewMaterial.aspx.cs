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
                string role = Session["Role"].ToString();
                foreach (DataList dl in dlMaterial.Items)
                {
                    Button btnAddToCart = dl.FindControl("btnAddToCart") as Button;
                    Button btnRemove = dl.FindControl("btnRemove") as Button;
                    Button btnModify = dl.FindControl("btnRemove") as Button;
                    if (role == "stud")
                    {
                        btnAddToCart.Visible = true;
                        btnRemove.Visible = false;
                        btnModify.Visible = false;
                    }
                }
            }
        }

        protected void dlMaterial_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Label lblID = e.Item.FindControl("lblID") as Label;
            TextBox txtName = e.Item.FindControl("txtName") as TextBox;
            DropDownList ddlCategory = e.Item.FindControl("ddlCategory") as DropDownList;
            TextBox txtDescription = e.Item.FindControl("txtDescription") as TextBox;
            TextBox txtMaterialIncluded = e.Item.FindControl("txtMaterialIncluded") as TextBox;
            TextBox txtPrice = e.Item.FindControl("txtPrice") as TextBox;
            TextBox txtStock = e.Item.FindControl("txtStock") as TextBox;
            FileUpload imageUpload = e.Item.FindControl("imageUpload") as FileUpload;
            //Button btnConfirm = e.Item.FindControl("btnConfirm") as Button;
            Button btnModify = e.Item.FindControl("btnModify") as Button;
            Button btnRemove = e.Item.FindControl("btnRemove") as Button;
            Image img = e.Item.FindControl("imgMaterial") as Image;
            if (e.CommandName == "modify")
            {
                Response.Redirect("AddMaterial.aspx?id=" + e.CommandArgument.ToString());
            }

            if (e.CommandName == "remove")
            {

                //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                //       "swal('Good job!', 'You clicked Success button!', 'success')", true);
                string confirmValue = Request.Form["confirm_value"];
                if (confirmValue == "Yes")
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string strQRemove = "Update MaterialKit set availability=@availability where materialId=@materialId";
                    SqlCommand comRemoveMaterial = new SqlCommand(strQRemove, con);
                    comRemoveMaterial.Parameters.AddWithValue("@materialId", lblID.Text);
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