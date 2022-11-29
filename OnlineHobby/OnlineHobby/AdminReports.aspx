<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminReports.aspx.cs" Inherits="OnlineHobby.AdminReports" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.4000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .bg {
            background-color: #fffefa;
        }

        .auto-style1 {
            width: 30px;
            height: 32px;
        }

        .auto-style2 {
            width: 130px;
        }

        .auto-style6 {
            width: 600px;
        }
    </style>

    <div class="container-fluid bg">
        <div class="alert alert-primary alert-dismissible fade show mt-2" runat="server" id="MsgNotice" visible="false">
            No record found.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>

        <div class="text-center">
            <h2 class="pt-5 mb-3 pb-3" style="color: #f98006; font-weight: bold; font-size: xx-large">Reports</h2>
        </div>
        <div class="text-center">
            <h5 class="pb-3" style="text-decoration: underline">Daily Basis</h5>
        </div>

        <%--Top 5 Most-Follwed Edu--%>
        <div style="padding-left: 300px">
            <table style="background-color: rgba(0, 0, 0, 0.03)">
                <tr>
                    <td dir="rtl" class="auto-style1"></td>
                    <td dir="rtl" class="auto-style4"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style2"></td>
                    <td class="auto-style3" rowspan="4">
                        <asp:Button ID="btnTopFollower" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="VIEW" Style="height: 40px; width: 110px; background-color: #f98006; color: white" Font-Size="Medium" OnClick="btnTopFollwer_Click" />
                        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
                    </td>

                    <td dir="rtl" class="auto-style1"></td>
                </tr>
                <tr>
                    <td dir="rtl" class="auto-style1">&nbsp;</td>
                    <td dir="ltr" colspan="3" class="auto-style6">
                        <asp:Label ID="lblReportFllw" runat="server" Font-Size="17px" Text="Top 5 Most-Followed Educators on "></asp:Label>
                        <asp:Label ID="lblReportFllwDate" runat="server" Font-Size="17px"></asp:Label>
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>

                </tr>

                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style4">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                </tr>
            </table>
        </div>

        <div class="text-center">
            <h5 class="mt-3 pt-3 pb-3" style="text-decoration: underline">Monthly Basis</h5>
            <div class="row pt-1">
                <div class="col-md-3" style="margin-right: 68px"></div>
                <div class="col-md-2">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:DropDownList ID="ddlMonth" runat="server" CssClass="form-control">
                                <asp:ListItem Selected hidden>Select Month</asp:ListItem>
                                <asp:ListItem Value="1">Jan</asp:ListItem>
                                <asp:ListItem Value="2">Feb</asp:ListItem>
                                <asp:ListItem Value="3">Mar</asp:ListItem>
                                <asp:ListItem Value="4">Apr</asp:ListItem>
                                <asp:ListItem Value="5">May</asp:ListItem>
                                <asp:ListItem Value="6">Jun</asp:ListItem>
                                <asp:ListItem Value="7">Jul</asp:ListItem>
                                <asp:ListItem Value="8">Aug</asp:ListItem>
                                <asp:ListItem Value="9">Sep</asp:ListItem>
                                <asp:ListItem Value="10">Oct</asp:ListItem>
                                <asp:ListItem Value="11">Nov</asp:ListItem>
                                <asp:ListItem Value="12">Dec</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
                <div class="col-md-2">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:DropDownList ID="ddlYear" runat="server" CssClass="form-control">
                                <asp:ListItem Selected hidden>Select Year</asp:ListItem>
                                <asp:ListItem Value="2022">2022</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row pb-3">
            <div class="col-md-3" style="margin-right: 68px"></div>
            <div class="col-md-2">
                <asp:Label ID="lblMonthRequired" runat="server" Text="Please select a month." ForeColor="Red" Font-Size="Small" Visible="false"></asp:Label>

            </div>
            <div class="col-md-1"></div>
            <div class="col-md-2">
                <asp:Label ID="lblYearRequired" runat="server" Text="Please select a year." ForeColor="Red" Font-Size="Small" Visible="false"></asp:Label>
            </div>
        </div>

        <%--Monthly New Edu Joined--%>
        <div style="padding-left: 300px">
            <table style="background-color: rgba(0, 0, 0, 0.03)">
                <tr>
                    <td dir="rtl" class="auto-style1"></td>
                    <td dir="rtl" class="auto-style4"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style2"></td>
                    <td class="auto-style3" rowspan="4">
                        <asp:Button ID="btnNewEduJoined" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="VIEW" Style="height: 40px; width: 110px; background-color: #f98006; color: white" Font-Size="Medium" OnClick="btnNewEduJoined_Click" />
                        <CR:CrystalReportViewer ID="CrystalReportViewer2" runat="server" AutoDataBind="true" />
                    </td>
                    <td dir="rtl" class="auto-style1"></td>
                </tr>
                <tr>
                    <td dir="rtl" class="auto-style1">&nbsp;</td>
                    <td dir="ltr" colspan="3" class="auto-style6">
                        <asp:Label ID="Label1" runat="server" Font-Size="17px" Text="Monthly New Educator Joined"></asp:Label>
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>

                </tr>

                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style4">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                </tr>
            </table>
        </div>

        <%--Monthly Commission--%>
         <div style="padding-left: 300px">
            <table style="background-color: rgba(0, 0, 0, 0.03)">
                <tr>
                    <td dir="rtl" class="auto-style1"></td>
                    <td dir="rtl" class="auto-style4"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style4"></td>
                    <td class="auto-style2"></td>
                    <td class="auto-style3" rowspan="4">
                        <asp:Button ID="btnCommissionReport" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="VIEW" Style="height: 40px; width: 110px; background-color: #f98006; color: white" Font-Size="Medium" OnClick="btnCommissionReport_Click" />
                        <CR:CrystalReportViewer ID="CrystalReportViewer3" runat="server" AutoDataBind="true" />
                    </td>
                    <td dir="rtl" class="auto-style1"></td>
                </tr>
                <tr>
                    <td dir="rtl" class="auto-style1">&nbsp;</td>
                    <td dir="ltr" colspan="3" class="auto-style6">
                        <asp:Label ID="Label2" runat="server" Font-Size="17px" Text="Monthly Commission Report"></asp:Label>
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                    <td>&nbsp;</td>

                </tr>

                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style4">&nbsp;</td>
                    <td class="auto-style2">&nbsp;</td>
                </tr>
            </table>
        </div>
        <asp:Panel ID="Panel1" runat="server">
            <div class="mt-5 pb-2 pt-5"></div>
            <div class="pt-1"></div>
        </asp:Panel>

    </div>
</asp:Content>
