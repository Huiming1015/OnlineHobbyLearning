<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="DeleteAccount.aspx.cs" Inherits="OnlineHobby.DeleteAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="container-fluid div-background">

        <div class="alert alert-danger mt-3" role="alert">
            <i class="fa fa-exclamation-triangle" style="color: indianred"></i>This is extremely important.
        </div>
        <div class="text-center">
            <h2 class="mt-4 pt-4 mb-3 pb-3" style="color: #f98006; font-weight: bold">Delete Account</h2>
        </div>

        <div class="row text-center">
            <p>Are you sure you want to do this?</p>
            <p>We will immediately delete all your information and history. You will no longer be able to login using this account and available to anyone on ReLife.</p>
            <p>Once you delete your account, there is no going back. Please be certain.</p>
        </div>

        <%--verify--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-3 pt-3 mb-2 pb-1">
                <div class="row my-1">
                    <asp:Label ID="Label3" runat="server">To verify, type <b><i>delete my account</i></b> below</asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtVerify" type="text" CssClass="form-control" runat="server" AutoPostBack="True" OnTextChanged="txtVerify_TextChanged"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>


        <div class="d-flex justify-content-center mt-5 pt-2 mb-3 pb-5 mb-lg-4">
            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="DELETE ACCOUNT" type="submit" Style="height: 47px; width: 245px; background-color: #f98006; color: white" OnClick="btnDelete_Click" />
        </div>

    </div>
</asp:Content>
