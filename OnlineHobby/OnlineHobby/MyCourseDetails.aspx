<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyCourseDetails.aspx.cs" Inherits="OnlineHobby.MyCourseDetails" MasterPageFile="~/StudMaster.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script>
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you confirm to withdraw this course?")) {
                confirm_value.value = "Yes";
            }
            else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
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

    <div class="container border border-dark mt-2 mb-2 align-content-center" style="width: 90%; margin-left: 5%; min-height: 600px; font-size: 18px;">
        <h3 class="mt-3 pb-2 text-center" style="color: #f98006; font-weight: bold; font-size: xx-large;">Course Details</h3>
        <hr />
        <asp:DataList ID="dlCourseInfo" runat="server" DataKeyField="scheduleId" DataSourceID="SqlCourseInfo" Width="100%" CssClass="mt-3 mb-3" OnItemDataBound="dlCourseInfo_ItemDataBound">
            <ItemTemplate>
                <div class="row text-center d-flex aligns-items-center justify-content-center" style="min-height: 400px;">
                    <div class="col-md-6 border-end">
                        <div class="row">
                            <div class="col-12">
                                <asp:Image ID="imgCourse" runat="server" ImageUrl='<%# Eval("courseImage") %>' Height="250px" Width="250px" />
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-12">
                                <asp:Label ID="courseNameLabel" runat="server" Text='<%# Eval("courseName") %>' />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-3"></div>
                            <div class="col-4 text-start">
                                Tutoring Mode
                            </div>
                            <div class="col-4 text-start">
                                :&nbsp;<asp:Label ID="tutoringModeLabel" runat="server" Text='<%# Eval("tutoringMode") %>' />
                            </div>
                            <div class="col-1"></div>
                        </div>
                        <div class="row">
                            <div class="col-3"></div>
                            <div class="col-md-4 text-start">
                                Maximum Student
                            </div>
                            <div class="col-md-4 text-start">
                                :&nbsp;<asp:Label ID="maxStudLabel" runat="server" Text='<%# Eval("maxStud") %>' />
                            </div>
                            <div class="col-1"></div>
                        </div>
                        <div class="row">
                            <div class="col-3"></div>
                            <div class="col-md-4 text-start">
                                Enrollment Status
                            </div>
                            <div class="col-md-4 text-start">
                                :&nbsp;<asp:Label ID="lblEnrolStatus" runat="server" Text='<%# Eval("enrolStatus") %>' />
                            </div>
                            <div class="col-1"></div>
                        </div>
                        <asp:Label ID="lblScheduleId" runat="server" Text='<%# Eval("scheduleId") %>' Visible="false" />
                        <asp:Label ID="lblCourseId" runat="server" Text='<%# Eval("courseId") %>' Visible="false" />
                    </div>
                    <div class="col-md-6">
                        <h3 class="mt-3 mb-2 pb-2" style="color: #f98006; font-weight: bold; font-size: x-large;">Schedule List</h3>
                        <asp:GridView ID="gvScheduleList" runat="server" class="w-75 text-center mt-5 mb-5" AutoGenerateColumns="False" DataKeyNames="scheduleListId" EmptyDataText="There are no data records to display." Font-Size="Large" BorderStyle="None" BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="10" CellSpacing="2" HorizontalAlign="Center" DataSourceID="SqlScheduleList">
                            <Columns>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDate" runat="server" Text='<%# Bind("date", "{0: dd/MMMM/yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStartTime" runat="server" Text='<%# DateTime.Parse(Eval("startTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                        &nbsp;-&nbsp;
                                        <asp:Label ID="lblEndTime" runat="server" Text='<%# DateTime.Parse(Eval("endTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
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
                        <asp:SqlDataSource ID="SqlScheduleList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ScheduleList] WHERE ([scheduleId] = @scheduleId)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblScheduleId" Name="scheduleId" PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
            </ItemTemplate>
        </asp:DataList>
        <hr /><br />
        <asp:Label ID="lblRate" runat="server" Visible="False" Font-Size="Large"></asp:Label><br /><br />
        <asp:Label ID="lblComment" runat="server" Visible="False" Font-Size="Large"></asp:Label>
        <asp:SqlDataSource ID="SqlCourseInfo" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT EnrolDetails.enrolStatus, Course.courseId, Course.courseName, Course.courseImage, Course.totalClass, CourseSchedule.scheduleId, CourseSchedule.tutoringMode, CourseSchedule.maxStud FROM EnrolDetails INNER JOIN CourseSchedule ON EnrolDetails.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId WHERE (EnrolDetails.enrolDetailId = @enrolDetailId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="enrolDetailId" QueryStringField="enrolDetailId" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Panel ID="Panel1" runat="server">
            <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
                <%--rating popup--%>
                <cc1:ModalPopupExtender ID="mp2" runat="server" PopupControlID="Panl2" TargetControlID="btnRate"
                    CancelControlID="Button3" BackgroundCssClass="Background">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="Panl2" runat="server" CssClass="Popup" align="center" Style="display: none">
                    <asp:Panel ID="Panel6" runat="server" align="right" Style="padding-right: 10px">
                        <asp:Button ID="Button3" runat="server" Text="X" Style="background-color: #f98006; color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" />
                    </asp:Panel>
                    <iframe style="width: 600px; height: 530px;" id="Iframe1" src="CourseRate.aspx" runat="server"></iframe>
                </asp:Panel>

                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

                <%--modify timetable popup--%>
                <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1"
                    CancelControlID="Button2" BackgroundCssClass="Background" TargetControlID="btnModify">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                    <asp:Panel ID="Panel4" runat="server" align="right" Style="padding-right: 10px">
                        <asp:Button ID="Button2" runat="server" Text="X" Style="background-color: #f98006; color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" />
                    </asp:Panel>
                    <iframe style="width: 700px; height: 530px;" id="irm1" src="TimetableModifyForm.aspx" runat="server"></iframe>
                </asp:Panel>
            </div>
        </asp:Panel>
        <div class="row pe-5 mb-2">
            <div class="col-md-6">
            </div>
            <div class="col-md-3 text-end">
                <asp:Button ID="btnModify" runat="server" Text="MODIFY TIMETABLE" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 220px; background-color: #f98006; color: white" />
            </div>
            <div class="col-md-3 text-end">
                <asp:Button ID="btnWithdraw" runat="server" Text="WITHDRAW" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 220px; background-color: #f98006; color: white" OnClick="btnWithdraw_Click" OnClientClick="Confirm()" />
            </div>
        </div>
        <div class="row pe-5 mb-2">
            <div class="col-md-9"></div>
            <div class="col-md-3 text-end">
                <asp:Button ID="btnRate" runat="server" Text="RATE" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 220px; background-color: #f98006; color: white" />
            </div>
        </div>
        <br />
    </div>
</asp:Content>
