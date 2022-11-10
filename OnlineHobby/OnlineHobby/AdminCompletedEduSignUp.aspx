<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminCompletedEduSignUp.aspx.cs" Inherits="OnlineHobby.AdminCompletedEduSignUp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .bg {
            background-color: #fffefa;
        }

        .auto-style1 {
            height: 40px;
            width: 100px;
        }

        .auto-style2 {
            width: 410px;
        }

        .auto-style3 {
            width: 400px;
        }

        .auto-style4 {
            width: 340px;
        }

        .auto-style5 {
            width: 100px;
        }

         .auto-style6 {
            width: 120px;
        }

        .buttonHeader {
            background: rgba(0, 0, 0, 0.03);
        }

            .buttonHeader:hover {
                background: #e6e6e6;
            }
    </style>

    <div class="container-fluid bg">
        <div class="text-center">
            <h2 class="pt-5 mb-3 pb-3" style="color: #f98006; font-weight: bold; font-size: xx-large">Educator Sign Up</h2>
        </div>

        <div class="row justify-content-center mt-4 pt-1 mb-3 pb-4 mb-lg-4">
            <asp:Button ID="btnPending" CssClass="buttonHeader" runat="server" Text="Pending" type="submit" Style="width: 50%; height: 40px;" Font-Size="17px" OnClick="btnPending_Click" BorderStyle="Solid" BorderColor="Silver" />
            <asp:Button ID="btnCompleted" CssClass="buttonHeader" runat="server" Text="Completed" type="submit" Style="width: 50%; height: 40px; background: #e6e6e6;" Font-Size="17px" OnClick="btnCompleted_Click" BorderStyle="Solid" BorderColor="Silver" ForeColor="#F98006" Font-Bold="True" />
        </div>

        <div class="alert alert-primary alert-dismissible fade show" runat="server" id="MsgNotice" visible="false">
            <h4 class="alert-heading">Info</h4>
            No completed educator sign up application.
        </div>

        <asp:Panel ID="PanelTableHeader" runat="server">
            <div style="padding-left: 15px; padding-top: 10px">
                <table style="background-color: rgba(0, 0, 0, 0.03);" border="1">
                    <tr>
                        <td class="auto-style1" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="lblAddrName" runat="server" Font-Size="17px" Font-Bold="True">ID</asp:Label></td>
                        <td class="auto-style2" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="Label1" runat="server" Font-Size="17px" Font-Bold="True">Name</asp:Label></td>
                        <td class="auto-style3" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="Label2" runat="server" Font-Size="17px" Font-Bold="True">Email</asp:Label></td>
                        <td class="auto-style4" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="Label4" runat="server" Font-Size="17px" Font-Bold="True">Course Category</asp:Label></td>
                        <td class="auto-style6" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="Label3" runat="server" Font-Size="17px" Font-Bold="True">Status</asp:Label></td>
                        <td class="auto-style5"></td>
                    </tr>
                </table>
            </div>
        </asp:Panel>

        <div style="padding-left: 15px; padding-bottom: 70px">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate>
                    <table style="background-color: rgba(0, 0, 0, 0.03);" border="1">
                        <tr>
                            <td class="auto-style1" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="lblAddrName" runat="server" Font-Size="17px"><%#Eval("eduAppId").ToString()%></asp:Label></td>
                            <td class="auto-style2" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label1" runat="server" Font-Size="17px"><%#Eval("eduName").ToString()%></asp:Label></td>
                            <td class="auto-style3" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label2" runat="server" Font-Size="17px"><%#Eval("eduEmail").ToString()%></asp:Label></td>
                            <td class="auto-style4" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label4" runat="server" Font-Size="17px"><%#Eval("courseCategory").ToString()%></asp:Label></td>
                            <td class="auto-style6" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label5" runat="server" Font-Size="17px"><%#Eval("apprStatus").ToString()%></asp:Label></td>
                            <td class="auto-style5" style="text-align: center">
                                <asp:LinkButton ID="lbtnView" runat="server" ForeColor="#f98006" Text="View" CommandArgument='<%# Eval("eduAppId") %>' CommandName="View" type="submit"></asp:LinkButton></td>
                        </tr>
                    </table>
                </ItemTemplate>
                 <AlternatingItemTemplate>
                    <table style="background-color: rgba(0, 0, 0, 0.2);" border="1">
                        <tr>
                            <td class="auto-style1" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="lblAddrName" runat="server" Font-Size="17px"><%#Eval("eduAppId").ToString()%></asp:Label></td>
                            <td class="auto-style2" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label1" runat="server" Font-Size="17px"><%#Eval("eduName").ToString()%></asp:Label></td>
                            <td class="auto-style3" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label2" runat="server" Font-Size="17px"><%#Eval("eduEmail").ToString()%></asp:Label></td>
                            <td class="auto-style4" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label4" runat="server" Font-Size="17px"><%#Eval("courseCategory").ToString()%></asp:Label></td>
                            <td class="auto-style6" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label5" runat="server" Font-Size="17px"><%#Eval("apprStatus").ToString()%></asp:Label></td>
                            <td class="auto-style5" style="text-align: center">
                                <asp:LinkButton ID="lbtnView" runat="server" ForeColor="#f98006" Text="View" CommandArgument='<%# Eval("eduAppId") %>' CommandName="View" type="submit"></asp:LinkButton></td>
                        </tr>
                    </table>
                </AlternatingItemTemplate>
            </asp:Repeater>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [eduAppId], [eduName], [eduEmail], [courseCategory], [apprStatus] FROM [EduApplication] WHERE ([apprStatus] = 'Approve' OR [apprStatus] = 'Reject')"></asp:SqlDataSource>
        </div>
         <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="mt-5 mb-3 pb-3 pt-5"></div>
            <div class="pt-1"></div>
        </asp:Panel>

        <asp:Panel ID="Panel2" runat="server" Visible="False">
            <div class="mt-5 pt-4 pb-4 mb-1"></div>
        </asp:Panel>
    </div>
</asp:Content>
