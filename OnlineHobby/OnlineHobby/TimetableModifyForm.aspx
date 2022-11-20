<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TimetableModifyForm.aspx.cs" Inherits="OnlineHobby.TimetableModifyForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <script type="text/javascript">
        function RefreshParent() {
            window.parent.location.href = window.parent.location.href;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
            <div class="container text-center">
                <h2 class="mt-3 mb-2 pb-2" style="color: #f98006; font-weight: bold; font-size: xx-large;">Timetable Modification Form</h2>
                <p class="mt-3 mb-2 pb-2" style="font-size: medium;">You can only request a date modification 1 day before the course starts.</p>
                <asp:Label runat="server" ID="lblCantModify" class="mt-3 mb-2 pb-2" Font-Size="Medium" ForeColor="Red" Text="*There are no suitable course date to modify." Visible="false"></asp:Label>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-md-4">Date</div>
                    <div class="col-md-8"><asp:DropDownList ID="ddlDate" runat="server" Font-Size="large" Width="100%"></asp:DropDownList></div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-4">New Date</div>
                    <div class="col-md-8">
                            <div class="input-group bootstrap-datepicker datepicker">
                                <asp:TextBox ID="txtNewDate" runat="server" CssClass="form-control" TextMode="Date" Font-Size="large"></asp:TextBox>
                                <span class="input-group-addon"><i class="glyphicon glyphicon-calendar"></i></span>
                            </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-8">
                        <span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtNewDate" ErrorMessage="*Please choose a new date!" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </span>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-4">New Time</div>
                    <div class="col-md-8">
                        <asp:TextBox ID="txtNewTime" CssClass="form-control" runat="server" TextMode="Time" Font-Size="large"></asp:TextBox>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-8">
                        <span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtNewTime" ErrorMessage="*Please choose a new time!" ForeColor="Red" Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator>
                        </span>
                    </div>
                </div>
            </div>
            <br />
            <div class="d-flex justify-content-center mt-2 pt-3">
                <asp:Button ID="btnSend" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SEND REQUEST" Style="height: 47px; background-color: #f98006; color: white" OnClick="btnSend_Click" />
            </div>
    </form>
</body>
</html>

