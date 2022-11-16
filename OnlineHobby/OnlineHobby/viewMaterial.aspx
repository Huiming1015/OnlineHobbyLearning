<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="viewMaterial.aspx.cs" Inherits="OnlineHobby.viewMaterial" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .trRight {
            width: 35%;
            padding: 5px;
            text-align: center;
            border-left: 1px solid grey;
            border-top: 1px solid grey;
            vertical-align: top;
        }

        .trLeft {
            width: 65%;
            text-align: center;
            border-right: 1px solid grey;
        }

        table {
            border-bottom: 1px solid grey;
            border-top: 1px solid grey;
            border-left: 1px solid grey;
            border-right: 1px solid grey;
        }

        .div-background {
            background-color: #fffefa;
        }


        .rounded-pill {
            border-radius: 50rem !important;
        }

        .btn-lg, .btn-group-lg > .btn {
            padding: 0.5rem 1rem;
            font-size: 1.25rem;
            border-radius: 0.3rem;
        }

        .btn-light {
            color: #000;
            background-color: #f8f9fa;
            border-color: #f8f9fa;
        }

        .btn {
            transition: none;
        }

        .btn {
            display: inline-block;
            font-weight: 400;
            line-height: 1.5;
            color: #212529;
            text-align: center;
            text-decoration: none;
            vertical-align: middle;
            cursor: pointer;
            -webkit-user-select: none;
            -moz-user-select: none;
            user-select: none;
            background-color: transparent;
            border: 1px solid transparent;
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            border-radius: 0.25rem;
            transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }

        button,
        [type=button],
        [type=reset],
        [type=submit] {
            -webkit-appearance: button;
        }

        input,
        button,
        select,
        optgroup,
        textarea {
            margin: 0;
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
        }

        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }
    </style>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script>
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you confirm to remove the course?")) {
                confirm_value.value = "Yes";
            }
            else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
        function SuccessRemoveAlert() {

        }
    </script>

    <div class="text-center" style="background-position: center center; margin: 3%; background-repeat: repeat; background-attachment: fixed; font-size: 25px; border: 1px solid grey">
        <asp:DataList ID="dlMaterial" runat="server" DataKeyField="materialId" DataSourceID="SqlDataSource1" RepeatColumns="1" HorizontalAlign="Center" Width="100%" OnItemCommand="dlMaterial_ItemCommand" OnItemDataBound="dlMaterial_ItemDataBound" BorderStyle="None">
            <ItemTemplate>
                <table style="vertical-align: central;">
                    <tr>
                        <td class="trLeft" rowspan="3">
                            <asp:Label ID="lblName" runat="server" Enabled="False" Style="color: #f98006; font-weight: bold;" Text='<%# Eval("materialName") %>' Width="300px"></asp:Label>
                            <br />
                            <br />
                        </td>
                        <td rowspan="3" class="auto-style3">&nbsp;</td>
                        <td rowspan="3" class="auto-style2" align="left">
                            <asp:Image ID="imgEduImage" runat="server" Height="100px" ImageUrl='<%# Eval("profileImg") %>' Width="100px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="lblEdu" runat="server" Text='<%# Eval("eduName") %>' Width="300px"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr align="center">
                        <td class="trLeft">
                            <asp:Image ID="imgCourseImage" runat="server" Height="500px" ImageUrl='<%# Eval("materialImage") %>' Width="500px" />
                            <br />
                            <asp:Label ID="lblDescription" runat="server" Height="100px" Font-Size="20px" Text='<%# Eval("description") %>' Width="80%"></asp:Label>
                            <br />
                        </td>
                        <td class="trRight" colspan="3">
                            <br />
                            <h3 class="auto-style2">Material Included</h3>
                            <br />
                            <asp:Label ID="lblMaterialIncluded" runat="server" Text='<%# Eval("materialIncluded") %>' Width="90%" Font-Size="20px"></asp:Label>
                        </td>
                    </tr>
                    <tr align="center">
                        <td class="trLeft" style="font-weight: bold;">RM
                                <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price", "{0:F}") %>'></asp:Label>
                        </td>
                        <td colspan="3">
                            <div align="right">
                                <asp:Button ID="btnAddToCart" runat="server" CausesValidation="False" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 200px; background-color: #f98006; color: white" Text="ADD TO CART" CommandArgument='<%# Eval("materialId") %>' CommandName="addToCart" Visible="False" />
                                &nbsp;<asp:Button ID="btnRemove" runat="server" CausesValidation="False" CssClass="btn btn-light btn-lg rounded-pill" OnClientClick="Confirm()" Style="height: 47px; width: 165px; background-color: #f98006; color: white" Text="REMOVE" CommandArgument='<%# Eval("materialId") %>' CommandName="remove" />
                                &nbsp;<asp:Button ID="btnModify" runat="server" CausesValidation="False" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" Text="MODIFY" Width="163px" CommandArgument='<%# Eval("materialId") %>' CommandName="modify" />
                                &nbsp;
                                <br />
                                &nbsp;</div>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblStock" runat="server" Text='<%# Eval("stock") %>' Visible="False"></asp:Label>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM MaterialKit INNER JOIN Educator ON MaterialKit.eduId = Educator.eduId WHERE ([materialId] = @MaterialId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="MaterialId" QueryStringField="id" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>