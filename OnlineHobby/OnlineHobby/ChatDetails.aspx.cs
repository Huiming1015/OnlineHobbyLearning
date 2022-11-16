using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class ChatDetails : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        string receiverId;
        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Write("<script>alert('" + Request.QueryString["id"] + "') </script>");
            if (Session["UserEmail"] != null)
            {
                Int64 UserId = Convert.ToInt64(Session["UserId"]);
                string role = Session["Role"].ToString();

                con = new SqlConnection(strCon);
                con.Open();
                string cmd2 = "Select ChatDetails.messageDateTime,ChatDetails.senderId,ChatDetails.messageContents FROM ChatDetails WHERE ChatDetails.chatId = " + Request.QueryString["id"] + "ORDER BY ChatDetails.messageId";
                SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                Repeater1.DataSource = cmdSelect2.ExecuteReader();
                Repeater1.DataBind();
                con.Close();


                if (role == "stud")
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string cmd = "Select Chat.eduId,Chat.eduName,Educator.profileImg FROM Chat INNER JOIN Educator ON Chat.eduId = Educator.eduId WHERE Chat.chatId = " + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    SqlDataReader dr = cmdSelect.ExecuteReader();
                    while (dr.Read())
                    {
                        receiverId = dr.GetValue(0).ToString();
                        lblName.Text = dr.GetValue(1).ToString();
                        imgProfile.ImageUrl = dr.GetValue(2).ToString();
                    }
                    con.Close();


                }
                else
                {
                    con = new SqlConnection(strCon);
                    con.Open();
                    string cmd = "Select Chat.studId,Chat.studName,Student.profileImg FROM Chat INNER JOIN Student ON Chat.studId = Student.studId WHERE Chat.chatId = " + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    SqlDataReader dr = cmdSelect.ExecuteReader();
                    while (dr.Read())
                    {
                        receiverId = dr.GetValue(0).ToString();
                        lblName.Text = dr.GetValue(1).ToString();
                        imgProfile.ImageUrl = dr.GetValue(2).ToString();
                    }
                    con.Close();
                }
            }
            else
            {
                Response.Redirect("LogIn.aspx");

            }
        }

        protected void imgBtnBack_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("Chats.aspx");
        }

        protected void imgBtnSendMsg_Click(object sender, ImageClickEventArgs e)
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            if (txtMessage.Text != "")
            {
                DateTime date = DateTime.Now;
                AutoGenerateUserID();

                con.Open();
                string cmd = "Insert into ChatDetails(messageId, chatId, messageContents, messageDateTime, senderId) Values(@id, @chatId, @content, @date, @senderId)";
                SqlCommand cmdSelect = new SqlCommand(cmd, con);
                cmdSelect.Parameters.AddWithValue("@id", id);
                cmdSelect.Parameters.AddWithValue("@chatId", Request.QueryString["id"]);
                cmdSelect.Parameters.AddWithValue("@content", txtMessage.Text);
                cmdSelect.Parameters.AddWithValue("@date", date);
                cmdSelect.Parameters.AddWithValue("@senderId", UserId);
                cmdSelect.ExecuteNonQuery();
                con.Close();

                txtMessage.Text = "";
                Response.Redirect("ChatDetails.aspx?id=" + Request.QueryString["id"]);
            }
            else
            {
                txtMessage.BorderColor = System.Drawing.Color.DarkOrange;
                txtMessage.BorderWidth = 2;
            }
        }

        protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
            {
                var lblSender = (Label)e.Item.FindControl("lblSenderId");
                var divMsgBox = (HtmlContainerControl)e.Item.FindControl("divMsgBox");

                if (lblSender.Text == UserId.ToString())
                {
                    divMsgBox.Attributes.Add("style", "float:right");
                }
                else
                {
                    divMsgBox.Attributes.Add("style", "float:left");
                }

            }
        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(messageId),0) from ChatDetails", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();

        }
    }
}