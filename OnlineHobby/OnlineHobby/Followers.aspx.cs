﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
	public partial class Followers : System.Web.UI.Page
	{
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
		{
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
                    string cmd = "Select COUNT(fllwId) from Follower where eduId=@eduId";
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@eduId", UserId);
                    Int64 count = Convert.ToInt64(cmdSelect.ExecuteScalar());
                    lblFllwerCount.Text = count.ToString();

                    if (count == 0)
                    {
                        con.Close();
                        Repeater1.Visible = false;
                        MsgNotice.Visible = true;
                        lblFllwerCount.Visible = false;
                        Label10.Visible = false;
                        Panel1.Visible = true;
                        Panel2.Visible = true;
                    }

                    if (count == 1)
                    {
                        con.Close();
                        Panel3.Visible = true;
                        Panel5.Visible = true;
                    }

                    if (count == 2)
                    {
                        con.Close();
                        Panel4.Visible = true;
                    }

                    if (count == 3)
                    {
                        con.Close();
                        Panel6.Visible = true;
                    }
                }

            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }
        }
	}
}