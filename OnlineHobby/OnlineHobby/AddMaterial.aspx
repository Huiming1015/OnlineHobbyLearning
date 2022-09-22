<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddMaterial.aspx.cs" Inherits="OnlineHobby.AddMaterial" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgArt.ClientID%>').prop('src', e.target.result)
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

        .button2 {
            height: 45px;
            background-color: #ffedcf;
            color: black;
            border: 1px solid;
            font-size: 12pt;
            border-radius: 3px;
        }

        .button2:hover {
                background-color:#f5d8a4 ;
                color: black;
        }   
        .auto-style1 {
            width: 12px;
            height: 24px;
        }
        .auto-style2 {
            text-align: center;
            width: 12px;
        }
        .auto-style4 {
            height: 24px;
        }
        .auto-style6 {
            height: 24px;
            width: 408px;
        }
        .auto-style7 {
            width: 408px;
        }
        .auto-style8 {
            height: 24px;
            width: 455px;
        }
        .auto-style9 {
            text-align: left;
            vertical-align: top;
            width: 455px;
        }
        .auto-style10 {
            height: 24px;
            width: 18px;
        }
        .auto-style11 {
            text-align: left;
            vertical-align: top;
            width: 18px;
        }
        .auto-style12 {
            width: 18px;
        }
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="text-center div-background" style="background-position: center center;">
        <strong>
            <br />
            <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />
            <asp:Label ID="Label1" runat="server" CssClass="auto-style17" Text="ADD MATERIAL KIT" Style="font-size: xx-large;" BorderStyle="None" Font-Underline="False" Width="427px" ForeColor="Black"></asp:Label></strong><br />
        <table class="auto-style24" style="border: 2px solid #000000; vertical-align: central; background-color: #FFFFFF" align="center">

            <tr>
                <td class="auto-style7" rowspan="14">
                    <asp:Image ID="imgArt" runat="server" Height="350px" Width="300px" ImageAlign="Middle" />
                    <br />
                    <br />
                    <asp:FileUpload ID="imageUpload" runat="server" AllowMultiple="True" BorderStyle="None" Width="168px" onchange="ImagePreview(this);" />&nbsp;<span class="auto-style2"><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="imageUpload" ErrorMessage="Please upload material image!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Please upload artwork image!</asp:RequiredFieldValidator>
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="imageUpload" ErrorMessage="Only image files are allowed" ForeColor="Red" ValidationExpression=".*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$" Font-Size="Small" Display="Dynamic">*Only image files are allowed</asp:RegularExpressionValidator>
                    </span>
                </td>
                <td class="auto-style27" rowspan="14">&nbsp;</td>
                <td class="auto-style4"></td>
                <td class="auto-style1"></td>
                <td class="auto-style8"></td>
                <td class="auto-style10">&nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Material ID</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td class="auto-style9" style="font-size: large;">
                    <asp:Label ID="lblID" runat="server" CssClass="auto-style2"></asp:Label></td>
                <td class="auto-style11" style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Material Kit Name<br />
                </td>
                <td class="auto-style2" style="font-size: large;"><strong class="labelColumn">:</strong></td>
                <td style="font-size: large;" class="auto-style9">
                    <asp:TextBox ID="txtName" runat="server" Width="454px"></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="auto-style2" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtName" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Material kit name should not be empty"></asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Category</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td style="font-size: large;" class="auto-style9">
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
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="auto-style2" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="auto-style9">
                    &nbsp;</td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Description</td>
                <td class="labelColumn" style="font-size: large;"><strong>:<br />
                    <br />
                    <br />
                    <br />
                </strong></td>
                <td style="font-size: large;" class="auto-style9">
                    <asp:TextBox ID="txtDescription" runat="server" Height="103px" Width="459px" TextMode="MultiLine"></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDescription" ErrorMessage="The material kit description should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Material kit description should not be empty!</asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText">Material Include</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td style="font-size: large;" class="auto-style9">
                    <asp:TextBox ID="txtMaterialIncluded" runat="server" Height="76px" Width="458px" TextMode="MultiLine"></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="auto-style9">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtMaterialIncluded" ErrorMessage="The material included should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Material included description should not be empty!</asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>            
            <tr>
                <td class="labelText" style="font-size: large;">Price</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td class="auto-style9" style="font-size: large;">
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="labelColumn" Width="184px"></asp:TextBox>
                    <br />
                    <br />
                </td>
                <td class="auto-style11" style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td class="auto-style9" style="font-size: large;">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Price should not be empty!</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="validatePrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price must be number!" ForeColor="Red" Type="Double" Font-Size="Small" ValidationExpression="^(?:[1-9]\d*|0)?(?:\.\d+)?$" Display="Dynamic">*Price must be positive number!</asp:RegularExpressionValidator>
                </td>
                <td class="auto-style11" style="font-size: large;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">Stock</td>
                <td class="labelColumn" style="font-size: large;">:</td>
                <td style="font-size: large;" class="auto-style9">
                    <asp:TextBox ID="txtStock" runat="server" CssClass="labelColumn" Width="191px"></asp:TextBox><span class="auto-style2">units</span></td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText" style="font-size: large;">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="auto-style9">
                    <span class="auto-style2">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtStock" ErrorMessage="Stock should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Stock should not be empty!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="validateStock" runat="server" ControlToValidate="txtStock" ErrorMessage="Stock must be integer!" ForeColor="Red" Operator="DataTypeCheck" Type="Integer" Font-Size="Small" ValidationExpression="^[1-9]\d*$" Display="Dynamic">*Stock must be positive integer!</asp:RegularExpressionValidator>
                    </span></td>
                <td style="font-size: large;" class="auto-style11">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6"></td>
                <td class="auto-style4"></td>
                <td colspan="3" class="auto-style4"></td>
                <td class="auto-style10">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="5" style="text-align:right">
                    <asp:Button ID="btnReset" runat="server" Text="RESET" CausesValidation="false" Font-Bold="False" Font-Size="Large" Width="158px" OnClick="btnReset_Click" CssClass="button2" />
                    &nbsp;
                        &nbsp;
                        <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" Font-Bold="False" Font-Size="Large" Width="243px" CssClass="button2" />
                    <br />
                </td>
                <td style="text-align:right" class="auto-style12">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="5" style="text-align:right">
                    &nbsp;</td>
                <td style="text-align:right" class="auto-style12">
                    &nbsp;</td>
            </tr>
        </table>

    </div>
</asp:Content>
