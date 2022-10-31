<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EduRate.aspx.cs" Inherits="OnlineHobby.EduRate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
    <style type="text/css">
        .Star {
            background-image: url('Assets/Star.gif');
            /*height: 17px;
            width: 17px;*/
        }

        .WaitingStar {
            background-image: url('Assets/WaitingStar.gif');
        }

        .FilledStar {
            background-image: url('Assets/FilledStar.gif');
        }

        .ratingStar {
            font-size: 0pt;
            width: 64px;
            height: 40px;
            margin-left: 25px;
            padding: 5px;
            cursor: pointer;
            display: block;
            background-repeat: no-repeat;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="container text-center">
                <h2 class="mt-3 mb-2" style="color: #f98006; font-weight: bold; font-size: xx-large;">Rate Educator</h2>
            </div>
            <div class="container text-center mb-2 pb-2">
                <asp:Label ID="Label3" runat="server" Text="Tell people what you think about this educator."></asp:Label>
            </div>
            <div class="row ps-5 mt-4">
                <asp:ScriptManager ID="ToolkitScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:Rating ID="Rating1" AutoPostBack="true" runat="server"
                    StarCssClass="ratingStar" WaitingStarCssClass="WaitingStar" EmptyStarCssClass="Star"
                    FilledStarCssClass="FilledStar" CurrentRating="0" MaxRating="5" OnClick="Rating1_Click">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </asp:Rating>
                <br />

            </div>
            <div class="row ps-4" style="height: 20px">
                <asp:Label ID="lblRatingStatus" runat="server" Text="" ForeColor="Red" Font-Size="Small" Visible="False"></asp:Label>
            </div>

        </div>
    </form>
</body>
</html>
