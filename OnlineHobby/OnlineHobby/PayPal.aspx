<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PayPal.aspx.cs" Inherits="OnlineHobby.PayPal" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="mt-4 mb-4 border" style="width: 90%; margin-left: 5%; min-height: 600px; font-size: 20px">
        <div class="container w-50 align-content-center ">
            <div class="row text-center d-flex aligns-items-center justify-content-center">
                <div class="col-12">
                    <h3 class="pt-3 pb-3" style="color: #011797; font-size: x-large; font-weight: bold; text-align: center; text-decoration: underline;">PayPal Payment</h3>
                    <asp:Image ID="imgPaypal" runat="server" ImageUrl="~/Resources/paypal (2).png" Height="75%" Width="60%" />
                </div>
            </div>
        </div>
        <div class="container w-25 align-content-center">
            <div class="row">
                <div class="col-12">Email</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="jessie@gmail.com"></asp:TextBox>
                </div>
            </div>
             <div class="row">
                <div class="col-12">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Email should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtEmail" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Invalid email!" ControlToValidate="txtEmail" Font-Size="Small" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-12">Password</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="ab1234"></asp:TextBox>
                </div>
            </div>
             <div class="row">
                <div class="col-12">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Password should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtPassword" ForeColor="Red"></asp:RequiredFieldValidator>               
                </div>
            </div>
        </div>
        <div class="container w-100 mb-5" style="margin-top:10%">
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-5">Total Amount: RM
                    <asp:Label ID="lblTotalPrice" runat="server" Text="0.00"></asp:Label></div>
                <div class="col-md-1"></div>
                <div class="col-md-5 text-end">
                    <asp:Button ID="btnPay" runat="server" Text="PAY" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 200px; background-color: #f98006; color: white" OnClick="btnPay_Click" /></div>
            </div>
        </div>
    </div>
</asp:Content>
