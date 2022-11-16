<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewStudNameList.aspx.cs" Inherits="OnlineHobby.ViewStudNameList" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container mt-2 mb-2 align-content-center" style="width: 90%; margin-left: 5%; min-height:600px">
        <div class="row text-end me-5 pt-3 pb-3"><asp:Label ID="lblCourseId" runat="server" Font-Size="Large"></asp:Label></div>
        <hr />
        <div class="row">
            <div class="col-md-7 text-center border-end" style="min-height:550px">
                <h3 class="pt-3 pb-3" style="color: #011797; font-size: x-large; font-weight: bold; text-align: center">Schedule List</h3>
                <asp:DataList ID="dlSchedule" runat="server" DataSourceID="sqlSchedule" Width="100%" Style="font-size: large" HorizontalAlign="Center" CellPadding="0" BorderStyle="None" OnItemCommand="dlSchedule_ItemCommand">
                    <ItemTemplate>
                        <div class="row text-center d-flex aligns-items-center justify-content-center">
                            <div class="col-md-2 border d-flex align-items-center justify-content-center pt-4 pb-4">
                                <asp:Label ID="lblScheduleId" runat="server" Text='<%# Eval("scheduleId") %>'></asp:Label>
                            </div>
                            <div class="col-md-7 border d-flex aligns-items-center justify-content-center pt-4 pb-4">
                                <asp:DataList ID="dlTime" runat="server" DataSourceID="SqlSchedule" Font-Size="Large" RepeatColumns="1" RepeatDirection="Horizontal">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStartDate" runat="server" Text='<%# Eval("date", "{0: dd/MMMM/yyyy}") %>'></asp:Label>&nbsp;
                                        (<asp:Label ID="lblStartTime" runat="server" Text='<%# DateTime.Parse(Eval("startTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                        &nbsp;to
                                            <asp:Label ID="lblEndTime" runat="server" Text='<%# DateTime.Parse(Eval("endTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>)
                                    </ItemTemplate>
                                </asp:DataList>
                            </div>
                            <div class="col-md-2 border d-flex align-items-center justify-content-center pt-4 pb-4">
                                <asp:Button ID="btnView" runat="server" CommandArgument='<%# Eval("scheduleId") %>' CommandName="view" Text="VIEW" BackColor="#FFDBB7" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
                            </div>
                            <div class="col-md-1"></div>
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
            </div>
            <div class="col-md-5 text-center">
                <h3 class="pt-3 pb-3" style="color: #011797; font-size: x-large; font-weight: bold; text-align: center">Student List</h3>
                
                <asp:GridView ID="gvNameList" runat="server" class="w-100 text-center m-5" AutoGenerateColumns="False" DataKeyNames="studId" EmptyDataText="There are no data records to display." Font-Size="Large" BorderStyle="None" BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="10" CellSpacing="2" HorizontalAlign="Center">
                        <Columns>
                            <asp:TemplateField HeaderText="Student Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblStudName" runat="server" Text='<%# Bind("studName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <asp:Label ID="lblScheduleId" runat="server" Text='<%# Bind("studEmail") %>'></asp:Label>
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
            </div>
        </div>
        <hr />
        <asp:SqlDataSource ID="sqlSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [CourseSchedule] WHERE ([courseId] = @courseId)">
            <SelectParameters>
                <asp:QueryStringParameter Name="courseId" QueryStringField="courseId" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
