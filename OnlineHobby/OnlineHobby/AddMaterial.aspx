<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddMaterial.aspx.cs" Inherits="OnlineHobby.AddMaterial" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script type="text/javascript">
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgMaterial.ClientID%>').prop('src', e.target.result)
                        .width(300)
                        .height(350);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>
    <style type="text/css">
        .labelText {
            text-align: right;
            vertical-align:top;
        }        }
        .labelColumn{
            text-align:center;
            vertical-align:top;
        }
        .inputStyle{
            text-align: left;
            vertical-align:top;
        }   

        .cssInputTr{
            text-align:left;
        }

        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div style="border: 1px solid grey; padding: 20px; font-size: 20px; width: 90%; margin:5%; text-align: center">
        <strong>
            <br />
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
            <asp:Label ID="lblTitle" runat="server"  Text="ADD MATERIAL KIT" Style="color: #f98006; font-size: x-large; text-align: center; font-weight: bold; text-decoration: underline" ></asp:Label></strong><br />
        <table style="background-color:#FFFFFF" align="center">

            <tr>
                <td rowspan="13" Width="350px">
                    <asp:Image ID="imgMaterial" runat="server" Height="350px" Width="300px" ImageAlign="Middle" />
                    <br />
                    <br />
                    <asp:FileUpload ID="imageUpload" runat="server" AllowMultiple="True" BorderStyle="None" Width="168px" onchange="ImagePreview(this);" />&nbsp;<span class="auto-style2"><br />
                        <asp:RequiredFieldValidator ID="requireImage" runat="server" ControlToValidate="imageUpload" ErrorMessage="Please upload material image!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Please upload material image!</asp:RequiredFieldValidator>
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="imageUpload" ErrorMessage="Only image files are allowed" ForeColor="Red" ValidationExpression=".*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP]|[pP][nN][gG])$" Font-Size="Small" Display="Dynamic">*Only image files are allowed</asp:RegularExpressionValidator>
                    </span>
                </td>
                <td rowspan="13">&nbsp;</td>
                <td></td>
                <td></td>
                <td class="cssInputTr">
                    <asp:Label ID="lblID" runat="server" Visible="False"></asp:Label></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Material Kit Name<br />
                </td>
                <td style="font-size: large;"><strong class="labelColumn">:&nbsp;</strong></td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:TextBox ID="txtName" runat="server" Width="454px"></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtName" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Material kit name should not be empty"></asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Category</td>
                <td class="labelColumn" style="font-size: large;"><strong>:&nbsp;</strong></td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:DropDownList ID="ddlCategory" runat="server" Width="250px">
                        <asp:ListItem Value="draw">Drawing & Painting</asp:ListItem>
                        <asp:ListItem Value="floral">Floral</asp:ListItem>
                        <asp:ListItem Value="sew">Sewing & Crochet</asp:ListItem>
                        <asp:ListItem Value="jewelleries">Jewelleries</asp:ListItem>
                        <asp:ListItem Value="music">Music</asp:ListItem>
                        <asp:ListItem Value="food">Food & Beverage</asp:ListItem>
                        <asp:ListItem Value="language">Language</asp:ListItem>
                        <asp:ListItem Value="cratt">Craft</asp:ListItem>
                        <asp:ListItem Value="others">Others</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="cssInputTr">
                    &nbsp;</td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Description</td>
                <td class="labelColumn" style="font-size: large;"><strong>:&nbsp;<br />
                    <br />
                    <br />
                    <br />
                </strong></td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:TextBox ID="txtDescription" runat="server" Height="103px" Width="459px" TextMode="MultiLine"></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDescription" ErrorMessage="The material kit description should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Material kit description should not be empty!</asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText">Material Include</td>
                <td class="labelColumn" style="font-size: large;"><strong>:&nbsp;</strong></td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:TextBox ID="txtMaterialIncluded" runat="server" Height="76px" Width="458px" TextMode="MultiLine"></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtMaterialIncluded" ErrorMessage="The material included should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Material included description should not be empty!</asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>            
            <tr>
                <td class="labelText" style="font-size: large;">Price</td>
                <td class="labelColumn" style="font-size: large;"><strong>:&nbsp;</strong></td>
                <td class="cssInputTr" style="font-size: large;">
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="labelColumn" Width="184px"></asp:TextBox>
                    <br />
                    <br />
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td class="cssInputTr" style="font-size: large;">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Price should not be empty!</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="validatePrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price must be number!" ForeColor="Red" Type="Double" Font-Size="Small" ValidationExpression="^(?:[1-9]\d*|0)?(?:\.\d+)?$" Display="Dynamic">*Price must be positive number!</asp:RegularExpressionValidator>
                </td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Stock</td>
                <td class="labelColumn" style="font-size: large;">:&nbsp;</td>
                <td style="font-size: large;" class="cssInputTr">
                    <asp:TextBox ID="txtStock" runat="server" CssClass="labelColumn" Width="191px"></asp:TextBox><span>units</span></td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="cssInputTr">
                    <span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtStock" ErrorMessage="Stock should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Stock should not be empty!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="validateStock" runat="server" ControlToValidate="txtStock" ErrorMessage="Stock must be integer!" ForeColor="Red" Operator="DataTypeCheck" Type="Integer" Font-Size="Small" ValidationExpression="^[1-9]\d*$" Display="Dynamic">*Stock must be positive integer!</asp:RegularExpressionValidator>
                    </span></td>
                <td style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td></td>
                <td></td>
                <td colspan="3"></td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td colspan="5" style="text-align:right">
                    <asp:Button ID="btnReset" runat="server" Text="RESET" CausesValidation="false" OnClick="btnReset_Click" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" />
                    &nbsp;
                        &nbsp;
                        <asp:Button ID="btnUpload" runat="server" Text="UPLOAD" OnClick="btnUpload_Click" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white"/>
                    <br />
                </td>
                <td style="text-align:right">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="5" style="text-align:right">
                    &nbsp;</td>
                <td style="text-align:right">
                    &nbsp;</td>
            </tr>
        </table>

    </div>
</asp:Content>
