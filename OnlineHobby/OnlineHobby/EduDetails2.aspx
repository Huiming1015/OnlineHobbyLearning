<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="EduDetails2.aspx.cs" Inherits="OnlineHobby.EduDetails2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .bg {
            background-color: #fffefa;
        }

        .navbar-edu .navbar-nav > li > a {
            color: black;
            text-decoration: none;
        }

            .navbar-edu .navbar-nav > li > a:hover {
                color: dimgrey;
            }

        .auto-style1 {
            width: 50px;
        }

        .auto-style8 {
            width: 900px;
        }

        .auto-style10 {
            width: 50px;
        }
    </style>

    <div class="container-fluid bg">
        <div class="row">
            <div class="col-md-2" style="border-right: 1px solid lightgray">
                <div class="text-center mt-4">
                    <asp:Image ID="imgProfile" runat="server" CssClass="rounded-circle img-fluid" Height="150" Width="150" ImageUrl="~/Resources/profile_orange.png" />
                </div>
                <div class="text-center mt-3 mb-1">
                    <asp:Label ID="lblName" runat="server" Text="Name"></asp:Label>
                </div>
                <div class="text-center mb-3">
                    <asp:Label ID="Label1" runat="server" Text="EDUCATOR" BorderColor="#FF6600" BackColor="#FFCC99" CssClass="rounded" BorderStyle="Solid" BorderWidth="1px" Width="90px" Font-Size="Small"></asp:Label>
                </div>
                <div class=" row text-center">
                    <div class="col-md-6">
                        <asp:Label ID="lblRate" runat="server" Text="--" ForeColor="#F98006" Font-Bold="True"></asp:Label>
                    </div>
                    <div class="col-md-6">
                        <asp:Label ID="lblFllw" runat="server" Text="--" ForeColor="#F98006" Font-Bold="True"></asp:Label>
                    </div>
                </div>
                <div class="row text-center mb-4">
                    <div class="col-md-6">
                        <asp:Label ID="lblRateWord" runat="server" Text="Ratings"></asp:Label>
                    </div>
                    <div class="col-md-6">
                        <asp:Label ID="lblFllwWord" runat="server" Text="Following"></asp:Label>
                    </div>
                </div>

                <div class="row text-center mb-4">
                    <div class="col-md-6">
                        <%--                        <asp:Button ID="btnFollow" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="Follow" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnFollow_Click" />--%>
                        <button runat="server" id="btnFllw" onserverclick="functionFollow" class="btn btn-light btn-lg" style="font-size: small; height: 40px; width: 100px;">
                            <i class="fa fa-plus"></i>&nbsp;Follow
                        </button>
                    </div>
                    <div class="col-md-6">
                        <button runat="server" id="btnMsg" onserverclick="functionMessage" class="btn btn-light btn-lg" style="font-size: small; height: 40px;">
                            <i class="fa fa-envelope"></i>&nbsp;Message
                        </button>
                    </div>

                </div>

                <asp:Panel ID="Panel2" runat="server">
                    <div class="mt-5 mb-5 pb-5 pt-5"></div>
                    <div class="mt-5 mb-5 pb-3 pt-3"></div>
                </asp:Panel>

            </div>

            <div class="col-md-10">
                <nav class="navbar navbar-expand-lg navbar-edu my-3">
                    <div class="container-fluid">
                        <button class="navbar-toggler"
                            type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#navbarNav"
                            aria-controls="navbarNav"
                            aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                <li class="nav-item">
                                    <asp:LinkButton ID="lbtnEduAbout" runat="server" Font-Size="Large" OnClick="lbtnEduAbout_Click" >About</asp:LinkButton>
                                </li>
                                <asp:Label ID="Label2" runat="server" Text="|" Font-Size="Large"></asp:Label>
                                <li class="nav-item">
                                    <asp:LinkButton ID="lbtnEduDashboard" runat="server" Font-Size="Large" ForeColor="DarkOrange" OnClick="lbtnEduDashboard_Click">Dashboard</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="alert alert-primary alert-dismissible fade show" runat="server" id="MsgNotice" visible="false">
                    <h4 class="alert-heading">Info</h4>
                    This educator has not added any posts yet.
                </div>

                <asp:Panel ID="Panel1" runat="server">
                    <div class="row ms-4 my-4">
                        <asp:Label ID="Label5" runat="server" Text="Dashboard" Font-Bold="True" Font-Size="X-Large"></asp:Label>
                        <div style="padding-left: 15px; padding-top: 10px">
                            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1">
                                <ItemTemplate>
                                    <table style="background-color: rgba(0, 0, 0, 0.03); border-radius: 15px">
                                        <tr>
                                            <td dir="rtl" class="auto-style1" style="height: 15px"></td>
                                            <td dir="rtl" class="auto-style4"></td>
                                            <td class="auto-style4"></td>
                                            <td class="auto-style4"></td>
                                            <td class="auto-style2"></td>
                                            <td class="auto-style3" rowspan="6"></td>
                                            <td dir="rtl" class="auto-style10"></td>
                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1"></td>
                                            <td dir="ltr" colspan="4" class="auto-style8">
                                                <asp:Label ID="Label3" runat="server" Font-Size="Smaller" ForeColor="Gray">Posted on </asp:Label>
                                                <asp:Label ID="lblDateTime" runat="server" Font-Size="Smaller" ForeColor="Gray"><%#Eval("postDateTime").ToString()%></asp:Label>
                                            </td>
                                            <td class="auto-style10"></td>

                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1"></td>
                                            <td dir="ltr" colspan="4" class="auto-style8"></td>
                                            <td class="auto-style10"></td>

                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1"></td>
                                            <td dir="ltr" colspan="4" class="auto-style8">
                                                <asp:Label ID="lblDesc" runat="server" Font-Size="17px"><%#Eval("postContents")%></asp:Label>
                                            </td>
                                            <td class="auto-style10"></td>

                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1"></td>
                                            <td dir="ltr" colspan="4" class="auto-style8">
                                                <asp:Image ID="imgPostImage" runat="server" Height="179px" Width="178px" ImageUrl='<%#Eval("postImg")%>' />
                                            </td>
                                            <td class="auto-style10"></td>

                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1" style="height: 15px"></td>
                                            <td dir="rtl" class="auto-style4"></td>
                                            <td class="auto-style4"></td>
                                            <td class="auto-style4"></td>
                                            <td class="auto-style2"></td>
                                            <td dir="rtl" class="auto-style10"></td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:Repeater>

                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select Posts.postId,Posts.postDateTime, Posts.postContents, Posts.postImg
FROM Posts INNER JOIN Educator ON Posts.eduId = Educator.eduId  WHERE Posts.eduId=201 ORDER BY Posts.postDateTime DESC">
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </asp:Panel>

            </div>
        </div>

    </div>
</asp:Content>
