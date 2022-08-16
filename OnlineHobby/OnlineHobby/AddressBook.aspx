<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="AddressBook.aspx.cs" Inherits="OnlineHobby.AddressBook" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }

        .auto-style1 {
            width: 30px;
        }

        .auto-style2 {
            width: 130px;
        }

        .auto-style6 {
            width: 600px;
        }
    </style>

    <div class="container-fluid div-background mt-3">

        <div class="text-center">
            <h2 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">Address Book</h2>
        </div>
        <div class="alert alert-primary alert-dismissible fade show" runat="server" id="MsgNotice" visible="false">
            <h4 class="alert-heading">Info</h4>
            You have not yet setup an address, add your address now.
        </div>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="mt-5 mb-5 pb-3 pt-4"></div>
        </asp:Panel>

        <div style="padding-left: 160px">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate>
                    <br />
                    <table style="background-color: rgba(0, 0, 0, 0.03); border-radius: 15px">
                        <tr>
                            <td dir="rtl" class="auto-style1" style="height: 30px"></td>
                            <td dir="rtl" class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style2"></td>
                            <td class="auto-style3" rowspan="4">
                                <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="EDIT" CommandArgument='<%# Eval("addrId") %>' CommandName="Edit" type="submit" Style="height: 40px; width: 110px; background-color: #f98006; color: white" Font-Size="Medium" />
                            </td>
                            <td dir="rtl" class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td dir="rtl" class="auto-style1">&nbsp;</td>
                            <td dir="ltr" colspan="3" class="auto-style6">
                                <asp:Label ID="lblAddrName" runat="server" Font-Size="17px"><%#Eval("name")%></asp:Label>
                                &nbsp;
                            <asp:Label ID="Label1" runat="server" Font-Size="17px">|</asp:Label>
                                &nbsp;
                            <asp:Label ID="lblAddrPhone" runat="server" Font-Size="17px"><%#Eval("phone")%></asp:Label>
                            </td>
                            <td class="auto-style2">&nbsp;</td>
                            <td>&nbsp;</td>

                        </tr>
                        <tr>
                            <td dir="rtl" class="auto-style7"></td>
                            <td dir="ltr" colspan="3" class="auto-style8">
                                <asp:Label ID="lblAddrAddress" runat="server" Font-Size="17px"><%#Eval("address")%></asp:Label>
                            </td>
                            <td class="auto-style9"></td>

                        </tr>

                        <tr>
                            <td class="auto-style1">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td class="auto-style5">&nbsp;</td>
                            <td class="auto-style4">&nbsp;</td>
                            <td class="auto-style2">&nbsp;</td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select AddressBook.addrId,AddressBook.name,AddressBook.phone,AddressBook.address
FROM AddressBook INNER JOIN Student ON AddressBook.studId = Student.studId  WHERE AddressBook.studId=@UserId">
                <SelectParameters>
                    <asp:SessionParameter Name="UserId" SessionField="UserId" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <asp:Panel ID="Panel3" runat="server" Visible="False">
            <%--5525--%>
            <div class="mt-5 mb-5 pb-3 pt-5"></div>
            <div class="pt-1"></div>
        </asp:Panel>

        <asp:Panel ID="Panel4" runat="server" Visible="False">
            <%--1121--%>
            <div class="mt-2 pt-2 pb-2 mb-1"></div>
        </asp:Panel>

        <%--//52354--%>
        <div class="d-flex justify-content-center mt-5 pt-2 mb-3 pb-5 mb-lg-4">
            <asp:Button ID="btnAddAddress" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="ADD ADDRESS" type="submit" Style="height: 47px; width: 215px; background-color: #f98006; color: white" OnClick="btnAddAddress_Click" />
        </div>
        <asp:Panel ID="Panel2" runat="server" Visible="False">
            <div class="mt-5 mb-4 pb-3 pt-5"></div>
        </asp:Panel>
    </div>
</asp:Content>
