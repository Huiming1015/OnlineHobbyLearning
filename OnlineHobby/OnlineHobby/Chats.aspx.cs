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
    public partial class Chats : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserEmail"] != null)
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);
                    string role = Session["Role"].ToString();

                    if (role == "stud")
                    {
                        //SqlDataSource1.SelectCommand = "Select DISTINCT Chat.chatId AS id,Chat.eduId,Chat.eduName AS name,Educator.profileImg,MAX(ChatDetails.messageContents) AS messageContents FROM Chat INNER JOIN Educator ON Chat.eduId = Educator.eduId INNER JOIN ChatDetails ON Chat.chatId = ChatDetails.chatId WHERE Chat.studId = " + UserId + " GROUP BY Chat.chatId,Chat.eduId,Chat.eduName,Educator.profileImg";
                        con = new SqlConnection(strCon);
                        con.Open();
                        string cmd2 = "SELECT cd.chatId as id, cd.messageContents as messageContents, c.eduId, c.eduName as name, e.profileImg from(SELECT *, ROW_NUMBER() OVER(PARTITION BY chatid ORDER BY messageDateTime DESC) AS RN FROM ChatDetails) cd INNER JOIN Chat c ON c.chatId = cd.chatId INNER JOIN Educator e ON c.eduId = e.eduId WHERE RN = 1 and c.studId = " + UserId;
                        SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                        Repeater1.DataSource = cmdSelect2.ExecuteReader();
                        Repeater1.DataBind();
                        con.Close();

                        con = new SqlConnection(strCon);
                        con.Open();
                        string cmd = "Select COUNT(chatId) from Chat where studId=@studId";
                        SqlCommand cmdSelect = new SqlCommand(cmd, con);
                        cmdSelect.Parameters.AddWithValue("@studId", UserId);
                        Int64 count = Convert.ToInt64(cmdSelect.ExecuteScalar());

                        if (count == 0)
                        {
                            con.Close();
                            Repeater1.Visible = false;
                            MsgNotice.Visible = true;
                            Panel1.Visible = true;
                            Panel2.Visible = true;
                        }

                        if (count == 1)
                        {
                            con.Close();
                            Panel3.Visible = true;
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

                        if (count >= 4)
                        {
                            Panel5.Visible = true;
                        }
                    }
                    else
                    {
                        // SqlDataSource1.SelectCommand = "Select DISTINCT Chat.chatId AS id,Chat.studId,Chat.studName AS name,Student.profileImg,MAX(ChatDetails.messageContents) AS messageContents FROM Chat INNER JOIN Student ON Chat.studId = Student.studId INNER JOIN ChatDetails ON Chat.chatId = ChatDetails.chatId WHERE Chat.eduId = " + UserId + " GROUP BY Chat.chatId,Chat.studId,Chat.studName,Student.profileImg";

                        con = new SqlConnection(strCon);
                        con.Open();
                        string cmd2 = "SELECT cd.chatId as id, cd.messageContents as messageContents, c.eduId, c.eduName as name, s.profileImg from(SELECT *, ROW_NUMBER() OVER(PARTITION BY chatid ORDER BY messageDateTime DESC) AS RN FROM ChatDetails) cd INNER JOIN Chat c ON c.chatId = cd.chatId INNER JOIN Student s ON c.studId = s.studId WHERE RN = 1 and c.eduId = " + UserId;
                        SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                        Repeater1.DataSource = cmdSelect2.ExecuteReader();
                        Repeater1.DataBind();
                        con.Close();

                        con = new SqlConnection(strCon);
                        con.Open();
                        string cmd = "Select COUNT(chatId) from Chat where eduId=@eduId";
                        SqlCommand cmdSelect = new SqlCommand(cmd, con);
                        cmdSelect.Parameters.AddWithValue("@eduId", UserId);
                        Int64 count = Convert.ToInt64(cmdSelect.ExecuteScalar());

                        if (count == 0)
                        {
                            con.Close();
                            Repeater1.Visible = false;
                            MsgNotice.Visible = true;
                            Panel1.Visible = true;
                            Panel2.Visible = true;
                        }

                        if (count == 1)
                        {
                            con.Close();
                            Panel3.Visible = true;
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

                        if (count >= 4)
                        {
                            Panel5.Visible = true;
                        }
                    }
                }
                else
                {
                    Response.Redirect("LogIn.aspx");
                }
            }
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                Response.Redirect("ChatDetails.aspx?id=" + e.CommandArgument.ToString());
            }
        }
    }
}