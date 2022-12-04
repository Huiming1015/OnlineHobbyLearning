<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreditCard.aspx.cs" Inherits="OnlineHobby.CreditCard" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/inputmask/inputmask.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.inputmask/3.3.4/inputmask/inputmask.extensions.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var inputmask = new Inputmask("9999-9999-9999-9999");
            inputmask.PromptChar = ' ';
            inputmask.mask($('[id*=txtCardNum]'));
            
        });
    </script>
    <div class="mt-4 mb-4 border" style="width: 90%; margin-left: 5%; min-height: 600px; font-size: 20px">
        <div class="container w-50 align-content-center ">
            <div class="row text-center d-flex aligns-items-center justify-content-center">
                <div class="col-12">
                    <h3 class="pt-3 pb-3" style="color: #011797; font-size: x-large; font-weight: bold; text-align: center; text-decoration: underline;">Credit Card Payment</h3>
                    <asp:Image ID="imgCreditCard" runat="server" ImageUrl="~/Resources/credit.png" Height="65%" Width="80%" />
                </div>
            </div>
        </div>
        <div class="container w-25 align-content-center">
            <div class="row">
                <div class="col-12">Card Holder Name</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <asp:TextBox ID="txtHolderName" runat="server" CssClass="form-control" placeholder="Jessie"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Card holder name should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtHolderName" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="*Name can only contains letter!" ControlToValidate="txtHolderName" Font-Size="Small" ForeColor="Red" ValidationExpression="^[a-zA-Z][a-zA-Z ]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-12">Card Number</div>
            </div>
            <div class="row">
                <div class="col-12">
                    <asp:TextBox ID="txtCardNum" runat="server" CssClass="form-control" placeholder="4123-4123-4123-4123"></asp:TextBox>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Card number should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtCardNum" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Only new Visa and MasterCard are allowed!" ControlToValidate="txtCardNum" Font-Size="Small" ForeColor="Red" ValidationExpression="^4[0-9]{3}(?:-[0-9]{4}){3}|5[0-9]{3}(?:-[0-9]{4}){3}$" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-md-5">
                    Expiry Date
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-6">
                    Security Code
                </div>
            </div>
            <div class="row">
                <div class="col-md-5">
                    <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control" placeholder="MM/YY"></asp:TextBox>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-6">
                    <asp:TextBox ID="txtSecurityCode" runat="server" CssClass="form-control" TextMode="Password" placeholder="123"></asp:TextBox>
                </div>
            </div>
            <div class="row">
                <div class="col-md-5">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Expiry date should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtExpiry" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Expiry date should be MM/YY which not expired!" ControlToValidate="txtExpiry" Font-Size="Small" ForeColor="Red" ValidationExpression="^(0[1-9]|1[0-2])\/?(2[4-9])$" Display="Dynamic"></asp:RegularExpressionValidator>

                </div>
                <div class="col-md-1"></div>
                <div class="col-md-6">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*Security code should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtSecurityCode" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="*Security code can only contains 3/4 digit!" ControlToValidate="txtSecurityCode" Font-Size="Small" ForeColor="Red" ValidationExpression="^[0-9]{3,4}$" Display="Dynamic"></asp:RegularExpressionValidator>
                </div>
            </div>
        </div>
        <div class="container w-100 mt-5 mb-5 align-content-center ">
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-5">
                    Total Amount: RM
                    <asp:Label ID="lblTotalPrice" runat="server" Text="0.00"></asp:Label>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-5 text-end">
                    <asp:Button ID="btnPay" runat="server" Text="PAY" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 200px; background-color: #f98006; color: white" OnClick="btnPay_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
