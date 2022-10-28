<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCourse.aspx.cs" Inherits="OnlineHobby.AddCourse" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
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
                    $('#<%=imgArt.ClientID%>').prop('src', e.target.result)
                        .width(300)
                        .height(350);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

    </script>

        <div style="border: 1px solid grey; padding: 20px; font-size: 20px; width: 90%; margin:5%; text-align: center">
            <h1 runat="server" style="color: #f98006; font-size: x-large; text-align: center; font-weight: bold; text-decoration: underline;">ADD COURSE</h1>
            <div>
                <asp:Image ID="imgArt" runat="server" Height="250px" Width="250px" ImageAlign="Middle" />
                <br />
                <br />
                <asp:FileUpload ID="imageUpload" runat="server" AllowMultiple="True" BorderStyle="None" Width="168px" onchange="ImagePreview(this);" />&nbsp;<span><br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="imageUpload" ErrorMessage="Please upload material image!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Please upload artwork image!</asp:RequiredFieldValidator>
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
                            <asp:TextBox ID="txtName" runat="server" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="trInput">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Description:</td>
                        <td class="trInput">
                            <asp:TextBox ID="txtDescription" runat="server" Height="100px" TextMode="MultiLine" Width="500px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="trInput">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Learning Outcome:</td>
                        <td class="trInput">
                            <asp:TextBox ID="txtOutcome" runat="server" TextMode="MultiLine" Height="100px" Width="500px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="trInput">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Category:</td>
                        <td class="trInput">
                            <asp:DropDownList ID="ddlCategory" runat="server" Width="300px">
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
                            <asp:TextBox ID="txtTotalClass" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="trInput">&nbsp;</td>
                    </tr>
                    <tr>
                        <td>Class Duration:</td>
                        <td class="trInput">
                            <asp:TextBox ID="txtDuration" runat="server"></asp:TextBox>
                            &nbsp;minutes</td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="trInput">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Age Range:</td>
                        <td class="auto-style2">
                            <asp:TextBox ID="txtMinAge" runat="server"></asp:TextBox>
                            &nbsp;to
                            <asp:TextBox ID="txtMaxAge" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td class="trInput">&nbsp;</td>
                    </tr>
                </table>
            </div>
            <div class="text-center" align="right">
                <asp:Button ID="btnReset" runat="server" Text="RESET" CausesValidation="false" OnClick="btnReset_Click" CssClass="button btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white; border-color:transparent"/>
                &nbsp;
                        &nbsp;
                        <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="button btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white; border-color:transparent"/>
                <br />
            </div>
        </div>
</asp:Content>
