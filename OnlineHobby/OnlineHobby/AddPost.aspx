<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="AddPost.aspx.cs" Inherits="OnlineHobby.AddPost" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="container-fluid div-background mt-3">
        <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSuccess" visible="false">
            Post details added successful.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgImage" visible="false">
            Please make sure the image entension is png or jpg file.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="text-center">
            <h2 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">New Post</h2>
        </div>

        <%--desc--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-1">
                <div class="row my-1">
                    <asp:Label ID="Label3" runat="server" Text="Description"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtDesc" type="text" CssClass="form-control" runat="server" Height="96px" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <%--image--%>
        <div class="row  ml-4 mt-2">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-1">
                <div class="row my-1">
                    <asp:Label ID="Label1" runat="server" Text="Image (if any)"></asp:Label>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <asp:Image ID="imgPostImage" runat="server" Height="179px" Width="178px" />
                    </div>
                    <div class="col-md-8">
                        <div class="input-group">
                            <div class="flex-grow-1">
                                <asp:FileUpload ID="fileUploadImg" runat="server" CssClass="form-control" AutoPostBack="true" onchange="this.form.submit();"/>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="col-md-3"></div>
        </div>


        <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill" Text="POST" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnSubmit_Click" />
        </div>

    </div>
</asp:Content>
