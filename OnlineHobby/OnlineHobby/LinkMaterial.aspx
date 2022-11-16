<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LinkMaterial.aspx.cs" Inherits="OnlineHobby.LinkMaterial" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .auto-style1 {
            width: 219px;
        }
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div style="border: 1px solid grey; padding: 20px; font-size: 20px; width: 90%; margin-left: 5%; margin-right: 5%; text-align: center; min-height:610px;">
        <h3 style="color: #990000; text-align: center;">Selects the material kits to link to the course</h3>
        <p style="font-size:small; color:#808080;">Leave the Discount Rate field blank when you do not need to link material kit and course</p>
        <asp:DataList ID="dlMaterialKit" runat="server" DataSourceID="SqlDataSource1" HorizontalAlign="Center" RepeatDirection="Horizontal" RepeatColumns="5" CellSpacing="30" CellPadding="5">
            <ItemTemplate>
                <table style="width: 225px; font-size: 20px; border: 1px solid grey; margin-right:15px;">
                    <tr>
                        <td class="auto-style1">
                            <asp:Image ID="imgMaterial" class="card-img-top" runat="server" Height="200px" Width="200px" ImageUrl='<%# Eval("materialImage") %>' BorderStyle="Solid" BorderWidth="3px" ImageAlign="Middle" />

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center; height:60px;">
                            <asp:Label ID="lblMaterialName" class="card-body" runat="server" Style="text-align: center !important" Font-Underline="False" ForeColor="#993333"><%# Eval("materialName") %> </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Discount Rate:<asp:DataList ID="dlDiscount" runat="server" DataSourceID="sqlDiscount" RepeatColumns="1" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtDiscount" runat="server" Text='<%# Eval("discount") %>' Width="60px"></asp:TextBox>
                                            %                                           
                                            <br />
                                            <span>
                                            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtDiscount" Display="Dynamic" ErrorMessage="*Discount Rate must between 1 to 100!" Font-Size="Small" ForeColor="Red" MaximumValue="100" MinimumValue="0" Type="Integer"></asp:RangeValidator>
                                            </span>                                           
                                        </ItemTemplate>
                            </asp:DataList>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:Label ID="lblMaterialId" runat="server" Text='<%# Eval("materialId") %>' Visible="False"></asp:Label>
                            <asp:SqlDataSource ID="sqlDiscount" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ISNULL((SELECT [discountRate] FROM [Discount] WHERE (([courseId] = @courseId) AND ([materialId] = @materialId))),0) AS discount">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="courseId" QueryStringField="courseId" Type="String" />
                                    <asp:ControlParameter ControlID="lblMaterialId" Name="materialId" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [materialId], [materialName], [materialImage] FROM [MaterialKit] WHERE (([eduId] = @eduId) AND ([availability] = 'available'))">
            <SelectParameters>
                <asp:SessionParameter Name="eduId" SessionField="UserId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div align="right">
            <asp:Button ID="btnFinish" runat="server" Text="Finish" OnClick="btnFinish_Click" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" />
        </div>
    </div>
</asp:Content>
