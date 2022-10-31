<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="Following.aspx.cs" Inherits="OnlineHobby.Following" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }

        .auto-style1 {
            width: 30px;
            height: 10px;
        }

        .auto-style2 {
            width: 130px;
        }

        .auto-style6 {
            width: 400px;
        }
    </style>

    <div class="container-fluid div-background mt-3">

        <div class="text-center">
            <h2 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">Following</h2>
        </div>
        <div class="alert alert-primary alert-dismissible fade show" runat="server" id="MsgNotice" visible="false">
            <h4 class="alert-heading">Info</h4>
            You have not followed any educator, start follow now.
        </div>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="mt-5 mb-5 pb-4 pt-4"></div>
        </asp:Panel>

        <div style="padding-left: 180px">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate>
                    <br />
                    <table style="background-color: rgba(0, 0, 0, 0.03); border-radius: 15px">
                        <tr>
                            <td dir="rtl" class="auto-style1" style="height: 10px"></td>
                            <td dir="rtl" class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style2"></td>
                            <td class="auto-style3" rowspan="5">
                                <asp:Button ID="btnView" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="VIEW" CommandArgument='<%# Eval("eduId") %>' CommandName="View" type="submit" Style="height: 40px; width: 110px; background-color: #f98006; color: white" Font-Size="Medium" />
                            </td>
                            <td dir="rtl" class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td dir="rtl" class="auto-style1">&nbsp;</td>
                            <td dir="ltr" rowspan="3" style="width: 100px">
                                <asp:Image ID="imgProfile" runat="server" CssClass="rounded-circle img-fluid" Height="70" Width="70" ImageUrl='<%# Eval("profileImg") %>' />
                            </td>
                            <td dir="ltr" rowspan="3" class="auto-style6">
                                <asp:Label ID="Label2" runat="server" Font-Size="19px"><%#Eval("eduName")%></asp:Label>
                            </td>
                            <td dir="rtl" class="auto-style1"></td>

                        </tr>
                        <tr>
                            <td class="auto-style1">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td class="auto-style5">&nbsp;</td>
                            <td class="auto-style4">&nbsp;</td>
                        </tr>

                        <tr>
                            <td class="auto-style1">&nbsp;</td>
                            <td>&nbsp;</td>
                            <td class="auto-style5">&nbsp;</td>
                            <td class="auto-style4">&nbsp;</td>
                        </tr>
                        <tr>
                            <td dir="rtl" class="auto-style1" style="height: 10px"></td>
                            <td dir="rtl" class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style2"></td>
                            <td class="auto-style3"></td>
                            <td dir="rtl" class="auto-style1"></td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:Repeater>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="Select Follower.eduId,Follower.eduName,Educator.profileImg
FROM Follower INNER JOIN Educator ON Follower.eduId = Educator.eduId  WHERE Follower.studId=@UserId">
                <SelectParameters>
                    <asp:SessionParameter Name="UserId" SessionField="UserId" />
                </SelectParameters>
            </asp:SqlDataSource>

            <div class="container pt-4 pb-5">
                <asp:Label ID="Label10" runat="server" Text="Total Following: "></asp:Label>
                &nbsp;
            <asp:Label ID="lblFllwingCount" runat="server" Text="-"></asp:Label>
            </div>
        </div>

        <asp:Panel ID="Panel2" runat="server" Visible="False">
            <div class="mt-5 mb-4 pb-3 pt-5"></div>
        </asp:Panel>

        <asp:Panel ID="Panel3" runat="server" Visible="False">
            <div class="my-5 py-5"></div>
            <div class="pt-1"></div>
        </asp:Panel>

        <asp:Panel ID="Panel4" runat="server" Visible="False">
            <div class="my-5 py-3"></div>
        </asp:Panel>

        <asp:Panel ID="Panel5" runat="server" Visible="False">
            <div class="my-3 py-3"></div>
        </asp:Panel>
        <asp:Panel ID="Panel6" runat="server" Visible="False">
            <div class="my-1 py-1"></div>
        </asp:Panel>

    </div>
</asp:Content>
