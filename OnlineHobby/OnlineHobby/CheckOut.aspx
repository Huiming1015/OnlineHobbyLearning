<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckOut.aspx.cs" Inherits="OnlineHobby.CheckOut" MasterPageFile="~/StudMaster.Master" %>


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
    </style>
    <div class="mt-2 mb-2" style="width: 90%; margin-left: 5%; min-height: 650px;">
        <h3 class="pt-3 pb-3" style="color: #011797; font-size: x-large; font-weight: bold; text-align: center">Checkout</h3>
        <hr />
        <div class="row">
            <div class="col-md-6 border-end">
                <h3 class="mt-1 pt-3 mb-1 pb-3" style="color: #011797; font-size: x-large; text-align: center">Order or Enrollment Details</h3>

                <div class="row text-center d-flex aligns-items-center justify-content-center">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <asp:Label runat="server" ID="lblTitleCourse" Style="font-size: large; color: #011797; text-align: center;">Course(s)</asp:Label>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <br />

                <asp:DataList ID="dlCartCourse" runat="server" DataSourceID="SqlCourse" Width="90%" Style="font-size: 15px" HorizontalAlign="Center" CellPadding="0" BorderStyle="None">
                    <ItemTemplate>
                        <div class="row text-center d-flex aligns-items-center justify-content-center">
                            <div class="col-md-2 border">
                                <asp:Image ID="imgCourse" runat="server" Height="70px" ImageUrl='<%# Eval("courseImage") %>' Width="70px" class="rounded" />
                            </div>
                            <div class="col-md-4 border d-flex align-items-center justify-content-center">
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
                            <div class="col-md-2 border d-flex align-items-center justify-content-center">
                                RM&nbsp;<asp:Label ID="lblCoursePrice" runat="server" Text='<%# Eval("price", "{0:F}") %>'></asp:Label>
                            </div>
                        </div>
                        <asp:SqlDataSource ID="SqlSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 1 [startTime], [endTime], [date] FROM ScheduleList WHERE (scheduleId = @scheduleId)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblScheduelId" Name="scheduleId" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="lblScheduelId" runat="server" Text='<%# Eval("scheduleId") %>' Visible="False"></asp:Label>
                        <asp:Label ID="lblCourseId" runat="server" Visible="False" Text='<%# Eval("courseId") %>'></asp:Label>
                        </div>            
                    </ItemTemplate>
                </asp:DataList>
                <br />
                <div class="row text-center d-flex aligns-items-center justify-content-center">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <asp:Label runat="server" ID="lblTitleMaterial" CssClass="mt-5 pt-3 mb-3 pb-3" Style="font-size: large; color: #011797; text-align: center">Material Kit(s)</asp:Label>
                    </div>
                    <div class="col-md-3"></div>
                </div>
                <br />
                <asp:DataList ID="dlCartMaterial" runat="server" DataSourceID="SqlMaterial" Style="font-size: 15px" Width="90%" HorizontalAlign="Center" CellPadding="0" BorderStyle="None">
                    <ItemTemplate>
                        <div class="row text-center d-flex aligns-items-center justify-content-center">
                            <div class="col-md-2 border">
                                <asp:Image ID="imgMaterial" runat="server" Height="70px" ImageUrl='<%# Eval("materialImage") %>' Width="70px" class="rounded" />
                            </div>
                            <div class="col-md-4 border d-flex align-items-center justify-content-center">
                                <asp:Label ID="lblMaterialName" runat="server" Text='<%# Eval("materialName") %>'></asp:Label>
                            </div>
                            <div class="col-md-4 border-top border-bottom d-flex align-items-center justify-content-center">
                                <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("quantity") %>'></asp:Label>
                            </div>
                            <div class="col-md-2 border d-flex align-items-center justify-content-center">
                                RM&nbsp;<asp:Label ID="lblMaterialPrice" runat="server" Text='<%# Eval("price", "{0:F}") %>'></asp:Label>
                            </div>
                        </div>
                        <asp:Label ID="lblMaterialId" runat="server" Visible="False" Text='<%# Eval("materialId") %>'></asp:Label>
                    </ItemTemplate>
                </asp:DataList>
                <br />
                <br />
                <div class="row" style="font-size: 18px">
                    <div class="col-md-6"></div>
                    <div class="col-md-3 text-end">Sub Total: RM&nbsp;</div>
                    <div class="col-md-3">
                        <asp:Label ID="lblSubTotal" runat="server" Visible="true" Text="0.00"></asp:Label>
                    </div>
                </div>
                <div class="row" style="font-size: 18px">
                    <div class="col-md-6"></div>
                    <div class="col-md-3 text-end">Discount: RM&nbsp;</div>
                    <div class="col-md-3 text-start">
                        <asp:Label ID="lblDiscount" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="row" style="font-size: 18px">
                    <div class="col-md-6"></div>
                    <div class="col-md-3 text-end">Total Amount :RM&nbsp;</div>
                    <div class="col-md-3 text-start">
                        <asp:Label ID="lblTotalAmount" runat="server"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <h3 class="mt-1 pt-3 mb-1 pb-3" style="color: #011797; font-size: x-large; text-align: center">Shipping Information</h3>
                <div>
                    <div class="row" style="font-size: 18px">
                        <div class="col-md-5 text-end">
                            Shipping Address:
                        </div>
                        <div class="col-md-7 text-start">
                            <asp:DropDownList ID="ddlAddress" runat="server" AutoPostBack="True" Width="400px" Style="border-color: lightgrey;" OnSelectedIndexChanged="ddlAddress_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                    </div>
                    <br />
                    <div class="row" style="font-size: 18px">
                        <div class="col-md-5 text-end">
                            Name:
                        </div>
                        <div class="col-md-7 text-start">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Width="400px"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5"></div>
                        <div class="col-7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*Name should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtName" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="*Name can only contains letter!" ControlToValidate="txtName" Font-Size="Small" ForeColor="Red" ValidationExpression="^[a-zA-Z][a-zA-Z ]*$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <br />
                    <div class="row" style="font-size: 18px">
                        <div class="col-md-5 text-end">
                            Phone Number:
                        </div>
                        <div class="col-md-7 text-start">
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" Width="400px"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5"></div>
                        <div class="col-7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Phone number should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtPhone" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Invalid phone number!" ControlToValidate="txtPhone" Font-Size="Small" ForeColor="Red" ValidationExpression="^(\+?6?01)[0-46-9]-*[0-9]{7,8}$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                    <br />
                    <div class="row" style="font-size: 18px">
                        <div class="col-md-5 text-end">
                            Address:
                        </div>
                        <div class="col-md-7 text-start">
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-5"></div>
                        <div class="col-7">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*Address should not be empty!" Font-Size="Small" Display="Dynamic" ControlToValidate="txtAddress" ForeColor="Red"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <br />
                    <br />
                    <div class="row" style="font-size: 18px">
                        <div class="col-md-5 text-end">
                            Payment Method:
                        </div>
                        <div class="col-md-7 text-start">
                            <asp:DropDownList ID="ddlPayMethod" runat="server">
                                <asp:ListItem Value="creditCard">Credit or Master Card</asp:ListItem>
                                <asp:ListItem Value="paypal">PayPal</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="col-md-1"></div>
            </div>
        </div>
        <hr />
        <br />
        <div class="text-end">
            <asp:Button ID="btnConfirm" runat="server" Text="CONFIRM" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 200px; background-color: #f98006; color: white" OnClick="btnConfirm_Click" />
        </div>

        <asp:SqlDataSource ID="SqlCourse" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Cart.cartId, CourseSchedule.price, CourseSchedule.scheduleId, Course.courseName, Course.courseId, Course.courseImage, Course.availability FROM Cart INNER JOIN CourseSchedule ON Cart.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId WHERE (Cart.studId = @StudId)">
            <SelectParameters>
                <asp:SessionParameter Name="StudId" SessionField="UserId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlMaterial" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT Cart.cartId, Cart.materialId, Cart.quantity, MaterialKit.materialId AS Expr1, MaterialKit.materialName, MaterialKit.price, MaterialKit.stock, MaterialKit.materialImage, MaterialKit.availability FROM Cart INNER JOIN MaterialKit ON Cart.materialId = MaterialKit.materialId"></asp:SqlDataSource>
    </div>
</asp:Content>

