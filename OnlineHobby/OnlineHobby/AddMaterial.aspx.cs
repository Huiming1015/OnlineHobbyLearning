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

        String strMaterialID;
        int intCountID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            strMaterialID = GenerateID();
            lblID.Text = strMaterialID;
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            try
            {
                string strQAdd;
                string strImage = "";
                string fileName = Path.GetFileName(imageUpload.PostedFile.FileName);

                string fileExtension = Path.GetExtension(fileName);
                imageUpload.SaveAs(Request.PhysicalApplicationPath + "images/" + imageUpload.FileName.ToString());

                strImage = "images/" + fileName;

                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [MaterialKit](materialId, eduId, materialName, category, description, materialIncluded, price, stock, materialImage, availability) VALUES (@MaterialId, @EduId, @MaterialName, @Category, @Description, @MaterialIncluded, @Price, @Stock, @MaterialImage, @Availability)";
                SqlCommand comAddMaterial = new SqlCommand(strQAdd, con);
                comAddMaterial.Parameters.AddWithValue("@MaterialId", lblID.Text);
                comAddMaterial.Parameters.AddWithValue("@EduId",Session["UserId"]);
                comAddMaterial.Parameters.AddWithValue("@MaterialName", txtName.Text);
                comAddMaterial.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue.ToString());
                comAddMaterial.Parameters.AddWithValue("@Description", txtDescription.Text);
                comAddMaterial.Parameters.AddWithValue("@MaterialIncluded", txtMaterialIncluded.Text);
                comAddMaterial.Parameters.AddWithValue("@Price", txtPrice.Text);
                comAddMaterial.Parameters.AddWithValue("@Stock", txtStock.Text);
                comAddMaterial.Parameters.AddWithValue("@MaterialImage", strImage);
                comAddMaterial.Parameters.AddWithValue("@Availability", "available");
                int k = comAddMaterial.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Material Kit Added Successfully!", this.Page, this);
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