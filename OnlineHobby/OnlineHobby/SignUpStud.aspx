<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="SignUpStud.aspx.cs" Inherits="OnlineHobby.SignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .gradient-custom {
            background: linear-gradient(to bottom right, #f08c75, #e85230)
        }

        .bg-image {
            background-image: url('Assets/background.png');
            /*height: 100%;
            background-position: center;
            background-repeat: no-repeat;*/
            background-size: cover;
        }
    </style>
    <section class="h-70 bg-image">
        <div class="container py-5 h-70">
            <div class="row d-flex justify-content-center align-items-center h-70">
                <div class="col">
                    <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSignUpSuccess" visible="false">
                        <strong>Sign up successful.</strong> Please log in to continue.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgSignUpFail" visible="false">
                        <strong>Oops!</strong> Email has been registered. Please try again.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
                        Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgError" visible="false">
                        Error:
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>

                    <div class="card card-registration my-4">
                        <div class="row g-0">
                            <%--left side--%>
                            <div class="col-xl-5 gradient-custom text-center">
                                <div class="mt-5 pt-5"></div>

                                <div>
                                    <h2 class="my-4 py-4" style="color: white; font-weight: bold">Hello, Buddy!</h2>
                                    <p class="mt-2" style="color: white">Enter your personal details </p>
                                    <p class="mt-2" style="color: white">and start the journey with us</p>
                                    <div class="d-flex justify-content-center mx-4 my-4 pt-4 mb-lg-4">
                                        <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="LOG IN" type="submit" Style="height: 47px; width: 165px; background-color: transparent; color: white; border-color: white" OnClick="btnLogin_Click" />
                                    </div>
                                </div>

                            </div>
                            <%--right side--%>
                            <div class="col-xl-7">
                                <div class="card-body p-md-7 text-black">
                                    <h2 class="my-4 text-center" style="color: #ec6e51; font-weight: bold">Create Account</h2>

                                    <%--name--%>
                                    <div class="row">
                                        <div class="col-md-2"></div>
                                        <div class="col-md-8">
                                            <div class="form-floating my-3">
                                                <asp:TextBox ID="txtSUName" type="text" CssClass="form-control" placeholder="Name" runat="server"></asp:TextBox>
                                                <label for="txtSUName">Name</label>
<%--                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Please include letters only." ControlToValidate="txtSUName" Font-Size="X-Small" ForeColor="Red" ValidationExpression="[a-zA-Z][a-zA-Z ]*">*Please include letters only.</asp:RegularExpressionValidator>--%>
                                                <%-- <asp:Label ID="Label2" runat="server" Text="*Password must between 8-16 character, contain at least 1 digit, 1 uppercase, 1 lowercase and 1 special character." Font-Size="Small" ForeColor="#6C757D"></asp:Label>--%>
                                            </div>
                                        </div>
                                        <div class="col-md-2"></div>
                                    </div>
                                    <%--email--%>
                                    <div class="row">
                                        <div class="col-md-2"></div>
                                        <div class="col-md-8">
                                            <div class="form-floating my-3">
                                                <asp:TextBox ID="txtSUEmail" type="text" CssClass="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                                <label for="txtSUEmail">Email Address</label>
<%--                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Please enter a valid email address." ControlToValidate="txtSUEmail" Font-Size="X-Small" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*Please enter a valid email address.</asp:RegularExpressionValidator>--%>
                                            </div>
                                        </div>
                                        <div class="col-md-2"></div>
                                    </div>
                                    <%--pswd--%>
                                    <div class="row">
                                        <div class="col-md-2"></div>
                                        <div class="col-md-8">
                                            <div class="input-group mt-3">
                                                <div class="form-floating flex-grow-1">
                                                    <asp:TextBox ID="txtSUPassword" TextMode="Password" CssClass="form-control" placeholder="Password" runat="server" AutoPostBack="True"></asp:TextBox>
                                                    <label for="txtSUPassword">Password</label>
                                                </div>
                                                <asp:ImageButton ID="ImageButton1" runat="server" Height="58px" ImageUrl="Resources/passwordShow.png" Width="45px" ImageAlign="AbsMiddle" OnClick="ImageButton1_Click" />

                                            </div>
                                            <asp:Label ID="Label1" runat="server" Text="Password must contains min 8 characters, at least 1 uppercase, 1 lowercase, 1 digit." Font-Size="Smaller" ForeColor="Gray" ></asp:Label>
                                        </div>
                                        <div class="col-md-2"></div>
                                    </div>
                                    <%--confirm pswd--%>
                                    <div class="row">
                                        <div class="col-md-2"></div>
                                        <div class="col-md-8">
                                            <div class="input-group mt-4 mb-3">
                                                <div class="form-floating flex-grow-1">
                                                    <asp:TextBox ID="txtSUConfirmPassword" TextMode="Password" CssClass="form-control" placeholder="Confirm Password" runat="server" AutoPostBack="True"></asp:TextBox>
                                                    <label for="txtSUConfirmPassword">Confirm Password</label>
                                                </div>
                                                <asp:ImageButton ID="ImageButton2" runat="server" Height="58px" ImageUrl="Resources/passwordShow.png" Width="45px" ImageAlign="AbsMiddle" OnClick="ImageButton2_Click" />

                                            </div>
                                        </div>
                                        <div class="col-md-2"></div>
                                    </div>

                                    <div class="d-flex justify-content-center mx-4 my-4 mb-lg-4">
                                        <asp:Button ID="btnSignUp" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SIGN UP" type="submit" Style="height: 47px; width: 165px; background-color: #ec6e51; color: white" OnClick="btnSignUp_Click" />
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
