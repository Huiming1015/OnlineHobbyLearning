using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OnlineHobby
{
    public partial class EditAddress : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int addrId;

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserEmail"] != null)
            {
                if (!IsPostBack)
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);

                    con = new SqlConnection(strCon);
                    
                        con.Open();
                        string cmd2 = "Select name,phone,address from AddressBook where studId =" + UserId + "and addrId =" + Request.QueryString["id"]; //where addrId is ??
                        SqlCommand cmdSelect2 = new SqlCommand(cmd2, con);
                        SqlDataReader dr = cmdSelect2.ExecuteReader();
                        while (dr.Read())
                        {
                            txtAddrName.Text = dr.GetValue(0).ToString();
                            txtAddrPhone.Text = dr.GetValue(1).ToString();
                            txtAddrAddress.Text = dr.GetValue(2).ToString();
                        }
                }
            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            MsgRequired.Visible = false;
            MsgSuccess.Visible = false;
            MsgError.Visible = false;

            MsgError.InnerHtml = " ";
            int error = 0;

            Int64 UserId = Convert.ToInt64(Session["UserId"]);
            con = new SqlConnection(strCon);

            if (txtAddrName.Text != "" && txtAddrPhone.Text != "" && txtAddrAddress.Text != "")
            {
                if (!validateName(txtAddrName.Text))
                {
                    error += 1;
                    if (MsgError.InnerHtml == " ")
                    {
                        MsgError.InnerHtml = "Name should include letters only.";
                    }
                    else
                    {
                        MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Name should include letters only.";
                    }
                }

                if (!validatePhone(txtAddrPhone.Text))
                {
                    error += 1;
                    if (MsgError.InnerHtml == " ")
                    {
                        MsgError.InnerHtml = "Please enter a valid phone number.";
                    }
                    else
                    {
                        MsgError.InnerHtml = MsgError.InnerHtml + "</br>" + "Please enter a valid phone number.";
                    }
                }

                if (error != 0)
                {
                    MsgError.Visible = true;
                }
                else
                {
                    con.Open();
                    string cmd = "Update AddressBook set name=@Name,phone=@phone,address=@address where studId =" + UserId + "and addrId =" + Request.QueryString["id"];
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.Parameters.AddWithValue("@Name", txtAddrName.Text);
                    cmdSelect.Parameters.AddWithValue("@phone", txtAddrPhone.Text);
                    cmdSelect.Parameters.AddWithValue("@address", txtAddrAddress.Text);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();


                    MsgSuccess.Visible = true;
                }

            }
            else
            {
                MsgRequired.Visible = true;
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Int64 UserId = Convert.ToInt64(Session["UserId"]);

            con = new SqlConnection(strCon);
            con.Open();
            string cmd = "Delete from AddressBook  where studId =" + UserId + "and addrId =" + Request.QueryString["id"];
            SqlCommand cmdSelect = new SqlCommand(cmd, con);
            cmdSelect.ExecuteNonQuery();
            con.Close();

            Response.Redirect("AddressBook.aspx");
        }

        private Boolean validateName(string name)
        {
            Regex regex = new Regex("^[a-zA-Z][a-zA-Z ]*$");
            Match match = regex.Match(name);
            if (match.Success)
                return true;
            else
                return false;
        }

        private Boolean validatePhone(string phone)
        {
            Regex regex = new Regex("^(\\+?6?01)[02-46-9]-*[0-9]{7}$|^(\\+?6?01)[1]-*[0-9]{8}$");
            Match match = regex.Match(phone);
            if (match.Success)
                return true;
            else
                return false;

            //60 1112345678 (number start with 11 have 10 digit)
            //60 121234567 (number that not start with 11 have 9 digit)
            //60 151234567 (number start with 15 will is not a valid phone number, it is for Digi broadband user if not mistaken)
        }
    }
}