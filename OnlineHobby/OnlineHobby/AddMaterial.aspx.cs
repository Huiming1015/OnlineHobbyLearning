using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class AddMaterial : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        String strMaterialID, strQueryId;
        int intCountID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            strQueryId = Request.QueryString["id"];

            if (strQueryId != null)
            {
                if (!IsPostBack)
                {
                    lblTitle.Text = "MODIFY MATERIAL KIT";
                    btnUpload.Text = "CONFIRM";
                    String strQ;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQ = "Select * from MaterialKit where materialId = '" + strQueryId + "'";
                    SqlCommand comID = new SqlCommand(strQ, con);
                    SqlDataReader dr = comID.ExecuteReader();
                    while (dr.Read())
                    {
                        string description = dr["description"].ToString().Replace("<br />", "\r\n").Replace("<br />", "\n");
                        string materialIncluded = dr["materialIncluded"].ToString().Replace("<br />", "\r\n").Replace("<br />", "\n");
                        strMaterialID = strQueryId;
                        imgMaterial.ImageUrl = dr["materialImage"].ToString();
                        requireImage.Enabled = false;
                        txtName.Text = dr["materialName"].ToString();
                        txtDescription.Text = description;
                        txtMaterialIncluded.Text = materialIncluded;
                        txtStock.Text = dr["stock"].ToString();
                        txtPrice.Text = String.Format("{0:N2}", double.Parse(dr["price"].ToString()));
                        ddlCategory.SelectedValue = dr["category"].ToString();
                    }
                    con.Close();
                }
            }
            else
            {
                lblTitle.Text = "ADD MATERIAL KIT";
                strMaterialID = GenerateID();
            }
            lblID.Text = strMaterialID;
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (strQueryId != null)
            {
                modifyMaterial();
            }
            else
            {
                addMaterial();
            }

        }

        private void addMaterial()
        {
            try
            {
                string strQAdd;
                string strImage = "";
                string fileName = Path.GetFileName(imageUpload.PostedFile.FileName);

                string fileExtension = Path.GetExtension(fileName);
                imageUpload.SaveAs(Request.PhysicalApplicationPath + "images/" + imageUpload.FileName.ToString());

                strImage = "images/" + fileName;
                string materialIncluded = txtMaterialIncluded.Text.Replace("\r\n", "<br />").Replace("\n", "<br />");
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [MaterialKit](materialId, eduId, materialName, category, description, materialIncluded, price, stock, materialImage, availability) VALUES (@MaterialId, @EduId, @MaterialName, @Category, @Description, @MaterialIncluded, @Price, @Stock, @MaterialImage, @Availability)";
                SqlCommand comAddMaterial = new SqlCommand(strQAdd, con);
                comAddMaterial.Parameters.AddWithValue("@MaterialId", lblID.Text);
                comAddMaterial.Parameters.AddWithValue("@EduId", Session["UserId"]);
                comAddMaterial.Parameters.AddWithValue("@MaterialName", txtName.Text);
                comAddMaterial.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue.ToString());
                comAddMaterial.Parameters.AddWithValue("@Description", txtDescription.Text);
                comAddMaterial.Parameters.AddWithValue("@MaterialIncluded", materialIncluded);
                comAddMaterial.Parameters.AddWithValue("@Price", txtPrice.Text);
                comAddMaterial.Parameters.AddWithValue("@Stock", txtStock.Text);
                comAddMaterial.Parameters.AddWithValue("@MaterialImage", strImage);
                comAddMaterial.Parameters.AddWithValue("@Availability", "available");
                int k = comAddMaterial.ExecuteNonQuery();

                if (k != 0)
                {
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                "swal('Good job!', 'You clicked Success button!', 'success')", true);
                    // MsgBox("Material Kit Added Successfully!", this.Page, this);
                    Clear();
                    Response.Redirect("EduMaterial.aspx?");
                }

                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        private void modifyMaterial()
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
                    strImage = imgMaterial.ImageUrl.ToString();
                }
                con = new SqlConnection(strCon);
                con.Open();
                string strQModify = "Update MaterialKit set materialName=@materialName, category=@category, description=@description, materialIncluded=@materialIncluded, price=@price, stock=@stock, materialImage=@materialImage where materialId=@materialId";
                SqlCommand comModifyMaterial = new SqlCommand(strQModify, con);
                string materialIncluded = txtMaterialIncluded.Text.Replace("\r\n", "<br />").Replace("\n", "<br />");
                comModifyMaterial.Parameters.AddWithValue("@materialId", strQueryId);
                comModifyMaterial.Parameters.AddWithValue("@materialName", txtName.Text);
                comModifyMaterial.Parameters.AddWithValue("@category", ddlCategory.SelectedValue.ToString());
                comModifyMaterial.Parameters.AddWithValue("@description", txtDescription.Text);
                comModifyMaterial.Parameters.AddWithValue("@materialIncluded", materialIncluded);
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

        protected void btnReset_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
        }


        private string GenerateID()
        {
            string id = "";
            String strQMaterial;
            con = new SqlConnection(strCon);
            con.Open();
            strQMaterial = "Select materialId from MaterialKit";
            SqlCommand comID = new SqlCommand(strQMaterial, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["materialId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            con.Close();
            return "M" + intCountID.ToString("0000");
        }


        private void Clear()
        {
            txtName.Text = "";
            txtMaterialIncluded.Text = "";
            txtStock.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            ddlCategory.ClearSelection();
            imageUpload = new FileUpload();
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