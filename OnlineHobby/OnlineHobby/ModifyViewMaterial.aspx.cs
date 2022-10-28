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
    public partial class ModifyViewMaterial : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {


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
            Image img = e.Item.FindControl("imgArt") as Image;
            if (e.CommandName == "modify")
            {
                if (btnModify.Text == "MODIFY")
                {
                    //btnConfirm.Enabled = true;
                    txtName.Enabled = true;
                    ddlCategory.Enabled = true;
                    txtDescription.Enabled = true;
                    txtMaterialIncluded.Enabled = true;
                    txtStock.Enabled = true;
                    txtPrice.Enabled = true;
                    imageUpload.Visible = true;
                    btnModify.Text = "CONFIRM";
                    btnRemove.Visible = false;
                    btnModify.CausesValidation = true;
                }
                else
                {
                    try
                    {
                        string strImage = "";
                        if (imageUpload.HasFile != false)
                        {
                            imageUpload.SaveAs(Request.PhysicalApplicationPath + "images/" + imageUpload.FileName.ToString());
                            strImage = "images/" + imageUpload.FileName.ToString();
                        }
                        else
                        {
                            strImage = img.ImageUrl.ToString();
                        }
                        con = new SqlConnection(strCon);
                        con.Open();
                        string strQModify = "Update MaterialKit set materialName=@materialName, category=@category, description=@description, materialIncluded=@materialIncluded, price=@price, stock=@stock, materialImage=@materialImage where materialId=@materialId";
                        SqlCommand comModifyMaterial = new SqlCommand(strQModify, con);

                        comModifyMaterial.Parameters.AddWithValue("@materialId", lblID.Text);
                        comModifyMaterial.Parameters.AddWithValue("@eduID", Session["userId"]);
                        comModifyMaterial.Parameters.AddWithValue("@materialName", txtName.Text);
                        comModifyMaterial.Parameters.AddWithValue("@category", ddlCategory.SelectedValue.ToString());
                        comModifyMaterial.Parameters.AddWithValue("@description", txtDescription.Text);
                        comModifyMaterial.Parameters.AddWithValue("@materialIncluded", txtMaterialIncluded.Text);
                        comModifyMaterial.Parameters.AddWithValue("@price", txtPrice.Text);
                        comModifyMaterial.Parameters.AddWithValue("@stock", txtStock.Text);
                        comModifyMaterial.Parameters.AddWithValue("@materialImage", strImage);

                        int k = comModifyMaterial.ExecuteNonQuery();

                        if (k != 0)
                        {
                            MsgBox("Your material kit has been successfully modified!", this.Page, this);
                            Response.Redirect("EduMaterial.aspx?");
                        }
                        con.Close();
                    }
                    catch
                    {
                        MsgBox("Please insert the valid data into all required field!", this.Page, this);
                    }
                }
                
            }         

            if (e.CommandName == "remove")
            {

                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                       "swal('Good job!', 'You clicked Success button!', 'success')", true);
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