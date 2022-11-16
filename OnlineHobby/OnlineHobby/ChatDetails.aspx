<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChatDetails.aspx.cs" Inherits="OnlineHobby.ChatDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <style type="text/css">
        .bg {
            background-color: #fff0d4;
        }

        .auto-style1 {
            width: 15px;
        }

        .auto-style2 {
            width: 130px;
        }

        .auto-style6 {
            width: 400px;
        }

        .auto-style7 {
            width: 15px;
            height: 16px;
        }

        .auto-style8 {
            height: 16px;
        }

        .auto-style9 {
            width: 130px;
            height: 16px;
        }

        .divMsgBox {
            border-radius: 15px;
            background: #f98006;
            padding-left: 5px;
            padding-right: 10px;
            padding-bottom: 10px;
            padding-top: 10px;
            width: auto;
            max-width: 1300px;
            text-align: left;
            height: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="row bg sticky-top px-3">

            <table style="border-bottom: 1px solid; border-bottom-color: #f2f2f2">
                <tr>
                    <td dir="rtl" class="auto-style1">&nbsp;</td>
                    <td dir="rtl" class="auto-style4" style="width: 30px"></td>
                    <td dir="rtl" class="auto-style1" style="width: 20px"></td>
                    <td dir="ltr" rowspan="3" style="width: 80px">
                        <asp:Image ID="imgProfile" runat="server" CssClass="rounded-circle img-fluid" Height="60" Width="60" ImageUrl="~/Resources/profile_orange.png" />
                    </td>
                    <td dir="ltr" rowspan="3" class="auto-style6">
                        <asp:Label ID="lblName" runat="server" Font-Size="21px" Text="Name"></asp:Label>
                    </td>
                    <td dir="rtl" class="auto-style1"></td>

                </tr>
                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td dir="rtl" class="auto-style4">
                        <asp:ImageButton ID="imgBtnBack" runat="server" Height="18" ImageUrl="~/Assets/backArrow.png" Width="30" OnClick="imgBtnBack_Click" /></td>
                    <td>&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style4">&nbsp;</td>
                </tr>

                <tr>
                    <td class="auto-style1">&nbsp;</td>
                    <td dir="rtl" class="auto-style4"></td>
                    <td>&nbsp;</td>
                    <td class="auto-style5">&nbsp;</td>
                    <td class="auto-style4">&nbsp;</td>
                </tr>
            </table>

        </div>

        <div style="padding-left: 50px; padding-right: 50px; height: auto; margin-bottom: 80px">
            <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                <ItemTemplate>
                    <br />
                    <table style="width: initial">
                        <tr>
                            <td class="auto-style1" colspan="5" style="width: 1500px">
                                <div class="container text-center my-2">
                                    <asp:Label ID="lblDateTime" runat="server" Font-Size="17px" ForeColor="Gray"><%#Eval("messageDateTime")%></asp:Label>

                                </div>
                            </td>
                            <td class="auto-style4">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="auto-style1" colspan="5">
                                <div id="divMsgBox" runat="server" class="divMsgBox">
                                    <asp:Label ID="lblSenderId" runat="server" Font-Size="1px" Text='<%#Eval("senderId")%>'></asp:Label>
                                    <asp:Label ID="lblContent" runat="server" Font-Size="17px" ForeColor="White"><%#Eval("messageContents")%></asp:Label>

                                </div>
                            </td>
                    </table>
                </ItemTemplate>
            </asp:Repeater>

            <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select ChatDetails.messageDateTime,ChatDetails.senderId,ChatDetails.messageContents
FROM ChatDetails WHERE ChatDetails.chatId=1 ORDER BY ChatDetails.messageId"></asp:SqlDataSource>--%>
        </div>

        <div class="row bg fixed-bottom px-3 py-2">
            <div class="col-md-11">
                <div class="input-group">
                    <div class="flex-grow-1">
                        <asp:TextBox ID="txtMessage" type="text" placeholder="Type your message here" CssClass="form-control" runat="server" Width="1440px"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="col-md-1 py-1">
                <div class="row">
                    <div class="col-md-6"></div>
                    <div class="col-md-5">
                        <asp:ImageButton ID="imgBtnSendMsg" runat="server" Height="26" ImageUrl="~/Assets/sendBtn.png" Width="26" OnClick="imgBtnSendMsg_Click" />
                    </div>
                    <div class="col-md-1"></div>
                </div>

            </div>

        </div>
    </form>
</body>
</html>
