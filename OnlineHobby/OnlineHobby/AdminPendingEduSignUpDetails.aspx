<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminPendingEduSignUpDetails.aspx.cs" Inherits="OnlineHobby.AdminPendingEduSignUpDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
    <style type="text/css">
        .bg {
            background-color: #fffefa;
        }
    </style>
    <section class="h-70 bg">
        <div class="container bg py-5 h-70">
            <div class="row d-flex justify-content-center align-items-center h-70">
                <div class="col">
                    <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
                        Please select an approval action.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <div class="card card-registration my-4 mx-5">
                        <div class="row g-0">
                            <div class="container p-md-7 text-black">
                                <%--header--%>
                                <div class="container py-2" style="background-color: rgba(0, 0, 0, 0.03);">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <asp:Label runat="server" Text="Application ID:" ID="Label1" Font-Bold="True" ForeColor="#F98006"></asp:Label>
                                            &nbsp;
                                            <asp:Label runat="server" Text="-" ID="lblAppId" Font-Bold="True" ForeColor="#F98006"></asp:Label>
                                        </div>
                                        <div class="col-md-8"></div>
                                        <div class="col-md-1 ">
                                            <asp:Label runat="server" Text="Pending" ID="lblStatus" CssClass="badge badge-warning" Font-Size="13px"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <h4 class="pt-4 pl-3" style="font-weight: bold">Personal Information</h4>

                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label10" runat="server" Text="Name: "></asp:Label> &nbsp;
                                        <asp:Label ID="lblName" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label3" runat="server" Text="Email Address: "></asp:Label>&nbsp;
                                        <asp:Label ID="lblEmail" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="row mb-3" style="color: darkgray">
                                        ________________________________________________________________________________________________________________________________________________________
                                    </div>
                                    <div class="row">
                                        <h4 class="pt-2 pl-3" style="font-weight: bold">Qualification Information</h4>

                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label4" runat="server" Text="Course Category: "></asp:Label>&nbsp;
                                        <asp:Label ID="lblCategory" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label6" runat="server" Text="Teaching Experience: "></asp:Label>&nbsp;
                                        <asp:Label ID="lblTeaching" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label8" runat="server" Text="Educator Qualification, Portfolio & Videos: "></asp:Label>&nbsp;
                                        <asp:Label ID="lblQualification" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="row mb-3" style="color: darkgray">
                                        ________________________________________________________________________________________________________________________________________________________
                                    </div>
                                    <%--approval--%>
                                    <div class="row px-3 pt-2">
                                        <div class="col-md-2">
                                            <asp:Label ID="Label5" runat="server" Text="Approval Action: "></asp:Label>
                                        </div>
                                        <div class="col-md-10 px-0">
                                            <asp:RadioButtonList ID="rblApprovalAction" runat="server">
                                                <asp:ListItem>Approve</asp:ListItem>
                                                <asp:ListItem>Reject</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                    </div>
                                    <div class="d-flex justify-content-center my-3 py-4 mb-lg-4">
                                        <asp:Button ID="btnBack" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-5" Text="BACK" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnBack_Click" />
                                        <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-5" Text="SUBMIT" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnSubmit_Click" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
