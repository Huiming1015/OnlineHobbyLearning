<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimetableEdu.aspx.cs" Inherits="OnlineHobby.TimetableEdu" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container mt-2 mb-2 align-content-center" style="width: 90%; margin-left: 5%;">
        <div class="row g-0">
            
            <div class="col-md-2">
                <asp:Button ID="btnTimetable" runat="server" Text="Timetable" CssClass="border-1 w-100" BackColor="#FFF0E1" BorderColor="Black" Font-Size="Large" />
            </div>
            <div class="col-md-2">
                <asp:Button ID="btnModifyTimeTable" runat="server" Text="Timetable Modification" CssClass="border-1 w-100" BackColor="#FFF0E1" BorderColor="Black" Font-Size="Large" OnClick="btnModifyTimeTable_Click" />
            </div>
            <div class="col-md-6"></div>
        </div>
        <div class="border border-dark text-center">
            <asp:DropDownList ID="ddlDate" runat="server" AutoPostBack="True" CssClass="mt-5" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged" Font-Size="25px"></asp:DropDownList>
            <br />
            <asp:Label ID="lblNoClass" runat="server" Text="You are no class to join today." CssClass="mt-5" Font-Size="X-Large" Font-Bold="true" Visible="false"></asp:Label>
            <div class="mt-5 mb-5" style="min-height: 550px">
                <div class="w-100" align="center">
                    <asp:GridView ID="gvTimetable" runat="server" class="w-75 text-center mt-5 mb-5" AutoGenerateColumns="False" DataKeyNames="scheduleId" EmptyDataText="There are no data records to display." Font-Size="Large" BorderStyle="None" BackColor="#DEBA84" BorderColor="#DEBA84" BorderWidth="1px" CellPadding="10" CellSpacing="2" OnRowCommand="gvEnrolledList_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStartTime" runat="server" Text='<%# DateTime.Parse(Eval("startTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                        &nbsp;-&nbsp;
                                        <asp:Label ID="lblEndTime" runat="server" Text='<%# DateTime.Parse(Eval("endTime").ToString()).ToString("hh:mm tt") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            <asp:TemplateField HeaderText="Course Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourseName" runat="server" Text='<%# Bind("courseName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Schedule ID">
                                <ItemTemplate>
                                    <asp:Label ID="lblScheduleId" runat="server" Text='<%# Bind("scheduleId") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button Text="JOIN CLASS" runat="server" CommandName="join" BackColor="#FFDBB7" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" CommandArgument='<%# Eval("meetingLink") %>' OnClientClick="target ='_blank';" />
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
        </div>
    </div>
</asp:Content>