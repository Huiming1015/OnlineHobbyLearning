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
    public partial class LinkMaterial : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        String strDiscountID;
        String strMaterialID;
        Double dDiscountRate = 0.00;
        int intCountID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cbMaterial_CheckedChanged(object sender, EventArgs e)
        {
            foreach (DataListItem li in dlMaterialKit.Items)
            {
                CheckBox cbMaterial = li.FindControl("cbMaterial") as CheckBox;
                TextBox txtDiscount = li.FindControl("txtDiscount") as TextBox;
                if (cbMaterial.Checked == true)
                {
                    txtDiscount.Enabled = true;
                }
                else
                {
                    txtDiscount.Text = "";
                    txtDiscount.Enabled = false;
                }

            }
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            foreach (DataListItem li in dlMaterialKit.Items)
            {
                CheckBox cbMaterial = li.FindControl("cbMaterial") as CheckBox;
                TextBox txtDiscount = li.FindControl("txtDiscount") as TextBox;
                Label lblMaterialId = li.FindControl("lblMaterialId") as Label;
                Button btnLink = li.FindControl("btnLink") as Button;
                if (cbMaterial.Checked == true)
                {
                    strDiscountID = GenerateID();
                    strMaterialID = lblMaterialId.Text.ToString();
                    dDiscountRate = double.Parse(txtDiscount.Text.ToString());
                    addDiscount();
                }
                else
                {
                    removeDiscount();
                }
            }
        }

        private void addDiscount()
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Discount](discountId, courseId, materialId, discountRate) VALUES (@DiscountId, @CourseId, @MaterialId, @DiscountRate)";
                SqlCommand comAddMaterial = new SqlCommand(strQAdd, con);
                comAddMaterial.Parameters.AddWithValue("@DiscountId", strDiscountID);
                comAddMaterial.Parameters.AddWithValue("@CourseId", Session["CourseID"].ToString());
                comAddMaterial.Parameters.AddWithValue("@MaterialId", strMaterialID);
                comAddMaterial.Parameters.AddWithValue("@DiscountRate", dDiscountRate);
                int k = comAddMaterial.ExecuteNonQuery();

                if (k != 0)
                {
                    //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert",
                    //"swal('Good job!', 'You clicked Success button!', 'success')", true);
                    MsgBox("Material Linked Successfully!", this.Page, this);
                    //Response.Redirect("LinkMaterial.aspx?");
                }
                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        private void removeDiscount()
        {

        }
        private string GenerateID()
        {
            string id = "";
            String strQMaterial;
            con = new SqlConnection(strCon);
            con.Open();
            strQMaterial = "Select discountId from Discount";
            SqlCommand comID = new SqlCommand(strQMaterial, con);
            SqlDataReader dr = comID.ExecuteReader();
            while (dr.Read())
            {
                id = dr["discountId"].ToString();
                intCountID = int.Parse(id.Substring(id.Length - 4));
            }
            intCountID += 1;
            con.Close();
            return "D" + intCountID.ToString("0000");
        }

        //private Int64 GenerateID()
        //{
        //    Int64 id;
        //    String strQDiscount;
        //    con = new SqlConnection(strCon);
        //    con.Open();
        //    strQDiscount = "Select IsNull(max(discountId),0) from Discount";
        //    SqlCommand comID = new SqlCommand(strQDiscount, con);
        //    id = Convert.ToInt64(comID.ExecuteScalar()) + 1;
        //    con.Close();
        //    return id;
        //}

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }
        
    }
}