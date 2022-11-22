<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudCourseList.aspx.cs" Inherits="OnlineHobby.StudCourseList" MasterPageFile="~/StudMaster.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .div-background {
            background-color: #fffefa;
            min-height: 610px;
        }

         .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            background-color: #FFFFFF;
            border-width: 3px;
            border-style: solid;
            border-color: black;
            padding-top: 10px;
            padding-left: 10px;
            width: 800px;
            height: 580px;
        }
    </style>

    <div class="text-center div-background">
        <table class="text-center" style="width: 100%">
            <tr>
                <td>
                    <div>
                        <br />

                        <asp:Label ID="lblTitle" runat="server" Font-Bold="True" Font-Size="XX-Large" Font-Underline="False" ForeColor="#993333" Text="COURSES"></asp:Label>
                        <br />
                        <br />
                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged" Width="250px" Height="40px" Style="display: inline !important;">
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
                        <asp:Label ID="lblMessage" runat="server" BackColor="White" Text="Sorry, there is no course found." Visible="False" Width="100%" Font-Names="Gill Sans MT" Font-Size="Large"></asp:Label>

                         <div class="text-center">
                            <asp:DataList ID="dlCourse" runat="server" HorizontalAlign="Center" CssClass="text-center" RepeatDirection="Horizontal" RepeatColumns="5" OnItemCommand="dlCourse_ItemCommand" CellSpacing="30" OnItemDataBound="dlCourse_ItemDataBound" CellPadding="5">
                                <ItemTemplate>
                                    <table style="border: 1px solid grey;">
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="imgbMaterial" runat="server" Height="250px" Width="250px" ImageUrl='<%# Eval("courseImage") %>' CommandArgument='<%# Eval("courseId") %>' CommandName="view" BorderStyle="Solid" BorderWidth="3px" ImageAlign="Middle" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="linkCourse" class="text-center" runat="server" CommandArgument='<%# Eval("courseId") %>' CommandName="view" Font-Underline="False" ForeColor="#993333" Height="50px" Width="250px" Text='<%# Eval("courseName") %>'></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:ImageButton ID="btnAddToCart" runat="server" CommandName="addToCart" Height="40px" CommandArgument='<%# Eval("courseId") %>' ImageUrl="https://cdn.iconscout.com/icon/free/png-256/add-in-shopping-cart-461858.png" Text="Add To Cart" Width="40px" />
                                                &nbsp;</td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:DataList>
                             </div>
                            <asp:Panel ID="Panel1" runat="server">
                                        <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
                                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                                            </asp:ScriptManager>
                                            <cc1:modalpopupextender id="mp1" runat="server" popupcontrolid="Panl1"
                                                cancelcontrolid="Button2" backgroundcssclass="Background" TargetControlID="hiddenPopupTarget">
                                            </cc1:modalpopupextender>
                                            <asp:Button ID="hiddenPopupTarget" runat="server" Style="display: none;"/>
                                            <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                                                <asp:Panel ID="Panel4" runat="server" align="right" Style="padding-right: 10px">
                                                    <asp:Button ID="Button2" runat="server" Text="X" Style="background-color: #f98006; color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" />
                                                </asp:Panel>
                                                <iframe style="width: 700px; height: 530px;" id="irm1" src="AddCourseToCart.aspx" runat="server"></iframe>
                                            </asp:Panel>
                                        </div>
                                    </asp:Panel>
                  
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
