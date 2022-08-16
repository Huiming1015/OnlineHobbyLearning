<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="AddAchievement.aspx.cs" Inherits="OnlineHobby.AddAchivement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="container-fluid div-background mt-3">
        <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSuccess" visible="false">
            Achievement details added successful.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
            Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="text-center">
            <h2 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">New Achievement</h2>
        </div>

        <%--title--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-1">
                <div class="row my-1">
                    <asp:Label ID="Label3" runat="server" Text="Title"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtTitle" type="text" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>


        <%--org--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label1" runat="server" Text="Issuing Organization"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtIssueOrg" type="text" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <%--date--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label4" runat="server" Text="Issue Date (month, year)"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:DropDownList ID="ddlMonth" CssClass="form-control" runat="server">
                                    <asp:ListItem>Month</asp:ListItem>
                                    <asp:ListItem>January</asp:ListItem>
                                    <asp:ListItem>February</asp:ListItem>
                                    <asp:ListItem>March</asp:ListItem>
                                    <asp:ListItem>April</asp:ListItem>
                                    <asp:ListItem>May</asp:ListItem>
                                    <asp:ListItem>June</asp:ListItem>
                                    <asp:ListItem>July</asp:ListItem>
                                    <asp:ListItem>August</asp:ListItem>
                                    <asp:ListItem>September</asp:ListItem>
                                    <asp:ListItem>October</asp:ListItem>
                                    <asp:ListItem>November</asp:ListItem>
                                    <asp:ListItem>December</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:DropDownList ID="ddlYear" CssClass="form-control" runat="server">
                                    <asp:ListItem>Year</asp:ListItem>
                                    <asp:ListItem>2022</asp:ListItem>
                                    <asp:ListItem>2021</asp:ListItem>
                                    <asp:ListItem>2020</asp:ListItem>
                                    <asp:ListItem>2019</asp:ListItem>
                                    <asp:ListItem>2018</asp:ListItem>
                                    <asp:ListItem>2017</asp:ListItem>
                                    <asp:ListItem>2016</asp:ListItem>
                                    <asp:ListItem>2015</asp:ListItem>
                                    <asp:ListItem>2014</asp:ListItem>
                                    <asp:ListItem>2013</asp:ListItem>
                                    <asp:ListItem>2012</asp:ListItem>
                                    <asp:ListItem>2011</asp:ListItem>
                                    <asp:ListItem>2010</asp:ListItem>
                                    <asp:ListItem>2009</asp:ListItem>
                                    <asp:ListItem>2008</asp:ListItem>
                                    <asp:ListItem>2007</asp:ListItem>
                                    <asp:ListItem>2006</asp:ListItem>
                                    <asp:ListItem>2005</asp:ListItem>
                                    <asp:ListItem>2004</asp:ListItem>
                                    <asp:ListItem>2003</asp:ListItem>
                                    <asp:ListItem>2002</asp:ListItem>
                                    <asp:ListItem>2001</asp:ListItem>
                                    <asp:ListItem>2000</asp:ListItem>
                                    <asp:ListItem>1999</asp:ListItem>
                                    <asp:ListItem>1998</asp:ListItem>
                                    <asp:ListItem>1997</asp:ListItem>
                                    <asp:ListItem>1996</asp:ListItem>
                                    <asp:ListItem>1995</asp:ListItem>
                                    <asp:ListItem>1994</asp:ListItem>
                                    <asp:ListItem>1993</asp:ListItem>
                                    <asp:ListItem>1992</asp:ListItem>
                                    <asp:ListItem>1991</asp:ListItem>
                                    <asp:ListItem>1990</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <%--url--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label2" runat="server" Text="Credential URL"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtCredentialURL" type="text" CssClass="form-control" runat="server"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>


        <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SUBMIT" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnSubmit_Click" />
        </div>

    </div>
</asp:Content>
