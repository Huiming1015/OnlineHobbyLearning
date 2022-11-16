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
    public partial class StudCourseList : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                displayAll();
                if (dlCourse.Items.Count <= 0)
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

                strQCategory = "SELECT courseId, courseName, courseImage FROM Course Where (availability = 'available') AND (category = @Category)";

                SqlCommand com = new SqlCommand(strQCategory, con);
                SqlDataAdapter sda = new SqlDataAdapter(com);
                com.Parameters.AddWithValue("@Category", ddlCategory.SelectedValue);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                dlCourse.DataSource = dt;
                dlCourse.DataBind();
                con.Close();
            }
            if (dlCourse.Items.Count <= 0)
            {
                lblMessage.Visible = true;
            }
            else { lblMessage.Visible = false; }
        }


        public void displayAll()
        {
            string strQ = "SELECT courseId, courseName, courseImage FROM Course WHERE availability = 'available'";
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand com = new SqlCommand(strQ, con);
            SqlDataAdapter sda = new SqlDataAdapter(com);

            DataTable dt = new DataTable();
            sda.Fill(dt);
            dlCourse.DataSource = dt;
            dlCourse.DataBind();
            con.Close();
        }

        protected void dlCourse_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "view")
            {
                Response.Redirect("ViewCourse.aspx?courseId=" + e.CommandArgument.ToString());
            }
            if (e.CommandName == "addToCart")
            {
                Session["cartCourseId"] = e.CommandArgument.ToString();
                mp1.Show();
            }
        }

        protected void dlCourse_ItemDataBound(object sender, DataListItemEventArgs e)
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
    }
}