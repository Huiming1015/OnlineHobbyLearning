<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminLogIn.aspx.cs" Inherits="OnlineHobby.LogInAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        /*.btn-primary, .btn-primary:hover, .btn-primary:active, .btn-primary:visited {
            background-color: rgb(242, 242, 242) !important;
            border-color: lightgrey !important;
        }*/

        .bg-image {
            background-color: #fffefa;
        }

    </style>
    <section class="h-70 bg-image">
        <div class="container py-5 h-70">
            <div class="row d-flex justify-content-center align-items-center h-70">
                <div class="col">
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
                        Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgError" visible="false">
                        Incorrect email or password. Please try again.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>

                    <div class="card card-registration my-4">
                        <div class="row g-0">
                            <%--right side--%>
                            <div class="col-xl-5 d-none d-xl-block">
                                <img src="Resources/loginAdmin.png"
                                    alt="Login logo" class="img-fluid"
                                    style="border-top-left-radius: .25rem; border-bottom-left-radius: .25rem;" />
                            </div>
                            <%--right side--%>
                            <div class="col-xl-7">
                                <div class="card-body p-md-7 text-black">
                                    <h2 class="my-5 pt-5 text-center" style="color: darkorange; font-weight: bold">Admin Log in</h2>

                                    <%--email--%>
                                    <div class="row">
                                        <div class="col-md-2"></div>
                                        <div class="col-md-8">
                                            <div class="form-floating my-3">
                                                <asp:TextBox ID="txtLoginEmail" type="text" CssClass="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                <label for="txtLoginEmail">Email Address</label>
                                            </div>
                                        </div>
                                        <div class="col-md-2"></div>
                                    </div>
                                    <%--pswd--%>
                                    <div class="row">
                                        <div class="col-md-2"></div>
                                        <div class="col-md-8">
                                            <div class="input-group my-3">
                                                <div class="form-floating flex-grow-1">
                                                    <asp:TextBox ID="txtLoginPassword" TextMode="Password" CssClass="form-control" placeholder="Password" runat="server" AutoPostBack="True"></asp:TextBox>
                                                    <label for="txtLoginPassword">Password</label>
                                                </div>
                                                <asp:ImageButton ID="ImageButton1" runat="server" Height="58px" ImageUrl="Resources/passwordShow.png" Width="45px" ImageAlign="AbsMiddle" OnClick="ImageButton1_Click" />

                                            </div>
                                        </div>
                                        <div class="col-md-2"></div>
                                    </div>

                                    <div class="d-flex justify-content-center mx-4 my-4 pb-5 pt-4 mb-lg-4">
                                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="LOG IN" type="submit" Style="height: 47px; width: 165px; background-color: darkorange; color: white" OnClick="btnLogin_Click"  />
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
