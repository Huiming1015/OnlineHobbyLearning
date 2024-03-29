﻿using System;
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
    public partial class Posts : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            MsgNotice.Visible = false;

            if (Session["UserEmail"] != null)
            {
                Int64 UserId = Convert.ToInt64(Session["UserId"]);
                string role = Session["Role"].ToString();

                if (role == "stud")
                {
                    Response.Redirect("Profile.aspx");
                }
                else
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string cmd = "Select * from Posts where eduId=@eduId";
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@eduId", UserId);

                    DataTable dt = new DataTable();
                    SqlDataAdapter sda = new SqlDataAdapter(cmdSelect);
                    sda.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        con.Close();
                        Repeater1.Visible = false;
                        MsgNotice.Visible = true;
                        Panel1.Visible = true;
                        Panel2.Visible = true;
                    }
                    

                    //if (dt.Rows.Count == 1)
                    //{
                    //    con.Close();
                    //    Panel3.Visible = true;
                    //}
                }
            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }

            //foreach (RepeaterItem item in Repeater1.Items)
            //{
            //    Image img = item.FindControl("imgPostImage") as Image;
            //    if (img.ImageUrl == "")
            //    {
            //        img.Attributes.Add("style", "height:1px;");
            //    }
            //}
        }

        protected void btnAddPost_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddPost.aspx");
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                Response.Redirect("EditPost.aspx?id=" + e.CommandArgument.ToString());
            }
        }
        
        
    }
}