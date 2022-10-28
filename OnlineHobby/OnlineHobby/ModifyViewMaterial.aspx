<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifyViewMaterial.aspx.cs" Inherits="OnlineHobby.ModifyViewMaterial" MasterPageFile="~/StudMaster.Master" %>

<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script>
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("This will completely delete the project. Are you sure?")) {
                confirm_value.value = "Yes";
            }
            else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
        </script>
   <%--  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bluebird/3.3.5/bluebird.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script type="text/javascript" src='https://cdn.jsdelivr.net/sweetalert2/6.3.8/sweetalert2.min.js'></script>
    <link media="screen" rel="stylesheet" href='https://cdn.jsdelivr.net/sweetalert2/6.3.8/sweetalert2.min.css' />
    <link media="screen" rel="stylesheet" href='https://cdn.jsdelivr.net/sweetalert2/6.3.8/sweetalert2.css' />
    <script type="text/javascript">
        function Confirm(event) {
            swal({
                title: 'Do you want to delete ?',
                showCancelButton: true,
                showConfirmButton: true,
                confirmButtonText: 'Yes',
                cancelButtonText: 'No',
                confirmButtonClass: 'btn btn-success',
                cancelButtonClass: 'btn btn-danger',
                type: 'warning',
                buttonsStyling: false
            }).then(function (yes) {
                // Called if you click Yes.
                if (yes) {
                    // Make Ajax call.
                    swal('Deleted', '', 'success');
                }
            },
            function (no) {
                // Called if you click No.
                if (no == 'cancel') {
                    swal('Cancelled', '', 'error');
                }
                });
        }
    </script>--%>

    <style type="text/css">
        .labelText {
            text-align: right;
            vertical-align: top;
            width:200px;
        }

        .labelColumn {
            text-align: center;
            vertical-align: top;
            width:15px;
        }

        .columnImage {
            text-align: center;
            vertical-align: middle;
            width:250px;
        }

        .inputStyle {
            text-align: left;
            vertical-align: top;
            width:300px;
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
                background-color: #f5d8a4;
                color: black;
            }
        .auto-style1 {
            text-align: center;
            vertical-align: top;
            width: 456px;
        }
        .auto-style2 {
            text-align: center;
            vertical-align: middle;
            width: 253px;
        }
        .auto-style3 {
            text-align: center;
            vertical-align: middle;
            width: 456px;
        }
        .auto-style4 {
            width: 97px;
        }
    </style>
    <div class="text-center" style="background-position: center center; background-repeat: repeat; background-attachment: fixed; "><strong>
    <br />
   <asp:Label ID="Label1" runat="server" Text="MODIFY / REMOVE MATERIAL KIT" style="font-size: xx-large; text-align :center" BorderStyle="None" Font-Underline="False" width="768px" Font-Names="Gill Sans MT" ForeColor="#993333"></asp:Label></strong><br />
            <asp:DataList ID="dlMaterial" runat="server" DataKeyField="materialId" DataSourceID="SqlDataSource1" ForeColor="Black" HorizontalAlign="Center" OnItemCommand="dlMaterial_ItemCommand" BackColor="White">
                <ItemTemplate>
             <table style="border: 1px solid #000000; vertical-align: central; background-color: #FFFFFF">

            <tr>
                <td class="auto-style3" rowspan="15">
                    <asp:Image ID="imgArt" runat="server" Height="350px" Width="300px" ImageAlign="Middle" ImageUrl='<%# Eval("materialImage") %>' />
                    <br />
                    <br />
                    <asp:FileUpload ID="imageUpload" runat="server" AllowMultiple="True" BorderStyle="None" Width="168px" onchange="ImagePreview(this);" Visible="False" />&nbsp;<span class="auto-style2"><br />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="imageUpload" ErrorMessage="Please upload material image!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Please upload artwork image!</asp:RequiredFieldValidator>
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="imageUpload" ErrorMessage="Only image files are allowed" ForeColor="Red" ValidationExpression=".*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP]|[pP][nN][gG])$" Font-Size="Small" Display="Dynamic">*Only image files are allowed</asp:RegularExpressionValidator>
                    </span>
                </td>
                <td rowspan="15"></td>
                <td></td>
                <td></td>
                <td class="inputStyle"></td>
                <td class="auto-style4">&nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">Material ID</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td class="inputStyle" style="font-size: large;">
                    <asp:Label ID="lblID" runat="server" Text='<%# Eval("materialId") %>'></asp:Label></td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">&nbsp;</td>
                <td style="font-size: large;" class="labelColumn">&nbsp;</td>
                <td style="font-size: large;" class="inputStyle">
                    &nbsp;</td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">Material Kit Name<br /></td>
                <td style="font-size: large;"><strong class="labelColumn">:</strong></td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:TextBox ID="txtName" runat="server" Width="454px" Text='<%# Eval("materialName") %>' Enabled="False"></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">&nbsp;</td>
                <td style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtName" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Material kit name should not be empty"></asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">Category</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:DropDownList ID="ddlCategory" runat="server" Width="250px" Enabled="False">
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
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">&nbsp;</td>
                <td style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="inputStyle">
                    &nbsp;</td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">Description</td>
                <td class="labelColumn" style="font-size: large;"><strong>:<br />
                    <br />
                    <br />
                    <br />
                </strong></td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:TextBox ID="txtDescription" runat="server" Height="103px" Width="459px" TextMode="MultiLine" Enabled="False" Text='<%# Eval("description") %>'></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtDescription" ErrorMessage="The material kit description should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Material kit description should not be empty!</asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText">Material Include</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:TextBox ID="txtMaterialIncluded" runat="server" Height="76px" Width="458px" TextMode="MultiLine" Enabled="False" Text='<%# Eval("materialIncluded") %>'></asp:TextBox>
                    <br />
                </td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="labelText">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtMaterialIncluded" ErrorMessage="The material included should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Material included description should not be empty!</asp:RequiredFieldValidator>
                </td>
                <td style="font-size: large;"" class="auto-style4">
                    &nbsp;</td>
            </tr>            
            <tr>
                <td style="font-size: large;" class="labelText">Price</td>
                <td class="labelColumn" style="font-size: large;"><strong>:</strong></td>
                <td class="inputStyle" style="font-size: large;">
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="labelColumn" Width="184px" Enabled="False" Text='<%# Eval("price", "{0:0.00}") %>'></asp:TextBox>
                    <br />
                    <br />
                </td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td class="inputStyle" style="font-size: large;">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Price should not be empty!</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="validatePrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price must be number!" ForeColor="Red" Type="Double" Font-Size="Small" ValidationExpression="^(?:[1-9]\d*|0)?(?:\.\d+)?$" Display="Dynamic">*Price must be positive number!</asp:RegularExpressionValidator>
                </td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;" class="labelText">Stock</td>
                <td class="labelColumn" style="font-size: large;">:</td>
                <td style="font-size: large;" class="inputStyle">
                    <asp:TextBox ID="txtStock" runat="server" CssClass="labelColumn" Width="191px" Enabled="False" Text='<%# Eval("stock") %>'></asp:TextBox><span class="auto-style2">units</span></td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="font-size: large;">&nbsp;</td>
                <td class="labelColumn" style="font-size: large;">&nbsp;</td>
                <td style="font-size: large;" class="inputStyle">
                    <span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtStock" ErrorMessage="Stock should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Stock should not be empty!</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="validateStock" runat="server" ControlToValidate="txtStock" ErrorMessage="Stock must be integer!" ForeColor="Red" Operator="DataTypeCheck" Type="Integer" Font-Size="Small" ValidationExpression="^[1-9]\d*$" Display="Dynamic">*Stock must be positive integer!</asp:RegularExpressionValidator>
                    </span></td>
                <td style="font-size: large;" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1"></td>
                <td></td>
                <td colspan="3"></td>
                <td class="auto-style4">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="5" style="text-align:right">
                    <asp:Button ID="btnRemove" runat="server" CommandName="remove" Text="REMOVE" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" causesvalidation="false" OnClientClick="Confirm()" />
                    &nbsp;
                    <asp:Button ID="btnModify" runat="server" CommandName="modify"  CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" Text="MODIFY" Width="163px" causesvalidation="false" />
                    &nbsp; &nbsp; &nbsp;
                        <br />
                </td>
                <td style="text-align:right" class="auto-style4">
                    &nbsp;</td>
            </tr>
            <tr>
                <td colspan="5" style="text-align:right">
                    &nbsp;</td>
                <td style="text-align:right" class="auto-style4">
                    &nbsp;</td>
            </tr>
        </table>
            </ItemTemplate> 
                </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [MaterialKit] WHERE ([materialId] = @materialId)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="materialId" QueryStringField="id" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    <br /><br />
</asp:content>
