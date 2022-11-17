<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddCourseToCart.aspx.cs" Inherits="OnlineHobby.AddCourseToCart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <style type="text/css">
            .trListLeft {
            text-align: right;
            padding-left: 3px;
            vertical-align: top;
            font-size:15px;
        }

        .trListData {
            text-align: left;
            vertical-align: top;
            font-size:15px;
        }
        .auto-style1 {
            text-align: right;
            padding-left: 3px;
            vertical-align: top;
            font-size: 15px;
            width: 102px;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div class="container-fluid bg">
            <div class="container text-center">
                <h2 class="mt-3 mb-2 pb-2" style="color: #f98006; font-weight: bold; font-size: xx-large;">Select Your Preferred Schedule</h2>
            </div>
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-11">
                    <asp:DataList ID="dlSchedule" runat="server" DataSourceID="sqlCourse" HorizontalAlign="Center" class="text-center" RepeatDirection="Horizontal" RepeatColumns="3" CellSpacing="5" CellPadding="5" CssClass="auto-style2" OnItemCommand="dlSchedule_ItemCommand">
                        <ItemTemplate>
                            <table style="background-color: #FCF1E7; border: 1px solid grey;">
                                <tr style="padding: 10px;">
                                    <td colspan="2">
                                        <asp:Label ID="lblScheduleId" runat="server" Text='<%# Eval("scheduleId") %>' Visible="False"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;" class="trListLeft" colspan="2">
                                        <asp:Label ID="lblTutoringMode" runat="server" Text='<%# Eval("tutoringMode") %>'></asp:Label> tutorial
                                    </td>
                                </tr>
                                <tr>
                                    <td class="trListLeft" style="text-align:center" colspan="2">Maximum&nbsp;<asp:Label ID="lblMaxStud" runat="server" Text='<%# Eval("maxStud", "{0}") %>'></asp:Label>&nbsp;student(s)
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center;" class="trListLeft" colspan="2">
                                    <td ></td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">Day:&nbsp;</td>
                                    <td class="trListData">
                                        <asp:Label ID="lblDay" runat="server" Text='<%# Eval("day") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">&nbsp;</td>
                                    <td class="trListData">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">Time:&nbsp;</td>
                                    <td class="trListData">
                                        <asp:DataList ID="dlTime" runat="server" DataSourceID="SqlTime" RepeatColumns="1" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStartTime" runat="server" Text='<%# DateTime.Parse(Eval("startTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                                &nbsp;to
                                            <asp:Label ID="lblEndTime" runat="server" Text='<%# DateTime.Parse(Eval("endTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>&nbsp;
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">&nbsp;</td>
                                    <td class="trListData">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">Dates:&nbsp;</td>
                                    <td>
                                        <asp:BulletedList ID="blScheduleList" runat="server" DataTextField="date" DataValueField="scheduleId" DataSourceID="Sql" Style="list-style-type: none; text-align: left; margin-left: -30px; font-size:15px;" DataTextFormatString="{0:dd/MMMM/yyyy}">
                                        </asp:BulletedList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">Price:&nbsp;</td>
                                    <td class="trListData">RM
                                    <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price", "{0:F2}") %>'></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style1">&nbsp;</td>
                                    <td class="trListData">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td class="trListLeft" colspan="2">
                                        <asp:Button ID="btnAdd" runat="server" CommandName="addToCart" CssClass="btn btn-light btn-lg rounded-pill" Style="background-color: #f98006; color: white; margin: 5px; font-size:15px;" Text="ADD" CommandArgument='<%# Eval("scheduleId") %>' />
                                    </td>
                                </tr>
                            </table>
                            <asp:SqlDataSource ID="Sql" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [ScheduleList] WHERE ([scheduleId] = @scheduleId)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblScheduleId" Name="scheduleId" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="SqlTime" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT DISTINCT [startTime], [endTime] FROM [ScheduleList] WHERE ([scheduleId] = @scheduleId)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblScheduleId" Name="scheduleId" PropertyName="Text" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="lblNumEnrolled" runat="server" Text='<%# Eval("numEnrolled") %>' Visible="False"></asp:Label>
                        </ItemTemplate>
                    </asp:DataList>

                </div>
            <asp:SqlDataSource ID="sqlCourse" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CourseSchedule] WHERE ([courseId] = @courseId)">
                <SelectParameters>
                    <asp:SessionParameter DefaultValue="" Name="courseId" SessionField="cartCourseId" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
            </div>
            <br />

        </div>
    </form>
</body>
</html>
