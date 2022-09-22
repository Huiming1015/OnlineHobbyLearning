<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudMaterial.aspx.cs" Inherits="OnlineHobby.StudMaterial" MasterPageFile="~/StudMaster.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>

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
    </style>

    <div class="text-center" style="min-height:100%;">
        <table class="text-center" style="width:100%">
            <tr>
                <td>
                    <div>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <br />
                        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="XX-Large" Font-Underline="False" ForeColor="#993333" Text="MATERIAL KITS"></asp:Label>
                        <br />
                        <br />
                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
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
                        <asp:Label ID="lblMessage" runat="server" BackColor="White" Text="Sorry, there is no material kit found." Visible="False" Width="100%" Font-Names="Gill Sans MT" Font-Size="Large"></asp:Label>

                        <asp:DataList ID="dtMaterial" runat="server" CellPadding="10" CellSpacing="15" DataKeyField="materialId" HorizontalAlign="Center" RepeatDirection="Horizontal" OnSelectedIndexChanged="dtMaterial_SelectedIndexChanged" BackColor="White" RepeatColumns="5">
                            <AlternatingItemStyle Wrap="False" />
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" />
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="imgMaterial" runat="server" CommandArgument='materialId' CommandName="viewdetail" Height="234px" ImageUrl='<%# Eval("materialImage") %>' Width="215px" ImageAlign="Middle" BorderColor="Black" BorderStyle="Solid" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="lbMaterialName" runat="server" CommandArgument='materialId' CommandName="viewdetail" Text='<%# Eval("materialName") %>' Font-Underline="False" ForeColor="#993333"></asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Price: RM
                                                <asp:Label ID="PriceLabel" runat="server" Text='<%# Eval("price", "{0:0.00}") %>' />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:ImageButton ID="Button1" runat="server" CommandName="AddToCart" Height="40px" ImageUrl="https://cdn.iconscout.com/icon/free/png-256/add-in-shopping-cart-461858.png" Text="Add To Cart" Width="40px" />
                                            &nbsp;</td>
                                    </tr>
                                </table>

                                <br />
                            </ItemTemplate>
                            <SelectedItemStyle Wrap="True" />
                        </asp:DataList>
                        <br />
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
