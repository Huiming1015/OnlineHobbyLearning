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
    public partial class AddAddress : System.Web.UI.Page
    {
        SqlConnection con;
        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        Int64 id;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserEmail"] != null)
            {
                if (!IsPostBack)
                {
                    Int64 UserId = Convert.ToInt64(Session["UserId"]);
                    string role = Session["Role"].ToString();

                    con = new SqlConnection(strCon);

                    if (role == "edu")
                    {
                        Response.Redirect("Profile.aspx");
                    }
                }

            }
            else
            {
                Response.Redirect("LogIn.aspx");
            }
        }

        private void AutoGenerateUserID()
        {
            con = new SqlConnection(strCon);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select IsNull(max(addrId),0) from StudAddress", con);
            id = Convert.ToInt64(cmd.ExecuteScalar()) + 1;
            con.Close();

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
                    AutoGenerateUserID();

                    con.Open();
                    string cmd = "Insert into StudAddress(addrId, studId, name, phone, address) Values('" + id + "', '" + UserId + "', '" + txtAddrName.Text + "', '" + txtAddrPhone.Text + "', '" + txtAddrAddress.Text + "')";
                    SqlCommand cmdSelect = new SqlCommand(cmd, con);
                    cmdSelect.ExecuteNonQuery();
                    con.Close();


                    MsgSuccess.Visible = true;
                    clr();
                    //Response.Redirect("AddressBook.aspx");
                }

            }
            else
            {
                MsgRequired.Visible = true;
            }

        }

        private void clr()
        {
            txtAddrName.Text = "";
            txtAddrPhone.Text = "";
            txtAddrAddress.Text = "";
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