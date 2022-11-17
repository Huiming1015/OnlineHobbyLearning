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
    public partial class ViewCourse : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        String strCourseId;
        protected void Page_Load(object sender, EventArgs e)
        {
            strCourseId = Request.QueryString["courseId"];
            Session["cartCourseId"] = strCourseId;
            if (!IsPostBack)
            {
                if (Session["Role"] != null)
                {
                    string role = Session["Role"].ToString();
                    if (role == "edu")
                    {
                        btnAddToCart.Visible = false;
                        btnRemove.Visible = true;
                        btnModify.Visible = true;
                        lbtnNameList.Visible = true;
                    }
                    else
                    {
                        btnAddToCart.Visible = true;
                        btnRemove.Visible = false;
                        btnModify.Visible = false;
                        lbtnNameList.Visible = false;
                    }
                }
                else
                {
                    btnAddToCart.Visible = false;
                    btnRemove.Visible = false;
                    btnModify.Visible = false;
                    lbtnNameList.Visible = false;
                }

            }
            if (dlMaterialKit.Items.Count == 0)
            {
                lblTitleMaterial.Visible = false;
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            // need to check whether any student enrol in the course, if yes, how? maybe can make a refund / unable to remove but the refund is more easier
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                con = new SqlConnection(strCon);
                con.Open();
                string strQRemove = "Update Course set availability=@availability where courseId=@courseId";
                SqlCommand comRemoveMaterial = new SqlCommand(strQRemove, con);
                comRemoveMaterial.Parameters.AddWithValue("@courseId", strCourseId);
                comRemoveMaterial.Parameters.AddWithValue("@availability", "unavailable");
                int k = comRemoveMaterial.ExecuteNonQuery();

                if (k != 0)
                {
                    MsgBox("Your course has been successfully removed!", this.Page, this);
                    Response.Redirect("EduCourseList.aspx?");
                }
                con.Close();
            }
        }

        public void MsgBox(String ex, Page pg, Object obj)
        {
            string s = "<SCRIPT language='javascript'>alert('" + ex.Replace("\r\n", "\\n").Replace("'", "") + "'); </SCRIPT>";
            Type cstype = obj.GetType();
            ClientScriptManager cs = pg.ClientScript;
            cs.RegisterClientScriptBlock(cstype, s, s.ToString());
        }

        protected void btnModify_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddCourse.aspx?courseId=" + Request.QueryString["courseId"]);
        }

        protected void dlMaterialKit_ItemCommand(object source, DataListCommandEventArgs e)
        {
            Response.Redirect("viewMaterial.aspx?id=" + e.CommandArgument.ToString());
        }

        protected void lbtnNameList_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewStudNameList.aspx?courseId=" + Request.QueryString["courseId"]);
        }

        protected void dlCourse_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "viewEdu")
            {
                Session["EduDetailsId"] = e.CommandArgument.ToString();
                Response.Redirect("EduDetails.aspx");
            }
        }
    }
}