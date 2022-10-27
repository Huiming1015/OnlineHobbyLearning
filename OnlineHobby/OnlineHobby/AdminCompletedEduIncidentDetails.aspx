<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="AdminCompletedEduIncidentDetails.aspx.cs" Inherits="OnlineHobby.AdminCompletedEduIncidentDetails" %>

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
                    <div class="card card-registration my-4 mx-5">
                        <div class="row g-0">
                            <div class="container p-md-7 text-black">
                                <%--header--%>
                                <div class="container py-2" style="background-color: rgba(0, 0, 0, 0.03);">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <asp:Label runat="server" Text="Incident ID:" ID="Label1" Font-Bold="True" ForeColor="#F98006"></asp:Label>
                                            &nbsp;
                                            <asp:Label runat="server" Text="-" ID="lblComplaintId" Font-Bold="True" ForeColor="#F98006"></asp:Label>
                                        </div>
                                        <div class="col-md-7"></div>
                                        <div class="col-md-2 text-right ">
                                            <asp:Label runat="server" Text="Approved" ID="lblStatus" CssClass="badge badge-success" Font-Size="13px"></asp:Label>
                                        </div>
                                    </div>
                                </div>
                                <div class="container">
                                    <div class="row">
                                        <h4 class="pt-4 pl-3" style="font-weight: bold">Incident Information</h4>

                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label4" runat="server" Text="Date and Time: "></asp:Label>
                                        &nbsp;
                                        <asp:Label ID="lblIncidentDate" runat="server" Text="-"></asp:Label>
                                    </div>
                                    </br>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label10" runat="server" Text="Student ID: "></asp:Label>
                                        &nbsp;
                                        <asp:Label ID="lblStudId" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label7" runat="server" Text="Student Name: "></asp:Label>
                                        &nbsp;
                                        <asp:Label ID="lblStudName" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label9" runat="server" Text="Educator ID: "></asp:Label>
                                        &nbsp;
                                        <asp:Label ID="lblEduId" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label12" runat="server" Text="Educator Name: "></asp:Label>
                                        &nbsp;
                                        <asp:Label ID="lblEduName" runat="server" Text="-"></asp:Label>
                                    </div>
                                    </br>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label3" runat="server" Text="Incident Type: "></asp:Label>
                                        &nbsp;
                                        <asp:Label ID="lblIncidentType" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="Label11" runat="server" Text="Description: "></asp:Label>
                                        </br>
                                        <asp:Label ID="lblDesc" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="row mb-3" style="color: darkgray">
                                        ________________________________________________________________________________________________________________________________________________________
                                    </div>

                                    <%--approval--%>
                                    <div class="row">
                                        <h4 class="pt-2 pl-3" style="font-weight: bold">Approval Information</h4>

                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="lblApprovalPpl" runat="server" Text="Approved by:"></asp:Label>&nbsp;
                                        <asp:Label ID="lblAdmin" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="container px-3 pt-2">
                                        <asp:Label ID="lblApprovalDate" runat="server" Text="Approved on:"></asp:Label>&nbsp;
                                            <asp:Label ID="lblDate" runat="server" Text="-"></asp:Label>
                                    </div>
                                    <div class="d-flex justify-content-center my-3 py-4 mb-lg-4">
                                        <asp:Button ID="btnBack" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-5" Text="BACK" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnBack_Click" />
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
