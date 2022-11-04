﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSchedule.aspx.cs" Inherits="OnlineHobby.AddSchedule" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style type="text/css">
        .cssInputTr {
            width: 200px;
            padding: 5px;
            text-align: left;
            border-right: 1px solid grey;
        }

        .cssTitleTr {
            width: 200px;
            text-align: right;
        }

        .cssError {
            padding: 5px;
            text-align: left;
            border-right: 1px solid grey;
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

    <div style="padding: 20px; font-size: 20px; margin-left: 5%; margin-right: 5%; text-align: center" class="auto-style1">

        <table style="width: 100%; ">
            <tr>
                <td class="cssTitleTr">Start Date :</td>
                <td class="cssInputTr">
                    <div class="input-group bootstrap-datepicker datepicker">
                        <asp:TextBox ID="txtStartDate" runat="server" Width="180px" CssClass="form-control" TextMode="Date" Font-Size="20px"></asp:TextBox>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                    </div>
                </td>
                <td rowspan="7" align="center">
                    <h4>Schedule for the course</h4>
                    <asp:GridView ID="gvCourseSchedule" runat="server" AutoGenerateColumns="False" DataKeyNames="scheduleId" EmptyDataText="There are no data records to display." Height="220px" Width="95%" Font-Size="20px" OnSelectedIndexChanged="gvCourseSchedule_SelectedIndexChanged" class="table table-bordered table-condensed table-hover" AutoGenerateSelectButton="True" AutoGenerateDeleteButton="True" OnRowDeleting="gvCourseSchedule_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="tutoringMode" HeaderText="Tutoring Mode" SortExpression="tutoringMode" />
                            <asp:BoundField DataField="meetingLink" HeaderText="Meeting Link" SortExpression="meetingLink" />
                            <asp:BoundField DataField="maxStud" HeaderText="Maximum Student" SortExpression="maxStud" />
                            <asp:BoundField DataField="price" HeaderText="Price" SortExpression="price" DataFormatString="{0:C}" />
                        </Columns>
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="cssError" colspan="2">
                    <span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtStartDate" ErrorMessage="*Start date should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator>
                    </span></td>
            </tr>
            <tr>
                <td class="cssTitleTr">Time Begin :</td>
                <td class="cssInputTr">

                    <asp:TextBox ID="txtTime" CssClass="form-control" Width="180px" runat="server" TextMode="Time" Font-Size="20px"></asp:TextBox>

                </td>
            </tr>
            <tr>
                <td class="cssError" colspan="2">
                    <span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtTime" ErrorMessage="*Time should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator>
                    </span></td>
            </tr>
            <tr>
                <td class="cssTitleTr">Duration :</td>
                <td class="cssInputTr">

                    <asp:DropDownList ID="ddlDuration" runat="server" Width="80px" Font-Size="20px" AutoPostBack="True" OnSelectedIndexChanged="ddlTutoringMode_SelectedIndexChanged">
                        <asp:ListItem>30</asp:ListItem>
                        <asp:ListItem Value="60">60</asp:ListItem>
                        <asp:ListItem Value="90">90</asp:ListItem>
                        <asp:ListItem Value="120">120</asp:ListItem>
                        <asp:ListItem>150</asp:ListItem>
                    </asp:DropDownList>
                &nbsp;minutes</td>
            </tr>
            <tr>
                <td class="cssTitleTr">&nbsp;</td>
                <td class="cssInputTr">&nbsp;</td>
            </tr>
            <tr>
                <td class="cssTitleTr">Tutoring Mode :</td>
                <td class="cssInputTr">
                    <asp:DropDownList ID="ddlTutoringMode" runat="server" Width="180px" Font-Size="20px" AutoPostBack="True" OnSelectedIndexChanged="ddlTutoringMode_SelectedIndexChanged">
                        <asp:ListItem Value="oneToMany">One to Many</asp:ListItem>
                        <asp:ListItem Value="oneToOne">One to One</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="cssTitleTr">&nbsp;</td>
                <td class="cssInputTr">&nbsp;</td>
                <td rowspan="7" align="center">
                    <h4>Schedule List</h4>
                    <asp:GridView ID="gvScheduleList" runat="server" class="table table-bordered table-condensed table-hover" Width="90%" AutoGenerateColumns="False" DataKeyNames="scheduleListId" EmptyDataText="There are no data records to display." Font-Size="20px">
                        <Columns>
                            <asp:BoundField DataField="date" HeaderText="Schedule Date" SortExpression="date" ReadOnly="True" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="startTime" HeaderText="Start Time" SortExpression="time" ReadOnly="True" />
                            <asp:BoundField DataField="endTime" HeaderText="End Time" SortExpression="time" ReadOnly="True" />
                        </Columns>
                        <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="cssTitleTr">Maximum Student :</td>
                <td class="cssInputTr">
                    <asp:TextBox ID="txtMaxStud" runat="server" Width="180px" CssClass="form-control" Font-Size="20px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="cssError" colspan="2">
                    <span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtMaxStud" ErrorMessage="*Number of student should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtMaxStud" Display="Dynamic" ErrorMessage="*Number of student must between 1 to 150!" Font-Size="Small" ForeColor="Red" MaximumValue="150" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                    </span></td>
            </tr>
            <tr>
                <td class="cssTitleTr">Meeting Link :</td>
                <td class="cssInputTr">
                    <asp:TextBox ID="txtMeetLink" runat="server" Width="180px" CssClass="form-control" Font-Size="20px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="cssError" colspan="2">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtMeetLink" ErrorMessage="*Meeting link should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="validatePrice0" runat="server" ControlToValidate="txtMeetLink" ErrorMessage="*Meeting link should be a valid link!" ForeColor="Red" Type="Double" Font-Size="Small" ValidationExpression="^https://meet.google.com/" Display="Dynamic"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td class="cssTitleTr">Price for Course :</td>
                <td class="cssInputTr">
                    <asp:TextBox ID="txtPrice" runat="server" Width="180px" CssClass="form-control" Font-Size="20px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="cssError" colspan="2">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price should not be empty!" ForeColor="Red" Font-Size="Small" Display="Dynamic">*Price should not be empty!</asp:RequiredFieldValidator>
                    <span>
                            <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtPrice" Display="Dynamic" ErrorMessage="*Price must be a positive number!" Font-Size="Small" ForeColor="Red" MaximumValue="999" MinimumValue="0" Type="Double"></asp:RangeValidator>
                        </span>
                </td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td class="cssInputTr">
                    <asp:Button ID="btnAddSchedule" runat="server" Text="ADD" CssClass="button btn-lg rounded-pill" Style="height: 47px; width: 150px; margin: 10px; background-color: #f98006; color: white; border-color: transparent" OnClick="btnAddSchedule_Click" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <br />
        <br />
        <asp:Button ID="btnNext" runat="server" Text="Next" OnClick="btnNext_Click" CssClass="btn btn-light btn-lg rounded-pill" Style="height: 47px; width: 165px; background-color: #f98006; color: white" ValidateRequestMode="Disabled" />
    </div>
</asp:Content>
