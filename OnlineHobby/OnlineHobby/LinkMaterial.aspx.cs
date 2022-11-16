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

        String strDiscountID, strCourseID;
        String strMaterialID;
        Double dDiscountRate = 0.00;
        int intCountID = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            strCourseID = Request.QueryString["courseId"].ToString();
        }

        protected void btnFinish_Click(object sender, EventArgs e)
        {
            foreach (DataListItem li in dlMaterialKit.Items)
            {
                DataList dlDiscount = li.FindControl("dlDiscount") as DataList;
                Label lblMaterialId = li.FindControl("lblMaterialId") as Label;
                Button btnLink = li.FindControl("btnLink") as Button;
                strMaterialID = lblMaterialId.Text.ToString();
                foreach (DataListItem discount in dlDiscount.Items)
                {
                    TextBox txtDiscount = discount.FindControl("txtDiscount") as TextBox;
                    if (txtDiscount.Text.ToString() != "")
                    {
                        if (Convert.ToInt16(txtDiscount.Text) > 0)
                        {
                            dDiscountRate = Convert.ToInt32(txtDiscount.Text);
                        }
                    }

                    String strQ;
                    con = new SqlConnection(strCon);
                    con.Open();
                    strQ = "SELECT * FROM Discount WHERE materialId=@MaterialId AND courseId=@CourseId";
                    SqlCommand com = new SqlCommand(strQ, con);
                    com.Parameters.AddWithValue("@MaterialId", strMaterialID);
                    com.Parameters.AddWithValue("@CourseId", strCourseID);
                    SqlDataReader dr = com.ExecuteReader();
                    if (txtDiscount.Text != "" && dDiscountRate > 0)
                    {
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                strDiscountID = dr["discountId"].ToString();
                            }
                            modifyDiscount();
                        }
                        else
                        {
                            strDiscountID = GenerateID();
                            addDiscount();
                        }
                    }
                    else
                    {
                        removeDiscount();
                        con.Close();
                    }
                }
            }
            MsgBox("Course details has been successfully saved!", this.Page, this);
            ScriptManager.RegisterStartupScript(this, GetType(), "", "window.location = '" + Page.ResolveUrl("~/EduCourseList.aspx") + "';", true);
        }

        private void addDiscount()
        {
            try
            {
                string strQAdd;
                con = new SqlConnection(strCon);
                con.Open();
                strQAdd = "INSERT INTO [Discount](discountId, courseId, materialId, discountRate) VALUES (@DiscountId, @CourseId, @MaterialId, @DiscountRate)";
                SqlCommand comAddDiscount = new SqlCommand(strQAdd, con);
                comAddDiscount.Parameters.AddWithValue("@DiscountId", strDiscountID);
                comAddDiscount.Parameters.AddWithValue("@CourseId", strCourseID);
                comAddDiscount.Parameters.AddWithValue("@MaterialId", strMaterialID);
                comAddDiscount.Parameters.AddWithValue("@DiscountRate", dDiscountRate);
                int k = comAddDiscount.ExecuteNonQuery();

                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        private void removeDiscount()
        {
            try
            {
                string strQDelete;
                con = new SqlConnection(strCon);
                con.Open();
                strQDelete = "DELETE FROM Discount WHERE materialId=@MaterialId AND courseId=@CourseId";
                SqlCommand comRemoveDiscount = new SqlCommand(strQDelete, con);
                comRemoveDiscount.Parameters.AddWithValue("@MaterialId", strMaterialID);
                comRemoveDiscount.Parameters.AddWithValue("@CourseId", strCourseID);
                int k = comRemoveDiscount.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Course details has been successfully saved!", this.Page, this);
                    Response.Redirect("EduCourseList.aspx?");
                }
                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
        }

        private void modifyDiscount()
        {
            try
            {
                string strQModify;
                con = new SqlConnection(strCon);
                con.Open();
                strQModify = "UPDATE Discount SET discountRate=@DiscountRate WHERE discountId=@DiscountId";
                SqlCommand comModifyDiscount = new SqlCommand(strQModify, con);
                comModifyDiscount.Parameters.AddWithValue("@DiscountId", strDiscountID);
                comModifyDiscount.Parameters.AddWithValue("@DiscountRate", dDiscountRate);
                int k = comModifyDiscount.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Course details has been successfully saved!", this.Page, this);
                    Response.Redirect("EduCourseList.aspx?");
                }
                con.Close();
            }
            catch
            {
                MsgBox("Please insert the valid data into all required field!", this.Page, this);
            }
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

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

    }
}