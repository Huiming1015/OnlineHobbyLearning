<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="OnlineHobby.AboutUs" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>
    <div class="container-fluid div-background pt-2">
        <div class="text-center">
            <h3 class="pt-4 pb-2" style="color: #8600b3; font-weight: bold; font-size: 35px">Who Are We</h3>
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Assets/aboutUs.jpeg" Height="450px" Width="750px" Style="border-radius: 15px; box-shadow: 5px 5px 7px #f2ccff" />
        </div>
        <div class="container py-4 ps-5 pe-5">
            <p>ReLife was established as a platform for creative makers to educate the public about their crafts and express their enthusiasm for them. Since our founding in 2022, we have aided local creatives by introducing them to a global audience. Through the eyes of our artists, we hope to encourage you to begin learning distinctive arts and crafts so that you can acquire new abilities. Learn new talents and find inspiration in this community. At ReLife, start your creative journey right away! </p>
        </div>

        <div class="text-center">
            <h3 class="pb-2" style="color: #8600b3; font-weight: bold; font-size: 35px">Our Partners</h3>
        </div>
        <div class="row pb-5">
            <div class="col-md-4 text-center">
                <asp:Image ID="Image2" runat="server" ImageUrl="~/Assets/partner1.png" />
            </div>
            <div class="col-md-4  text-center">
                <asp:Image ID="Image3" runat="server" ImageUrl="~/Assets/partner2.png" />
            </div>
            <div class="col-md-4  text-center">
                <asp:Image ID="Image4" runat="server" ImageUrl="~/Assets/partner3.png" />
            </div>
        </div>
    </div>
</asp:Content>

