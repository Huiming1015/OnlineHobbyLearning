<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnrolledCourseList.aspx.cs" Inherits="OnlineHobby.EnrolledCourseList" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container mt-2 mb-2 align-content-center" style="width: 90%; margin-left: 5%;">
        <div class="row g-0">
            <div class="col-md-2">
                <asp:Button ID="btnMyCourse" runat="server" Text="My Course" CssClass="border-1 w-100" BackColor="#FFF0E1" BorderColor="Black" Font-Size="Large" />
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnTimetable" runat="server" Text="Timetable" CssClass="border-1 w-100" BackColor="#FFF0E1" BorderColor="Black" Font-Size="Large" OnClick="btnTimetable_Click" />
            </div>
            <div class="col-md-6"></div>
        </div>
        <div class="border border-dark">

            <div class="mt-5 mb-5" style="min-height: 550px">
                <div class="w-100" align="center">
                    <asp:GridView ID="gvEnrolledList" runat="server" class="w-75 text-center mt-5 mb-5" AutoGenerateColumns="False" DataKeyNames="enrolDetailId" EmptyDataText="There are no data records to display." Font-Size="Large" BorderStyle="None" BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="10" CellSpacing="2" OnRowCommand="gvEnrolledList_RowCommand" DataSourceID="SqlDataSource1">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Image ID="imgCourseImage" runat="server" ImageUrl='<%# Bind("courseImage") %>' Height="50px" Width="50px"></asp:Image>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Course Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourseName" runat="server" Text='<%# Bind("courseName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Day">
                                <ItemTemplate>
                                    <asp:Label ID="lblDay" runat="server" Text='<%# Bind("day") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Educator">
                                <ItemTemplate>
                                    <asp:Label ID="lblEduName" runat="server" Text='<%# Bind("eduName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button Text="VIEW" runat="server" CommandName="view" BackColor="#FFDBB7" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CommandArgument='<%# Eval("enrolDetailId") %>' />
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
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT EnrolDetails.enrolDetailId, CourseSchedule.day, Course.courseName, Educator.eduName, Course.courseImage, EnrolDetails.scheduleId FROM EnrolDetails INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId = EnrolledCourse.enrollmentId INNER JOIN CourseSchedule ON EnrolDetails.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON Course.courseId = CourseSchedule.courseId INNER JOIN Educator ON Course.eduId = Educator.eduId WHERE (EnrolledCourse.studId = @StudId)">
                        <SelectParameters>
                            <asp:SessionParameter Name="StudId" SessionField="UserId" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
