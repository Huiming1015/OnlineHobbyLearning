<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="OnlineHobby.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="container-fluid div-background mt-3">
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
            Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSuccess" visible="false">
            Password changed successful.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>

        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgError" visible="false">
            Error:
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="text-center">
            <h2 class="mt-5 pt-4 mb-3 pb-3" style="color: #f98006; font-weight: bold">Change Password</h2>
        </div>

        <%--current pswd--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-2">
                <div class="row my-1">
                    <asp:Label ID="Label3" runat="server" Text="Current Password"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtPCurrentPasword" TextMode="Password" CssClass="form-control" runat="server" AutoPostBack="True"></asp:TextBox>
                        </div>
                        <asp:ImageButton ID="ImageButton1" runat="server" Height="38px" ImageUrl="Resources/passwordShow.png" Width="31px" ImageAlign="AbsMiddle" OnClick="ImageButton1_Click" />
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <%--new pswd--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label1" runat="server" Text="New Password"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtPNewPassword" TextMode="Password" CssClass="form-control" runat="server" AutoPostBack="True"></asp:TextBox>
                        </div>
                        <asp:ImageButton ID="ImageButton2" runat="server" Height="38px" ImageUrl="Resources/passwordShow.png" Width="31px" ImageAlign="AbsMiddle" OnClick="ImageButton2_Click" />
                    </div>
                    <asp:Label ID="Label4" runat="server" Text="Password must contains min 8 characters, at least 1 uppercase, 1 lowercase, 1 digit." Font-Size="Smaller" ForeColor="Gray"></asp:Label>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <%--confirm pswd--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label2" runat="server" Text="Confirm New Password"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtPConfirmPassword" TextMode="Password" CssClass="form-control" runat="server" AutoPostBack="True"></asp:TextBox>
                        </div>
                        <asp:ImageButton ID="ImageButton3" runat="server" Height="38px" ImageUrl="Resources/passwordShow.png" Width="31px" ImageAlign="AbsMiddle" OnClick="ImageButton3_Click" />
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <div class="d-flex justify-content-center mt-5 pt-2 mb-3 pb-5 mb-lg-4">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SAVE CHANGES" type="submit" Style="height: 47px; width: 238px; background-color: #f98006; color: white" OnClick="btnSubmit_Click" />
        </div>

    </div>
</asp:Content>
