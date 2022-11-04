﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudCourseList.aspx.cs" Inherits="OnlineHobby.StudCourseList" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .img {
            height: 400px;
            width: 350px;
            border: 2px solid black;
            transition: transform .4s;
        }

            .img:hover {
                transform: scale(1.1);
                cursor: zoom-in;
            }

        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="text-center div-background" style="min-height: 600px;">
        <table class="text-center" style="width: 100%">
            <tr>
                <td>
                    <div>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <br />

                        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="XX-Large" Font-Underline="False" ForeColor="#993333" Text="COURSES"></asp:Label>
                        <br />
                        <br />
                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                            <asp:ListItem Value="draw">All</asp:ListItem>
                            <asp:ListItem Value="draw">Drawing & Painting</asp:ListItem>
                            <asp:ListItem Value="floral">Floral</asp:ListItem>
                            <asp:ListItem Value="sew">Sewing & Crochet</asp:ListItem>
                            <asp:ListItem Value="jewelleries">Jewelleries</asp:ListItem>
                            <asp:ListItem Value="music">Music</asp:ListItem>
                            <asp:ListItem Value="food">Food & Beverage</asp:ListItem>
                            <asp:ListItem Value="language">Language</asp:ListItem>
                            <asp:ListItem Value="cratt">Craft</asp:ListItem>
                            <asp:ListItem Value="others">Others</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <br />
                    <div class="text-center">
                        <asp:Label ID="lblMessage" runat="server" BackColor="White" Text="Sorry, there is no course found." Visible="False" Width="100%" Font-Names="Gill Sans MT" Font-Size="Large"></asp:Label>

                        <div class="text-center">
                            <asp:DataList ID="dlCourse" runat="server" HorizontalAlign="Center" RepeatDirection="Horizontal" RepeatColumns="5" OnItemCommand="dlCourse_ItemCommand" CellSpacing="15">
                                <ItemTemplate>
                                    <table style="border:1px solid grey">
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="imgbMaterial" class="card-img-top" runat="server" Height="250px" Width="250px" ImageUrl='<%# Eval("courseImage") %>' CommandArgument='<%# Eval("courseId") %>' CommandName="view" BorderStyle="Solid" BorderWidth="3px" ImageAlign="Middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="linkMaterial" class="card-body" runat="server" Style="text-align: center !important" CommandArgument='<%# Eval("courseId") %>' CommandName="view" Font-Underline="False" ForeColor="#993333" Height="45px"><%# Eval("courseName") %> </asp:LinkButton>

                                            </td>
                                        </tr>
                                        <tr>
                                           <td>
                                            <asp:ImageButton ID="Button1" runat="server" CommandName="AddToCart" Height="40px" ImageUrl="https://cdn.iconscout.com/icon/free/png-256/add-in-shopping-cart-461858.png" Text="Add To Cart" Width="40px" />
                                            &nbsp;</td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <br />
                    </div>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
</asp:Content>
