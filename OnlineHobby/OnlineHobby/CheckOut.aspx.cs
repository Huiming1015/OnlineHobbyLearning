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
    public partial class CheckOut : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            double subtotal = 0, discount = 0, total = 0;

            int matchCourse = 0, matchMaterial = 0, discountRate = 0;
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
                btnConfirm.CausesValidation = false;
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

            if (dlCartCourse.Items.Count >= 0 && dlCartMaterial.Items.Count >= 0)
            {
                String strQ;
                con = new SqlConnection(strCon);
                con.Open();
                strQ = "SELECT * FROM Discount";
                SqlCommand com = new SqlCommand(strQ, con);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    double coursePrice = 0, materialPrice = 0;
                    foreach (DataListItem course in dlCartCourse.Items)
                    {
                        Label lblCourseId = course.FindControl("lblCourseId") as Label;
                        Label lblCoursePrice = course.FindControl("lblCoursePrice") as Label;
                        if (lblCourseId.Text == dr["courseId"].ToString())
                        {
                            coursePrice = Convert.ToDouble(lblCoursePrice.Text);
                            matchCourse += 1;
                        }
                    }

                    foreach (DataListItem material in dlCartMaterial.Items)
                    {
                        Label lblMaterialId = material.FindControl("lblMaterialId") as Label;
                        Label lblMaterialPrice = material.FindControl("lblMaterialPrice") as Label;
                        if (lblMaterialId.Text == dr["materialId"].ToString())
                        {
                            materialPrice = Convert.ToDouble(lblMaterialPrice.Text);
                            matchMaterial += 1;
                        }
                    }

                    if (matchMaterial >= 1 && matchCourse >= 1)
                    {
                        discountRate = Convert.ToInt16(dr["discountRate"].ToString());
                        discount = ((coursePrice + materialPrice) * discountRate / 100);
                    }
                    matchCourse = 0;
                    matchMaterial = 0;
                }
            }
            con.Close();
            total = subtotal - discount;
            lblDiscount.Text = discount.ToString("0.00");
            lblSubTotal.Text = subtotal.ToString("0.00");
            lblTotalAmount.Text = total.ToString("0.00");

            if (!IsPostBack)
            {
                int countAddress = 0;
                ddlAddress.Items.Insert(countAddress, "Custom new address");
                String strName, strAddress, strPhone, item;
                String strQ;
                con = new SqlConnection(strCon);
                con.Open();
                strQ = "SELECT * FROM AddressBook WHERE studId=@StudId";
                SqlCommand com = new SqlCommand(strQ, con);
                com.Parameters.AddWithValue("@StudId", Session["UserId"]);
                SqlDataReader dr = com.ExecuteReader();
                while (dr.Read())
                {
                    strName = dr["name"].ToString();
                    strAddress = dr["address"].ToString();
                    strPhone = dr["phone"].ToString();
                    item = strName + "|" + strPhone + "|" + strAddress;
                    ddlAddress.Items.Insert(countAddress + 1, item);
                }
                con.Close();
            }
        }

        protected void ddlAddress_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlAddress.SelectedIndex == 0)
            {
                txtName.Text = "";
                txtPhone.Text = "";
                txtAddress.Text = "";
                txtName.Enabled = true;
                txtPhone.Enabled = true;
                txtAddress.Enabled = true;
            }
            else
            {
                txtName.Enabled = false;
                txtPhone.Enabled = false;
                txtAddress.Enabled = false;
                string[] info = ddlAddress.SelectedItem.ToString().Split('|');
                txtName.Text = info[0];
                txtPhone.Text = info[1];
                txtAddress.Text = info[2];
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            Session["shipName"] = txtName.Text;
            Session["shipPhone"] = txtPhone.Text;
            Session["shipAddress"] = txtAddress.Text;
            Session["totalPrice"] = lblTotalAmount.Text;
            Session["discount"] = lblDiscount.Text;
            if (ddlPayMethod.SelectedValue == "creditCard")
            {
                Response.Redirect("CreditCard.aspx?");
            }
            else
            {
                Response.Redirect("PayPal.aspx?");
            }
        }
    }
}