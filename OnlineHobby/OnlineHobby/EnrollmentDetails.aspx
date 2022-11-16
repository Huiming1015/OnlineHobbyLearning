<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentDetails.aspx.cs" Inherits="OnlineHobby.EnrollmentDetails" MasterPageFile="~/NestedOrder.Master" %>

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
    <div class="d-flex justify-content-center align-content-center w-100 mt-5 mb-5 pt-5 pb-5" style="min-height: 550px;">
        <div class="container-fluid bg-white" style="margin-left: 5%; width: 90%">
            <asp:DataList ID="dlEnrollmentDetails" runat="server" DataSourceID="SqlEnrollmentDetails" Width="100%" Style="font-size: 18px" HorizontalAlign="Center" CellPadding="0" BorderStyle="None">
                <ItemTemplate>
                    <div class="row text-center">
                        <div class="col-md-11">
                            <h3 class="mt-1 pt-3 mb-1 pb-3" style="color: #011797; font-size: large;">Enrollment Details</h3>
                        </div>
                        <div class="col-md-1">
                            <asp:Label ID="lblEnrollmentId" runat="server" Font-Size="Large" Text='<%# Eval("enrollmentId") %>'></asp:Label>
                        </div>
                    </div>
                    <asp:DataList ID="dlCourse" runat="server" DataSourceID="SqlCourse" Width="100%" Style="font-size: 18px" HorizontalAlign="Center" CellPadding="0" BorderStyle="None">
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
                        </ItemTemplate>
                    </asp:DataList>
                    <br />
                    <div class="row">
                        <div class="col-2">Enrollment Date:&nbsp;</div>
                        <div class="col-md-2">
                            <asp:Label ID="lblEnrolDate" runat="server" Text='<%# Eval("enrolDate", "{0:d}") %>'></asp:Label>
                        </div>
                        <div class="col-md-8"></div>
                    </div>
                    <div class="row">
                        <div class="col-2">Enrollment Time:&nbsp;</div>
                        <div class="col-md-2">
                            <asp:Label ID="lblEnrolTime" runat="server" Text='<%# DateTime.Parse(Eval("enrolTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                        </div>
                        <div class="col-md-8"></div>
                    </div>
                    <asp:SqlDataSource ID="SqlCourse" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT Course.courseName, Course.courseImage, EnrolDetails.unitPrice, CourseSchedule.tutoringMode, EnrolDetails.scheduleId FROM EnrolDetails INNER JOIN CourseSchedule ON EnrolDetails.scheduleId = CourseSchedule.scheduleId JOIN Course ON Course.courseId = CourseSchedule.courseId WHERE (EnrolDetails.enrollmentId = @enrollmentId)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblEnrollmentId" Name="enrollmentId" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </ItemTemplate>
            </asp:DataList>

        </div>


        <asp:SqlDataSource ID="SqlEnrollmentDetails" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [EnrolledCourse] WHERE ([enrollmentId] = @enrollmentId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="enrollmentId" QueryStringField="enrollmentId" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    <asp:Label ID="lblEmpty" runat="server" Text="There are no any course enrollment for this payment id." Visible="False" Font-Size="XX-Large" Font-Bold="True"></asp:Label>

</asp:Content>
