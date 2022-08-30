<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="OnlineHobby.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="container-fluid div-background mt-3">
        <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSuccess" visible="false">
            Profile updated successful.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
            Name and email are necessary to be fill up.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired2" visible="false">
            Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgImage" visible="false">
            Please make sure the image entension is png or jpg file.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgError" visible="false">
            Error:
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="text-center">
            <h2 class="mt-5 pt-4 mb-3 pb-3" style="color: #f98006; font-weight: bold">My Profile</h2>
        </div>

        <div class="row  my-3">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="row">
                    <div class="col-md-3 ms-4">
                        <asp:Image ID="imgProfile" runat="server" CssClass="rounded-circle img-fluid" Height="100" Width="100" ImageUrl="~/Resources/profile_orange.png" />
                    </div>
                    <div class="col-md-8">
                        <div class="row my-2">
                            <asp:Label ID="Label4" runat="server" Text="Upload Profile Image" AutoPostBack="True" onchange="this.form.submit();">Upload Profile Image </asp:Label>
                        </div>
                        <div class="row">
                            <div class="input-group">
                                <div class="flex-grow-1">
                                    <asp:FileUpload ID="fileUploadImg" runat="server" CssClass="form-control" AutoPostBack="true" onchange="this.form.submit();"/>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>


            </div>
            <%--<div class="col-md-2">
                <asp:Image ID="imgProfile" runat="server" CssClass="rounded-circle img-fluid" Height="100" Width="100" ImageUrl="~/Resources/profile_icon.png" />
            </div>
            <div class="col-md-4 mt-1">
                <div class="row my-2">
                    <asp:Label ID="Label4" runat="server" Text="Upload Profile Image">Upload Profile Image   <i class="fas fa-upload"></i></asp:Label>--%>
            <%--<i class="fas fa-upload"></i>--%>
            <%-- </div>
                <div class="row">
                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" />
                </div>
            </div>--%>
            <div class="col-md-3"></div>
        </div>

        <%--name--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-1">
                <div class="row my-1">
                    <asp:Label ID="Label3" runat="server" Text="Name"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtPName" type="text" CssClass="form-control" runat="server"></asp:TextBox>
                            <%--                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Please include letters only." ControlToValidate="txtSUName" Font-Size="Small" ForeColor="Red" ValidationExpression="[a-zA-Z][a-zA-Z ]*">*Please include letters only.</asp:RegularExpressionValidator>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>


        <%--email--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label1" runat="server" Text="Email Address"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtPEmail" type="text" CssClass="form-control" runat="server"></asp:TextBox>
                            <%--                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Please enter a valid email address." ControlToValidate="txtSUEmail" Font-Size="Small" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*Please enter a valid email address.</asp:RegularExpressionValidator>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <%--about(Edu)--%>
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="row  ml-4">
                <div class="col-md-3"></div>
                <div class="col-md-6 mt-4">
                    <div class="row my-1">
                        <asp:Label ID="Label2" runat="server" Text="About"></asp:Label>
                    </div>
                    <div class="row">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:TextBox ID="txtPAbout" type="text" CssClass="form-control" runat="server" Height="64px" TextMode="MultiLine"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3"></div>
            </div>
        </asp:Panel>


        <div class="d-flex justify-content-center mt-5 pt-2 mb-3 pb-5 mb-lg-4">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="SAVE CHANGES" type="submit" Style="height: 47px; width: 238px; background-color: #f98006; color: white" OnClick="btnSubmit_Click" />
        </div>

    </div>

</asp:Content>
