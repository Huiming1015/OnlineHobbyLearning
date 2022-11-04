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

        protected void Page_Load(object sender, EventArgs e)
        {
            if(dlMaterialKit.Items.Count == 0)
            {
                lblTitleMaterial.Visible = false;
            }
        }

        protected void btnRemove_Click(object sender, EventArgs e)
        {
            string strCourseId = Request.QueryString["courseId"];
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
                    //ClientScript.RegisterStartupScript(this.GetType(), "aa", "SuccessRemoveAlert()", true);
                    MsgBox("Your course has been successfully removed!", this.Page, this);
                    Response.Redirect("EduMaterial.aspx?");
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
    }
}