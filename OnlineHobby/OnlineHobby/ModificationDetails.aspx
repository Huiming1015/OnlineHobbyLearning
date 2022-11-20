<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModificationDetails.aspx.cs" Inherits="OnlineHobby.ModificationDetails" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceholder1" runat="server">
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
    <div class="w-100 mt-5 mb-5 border" style="min-height: 550px">
        <div class="container-fluid bg-white div-background" style="margin-left: 5%; width: 90%">
            <asp:DataList runat="server" ID="dlModification" DataSourceID="SqlDataSource1" RepeatColumns="1" Width="100%" Font-Size="18px" HorizontalAlign="Center" RepeatDirection="Horizontal" DataKeyField="modificationId" OnItemCommand="dlModification_ItemCommand" OnItemDataBound="dlModification_ItemDataBound">
                <ItemTemplate>
                    
                    <div class="row text-center d-flex aligns-items-center justify-content-center" style="min-height: 400px;">
                        <div class="col-md-6 border-end">
                            From:&nbsp<asp:Label ID="lblStudName" runat="server" Text='<%# Eval("studName") %>' /><br />
                            <h3 class="pt-3 mb-1 pb-3" style="color: #f98006; font-weight: bold; text-align: center">Course Details</h3>
                            <br />
                            <div class="row">
                                <div class="col-12">
                                    <asp:Image ID="imgCourse" runat="server" ImageUrl='<%# Eval("courseImage") %>' Height="250px" Width="250px" />
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-12">
                                    <asp:Label ID="lblCourseName" runat="server" Text='<%# Eval("courseName") %>' />
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 text-start">
                            <br />
                            <h3 class="pt-3 mb-1 pb-3" style="color: #f98006; font-weight: bold; text-align: center">Modification Details</h3>
                            <br />
                            <div class="row">
                                <div class="col-1"></div>
                                <div class="col-4">
                                    Old Date
                                </div>
                                <div class="col-7">
                                    :&nbsp<asp:Label ID="lblDate" runat="server" Text='<%# DateTime.Parse(Eval("date").ToString()).ToShortDateString() %>' />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-1"></div>
                                <div class="col-4">
                                    Old Time
                                </div>
                                <div class="col-md-7">
                                    :&nbsp<asp:Label ID="lblStartTime" runat="server" Text='<%# DateTime.Parse(Eval("startTime").ToString()).ToString("hh:mm tt")%>' />
                                    to  
                                    <asp:Label ID="lblEndTime" runat="server" Text='<%# DateTime.Parse(Eval("endTime").ToString()).ToString("hh:mm tt") %>' />
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-1"></div>
                                <div class="col-4">
                                    New Date
                                </div>
                                <div class="col-7">
                                    :&nbsp<asp:Label ID="lblNewDate" runat="server" Text='<%# DateTime.Parse(Eval("newDate").ToString()).ToShortDateString() %>' />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-1"></div>
                                <div class="col-4">
                                    New Time
                                </div>
                                <div class="col-md-7">
                                    :&nbsp<asp:Label ID="lblNewStartTime" runat="server" Text='<%# DateTime.Parse(Eval("newStartTime").ToString()).ToString("hh:mm tt")%>' />
                                    to  
                                    <asp:Label ID="lblNewEndTime" runat="server" Text='<%# DateTime.Parse(Eval("newEndTime").ToString()).ToString("hh:mm tt") %>' />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-1"></div>
                                <div class="col-4">
                                    Modification Status
                                </div>
                                <div class="col-7">
                                    :&nbsp<asp:Label ID="lblModificationStatus" runat="server" Text='<%# Eval("modificationStatus") %>' />
                                </div>
                            </div>
                        </div>
                        <div style="margin-top: 10%;" class="mb-1">
                <div class="row pe-5">
                    <div class="col-md-8"></div>
                    <div class="col-md-2 text-end">
                        <asp:Button ID="btnApprove" runat="server" Text="APPROVE" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 150px; background-color: #f98006; color: white" Visible="False" CommandArgument='<%# Eval("modificationId") %>' CommandName="approve"/>
                    </div>
                    <div class="col-md-2 text-end">
                        <asp:Button ID="btnReject" runat="server" Text="REJECT" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 150px; background-color: #f98006; color: white" Visible="False" CommandArgument='<%# Eval("modificationId") %>' CommandName="reject"/>
                    </div>
                </div>
            </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT ModificationRequest.modificationId, ModificationRequest.newDate, ModificationRequest.newStartTime, ModificationRequest.newEndTime, ModificationRequest.modificationStatus, ScheduleList.startTime, ScheduleList.endTime, ScheduleList.date, Course.courseName, Student.studName, Course.courseImage FROM ModificationRequest INNER JOIN ScheduleList ON ModificationRequest.scheduleListId = ScheduleList.scheduleListId INNER JOIN CourseSchedule ON ScheduleList.scheduleId = CourseSchedule.scheduleId INNER JOIN Course ON CourseSchedule.courseId = Course.courseId INNER JOIN EnrolDetails ON ModificationRequest.enrolDetailId = EnrolDetails.enrolDetailId INNER JOIN EnrolledCourse ON EnrolDetails.enrollmentId = EnrolledCourse.enrollmentId INNER JOIN Student ON EnrolledCourse.studId = Student.studId WHERE (ModificationRequest.modificationId = @modificatonId)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="modificatonId" QueryStringField="modificationId" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
