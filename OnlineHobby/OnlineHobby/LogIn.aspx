<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="OnlineHobby.LogIn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style type="text/css">
        .gradient-custom {
            background: linear-gradient(to bottom right, #f08c75, #e85230)
        }

        .bg-image {
            background-image: url('Assets/background.png');
            background-size: cover;
        }

        .fgtPswd a {
            /*font-size: medium;*/
            color: grey;
            text-decoration: none;
        }

            .fgtPswd a:hover {
                text-decoration: underline;
            }

        /*.button {
             background: #ec6e51;
             border-color: transparent; 
             color: white;
        }*/

            /*.button:hover {
                background: blue;
            }*/
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
                            <%--left side--%>
                            <div class="col-xl-7">
                                <div class="card-body p-md-7 text-black">
                                    <h2 class="my-5 pt-5 text-center" style="color: #ec6e51; font-weight: bold">Log in to ReLife</h2>

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

                                    <div class="fgtPswd" style="text-align: center; padding-bottom: 2em">
                                        &nbsp;<a href="ForgotPassword.aspx">Forgot Your Password?</a>
                                    </div>

                                    <div class="d-flex justify-content-center mx-4 my-4 pb-5 mb-lg-4">
<%--                                        <asp:Button ID="btnLogin" runat="server" CssClass="button btn-lg rounded-pill" Text="LOG IN" type="submit" Style="height: 47px; width: 165px;" OnClick="btnLogin_Click" />--%>

                                        <asp:Button ID="btnLogin" runat="server" CssClass="button btn-lg rounded-pill" Text="LOG IN" type="submit" Style="height: 47px; width: 165px; background-color: #ec6e51; border-color: transparent; color: white" OnClick="btnLogin_Click" />
                                    </div>

                                </div>
                            </div>

                            <%--right side--%>
                            <div class="col-xl-5 gradient-custom text-center">
                                <div class="mt-5 pt-5"></div>

                                <div>
                                    <h2 class="my-4 py-4" style="color: white; font-weight: bold">Welcome Back!</h2>
                                    <p class="mt-2" style="color: white">Login with your personal info</p>
                                    <p class="mt-2" style="color: white">for a better experience now</p>
                                    <div class="d-flex justify-content-center mx-4 my-4 pt-4 mb-lg-4">
                                        <asp:Button ID="btnSignUp" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SIGN UP" type="submit" Style="height: 47px; width: 165px; background-color: transparent; color: white; border-color: white" OnClick="btnSignUp_Click" />
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
