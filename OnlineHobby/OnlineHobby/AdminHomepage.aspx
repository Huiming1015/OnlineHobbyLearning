<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminHomepage.aspx.cs" Inherits="OnlineHobby.AdminHomepage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .bg {
            background-color: #fffefa;
        }
    </style>

    <div class="bg text-center pb-4">
        <h1 class="pt-5 mb-3 pb-3" style="color: #f98006; font-weight: bold">Online Hobby Learning System</h1>
        <asp:Image ID="imgAdminHomepage" runat="server" ImageAlign="Middle" ImageUrl="~/Assets/adminHomepage.png" Height="450px" Width="700px" />
    </div>
</asp:Content>
