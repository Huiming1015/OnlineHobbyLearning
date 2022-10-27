<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EduComplaint.aspx.cs" Inherits="OnlineHobby.EduComplaint" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid bg">
            <div class="row " style="height: 60px">
                    <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSuccess" visible="false">
                        Educator report incident submitted successful.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
            </div>

            <div class="container text-center">
                <h2 class="mt-1 mb-2 pb-2" style="color: #f98006; font-weight: bold; font-size: xx-large;">Report Educator</h2>
            </div>
            <div class="row  ml-4">
                <div class="col-md-3"></div>
                <div class="col-md-6 mt-1">
                    <div class="row my-1">
                        <asp:Label ID="Label3" runat="server" Text="Incident Type"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="col-md-1"></div>
                        <div class="col-md-11">
                            <asp:RadioButtonList ID="rblIncidentType" runat="server">
                                <asp:ListItem>Bad attitude of educator</asp:ListItem>
                                <asp:ListItem>Absence from live stream tutorials</asp:ListItem>
                                <asp:ListItem>Unship materials</asp:ListItem>
                                <asp:ListItem>Others</asp:ListItem>
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
            <div class="row  ml-4">
                <div class="col-md-3"></div>
                <div class="col-md-6 mt-4">
                    <div class="row my-1">
                        <asp:Label ID="Label2" runat="server" Text="Description"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:TextBox ID="txtReportDesc" type="text" CssClass="form-control" runat="server" Height="96px" TextMode="MultiLine" placeholder="Please further elaborate on your selected reason"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
            <div class="row " style="height: 20px">
                <asp:Label ID="lblRequired" runat="server" Text="*Please fill up all fields." ForeColor="Red" Font-Size="Small" Visible="False"></asp:Label>
            </div>

            <div class="d-flex justify-content-center my-3 py-3">
                <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SUBMIT" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnSubmit_Click" />
            </div>

        </div>
    </form>
</body>
</html>
