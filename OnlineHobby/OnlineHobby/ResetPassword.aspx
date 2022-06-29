<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="OnlineHobby.ResetPassword" %>

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
                    <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSuccess" visible="false">
                        <strong>Password reset.</strong> Please log in to continue.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
                        Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgError" visible="false">
                        Password reset link is expired or invalid.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgErrorPswd" visible="false">
                        Password must contains min 8 characters, at least 1 uppercase, 1 lowercase, 1 digit.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgErrorConfirmPswd" visible="false">
                        New password and confirm password does not matched.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="card card-registration my-4">
                        <div class="row g-0">

                            <div class="text-center">
                                <h2 class="mt-5 pt-5 mb-3 pb-3" style="color: #ec6e51; font-weight: bold">Reset Your Password</h2>
                            </div>
                            <%--pswd--%>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-6">
                                    <div class="input-group mt-4">
                                        <div class="form-floating flex-grow-1">
                                            <asp:TextBox ID="txtNewRPassword" TextMode="Password" CssClass="form-control" placeholder="Password" runat="server" AutoPostBack="True"></asp:TextBox>
                                            <label for="txtNewRPassword">New Password</label>
                                        </div>
                                        <asp:ImageButton ID="ImageButton1" runat="server" Height="58px" ImageUrl="Resources/passwordShow.png" Width="45px" ImageAlign="AbsMiddle" OnClick="ImageButton1_Click1" />
                                    </div>
                                    <asp:Label ID="Label1" runat="server" Text="Password must contains min 8 characters, at least 1 uppercase, 1 lowercase, 1 digit." Font-Size="Smaller" ForeColor="Gray"></asp:Label>

                                </div>
                                <div class="col-md-3"></div>
                            </div>
                            <%--confirm pswd--%>
                            <div class="row">
                                <div class="col-md-3"></div>
                                <div class="col-md-6">
                                    <div class="input-group my-4">
                                        <div class="form-floating flex-grow-1">
                                            <asp:TextBox ID="txtConfirmRPassword" TextMode="Password" CssClass="form-control" placeholder="Password" runat="server" AutoPostBack="True"></asp:TextBox>
                                            <label for="txtConfirmRPassword">Confirm New Password</label>
                                        </div>
                                        <asp:ImageButton ID="ImageButton2" runat="server" Height="58px" ImageUrl="Resources/passwordShow.png" Width="45px" ImageAlign="AbsMiddle" OnClick="ImageButton2_Click" />
                                    </div>
                                </div>
                                <div class="col-md-3"></div>
                            </div>

                            <div class="d-flex justify-content-center mt-3 pt-3 mb-5 pb-5 mb-lg-4">
                                <asp:Button ID="btnReset" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-3" Text="RESET" type="submit" Style="height: 47px; width: 165px; background-color: #ec6e51; color: white" OnClick="btnReset_Click" />
                                <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-3" Text="GO TO LOGIN" type="submit" Style="height: 47px; width: 165px; background-color: #ec6e51; color: white" Enabled="False" OnClick="btnLogin_Click" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
