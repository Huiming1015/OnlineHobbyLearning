<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCourse.aspx.cs" Inherits="OnlineHobby.AddCourse" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <style type="text/css">
        tr {
            width: 35%;
            text-align: right;
        }

        .trInput {
            text-align: left;
            padding-left: 10px;
        }

        .auto-style1 {
            height: 34px;
        }

        .auto-style2 {
            text-align: left;
            padding-left: 10px;
            height: 34px;
        }

        .div-background {
            background-color: #fffefa;
        }
    </style>

    <script type="text/javascript">
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgCourse.ClientID%>').prop('src', e.target.result)
                        .width(300)
                        .height(350);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>

    <div style="border: 1px solid grey; padding: 20px; font-size: 20px; width: 90%; margin: 5%; text-align: center">
        <asp:Label runat="server" Style="color: #f98006; font-size: x-large; text-align: center; font-weight: bold; text-decoration: underline" ID="lblTitle"></asp:Label>
        <div>
            <asp:Image ID="imgCourse" runat="server" Height="250px" Width="250px" ImageAlign="Middle" />
            <br />
            <br />
            <asp:FileUpload ID="imageUpload" runat="server" AllowMultiple="True" BorderStyle="None" Width="168px" onchange="ImagePreview(this);" Style="display: inline !important;" CssClass="form-control" />&nbsp;<span><br />
                <asp:RequiredFieldValidator ID="requireImage" runat="server" ControlToValidate="imageUpload" ErrorMessage="Please upload course image!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Please upload course image!</asp:RequiredFieldValidator>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="imageUpload" ErrorMessage="Only image files are allowed" ForeColor="Red" ValidationExpression=".*\.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP]|[pP][nN][gG])$" Font-Size="Small" Display="Dynamic">*Only image files are allowed</asp:RegularExpressionValidator>
            </span>
        </div>
        <br />
        <div align="center">
            <table>
                <tr>
                    <td>Course Name:</td>
                    <td class="trInput">
                        <asp:TextBox ID="txtName" runat="server" Width="300px" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="trInput">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ControlToValidate="txtName" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Course name should not be empty"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Description:</td>
                    <td class="trInput">
                        <asp:TextBox ID="txtDescription" runat="server" Height="100px" TextMode="MultiLine" Width="500px" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="trInput">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ControlToValidate="txtDescription" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Description should not be empty"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Learning Outcome:</td>
                    <td class="trInput">
                        <asp:TextBox ID="txtOutcome" runat="server" TextMode="MultiLine" Height="100px" Width="500px" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="trInput">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ControlToValidate="txtOutcome" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Learning outcome should not be empty"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Category:</td>
                    <td class="trInput">
                        <asp:DropDownList ID="ddlCategory" runat="server" Width="300px" style="border-color:gainsboro; height:40px;">
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
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="trInput">&nbsp;</td>
                </tr>
                <tr>
                    <td>Total Class per Schedule:</td>
                    <td class="trInput">
                        <asp:TextBox ID="txtTotalClass" runat="server" CssClass="form-control"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="trInput">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ControlToValidate="txtTotalClass" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Total class should not be empty"></asp:RequiredFieldValidator>
                        <span>
                            <asp:RegularExpressionValidator ID="validateStock1" runat="server" ControlToValidate="txtTotalClass" ErrorMessage="total class must be integer!" ForeColor="Red" Operator="DataTypeCheck" Type="Integer" Font-Size="Small" ValidationExpression="^([0]?[1-9]|1[0-5])$" Display="Dynamic">*Total class must be positive integer!</asp:RegularExpressionValidator>
                        </span></td>
                </tr>
                <tr>
                    <td class="auto-style1">Age Range:</td>
                    <td class="auto-style2">
                        <div class="row">
                            <div class="col-md-3">
                                <asp:TextBox ID="txtMinAge" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="col-md-1">
                                to
                            </div>
                            <div class="col-md-3">
                                <asp:TextBox ID="txtMaxAge" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td class="trInput">
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="txtMinAge" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Minimum age should not be empty"></asp:RequiredFieldValidator>
                        <span>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtMinAge" Display="Dynamic" ErrorMessage="*Minimum age must between 1 to 100!" Font-Size="Small" ForeColor="Red" MaximumValue="100" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                        </span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ControlToValidate="txtMaxAge" Display="Dynamic" Font-Size="Small" ForeColor="Red" Text="*Maximum age should not be empty"></asp:RequiredFieldValidator>
                        <span>
                            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtMaxAge" Display="Dynamic" ErrorMessage="*Maximum age must between 1 to 100!" Font-Size="Small" ForeColor="Red" MaximumValue="100" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtMinAge" ControlToValidate="txtMaxAge" Display="Dynamic" ErrorMessage="*Maximum age must greater than minimum age" Font-Size="Small" ForeColor="Red" Operator="GreaterThanEqual" Type="Integer"></asp:CompareValidator>
                        </span></td>
                </tr>
            </table>
        </div>
        <div class="text-center" align="right">
            <asp:Button ID="btnReset" runat="server" Text="RESET" CausesValidation="false" OnClick="btnReset_Click" CssClass="button btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white; border-color: transparent" />
            &nbsp;
                        &nbsp;
                        <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="button btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white; border-color: transparent" />
            <br />
        </div>
    </div>
</asp:Content>
