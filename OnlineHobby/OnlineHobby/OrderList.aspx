<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderList.aspx.cs" Inherits="OnlineHobby.OrderList" MasterPageFile="~/PurchaseSellMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="Server">
        <div class="mt-5 mb-5" style="min-height:550px">
            <div class="w-100" align="center">
                Order Status :
                <asp:DropDownList ID="ddlOrderStatus" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlOrderStatus_SelectedIndexChanged">
                    <asp:ListItem Value="all">All</asp:ListItem>
                    <asp:ListItem Value="pending">Pending</asp:ListItem>
                    <asp:ListItem Value="confirmed">Confirmed</asp:ListItem>
                    <asp:ListItem Value="cancelled">Cancelled</asp:ListItem>
                    <asp:ListItem Value="cancelling">Cancelling</asp:ListItem>
                </asp:DropDownList>
                <asp:GridView ID="gvOrderList" runat="server" class="w-75 text-center mt-5 mb-5" AutoGenerateColumns="False" DataKeyNames="orderId" EmptyDataText="There are no data records to display." Font-Size="Large" BorderStyle="None" BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="10" CellSpacing="2" OnRowCommand="gvOrderList_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="Order ID">  
                            <ItemTemplate>  
                                <asp:Label ID="lblOrderID" runat="server" Text='<%# Bind("orderId") %>'></asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Order Date">    
                            <ItemTemplate>  
                                <asp:Label ID="lblOrderDate" runat="server" Text='<%# Bind("orderDate","{0:dd/MMMM/yyyy}") %>'></asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField HeaderText="Order Time">  
                            <ItemTemplate>  
                                <asp:Label ID="lblOrderTime" runat="server" Text='<%# Bind("orderTime") %>'></asp:Label>  
                            </ItemTemplate>  
                        </asp:TemplateField> 
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button Text="VIEW" runat="server" CommandName="view" BackColor="#FFDBB7" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CommandArgument='<%# Eval("orderId") %>'/>                               
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="#FFF0E1" ForeColor="#8C4510" />
                    <HeaderStyle BackColor="#FFF0E1" Font-Bold="True" ForeColor="Black" />
                    <PagerStyle ForeColor="#FFF0E1" HorizontalAlign="Center" />
                    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#FFF1D4" />
                    <SortedAscendingHeaderStyle BackColor="#B95C30" />
                    <SortedDescendingCellStyle BackColor="#F1E5CE" />
                    <SortedDescendingHeaderStyle BackColor="#93451F" />
                </asp:GridView>
            </div>
        </div>
</asp:Content>
