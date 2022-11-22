<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudMaterial.aspx.cs" Inherits="OnlineHobby.StudMaterial" MasterPageFile="~/StudMaster.Master" %>

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
            min-height: 610px;
        }
    </style>

    <div class="text-center div-background">
        <table class="text-center" style="width: 100%">
            <tr>
                <td>
                    <div>
                        <br />

                        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="XX-Large" Font-Underline="False" ForeColor="#993333" Text="MATERIAL KITS"></asp:Label>
                        <br />
                        <br />
                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" Width="250px" Style="display: inline !important;" Height="40px">
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
                    <div class="text-center div-background">
                        <asp:Label ID="lblMessage" runat="server" BackColor="White" Text="Sorry, there is no material kit found." Visible="False" Width="100%" Font-Names="Gill Sans MT" Font-Size="Large"></asp:Label>
                        <div style="width: 100%;">
                            <asp:DataList ID="dtMaterial" runat="server" CellSpacing="30" DataKeyField="materialId" HorizontalAlign="Center" RepeatDirection="Horizontal" RepeatColumns="5" OnItemCommand="dtMaterial_ItemCommand" OnItemDataBound="dtMaterial_ItemDataBound" CellPadding="5">
                                <ItemTemplate>
                                    <table style="border: 1px solid grey;">
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="imgMaterial" runat="server" CommandArgument='<%# Eval("materialId") %>' CommandName="view" Height="250px" ImageUrl='<%# Eval("materialImage") %>' Width="250px" ImageAlign="Middle" BorderColor="Black" BorderStyle="Solid" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbMaterialName" runat="server" CommandArgument='<%# Eval("materialId") %>' CommandName="view" Text='<%# Eval("materialName") %>' Font-Underline="False" ForeColor="#993333" Height="50px" Width="250px" class="text-center"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Price: RM
                                                <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("price", "{0:0.00}") %>' />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="btnAddToCart" runat="server" CommandName="addToCart" CommandArgument='<%# Eval("materialId") %>' Height="40px" ImageUrl="https://cdn.iconscout.com/icon/free/png-256/add-in-shopping-cart-461858.png" Text="Add To Cart" Width="40px" />
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                    <br /><asp:Label ID="lblStock" runat="server" Text='<%# Eval("stock") %>' Visible="false" />
                                </ItemTemplate>
                                <SelectedItemStyle Wrap="True" />
                            </asp:DataList>
                        </div>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
