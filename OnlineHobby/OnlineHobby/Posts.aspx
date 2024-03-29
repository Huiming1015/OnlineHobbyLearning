﻿<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="Posts.aspx.cs" Inherits="OnlineHobby.Posts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
     <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }

        .auto-style1 {
            width: 30px;
        }

        .auto-style8 {
            width: 800px;
        }

        .auto-style10 {
            width: 30px;
        }

    </style>
    <%--post are arrange by date(latest -> oldest)--%>
    <div class="container-fluid div-background mt-3">

        <div class="text-center">
            <h2 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">Dashboard</h2>
        </div>
        <div class="alert alert-primary alert-dismissible fade show" runat="server" id="MsgNotice" visible="false">
            <h4 class="alert-heading">Info</h4>
            You have not yet add your post, add it now.
        </div>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="mt-5 mb-5 pb-3 pt-4"></div>
        </asp:Panel>

        <div style="padding-left: 120px">
            <asp:Repeater ID="Repeater1" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="Repeater1_ItemCommand">
                <ItemTemplate>
                    <br />
                    <table style="background-color: rgba(0, 0, 0, 0.03); border-radius: 15px">
                        <tr>
                            <td dir="rtl" class="auto-style1" style="height: 15px"></td>
                            <td dir="rtl" class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style4"></td>
                            <td class="auto-style2"></td>
                            <td class="auto-style3" rowspan="6">
                                <asp:Button ID="btnEdit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="EDIT" CommandArgument='<%# Eval("postId") %>' CommandName="Edit" type="submit" Style="height: 40px; width: 110px; background-color: #f98006; color: white" Font-Size="Medium" />
                            </td>
                            <td dir="rtl" class="auto-style10"></td>
                        </tr>
                        <tr>
                            <td dir="rtl" class="auto-style1"></td>
                            <td dir="ltr" colspan="4" class="auto-style8">
                               <asp:Label ID="Label3" runat="server" Font-Size="Smaller" ForeColor="Gray" >Posted on </asp:Label>
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
                                <asp:Image ID="imgPostImage" runat="server" Height="179px" Width="178px" ImageUrl='<%#Eval("postImg")%>'/>
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
FROM Posts INNER JOIN Educator ON Posts.eduId = Educator.eduId  WHERE Posts.eduId=@UserId ORDER BY Posts.postDateTime DESC">
                <SelectParameters>
                    <asp:SessionParameter Name="UserId" SessionField="UserId" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
        <asp:Panel ID="Panel3" runat="server" Visible="False">
            <div class="mt-5 mb-3 pb-3 pt-5"></div>
            <div class="pt-1"></div>
        </asp:Panel>

        <asp:Panel ID="Panel4" runat="server" Visible="False">
            <div class="mt-1 pt-1 pb-2 mb-1"></div>
        </asp:Panel>

        <%--//52354--%>
        <div class="d-flex justify-content-center mt-5 pt-2 mb-3 pb-5 mb-lg-4">
            <asp:Button ID="btnAddPost" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="ADD POST" type="submit" Style="height: 47px; width: 170px; background-color: #f98006; color: white" OnClick="btnAddPost_Click"  />
        </div>
        <asp:Panel ID="Panel2" runat="server" Visible="False">
            <div class="mt-5 mb-4 pb-3 pt-5"></div>
        </asp:Panel>
    </div>
</asp:Content>
