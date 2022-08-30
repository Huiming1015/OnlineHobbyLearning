<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="SignUpEducator.aspx.cs" Inherits="OnlineHobby.SignUpEducator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style type="text/css">
        .div-image {
            background-image: url('Assets/eduBackground.png');
            background-repeat: no-repeat;
            background-size: cover;
            height: 330px;
        }

        .icon-background {
            color: #e6fff0;
        }

        .div-background {
            background-color: #fffefa;
        }
    </style>
    <div class="alert alert-success alert-dismissible fade show m-0" runat="server" id="MsgSuccess" visible="false">
        <strong>Application submitted.</strong> Please allow 3-4 working days to process your application.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <div class="alert alert-danger alert-dismissible fade show m-0" runat="server" id="MsgRequired" visible="false">
        Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <div class="alert alert-danger alert-dismissible fade show m-0" runat="server" id="MsgSignUpFail" visible="false">
        <strong>Opps!</strong> The application of the email has been received and is in processing. Please try again.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <div class="container-fluid div-background">

        <div class="row div-image text-center">
            <div class="mt-2 pt-3"></div>
            <div>
                <h1 style="color: white; font-weight: bold; font-size: 50px">Teach what you love.</h1>
                <h3 class="pt-3" style="color: white; font-weight: bold; font-size: 25px">Share your knowledge and passion with people around the world.</h3>
            </div>
        </div>
        <div class="row my-4 py-4 mx-3">
            <div class="col-md-4 px-5">
                <div class="row">
                    <span class="fa-stack fa-2x">
                        <i class="fa fa-circle fa-stack-2x icon-background"></i>
                        <i class="fa fa-dollar-sign fa-stack-1x" style="color: green"></i>
                    </span>
                </div>
                <div class="row mt-2">
                    <h3 style="color: #009973">Earn money</h3>
                </div>
                <div class="row">
                    <p>We have a large and growing audience, and powerful website features to help you easily secure more orders. You can create a course and generate an income stream with your creative expertise.</p>
                </div>
            </div>
            <div class="col-md-4 px-5">
                <div class="row">
                    <span class="fa-stack fa-2x">
                        <i class="fa fa-circle fa-stack-2x icon-background"></i>
                        <i class="fa fa-users fa-stack-1x" style="color: green"></i>
                    </span>
                </div>
                <div class="row mt-2">
                    <h3 style="color: #009973">Build your community</h3>
                </div>
                <div class="row">
                    <p>ReLife is a community with millions of creative people who are keen to learn. You can inspire and get inspired alongisde other creatives.</p>
                </div>
            </div>
            <div class="col-md-4 px-5">
                <div class="row">
                    <span class="fa-stack fa-2x">
                        <i class="fa fa-circle fa-stack-2x icon-background"></i>
                        <i class="fa fa-clock fa-stack-1x" style="color: green"></i>
                    </span>
                </div>
                <div class="row mt-2">
                    <h3 style="color: #009973">Save time</h3>
                </div>
                <div class="row ">
                    <p>Spend more time on what you love, and less on bookings admin. From automated transactional to reminder emails, and everything in between, we'll handle the entire customer journey.</p>
                </div>
            </div>
        </div>

        <div class="row mt-3" style="background-color: #e6fff0;">
            <div class="text-center">
                <h2 class="mt-3 pt-3 mb-3 pb-3" style="color: #009973; font-weight: bold">- Become An Educator -</h2>
            </div>

            <div class="row ">
                <div class="col-md-1"></div>
                <div class="col-md-10 mt-2">
                    <h3 class="mb-0" style="color: #009973; font-weight: bold">Personal Information</h3>
                    <div class="row">
                        <asp:Label ID="Label1" runat="server" Text="For us to contact you!" Font-Size="Medium" ForeColor="Gray"></asp:Label>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
            <%--name--%>
            <div class="row  ml-4">
                <div class="col-md-1"></div>
                <div class="col-md-10 mt-2">
                    <div class="row my-1">
                        <asp:Label ID="Label3" runat="server" Text="Name"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:TextBox ID="txtSUName" type="text" CssClass="form-control" placeholder="YourName" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Please include letters only." ControlToValidate="txtSUName" Font-Size="Small" ForeColor="Red" ValidationExpression="[a-zA-Z][a-zA-Z ]*">*Please include letters only.</asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
            <%--email--%>
            <div class="row  ml-4">
                <div class="col-md-1"></div>
                <div class="col-md-10 mt-2">
                    <div class="row my-1">
                        <asp:Label ID="Label4" runat="server" Text="Email Address"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:TextBox ID="txtSUEmail" type="text" CssClass="form-control" placeholder="example@gmail.com" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Please enter a valid email address." ControlToValidate="txtSUEmail" Font-Size="Small" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*Please enter a valid email address.</asp:RegularExpressionValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
            <div class="row mb-3" style="color: darkgray">
                ____________________________________________________________________________________________________________________________________________________________________________________________________________________________________
            </div>

            <div class="row ">
                <div class="col-md-1"></div>
                <div class="col-md-10 mt-2">
                    <h3 class="mb-0" style="color: #009973; font-weight: bold">Qualification Information</h3>
                    <div class="row">
                        <asp:Label ID="Label2" runat="server" Text="Let us know more about your work!" Font-Size="Medium" ForeColor="Gray"></asp:Label>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>

            <%--course category--%>
            <div class="row  ml-4">
                <div class="col-md-1"></div>
                <div class="col-md-10 mt-2">
                    <div class="row my-1">
                        <asp:Label ID="Label5" runat="server" Text="Course Category"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:DropDownList ID="ddlSUCourse" runat="server" CssClass="form-control">
                                    <asp:ListItem>Painting</asp:ListItem>
                                    <asp:ListItem>Craft</asp:ListItem>
                                    <asp:ListItem>Photography &amp; Video</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>

            <%--teaching experience--%>
            <div class="row  mxl4">
                <div class="col-md-1"></div>
                <div class="col-md-10 mt-3">
                    <div class="row my-1">
                        <asp:Label ID="Label6" runat="server" Text="Teaching Experience"></asp:Label>
                    </div>
                    <div class="row mx-2">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:RadioButtonList ID="rblSUExperience" runat="server">
                                    <asp:ListItem>Yes</asp:ListItem>
                                    <asp:ListItem>No</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
            <%--Educator portfolio, quali.. --%>
            <div class="row  ml-4">
                <div class="col-md-1"></div>
                <div class="col-md-10 mt-3">
                    <div class="row my-1">
                        <asp:Label ID="Label7" runat="server" Text="Educator Qualification, Portfolio and Videos"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:TextBox ID="txtSUQualification" type="text" CssClass="form-control" placeholder="https://drive.google.com/drive/folders/1GSIlsPtd2irlr6mzxNwI3uei__b__QF3?usp=sharing" runat="server"></asp:TextBox>
                                <asp:Label ID="Label8" runat="server" Text="(share the Google Drive link of your work)" Font-Size="Smaller" ForeColor="Gray"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>

                <div class="d-flex justify-content-center mt-3 pt-1 mb-3 pb-1 mb-lg-4">
                    <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SUBMIT" type="submit" Style="height: 47px; width: 165px; background-color: #009973; color: white" OnClick="btnSubmit_Click" />
                </div>
            </div>

        </div>
        <%--<div class="row mb-4">
            <asp:Label ID="Label9" runat="server" Text="* Please allow 3-4 working days to process your application." Font-Size="Small" Style="font-style: italic"></asp:Label>
        </div>--%>
    </div>
</asp:Content>
