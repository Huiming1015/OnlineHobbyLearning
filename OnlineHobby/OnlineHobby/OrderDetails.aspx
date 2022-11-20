<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="OnlineHobby.OrderDetails" MasterPageFile="~/NestedOrder.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
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
    <div class="w-100 mt-5 mb-5" style="min-height:550px">
        <asp:Label ID="lblEmpty" runat="server" Text="There are no any course enrollment for this payment id." Visible="False" Font-Size="XX-Large" Font-Bold="True" Width="100%" CssClass="text-center"></asp:Label>
        <div class="container-fluid bg-white div-background" style="margin-left: 5%; width: 90%">
            <asp:DataList runat="server" ID="dlOrderDetails" DataSourceID="SqlDataSource1" RepeatColumns="1" Width="100%" Font-Size="18px" OnItemDataBound="dlOrderDetails_ItemDataBound" HorizontalAlign="Center" RepeatDirection="Horizontal">
                <ItemTemplate>
                    <div class="row">
                        <div class="col-md-5">
                            <div class="row">
                                <div class="col-md-4"></div>
                                <div class="col-md-4">
                                    <h3 class="mt-1 pt-3 mb-1 pb-3" style="color: #011797; font-size: large; text-align: center">Shipping Details</h3>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                            <div class="row">
                                <div class="col-4">Name</div>
                                <div class="col-1">:</div>
                                <div class="col-md-7">
                                    <asp:Label ID="lblShipName" runat="server" Text='<%# Eval("shipName") %>'></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4">Phone Number</div>
                                <div class="col-1">:</div>
                                <div class="col-md-7">
                                    <asp:Label ID="lblShipPhone" runat="server" Text='<%# Eval("shipPhone") %>'></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-4">Address</div>
                                <div class="col-1">:</div>
                                <div class="col-md-7">
                                    <asp:Label ID="lblShipAddress" runat="server" Text='<%# Eval("shipAddress") %>'></asp:Label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2"></div>
                        <div class="col-md-5 mt-5">
                            <div class="row">
                                <div class="col-5">Order ID</div>
                                <div class="col-1">:</div>
                                <div class="col-md-6">
                                    <asp:Label ID="lblOrderID" runat="server" Text='<%# Eval("orderId") %>'></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5">Order Status</div>
                                <div class="col-1">:</div>
                                <div class="col-md-6">
                                    <asp:Label ID="lblOrderStatus" runat="server" Text='<%# Eval("orderStatus") %>'></asp:Label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5">Express Company</div>
                                <div class="col-1">:</div>
                                <div class="col-md-6">
                                    <asp:Label ID="lblExpress" runat="server" Text='<%# Eval("expressCompany") %>'></asp:Label>
                                    <asp:DropDownList ID="ddlExpress" runat="server">
                                        <asp:ListItem Value="posLaju">Pos Laju</asp:ListItem>
                                        <asp:ListItem Value="jAndT">J&amp;T Express</asp:ListItem>
                                        <asp:ListItem Value="gdex">GDex Express</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5">Tracking Number</div>
                                <div class="col-1">:</div>
                                <div class="col-md-6">
                                    <asp:Label ID="lblTrackingNum" runat="server" Text='<%# Eval("trackingNum") %>'></asp:Label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row text-center d-flex aligns-items-center justify-content-center">
                        <div class="col-md-3"></div>
                        <div class="col-md-6">
                            <asp:Label runat="server" ID="lblOrder" CssClass="mt-5 pt-3 mb-3 pb-3" Style="font-size: large; color: #011797; text-align: center">Order Details</asp:Label>
                        </div>
                        <div class="col-md-3"></div>
                    </div>
                    <br />
                    <asp:DataList ID="dlMaterial" runat="server" Style="font-size: 18px" Width="100%" HorizontalAlign="Center" CellPadding="0" BorderStyle="None" DataSourceID="SqlMaterial">
                        <ItemTemplate>
                            <div class="row text-center d-flex aligns-items-center justify-content-center">
                                <div class="col-md-2 border">
                                    <asp:Image ID="imgMaterial" runat="server" Height="70px" ImageUrl='<%# Eval("materialImage") %>' Width="70px" class="rounded" />
                                </div>
                                <div class="col-md-4 border d-flex align-items-center justify-content-center">
                                    <asp:Label ID="lblMaterialName" runat="server" Text='<%# Eval("materialName") %>'></asp:Label>
                                </div>
                                <div class="col-md-3 border-top border-bottom d-flex align-items-center justify-content-center">
                                    <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                                </div>
                                <div class="col-md-3 border d-flex align-items-center justify-content-center">
                                    RM&nbsp;<asp:Label ID="lblMaterialPrice" runat="server" Text='<%# Eval("unitPrice", "{0:F}") %>'></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlMaterial" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT MaterialKit.materialName, MaterialKit.materialImage, OrderDetails.quantity, OrderDetails.unitPrice FROM MaterialKit INNER JOIN OrderDetails ON MaterialKit.materialId = OrderDetails.materialId WHERE (OrderDetails.orderId = @OrderId)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblOrderID" Name="OrderId" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <br />
                    <div class="row">
                        <div class="col-2">Order Date:&nbsp;</div>
                        <div class="col-md-2">
                            <asp:Label ID="lblOrderDate" runat="server" Text='<%# Eval("orderDate", "{0:d}") %>'></asp:Label>
                        </div>
                        <div class="col-md-8"></div>
                    </div>
                    <div class="row">
                        <div class="col-2">Order Time:&nbsp;</div>
                        <div class="col-md-2">
                            <asp:Label ID="lblOrderTime" runat="server" Text='<%# DateTime.Parse(Eval("orderTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                        </div>
                        <div class="col-md-8"></div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-2">
                            <asp:Label ID="lblCancel" runat="server" Text='Cancel Reason: ' Font-Bold="True"></asp:Label></div>
                        <div class="col-md-6">
                            <asp:Label ID="lblCancelReason" runat="server" Text='<%# Eval("cancelReason") %>'></asp:Label>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 1 Shipment.shipmentId, Shipment.orderId AS Expr1, Shipment.shipName, Shipment.shipPhone, Shipment.shipAddress, Shipment.expressCompany, Shipment.trackingNum, MaterialOrder.orderId, MaterialOrder.studId, MaterialOrder.orderDate, MaterialOrder.orderTime, MaterialOrder.orderStatus, MaterialOrder.cancelReason FROM Shipment INNER JOIN MaterialOrder ON Shipment.orderId = MaterialOrder.orderId WHERE (MaterialOrder.orderId = @orderId)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="orderId" QueryStringField="orderId" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel ID="Panel1" runat="server">
                <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1"
                        CancelControlID="Button2" BackgroundCssClass="Background" TargetControlID="hiddenPopupTarget">
                    </cc1:ModalPopupExtender>
                    <asp:Button ID="hiddenPopupTarget" runat="server" Style="display: none;" />
                    <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                        <asp:Panel ID="Panel4" runat="server" align="right" Style="padding-right: 10px">
                            <asp:Button ID="Button2" runat="server" Text="X" Style="background-color: #f98006; color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" />
                        </asp:Panel>
                        <iframe style="width: 700px; height: 530px;" id="irm1" src="CancelForm.aspx" runat="server"></iframe>
                    </asp:Panel>
                </div>
            </asp:Panel>
            <div style="margin-top: 10%;" class="mb-1">
                <div class="row pe-5">
                    <div class="col-md-8"></div>
                    <div class="col-md-2 text-end">
                        <asp:Button ID="btnConfirm" runat="server" Text="CONFIRM" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 150px; background-color: #f98006; color: white" OnClick="btnConfirm_Click" />
                    </div>
                    <div class="col-md-2 text-end">
                        <asp:Button ID="btnCancel" runat="server" Text="CANCEL" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 150px; background-color: #f98006; color: white" OnClick="btnCancel_Click" />
                    </div>
                </div>
                <div class="row pe-5">
                    <div class="col-md-8"></div>
                    <div class="col-md-2 text-end">
                        <asp:Button ID="btnApprove" runat="server" Text="APPROVE" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 150px; background-color: #f98006; color: white" Visible="False" OnClick="btnApprove_Click" />
                    </div>
                    <div class="col-md-2 text-end">
                        <asp:Button ID="btnReject" runat="server" Text="REJECT" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 150px; background-color: #f98006; color: white" Visible="False" OnClick="btnReject_Click" />
                    </div>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
