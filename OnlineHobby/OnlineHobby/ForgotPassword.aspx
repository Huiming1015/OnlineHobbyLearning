<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="OnlineHobby.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .bg-image {
            background-image: url('Assets/background.png');
            background-size: cover;
        }
    </style>
    <section class="h-70 bg-image">
        <div class="container py-5 h-70">
            <div class="row d-flex justify-content-center align-items-center h-70">
                <div class="col">
                    <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSend" visible="false">
                       Reset password link has been sent. Please check your inbox.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgError" visible="false">
                        <strong>Opps!</strong> Your email entered does not exist. Please try again.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="card card-registration my-4">
                        <div class="row g-0">

                            <div class="text-center">
                                <h2 class="mt-5 pt-5 mb-3 pb-3" style="color: #ec6e51; font-weight: bold">Find Your Account</h2>
                                <p class="my-3 pb-3">Please enter your email address to search for your account.</p>
                            </div>


                            <%--email--%>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-6">
                                    <div class="form-floating my-3">
                                        <asp:TextBox ID="txtFPEmail" type="text" CssClass="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                        <label for="txtFPEmail">Email Address</label>
                                    </div>
                                </div>
                                <div class="col-md-3"></div>
                            </div>

                            <div class="d-flex justify-content-center mt-3 pt-3 mb-5 pb-5 mb-lg-4">
                                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SUBMIT" type="submit" Style="height: 47px; width: 165px; background-color: #ec6e51; color: white" OnClick="btnReset_Click" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
