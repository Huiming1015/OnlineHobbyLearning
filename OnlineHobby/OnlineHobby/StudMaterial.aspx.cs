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
            if (category == "All Category")
            {
                displayAll();
            }
            else
            {
                string strQCategory;
                con = new SqlConnection(strCon);
                con.Open();

                strQCategory = "SELECT materialId, materialName, materialImage, price FROM MaterialKit Where (availability = 'available') AND (category = @Category)";

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

        protected void dtMaterial_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }

        public void displayAll()
        {
            string strQ = "SELECT materialId, materialName, materialImage, price FROM MaterialKit WHERE availability = 'available'";
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
    }
}