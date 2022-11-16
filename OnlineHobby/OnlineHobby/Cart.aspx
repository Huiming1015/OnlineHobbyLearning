<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineHobby.Cart" MasterPageFile="~/StudMaster.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
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

        .auto-style1 {
            --bs-gutter-x: 1.5rem;
            --bs-gutter-y: 0;
            display: flex;
            flex-wrap: wrap;
            margin-top: calc(-1 * var(--bs-gutter-y));
            margin-right: calc(-0.5 * var(--bs-gutter-x));
            margin-left: calc(-0.5 * var(--bs-gutter-x));
            width: 90%;
        }
    </style>

    <div style="margin-top: 3%; margin-bottom: 3%; width: 90%; margin-left: 5%; min-height: 650px;">
        <div style="width: 90%; margin-left: 5%;">
            <div class="row text-center d-flex aligns-items-center justify-content-center">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <asp:Label runat="server" ID="lblTitleCourse" Style="font-size: x-large; color: #011797; font-weight: bold; text-align: center;">Course(s)</asp:Label>
                </div>
                <div class="col-md-3"></div>
            </div>
            <br />
            <asp:DataList ID="dlCartCourse" runat="server" DataSourceID="SqlCourse" Width="100%" Style="font-size: 18px" HorizontalAlign="Center" CellPadding="0" BorderStyle="None" OnItemCommand="dlCartCourse_ItemCommand">
                <ItemTemplate>
                    <div class="row text-center d-flex aligns-items-center justify-content-center">
                        <div class="col-md-1 border">
                            <asp:Image ID="imgCourse" runat="server" Height="70px" ImageUrl='<%# Eval("courseImage") %>' Width="70px" class="rounded" />
                        </div>
                        <div class="col-md-3 border d-flex align-items-center justify-content-center">
                            <asp:Label ID="lblCourseName" runat="server" Text='<%# Eval("courseName") %>'></asp:Label>
                        </div>
                        <div class="col-md-4 border d-flex aligns-items-center justify-content-center">
                            <asp:DataList ID="dlTime" runat="server" DataSourceID="SqlSchedule" RepeatColumns="1" RepeatDirection="Horizontal">
                                <ItemTemplate>
                                    <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("date", "{0: dd/MMMM/yyyy}") %>'></asp:Label>&nbsp;
                                        (<asp:Label ID="lblStartTime" runat="server" Text='<%# DateTime.Parse(Eval("startTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                    &nbsp;to
                                            <asp:Label ID="lblEndTime" runat="server" Text='<%# DateTime.Parse(Eval("endTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>)
                                </ItemTemplate>
                            </asp:DataList>
                        </div>
                        <div class="col-md-1 border d-flex align-items-center justify-content-center">
                            RM&nbsp;<asp:Label ID="lblCoursePrice" runat="server" Text='<%# Eval("price", "{0:F}") %>'></asp:Label>
                        </div>
                        <div class="col-md-1 border d-flex align-items-center justify-content-center">
                            <asp:ImageButton ID="btnModify" runat="server" CommandArgument='<%# Eval("cartId") %>' CommandName="modify" Height="35px" ImageUrl="~/Resources/edit.png" Width="35px" />
                        </div>
                        <div class="col-md-1 border d-flex align-items-center justify-content-center">
                            <asp:ImageButton ID="btnRemove" runat="server" CommandArgument='<%# Eval("cartId") %>' CommandName="remove" Height="35px" ImageUrl="~/Resources/delete.png" Width="35px" />
                        </div>
                    </div>
                    <asp:SqlDataSource ID="SqlSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 1 [startTime], [endTime], [date] FROM ScheduleList WHERE (scheduleId = @scheduleId)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblScheduelId" Name="scheduleId" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Label ID="lblScheduelId" runat="server" Text='<%# Eval("scheduleId") %>' Visible="False"></asp:Label>
                    <asp:Label ID="lblCourseId" runat="server" Visible="False" Text='<%# Eval("courseId") %>'></asp:Label>
                    <asp:Label ID="lblNumEnrolled" runat="server" Visible="False" Text='<%# Eval("numEnrolled") %>'></asp:Label>
                    <asp:Label ID="lblMaxStud" runat="server" Visible="False" Text='<%# Eval("maxStud") %>'></asp:Label>
                    <asp:Label ID="lblAvailability" runat="server" Visible="False" Text='<%# Eval("availability") %>'></asp:Label>
                    </div>            
                </ItemTemplate>
            </asp:DataList>
        </div>
        <div style="width: 90%; margin-left: 5%;">
            <div class="row text-center d-flex aligns-items-center justify-content-center" style="margin-top: 5%;">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <asp:Image ID="imgCartEmpty" runat="server" ImageUrl="~/Resources/cartEmpty.png" Height="300px" Width="300px" ImageAlign="Middle" Visible="False" /><br />
                    <asp:Label runat="server" ID="lblNoItem" Style="font-size: x-large; margin-top: 50px; font-weight: bold; text-align: center;" Visible="False">Your cart is currently empty, let's add some items into cart!</asp:Label>
                </div>
                <div class="col-md-3"></div>
            </div>

            <div class="row text-center d-flex aligns-items-center justify-content-center">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <asp:Label runat="server" ID="lblTitleMaterial" CssClass="mt-5 pt-3 mb-3 pb-3" Style="font-size: x-large; color: #011797; font-weight: bold; text-align: center">Material Kit(s)</asp:Label>
                </div>
                <div class="col-md-3"></div>
            </div>
            <br />

            <asp:DataList ID="dlCartMaterial" runat="server" DataSourceID="SqlMaterial" Style="font-size: 18px" Width="100%" HorizontalAlign="Center" CellPadding="0" BorderStyle="None" OnItemCommand="dlCartMaterial_ItemCommand">
                <ItemTemplate>
                    <div class="row text-center d-flex aligns-items-center justify-content-center">
                        <div class="col-md-1 border">
                            <asp:Image ID="imgMaterial" runat="server" Height="70px" ImageUrl='<%# Eval("materialImage") %>' Width="70px" class="rounded" />
                        </div>
                        <div class="col-md-3 border d-flex align-items-center justify-content-center">
                            <asp:Label ID="lblMaterialName" runat="server" Text='<%# Eval("materialName") %>'></asp:Label>
                        </div>
                        <div class="col-md-1 border-top border-bottom d-flex align-items-center justify-content-center qty">
                            <asp:ImageButton ID="ibtnPlus" runat="server" CommandArgument='<%# Eval("cartId") %>' CommandName="minus" Height="25px" ImageUrl="~/Resources/minus.png" Width="25px" />
                        </div>
                        <div class="col-md-2 border-top border-bottom d-flex align-items-center justify-content-center">
                            <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                        </div>
                        <div class="col-md-1 border-top border-bottom d-flex align-items-center justify-content-center qty">
                            <asp:ImageButton ID="ibtnMinus" runat="server" CommandArgument='<%# Eval("cartId") %>' CommandName="plus" Height="25px" ImageUrl="~/Resources/plus.png" Width="25px" />
                        </div>
                        <div class="col-md-2 border d-flex align-items-center justify-content-center">
                            RM&nbsp;<asp:Label ID="lblMaterialPrice" runat="server" Text='<%# Eval("price", "{0:F}") %>'></asp:Label>
                        </div>
                        <div class="col-md-1 border d-flex align-items-center justify-content-center">
                            <asp:ImageButton ID="ibtnRemove" runat="server" CommandArgument='<%# Eval("cartId") %>' CommandName="remove" Height="35px" ImageUrl="~/Resources/delete.png" Width="35px" />
                        </div>
                    </div>
                    <asp:Label ID="lblStock" runat="server" Text='<%# Eval("stock") %>' Visible="false"></asp:Label>
                    <asp:Label ID="lblAvailability" runat="server" Text='<%# Eval("availability") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:DataList>
        </div>
        <div class="auto-style1" style="margin: 5%; margin-top: 10%">
            <div class="col-md-4 d-flex align-items-center justify-content-center" style="font-size: 20px">
                <asp:Label runat="server" ID="lblTitleSub" Text="Sub Total: RM&nbsp;"></asp:Label>
                <asp:Label ID="lblSubTotal" runat="server"></asp:Label>
            </div>
            <div class="col-md-7 text-end">
                <asp:Button ID="btnCheckout" runat="server" Text="CHECKOUT" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 200px; background-color: #f98006; color: white" OnClick="btnCheckout_Click" />
            </div>
            <div class="col-md-1"></div>
        </div>
        <asp:Panel ID="Panel1" runat="server">
            <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1"
                    CancelControlID="close" BackgroundCssClass="Background" TargetControlID="hiddenPopupTarget">
                </cc1:ModalPopupExtender>
                <asp:Button ID="hiddenPopupTarget" runat="server" Style="display: none;" />
                <asp:Button ID="close" runat="server" Style="display: none;" />
                <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                    <asp:Panel ID="Panel4" runat="server" align="right" Style="padding-right: 10px">
                        <asp:Button ID="btnClosePopUp" runat="server" Text="X" Style="background-color: #f98006; color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" OnClick="btnClosePopUp_Click" />
                    </asp:Panel>
                    <iframe style="width: 700px; height: 530px;" id="irm1" src="AddCourseToCart.aspx" runat="server"></iframe>
                </asp:Panel>
            </div>
        </asp:Panel>
        <asp:SqlDataSource ID="SqlCourse" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Cart.cartId, CourseSchedule.price, CourseSchedule.scheduleId, CourseSchedule.maxStud, CourseSchedule.numEnrolled, Course.courseName, Course.courseId, Course.courseImage, Course.availability FROM Cart INNER JOIN CourseSchedule ON Cart.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId WHERE (Cart.studId = @StudId)">
            <SelectParameters>
                <asp:SessionParameter Name="StudId" SessionField="UserId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlMaterial" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Cart.cartId, Cart.materialId, Cart.quantity, MaterialKit.materialId AS Expr1, MaterialKit.materialName, MaterialKit.price, MaterialKit.stock, MaterialKit.materialImage, MaterialKit.availability FROM Cart INNER JOIN MaterialKit ON Cart.materialId = MaterialKit.materialId"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    </div>
</asp:Content>
