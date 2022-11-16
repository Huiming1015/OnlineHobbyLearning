<%@ Page Title="" Language="C#" MasterPageFile="~/StudMaster.Master" AutoEventWireup="true" CodeBehind="Chats.aspx.cs" Inherits="OnlineHobby.Chats" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
       <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }

        .auto-style1 {
            width: 50px;
        }

        .auto-style2 {
            width: 130px;
        }

        .auto-style6 {
            width: 1400px;
        }
    </style>

    <div class="container-fluid div-background pt-3 px-0">

        <div class="text-center">
            <h2 class="mt-4 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">Chats</h2>

        </div>
        <div class="alert alert-primary alert-dismissible fade show" runat="server" id="MsgNotice" visible="false" style="margin-left: 100px; margin-right: 100px;">
            <h4 class="alert-heading">Info</h4>
            You have not any chat yet. Start your chat now.
        </div>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="mt-5 mb-5 pb-4 pt-4"></div>
        </asp:Panel>

        <div style="padding-left: 0px">
            <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate>
                    <table style="background-color: rgba(0, 0, 0, 0.03); border-color: #f2f2f2" border="1">
                        <tr>
                            <td dir="rtl" class="auto-style1" style="height: 5px"></td>
                            <td dir="rtl" class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style2"></td>
                            <td dir="rtl" class="auto-style1"></td>

                        </tr>
                        <tr>
                            <td dir="rtl" class="auto-style1">&nbsp;</td>
                            <td dir="ltr" rowspan="3" style="width: 100px">
                                <asp:ImageButton ID="imgProfile" runat="server" CssClass="rounded-circle img-fluid" Height="70" Width="70" ImageUrl='<%# Eval("profileImg") %>' CommandArgument='<%# Eval("id") %>' CommandName="View" type="submit" />
                            </td>
                            <td dir="ltr" colspan="4" rowspan="2" class="auto-style6">
                                <asp:LinkButton ID="lbtnName" runat="server" CommandArgument='<%# Eval("id") %>' CommandName="View" type="submit" Font-Bold="True" Font-Size="22px" Font-Underline="False" ForeColor="Black"><%#Eval("name")%></asp:LinkButton>
<%--                                <asp:Label ID="lblUnreadMsg" runat="server" Font-Bold="True" Font-Size="22px" ForeColor="Black"> <%#Eval("unread")%></asp:Label>--%>
                                <%--                                <asp:Label ID="Label1" runat="server" Text="(?)" Font-Bold="True" Font-Size="22px"  ForeColor="Black"></asp:Label>--%>
                            </td>
                            <td dir="rtl" class="auto-style1"></td>

                        </tr>
                        <tr>
                            <td class="auto-style1">&nbsp;</td>
                            <td dir="rtl" class="auto-style1"></td>
                        </tr>

                        <tr>
                            <td class="auto-style1">&nbsp;</td>
                            <td class="auto-style4" colspan="4">
                                <asp:Label ID="lblLatestMsg" runat="server" Font-Size="17px"><%#Eval("messageContents")%></asp:Label></td>
                            <td dir="rtl" class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td dir="rtl" class="auto-style1" style="height: 8px"></td>
                            <td dir="rtl" class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style2"></td>
                            <td dir="rtl" class="auto-style1"></td>

                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>

            <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select Chat.studId,Chat.studName,Student.profileImg,ChatDetails.messageContents
FROM Chat INNER JOIN Student ON Chat.studId = Student.studId  
INNER JOIN ChatDetails ON Chat.chatId = ChatDetails.chatId WHERE Chat.studId=101"></asp:SqlDataSource>--%>
        </div>

        <asp:Panel ID="Panel2" runat="server" Visible="False">
            <div class="my-5 py-5"></div>
            <div class="mt-5 py-5"></div>
            \
        </asp:Panel>

        <asp:Panel ID="Panel3" runat="server" Visible="False">
            <div class="my-5 py-5"></div>
            <div class="my-3 py-5"></div>
            <div class="py-5"></div>
        </asp:Panel>

        <asp:Panel ID="Panel4" runat="server" Visible="False">
            <div class="my-5 py-5"></div>
            <div class="mt-5 py-5"></div>
            <div class="py-2"></div>
        </asp:Panel>

        <asp:Panel ID="Panel6" runat="server" Visible="False">
            <div class="my-5 py-5"></div>
            <div class="mt-5 py-3"></div>
        </asp:Panel>

        <asp:Panel ID="Panel5" runat="server" Visible="False">
            <div class="mt-5 py-5"></div>
        </asp:Panel>

    </div>
</asp:Content>
