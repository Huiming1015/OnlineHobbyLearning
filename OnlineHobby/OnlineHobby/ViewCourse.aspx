<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewCourse.aspx.cs" Inherits="OnlineHobby.ViewCourse" MasterPageFile="~/StudMaster.Master" %>

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
            padding: 5px;
            vertical-align:top;
        }

        .trListData {
            text-align: left;
            vertical-align:top;
        }

        table {
            border-bottom: 1px solid grey;
            border-top: 1px solid grey;
            border-left: 1px solid grey;
            border-right: 1px solid grey;
        }

        .div-background {
            background-color: #fffefa;
        }
    </style>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
    <script>
        function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("Do you confirm to remove the course?")) {
                confirm_value.value = "Yes";
            }
            else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }
        function SuccessRemoveAlert() {

        }
    </script>
    <div class="text-center" style="background-position: center center; margin:3%; background-repeat: repeat; background-attachment: fixed; font-size: 25px; border:1px solid grey">
        <asp:DataList ID="dlCourse" runat="server" DataKeyField="courseId" DataSourceID="SqlDataSource1" RepeatColumns="1" HorizontalAlign="Center" Width="100%">
            <ItemTemplate>
                <div align="center">
                </div>
                <table style="vertical-align: central; width: 100%; height: 90%">
                    <tr>
                        <td class="trLeft" rowspan="3">
                            <asp:Label ID="lblName" runat="server" Enabled="False" style="color: #f98006; font-weight: bold;" Text='<%# Eval("courseName") %>' Width="300px"></asp:Label>
                            <br />
                            <br />
                            <p style="font-size:20px">Required Age Range:
                                 <asp:Label ID="lblMinAge" runat="server" Text='<%# Eval("minAge") %>'></asp:Label>
                            &nbsp;to
                                 <asp:Label ID="lblMaxAge" runat="server" Text='<%# Eval("maxAge") %>'></asp:Label></p>
                        </td>
                        <td rowspan="3" class="auto-style3">&nbsp;</td>
                        <td rowspan="3" class="auto-style2" align="left">
                            <asp:Image ID="imgEduImage" runat="server" Height="100px" ImageUrl='<%# Eval("profileImg") %>' Width="100px" />
                        </td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:LinkButton ID="lblEdu" runat="server" Text='<%# Eval("eduName") %>' Width="300px"></asp:LinkButton>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                    </tr>
                    <tr align="center">
                        <td class="trLeft">
                            <asp:Image ID="imgCourseImage" runat="server" Height="500px" ImageUrl='<%# Eval("courseImage") %>' Width="500px" />
                            <br />
                            <asp:Label ID="lblDescription" runat="server" Height="100px" Text='<%# Eval("description") %>' Width="80%"></asp:Label>
                        </td>
                        <td class="trRight" colspan="3">
                            <br />
                            <h3 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">Learning Outcome</h3>
                            <br />
                            <asp:Label ID="lblOutcome" runat="server" Text='<%# Eval("learningOutcome") %>' Width="90%" Font-Size="20px"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList>
        <div align="center">
            <br />
            <h3 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold; text-align: center">Course Schdule</h3>
            <div>
                <asp:DataList ID="dlSchedule" runat="server" DataSourceID="SqlDataSource3" HorizontalAlign="Center" Width="85%" RepeatDirection="Horizontal" RepeatColumns="3" CellSpacing="20" BorderStyle="None">
                    <ItemTemplate>
                        <table style="font-size: 20px; min-height:350px;">
                            <tr style="padding:10px;">
                                <td class="auto-style4" colspan="2">
                                    <asp:Label ID="lblScheduleId" runat="server" Text='<%# Eval("scheduleId") %>' Visible="False"></asp:Label>
                                </td>
                            </tr>
                            <tr >
                                <td class="trListLeft">Tutoring Mode :&nbsp; </td>
                                <td class="trListData">
                                    <asp:Label ID="lblTutoringMode" runat="server" Text='<%# Eval("tutoringMode") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="trListLeft">Time :&nbsp; </td>
                                <td class="trListData">
                                    <asp:DataList ID="dlTime" runat="server" DataSourceID="SqlTime" RepeatColumns="1" RepeatDirection="Horizontal" RepeatLayout="Flow">

                                        <ItemTemplate>

                                            <asp:Label ID="lblStartTime" runat="server" Text='<%# DateTime.Parse(Eval("startTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                            &nbsp;to
                                            <asp:Label ID="lblEndTime" runat="server" Text='<%# DateTime.Parse(Eval("endTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>

                                        </ItemTemplate>
                                    </asp:DataList>
                                </td>
                            </tr>
                            <tr>
                                <td class="trListLeft">Day :&nbsp;</td>
                                <td class="trListData">
                                    <asp:Label ID="lblDay" runat="server" Text='<%# Eval("day") %>'></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="trListLeft">Dates :&nbsp;</td>
                                <td>
                                    <asp:BulletedList ID="blScheduleList" runat="server" DataTextField="date" DataValueField="scheduleId" DataSourceID="Sql" Style="list-style-type: none; text-align:left; margin-left:-15px;" DataTextFormatString="{0:dd/MM/yyyy}" Width="200px">
                                    </asp:BulletedList>


                                </td>
                            </tr>
                            <tr>
                                <td class="trListLeft">Price :&nbsp;</td>
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

                <div align="center">
                    <br />
                    <asp:Label runat="server" class="mt-5 pt-3 mb-3 pb-3" Style="color: #f98006; font-weight: bold; text-align: center" ID="lblTitleMaterial">Buy together to enjoy discount...</asp:Label>
                    <asp:DataList ID="dlMaterialKit" runat="server" DataSourceID="SqlDataSource2" HorizontalAlign="Center" RepeatDirection="Horizontal" RepeatColumns="5" CellSpacing="50" BorderStyle="None">
                        <ItemTemplate>
                            <table style="width: 225px; font-size: 20px; border: 1px solid grey; text-align:center">
                                <tr>
                                    <td>
                                        <asp:Image ID="imgMaterial" class="card-img-top" runat="server" Height="200px" Width="200px" ImageUrl='<%# Eval("materialImage") %>' BorderStyle="Solid" BorderWidth="3px" ImageAlign="Middle" />

                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;" >
                                        <asp:Label ID="lblMaterialName" class="card-body" runat="server" Style="text-align: center !important" Font-Underline="False" Height="50px" ForeColor="#993333"><%# Eval("materialName") %> </asp:Label>
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
                <div align="right">
                    <asp:Button ID="btnRemove" runat="server" Text="REMOVE" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" CausesValidation="false" OnClientClick="Confirm()" OnClick="btnRemove_Click" />
                    &nbsp;
                        <asp:Button ID="btnModify" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" Text="MODIFY" Width="163px" CausesValidation="false" OnClick="btnModify_Click" />
                </div>

            </div>

            <br />

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
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CourseSchedule] WHERE ([courseId] = @courseId)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="courseId" QueryStringField="courseId" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
