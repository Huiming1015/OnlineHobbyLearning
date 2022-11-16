<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CancelForm.aspx.cs" Inherits="OnlineHobby.CancelForm" %>

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
        <div class="container-fluid bg">
            <div class="container text-center">
                <h2 class="mt-3 mb-2 pb-2" style="color: #f98006; font-weight: bold; font-size: xx-large;">CANCEL ORDER</h2>
            </div>
            <div class="row  ml-4">
                <div class="col-md-3"></div>
                <div class="col-md-6 mt-4">
                    <div class="row my-1">
                        <asp:Label ID="Label2" runat="server" Text="Cancel Reason: "></asp:Label>
                    </div>
                    <div class="row">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:TextBox ID="txtReason" type="text" CssClass="form-control" runat="server" Height="200px" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
            <div class="row mt-4" style="height: 20px">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*Please fill in the cancellation reason!" Font-Size="Small" ForeColor="Red" ControlToValidate="txtReason"></asp:RequiredFieldValidator>
            </div>
            <div class="d-flex justify-content-center mt-2 pt-3">
                <asp:Button ID="btnConfirm" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="CONFIRM CANCEL"  Style="height: 47px; background-color: #f98006; color: white" OnClick="btnConfirm_Click" />
            </div>
        </div>
    </form>
</body>
</html>
