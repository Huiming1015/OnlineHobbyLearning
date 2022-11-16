<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminPendingEduIncident.aspx.cs" Inherits="OnlineHobby.AdminPendingEduIncident" %>
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
            width: 360px;
        }

        .auto-style3 {
            width: 360px;
        }

        .auto-style4 {
            width: 450px;
        }

        .auto-style5 {
            width: 200px;
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
            <h2 class="pt-5 mb-3 pb-3" style="color: #f98006; font-weight: bold; font-size: xx-large">Educator Incident</h2>
        </div>

        <div class="row justify-content-center mt-4 pt-1 mb-3 pb-4 mb-lg-4">
            <asp:Button ID="btnPending" CssClass="buttonHeader" runat="server" Text="Pending" type="submit" Style="width: 50%; height: 40px; background: #e6e6e6;" Font-Size="17px"  BorderStyle="Solid" ForeColor="#F98006" BorderColor="Silver" Font-Bold="True" OnClick="btnPending_Click" />
            <asp:Button ID="btnCompleted" CssClass="buttonHeader" runat="server" Text="Completed" type="submit" Style="width: 50%; height: 40px;" Font-Size="17px"  BorderStyle="Solid" BorderColor="Silver" OnClick="btnCompleted_Click" />
        </div>

        <div class="alert alert-primary alert-dismissible fade show" runat="server" id="MsgNotice" visible="false">
            <h4 class="alert-heading">Info</h4>
            No pending educator incident.
        </div>

        <asp:Panel ID="PanelTableHeader" runat="server">
            <div style="padding-left: 15px; padding-top: 10px">
                <table style="background-color: rgba(0, 0, 0, 0.03);" border="1">
                    <tr>
                        <td class="auto-style1" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="lblAddrName" runat="server" Font-Size="17px" Font-Bold="True">ID</asp:Label></td>
                        <td class="auto-style2" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="Label1" runat="server" Font-Size="17px" Font-Bold="True">Student</asp:Label></td>
                        <td class="auto-style3" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="Label2" runat="server" Font-Size="17px" Font-Bold="True">Educator</asp:Label></td>
                        <td class="auto-style4" style="text-align: center; border-right: 1px solid;">
                            <asp:Label ID="Label4" runat="server" Font-Size="17px" Font-Bold="True">Incident Type</asp:Label></td>
                        <td class="auto-style5"></td>
                    </tr>
                </table>
            </div>
        </asp:Panel>

        <div style="padding-left: 15px; padding-bottom: 70px">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand" >
                <ItemTemplate>
                    <table style="background-color: rgba(0, 0, 0, 0.03);" border="1">
                        <tr>
                            <td class="auto-style1" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="lblAddrName" runat="server" Font-Size="17px"><%#Eval("complaintId").ToString()%></asp:Label></td>
                            <td class="auto-style2" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label1" runat="server" Font-Size="17px"><%#Eval("studName").ToString()%></asp:Label></td>
                            <td class="auto-style3" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label2" runat="server" Font-Size="17px"><%#Eval("eduName").ToString()%></asp:Label></td>
                            <td class="auto-style4" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label4" runat="server" Font-Size="17px"><%#Eval("incidentType").ToString()%></asp:Label></td>
                            <td class="auto-style5" style="text-align: center">
                                <asp:LinkButton ID="lbtnView" runat="server" ForeColor="#f98006" Text="View" CommandArgument='<%# Eval("complaintId") %>' CommandName="View" type="submit"></asp:LinkButton></td>
                        </tr>
                    </table>
                </ItemTemplate>
                 <AlternatingItemTemplate>
                    <table style="background-color: rgba(0, 0, 0, 0.2);" border="1">
                        <tr>
                            <td class="auto-style1" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="lblAddrName" runat="server" Font-Size="17px"><%#Eval("complaintId").ToString()%></asp:Label></td>
                            <td class="auto-style2" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label1" runat="server" Font-Size="17px"><%#Eval("studName").ToString()%></asp:Label></td>
                            <td class="auto-style3" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label2" runat="server" Font-Size="17px"><%#Eval("eduName").ToString()%></asp:Label></td>
                            <td class="auto-style4" style="text-align: center; border-right: 1px solid">
                                <asp:Label ID="Label4" runat="server" Font-Size="17px"><%#Eval("incidentType").ToString()%></asp:Label></td>
                            <td class="auto-style5" style="text-align: center">
                                <asp:LinkButton ID="lbtnView" runat="server" ForeColor="#f98006" Text="View" CommandArgument='<%# Eval("complaintId") %>' CommandName="View" type="submit"></asp:LinkButton></td>
                        </tr>
                    </table>
                </AlternatingItemTemplate>
            </asp:Repeater>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [complaintId], [studName], [eduName], [incidentType] FROM [Complaint] WHERE ([apprStatus] = @apprStatus)">
                <SelectParameters>
                    <asp:Parameter DefaultValue="Pending" Name="apprStatus" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
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
