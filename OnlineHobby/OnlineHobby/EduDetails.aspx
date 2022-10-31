<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="EduDetails.aspx.cs" Inherits="OnlineHobby.EduDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

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

        .heart {
            color: #f00;
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

        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 800px;
            height: 580px;
        }

         .Popup2 {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 650px;
            height: 280px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
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
                        <asp:Label ID="lblFllwWord" runat="server" Text="Followers"></asp:Label>
                    </div>
                </div>

                <div class="row text-center mb-4">
                    <div class="col-md-6">
                        <button runat="server" id="btnFllw" onserverclick="functionFollow" class="btn btn-light btn-lg" style="font-size: small; height: 40px; width: 100px; ">
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
                                    <asp:LinkButton ID="lbtnEduAbout" runat="server" Font-Size="Large" ForeColor="DarkOrange" OnClick="lbtnEduAbout_Click">About</asp:LinkButton>
                                </li>
                                <asp:Label ID="Label2" runat="server" Text="|" Font-Size="Large"></asp:Label>
                                <li class="nav-item">
                                    <asp:LinkButton ID="lbtnEduDashboard" runat="server" Font-Size="Large" OnClick="lbtnEduDashboard_Click">Dashboard</asp:LinkButton>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="row ms-4 my-4">
                    <asp:Label ID="Label3" runat="server" Text="About Me" Font-Bold="True" Font-Size="X-Large"></asp:Label><br />
                    <asp:Label ID="lblAbout" runat="server" Text="hello. my name is ...."></asp:Label>
                </div>

                <div class="row ms-4 my-4">
                    <asp:Label ID="Label4" runat="server" Text="Teaching Courses" Font-Bold="True" Font-Size="X-Large"></asp:Label><br />
                    <asp:Label ID="lblTeaching" runat="server" Text=""></asp:Label>
                </div>

                <asp:Panel ID="Panel1" runat="server">
                    <div class="row ms-4 my-4">
                        <asp:Label ID="Label5" runat="server" Text="Achievements" Font-Bold="True" Font-Size="X-Large"></asp:Label>
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
                                                <asp:Label ID="lblTitle" runat="server" Font-Size="17px" Font-Bold="True"><%#Eval("title")%></asp:Label>
                                            </td>
                                            <td class="auto-style10"></td>

                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1"></td>
                                            <td dir="ltr" colspan="4" class="auto-style8">
                                                <asp:Label ID="Label6" runat="server" Font-Size="17px"><%#Eval("issueOrg")%></asp:Label>
                                            </td>
                                            <td class="auto-style10"></td>

                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1"></td>
                                            <td dir="ltr" colspan="4" class="auto-style8">
                                                <asp:Label ID="Label9" runat="server" Font-Size="17px">Issued on </asp:Label>
                                                <asp:Label ID="Label8" runat="server" Font-Size="17px"><%#Eval("issueMonth")%> </asp:Label>
                                                <asp:Label ID="lblissueYear" runat="server" Font-Size="17px"><%#Eval("issueYear")%></asp:Label>
                                            </td>
                                            <td class="auto-style10"></td>

                                        </tr>
                                        <tr>
                                            <td dir="rtl" class="auto-style1"></td>
                                            <td dir="ltr" colspan="4" class="auto-style8">
                                                <asp:Label ID="Label10" runat="server" Font-Size="17px">Credential URL: </asp:Label>
                                                <asp:Label ID="Label11" runat="server" Font-Size="17px"><%#Eval("credentialURL")%></asp:Label>
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

                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select Achievements.achievementId,Achievements.title,Achievements.issueOrg,Achievements.issueMonth,Achievements.issueYear,Achievements.credentialURL
FROM Achievements INNER JOIN Educator ON Achievements.eduId = Educator.eduId  WHERE Achievements.eduId=201"></asp:SqlDataSource>
                        </div>
                    </div>
                </asp:Panel>


                <div class="ms-4 my-4">
                    <asp:Label ID="Label7" runat="server"><span class="heart">&nbsp; ♥</span>&nbsp;Joined </asp:Label>
                    <asp:Label ID="lblJoined" runat="server" Text=""></asp:Label>
                </div>

                <asp:Panel ID="Panel3" runat="server">
                    <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
<%--                        only one instance of script manager can be put, so this one btn the below one--%>
                        <asp:Button ID="btnRate" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-5" Text="RATE" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white"  />
                        <cc1:ModalPopupExtender ID="mp2" runat="server" PopupControlID="Panl2" TargetControlID="btnRate"
                            CancelControlID="Button1" BackgroundCssClass="Background">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Panl2" runat="server" CssClass="Popup2" align="center" Style="display: none">
                           <asp:Panel ID="Panel6" runat="server" align="right" style="padding-right:10px" >
                               <asp:Button ID="Button1" runat="server" Text="X" Style=" background-color: #f98006;color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" />
                               </asp:Panel>
                            <iframe style="width: 550px; height: 230px;" id="Iframe1" src="EduRate.aspx" runat="server"></iframe>
                            <br />
                        </asp:Panel>

                        <%--popup window--%>
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <asp:Button ID="btnReport" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-5" Text="REPORT" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white"  />

                        <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="btnReport"
                            CancelControlID="Button2" BackgroundCssClass="Background">
                        </cc1:ModalPopupExtender>
                        <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                           <asp:Panel ID="Panel4" runat="server" align="right" style="padding-right:10px" >
                               <asp:Button ID="Button2" runat="server" Text="X" Style=" background-color: #f98006;color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" />
                               </asp:Panel>
                            <iframe style="width: 700px; height: 530px;" id="irm1" src="EduComplaint.aspx" runat="server"></iframe>
                            <br />
                            
                        </asp:Panel>
                    </div>
                </asp:Panel>



            </div>
        </div>

    </div>

</asp:Content>
