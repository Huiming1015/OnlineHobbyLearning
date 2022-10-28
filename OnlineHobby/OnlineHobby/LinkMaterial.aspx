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

    <div style="border: 1px solid grey; padding: 20px; font-size: 20px; width: 90%; margin-left: 5%; margin-right: 5%; text-align: center">
        <h3 style="color: #990000; text-align: center;">Selects the material kits to link to the course</h3>
        <asp:DataList ID="dlMaterialKit" runat="server" DataSourceID="SqlDataSource1" HorizontalAlign="Center" RepeatDirection="Horizontal" RepeatColumns="5" CellSpacing="15">
            <ItemTemplate>
                <table style="width: 225px; font-size: 20px; border: 1px solid grey;">
                    <tr>
                        <td align="left">
                            <asp:CheckBox ID="cbMaterial" runat="server" OnCheckedChanged="cbMaterial_CheckedChanged" AutoPostBack="True" />
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:Image ID="imgMaterial" class="card-img-top" runat="server" Height="200px" Width="200px" ImageUrl='<%# Eval("materialImage") %>' BorderStyle="Solid" BorderWidth="3px" ImageAlign="Middle" />

                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center;" class="auto-style1">
                            <asp:Label ID="lblMaterialName" class="card-body" runat="server" Style="text-align: center !important" Font-Underline="False" Height="50px" ForeColor="#993333"><%# Eval("materialName") %> </asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">Discount Rate:
                                    <asp:TextBox ID="txtDiscount" runat="server" Width="60px" Enabled="False"></asp:TextBox>
                            %
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style1">
                            <asp:Label ID="lblMaterialId" runat="server" Text='<%# Eval("materialId") %>' Visible="False"></asp:Label>
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
