<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PaymentDetails.aspx.cs" Inherits="OnlineHobby.PaymentDetails" MasterPageFile="~/NestedOrder.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <div class="div-background w-100 mt-5 mb-5" style="min-height: 550px;">
        <div class="row text-center">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <h3 class="mt-1 pt-3 mb-1 pb-3" style="color: #011797; font-size: large;">Course(s)</h3>
            </div>
            <div class="col-md-3"></div>
        </div>
        <asp:DataList ID="dlCourse" runat="server" DataSourceID="SqlCourse" Width="90%" Style="font-size: 18px" HorizontalAlign="Center" CellPadding="0" BorderStyle="None">
            <ItemTemplate>
                <div class="row text-center d-flex aligns-items-center justify-content-center">
                    <div class="col-md-2 border">
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
                    <div class="col-md-2 border d-flex align-items-center justify-content-center">
                        <asp:Label ID="lblTutoringMode" runat="server" Text='<%# Eval("tutoringMode") %>'></asp:Label>
                    </div>
                    <div class="col-md-1 border d-flex align-items-center justify-content-center">
                        RM&nbsp;<asp:Label ID="lblCoursePrice" runat="server" Text='<%# Eval("unitPrice", "{0:F}") %>'></asp:Label>
                    </div>
                </div>
                <asp:SqlDataSource ID="SqlSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 1 [startTime], [endTime], [date] FROM ScheduleList WHERE (scheduleId = @scheduleId)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblScheduelId" Name="scheduleId" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:Label ID="lblScheduelId" runat="server" Text='<%# Eval("scheduleId") %>' Visible="False"></asp:Label>
                </div>            
            </ItemTemplate>
        </asp:DataList>
        <br />
        <div class="row text-center d-flex aligns-items-center justify-content-center">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <asp:Label runat="server" ID="lblOrder" CssClass="mt-5 pt-3 mb-3 pb-3" Style="font-size: large; color: #011797; text-align: center">Material Kit(s)</asp:Label>
            </div>
            <div class="col-md-3"></div>
        </div>
        <br />
        <asp:DataList ID="dlMaterial" runat="server" Style="font-size: 18px" Width="90%" HorizontalAlign="Center" CellPadding="0" BorderStyle="None" DataSourceID="SqlMaterial">
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
        <br />
        <asp:DataList ID="dlPaymentDetails" runat="server" DataKeyField="paymentId" DataSourceID="SqlPayment" Width="100%" Font-Size="18px" OnItemDataBound="dlPaymentDetails_ItemDataBound">
            <ItemTemplate>
                <div class="row">
                    <div class="col-md-7"></div>
                    <div class="col-md-2">Sub Total</div>
                    <div class="col-md-3">
                        :&nbsp;<asp:Label ID="lblSubTotal" runat="server" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-7"></div>
                    <div class="col-md-2">Discount</div>
                    <div class="col-md-3">
                        :&nbsp;<asp:Label ID="lblDiscount" runat="server" Text='<%# Eval("discountAmount", "{0:F}") %>' />
                    </div>
                </div>

                    <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-2">Amount Paid</div>
                        <div class="col-md-3">
                            :&nbsp;<asp:Label ID="lblTotalPayment" runat="server" Text='<%# Eval("paymentAmount", "{0:F}") %>' />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-2">Payment Date</div>
                        <div class="col-md-3">
                            :&nbsp;<asp:Label ID="lblPaymentDate" runat="server" Text='<%# Eval("paymentDate", "{0:dd/MMMM/yyyy}") %>' />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-2">Payment Time</div>
                        <div class="col-md-3">
                            :&nbsp;<asp:Label ID="lblPaymentTime" runat="server" Text='<%# DateTime.Parse(Eval("paymentTime").ToString()).ToString("hh:mm tt") %>' />
                        </div>
                    </div>
                    <br />
                     <div class="row">
                        <div class="col-md-7"></div>
                        <div class="col-md-2"><asp:Label ID="lblRefundTitle" runat="server" Text='Refunded Amount' Visible="false"/></div>
                        <div class="col-md-3">
                            <asp:Label ID="lblRefundTitle2" runat="server" Text=': RM ' Visible="false"/><asp:Label ID="lblRefundAmount" runat="server" Text='<%# Eval("refundAmount", "{0:F}") %>' Visible="false"/>
                        </div>
                    </div>
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlPayment" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Payment] WHERE ([paymentId] = @paymentId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="paymentId" QueryStringField="paymentId" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlMaterial" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT MaterialKit.materialName, MaterialKit.materialImage, OrderDetails.quantity, OrderDetails.unitPrice FROM MaterialKit INNER JOIN OrderDetails ON MaterialKit.materialId = OrderDetails.materialId INNER JOIN MaterialOrder ON OrderDetails.orderId = MaterialOrder.orderId WHERE (MaterialOrder.paymentId = @PaymentId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="PaymentId" QueryStringField="paymentId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlCourse" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT Course.courseName, Course.courseImage, EnrolDetails.unitPrice, CourseSchedule.tutoringMode, EnrolDetails.scheduleId FROM EnrolDetails INNER JOIN CourseSchedule ON EnrolDetails.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON Course.courseId = CourseSchedule.courseId INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId = EnrolledCourse.enrollmentId WHERE (EnrolledCourse.paymentId = @PaymentId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="PaymentId" QueryStringField="paymentId" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
