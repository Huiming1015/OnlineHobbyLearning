<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCourse.aspx.cs" Inherits="OnlineHobby.ViewCourse" MasterPageFile="~/StudMaster.Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .trRight {
            width: 35%;
            padding: 5px;
            text-align: center;
            border-top: 1px solid grey;
            vertical-align: top;
        }

        .trLeft {
            width: 65%;
            text-align: center;
            border-right: 1px solid grey;
        }

        .trListLeft {
            text-align: right;
            padding-left: 3px;
            vertical-align: top;
        }

        .trListData {
            text-align: left;
            vertical-align: top;
        }

        table {
            border-bottom: 0px solid grey;
            border-top: 0px solid grey;
            border-left: 0px solid grey;
            border-right: 0px solid grey;
        }

        .div-background {
            background-color: #fffefa;
        }

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
            width: 900px;
            height: 580px;
        }
    </style>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script>
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you confirm to remove the course? Students enrolled in courses will receive a full refund.")) {
                confirm_value.value = "Yes";
            }
            else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    <div class="text-center" style="background-position: center center; margin: 3%; background-repeat: repeat; background-attachment: fixed; font-size: 25px; border: 1px solid grey">
        <div class="row text-end pe-3 mt-2 mb-2 me-5">
            <asp:LinkButton runat="server" Font-Underline="False" Text="View Student Name List" ID="lbtnNameList" OnClick="lbtnNameList_Click" Font-Size="Medium"></asp:LinkButton>
        </div>
        <h3 class="pt-3 mb-1 pb-3" style="color: #f98006; font-weight: bold; text-align: center">Course Details</h3>
        <hr />
        <div align="center">
            <asp:DataList ID="dlCourse" runat="server" DataKeyField="courseId" DataSourceID="SqlDataSource1" RepeatColumns="1" HorizontalAlign="Center" Width="100%" BorderStyle="None">
                <ItemTemplate>
                    <table style="vertical-align: central; width: 100%; height: 90%">
                        <tr>
                            <td class="trLeft" rowspan="3">
                                <asp:Label ID="lblName" runat="server" Enabled="False" Style="color: #f98006; font-weight: bold;" Text='<%# Eval("courseName") %>'></asp:Label>
                                <br />
                                <br />
                                <p style="font-size: 20px">
                                    Required Age Range:
                                 <asp:Label ID="lblMinAge" runat="server" Text='<%# Eval("minAge") %>'></asp:Label>
                                    &nbsp;to
                                 <asp:Label ID="lblMaxAge" runat="server" Text='<%# Eval("maxAge") %>'></asp:Label>
                                </p>
                            </td>
                            <td rowspan="3" align="left" style="border-bottom: 1px solid grey;">
                                <asp:Image ID="imgEduImage" runat="server" Height="100px" ImageUrl='<%# Eval("profileImg") %>' Width="100px" ImageAlign="Right" />
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="text-center">
                                <asp:LinkButton ID="lblEdu" runat="server" Text='<%# Eval("eduName") %>' Width="300px"></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td style="border-bottom: 1px solid grey;">&nbsp;</td>
                        </tr>
                        <tr align="center">
                            <td class="trLeft">
                                <asp:Image ID="imgCourseImage" runat="server" Height="500px" ImageUrl='<%# Eval("courseImage") %>' Width="500px" ImageAlign="Top" />
                                <br />
                                <asp:Label ID="lblDescription" runat="server" Font-Size="20px" Height="100px" Text='<%# Eval("description") %>' Width="80%"></asp:Label>
                            </td>
                            <td colspan="2" style="vertical-align: top;">
                                <h3 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">Learning Outcome</h3>
                                <br />
                                <asp:Label ID="lblOutcome" runat="server" Font-Size="20px" Text='<%# Eval("learningOutcome") %>' Width="90%"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </div>
        <hr />
        <h3 class="mt-3 pt-3 pb-3" style="color: #f98006; font-weight: bold; text-align: center">Course Schdule</h3>
        <div class="text-center w-100" align="center">
            <asp:DataList ID="dlSchedule" runat="server" DataSourceID="SqlDataSource3" HorizontalAlign="Center" class="text-center" RepeatDirection="Horizontal" RepeatColumns="4" CellSpacing="15" BorderStyle="None" CellPadding="30" Font-Size="20px">
                <ItemTemplate>
                    <table style="font-size: 20px; background-color: #FCF1E7; border: 1px solid grey;">
                        <tr style="padding: 10px;">
                            <td class="auto-style4" colspan="2">
                                <asp:Label ID="lblScheduleId" runat="server" Text='<%# Eval("scheduleId") %>' Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="trListLeft">Tutoring Mode:&nbsp;</td>
                            <td class="trListData">
                                <asp:Label ID="lblTutoringMode" runat="server" Text='<%# Eval("tutoringMode") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="trListLeft">&nbsp;</td>
                            <td class="trListData">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="trListLeft">Max Student:&nbsp;</td>
                            <td class="trListData">
                                <asp:Label ID="lblMaxStud" runat="server" Text='<%# Eval("maxStud", "{0}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="trListLeft">&nbsp;</td>
                            <td class="trListData">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="trListLeft">Day:&nbsp;</td>
                            <td class="trListData">
                                <asp:Label ID="lblDay" runat="server" Text='<%# Eval("day") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="trListLeft">&nbsp;</td>
                            <td class="trListData">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="trListLeft">Time:&nbsp;</td>
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
                            <td class="trListLeft">&nbsp;</td>
                            <td class="trListData">&nbsp;</td>
                        </tr>
                        <tr>
                            <td class="trListLeft">Dates:&nbsp;</td>
                            <td style="min-height: 200px;">
                                <asp:BulletedList ID="blScheduleList" runat="server" DataTextField="date" DataValueField="scheduleId" DataSourceID="Sql" Style="list-style-type: none; text-align: left; margin-left: -30px;" DataTextFormatString="{0:dd/MMMM/yyyy}">
                                </asp:BulletedList>
                            </td>
                        </tr>
                        <tr>
                            <td class="trListLeft">Price:&nbsp;</td>
                            <td class="trListData">RM
                                    <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("price", "{0:F2}") %>'></asp:Label>
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
                </ItemTemplate>
            </asp:DataList>
        </div>
        <hr />
        <br />
        <asp:Label runat="server" class="mt-5 pt-3 mb-3 pb-3" Style="color: #f98006; font-weight: bold; text-align: center" ID="lblTitleMaterial">Buy together to enjoy discount...</asp:Label>
        <br />
        <br />
        <div class="container w-100">
            <asp:DataList ID="dlMaterialKit" runat="server" DataSourceID="SqlDataSource2" HorizontalAlign="Center" RepeatDirection="Horizontal" RepeatColumns="4" CellSpacing="15" BorderStyle="None" OnItemCommand="dlMaterialKit_ItemCommand" CellPadding="30">
                <ItemTemplate>
                    <table style="width: 250px; font-size: 20px; border: 1px solid grey; text-align: center">
                        <tr>
                            <td>
                                <asp:ImageButton ID="imgMaterial" class="card-img-top" runat="server" Height="200px" Width="200px" ImageUrl='<%# Eval("materialImage") %>' BorderStyle="Solid" BorderWidth="3px" ImageAlign="Middle" CommandArgument='<%# Eval("materialId") %>' />

                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center; height: 60px;">
                                <asp:LinkButton ID="lblMaterialName" class="card-body" runat="server" Style="text-align: center !important" Font-Underline="False" ForeColor="#993333" CommandArgument='<%# Eval("materialId") %>' Text='<%# Eval("materialName") %>'></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td>Price: RM
                                    <asp:Label ID="lblPrice" runat="server" Width="60px" Text='<%# Eval("price", "{0:F}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Discount Rate:
                                    <asp:Label ID="txtDiscount" runat="server" Width="60px" Text='<%# Eval("discountRate") %>'></asp:Label>
                                %
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:DataList>
        </div>
        <div align="right" style="padding-right: 3%;">
            <asp:Button ID="btnRemove" runat="server" Text="REMOVE" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" CausesValidation="false" OnClientClick="Confirm()" OnClick="btnRemove_Click" />
            &nbsp;
                        <asp:Button ID="btnModify" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" Text="MODIFY" Width="163px" CausesValidation="false" OnClick="btnModify_Click" />

        </div>
        <asp:Panel ID="Panel1" runat="server">
            <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
                <div class="text-end" style="padding-right: 3%;">
                <asp:Button ID="btnAddToCart" runat="server" CausesValidation="False" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 200px; background-color: #f98006; color: white" Text="ADD TO CART" CommandArgument='<%# Eval("materialId") %>' CommandName="addToCart" Visible="False" />
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <cc1:ModalPopupExtender ID="mp1" runat="server" PopupControlID="Panl1" TargetControlID="btnAddToCart"
                    CancelControlID="Button2" BackgroundCssClass="Background">
                </cc1:ModalPopupExtender>
                <asp:Panel ID="Panl1" runat="server" CssClass="Popup" align="center" Style="display: none">
                    <asp:Panel ID="Panel4" runat="server" align="right" Style="padding-right: 10px">
                        <asp:Button ID="Button2" runat="server" Text="X" Style="background-color: #f98006; color: white" Font-Bold="True" BorderStyle="None" BorderColor="Silver" />
                    </asp:Panel>
                    <iframe style="width: 800px; height: 530px;" id="irm1" src="AddCourseToCart.aspx" runat="server"></iframe>
                </asp:Panel>
            </div>
        </asp:Panel>
        <br />
        <hr />
        <asp:Image runat="server" ID="imgStar" imageUrl="Resources/starRate.png" Height="28px" Width="30px" />&nbsp;<asp:Label runat="server" class="mt-5 pt-3 mb-3 pb-3" Style="color: #f98006; font-weight: bold; text-align: center" ID="lblRateTitle" Font-Size="X-Large">Rating For This Course</asp:Label>
        &nbsp;<asp:Label runat="server" class="mt-5 pt-3 mb-3 pb-3" Style="color: #f98006; font-weight: bold; text-align: center" ID="lblAverage" Font-Size="X-Large"></asp:Label><br />
        <asp:Label runat="server" class="mt-5 pt-3 mb-3 pb-3" Style="font-weight: bold; text-align: center" ID="lblNoRate" Text="There are no any rating for this course yet..." Visible="false"></asp:Label>
        <br /><div class="w-100 mt-2" align="center">
            <asp:DataList ID="dlRating" runat="server" DataKeyField="courseRatingId" DataSourceID="SqlDataSource4" HorizontalAlign="Center" Font-Size="large" align="center" CellPadding="15" Width="100%">
                <ItemTemplate>
                    <div class="container-fluid text-center">
                        <div class="row fw-bold">
                            <div class="col-3">
                                <asp:Label ID="lblStudName" runat="server" Text='<%# Eval("studName") %>' />
                            </div>
                            <div class="col-1">
                                (<asp:Label ID="lblRating" runat="server" Text='<%# Eval("rating") %>' />)
                            </div>
                            <div class="col-8"></div>
                        </div>
                        <div class="row w-100">
                            <div class="col-12">
                                <asp:Label ID="lblComment" runat="server" Text='<%# Eval("comment") %>' />
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>
            </div>
            <br />
            <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT CourseRating.courseRatingId, CourseRating.rating, CourseRating.comment, Student.studName FROM CourseRating INNER JOIN Student ON CourseRating.studId = Student.studId WHERE (CourseRating.courseId = @courseId)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="courseId" QueryStringField="courseId" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM Course INNER JOIN Educator ON Course.eduId = Educator.eduId WHERE ([courseId] = @courseId)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="courseId" QueryStringField="courseId" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [Discount] INNER JOIN [MaterialKit] ON Discount.materialId = MaterialKit.materialId WHERE Discount.courseId = @courseId">
                <SelectParameters>
                    <asp:QueryStringParameter Name="courseId" QueryStringField="courseId" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CourseSchedule] WHERE ([courseId] = @courseId) and (availability='available')">
                <SelectParameters>
                    <asp:QueryStringParameter Name="courseId" QueryStringField="courseId" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
</asp:Content>
