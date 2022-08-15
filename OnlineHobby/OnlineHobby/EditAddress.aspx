<%@ Page Title="" Language="C#" MasterPageFile="~/NestedProfile.master" AutoEventWireup="true" CodeBehind="EditAddress.aspx.cs" Inherits="OnlineHobby.EditAddress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="Body" runat="server">
      <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="container-fluid div-background mt-3">
        <div class="alert alert-success alert-dismissible fade show" runat="server" id="MsgSuccess" visible="false">
            Address details updated successful.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgRequired" visible="false">
            Please fill up all fields.
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="alert alert-danger alert-dismissible fade show" runat="server" id="MsgError" visible="false">
            Error:
    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <div class="text-center">
            <h2 class="mt-5 pt-3 mb-3 pb-3" style="color: #f98006; font-weight: bold">Edit Address</h2>
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
                            <asp:TextBox ID="txtAddrName" type="text" CssClass="form-control" runat="server"></asp:TextBox>
                            <%--                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="*Please include letters only." ControlToValidate="txtSUName" Font-Size="Small" ForeColor="Red" ValidationExpression="[a-zA-Z][a-zA-Z ]*">*Please include letters only.</asp:RegularExpressionValidator>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>


        <%--phone--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label1" runat="server" Text="Phone Number"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtAddrPhone" type="text" CssClass="form-control" runat="server"></asp:TextBox>
                            <%--                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="*Please enter a valid email address." ControlToValidate="txtSUEmail" Font-Size="Small" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*Please enter a valid email address.</asp:RegularExpressionValidator>--%>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>

        <%--address--%>
        <div class="row  ml-4">
            <div class="col-md-3"></div>
            <div class="col-md-6 mt-4">
                <div class="row my-1">
                    <asp:Label ID="Label2" runat="server" Text="Address"></asp:Label>
                </div>
                <div class="row">
                    <div class="input-group">
                        <div class="flex-grow-1">
                            <asp:TextBox ID="txtAddrAddress" type="text" CssClass="form-control" runat="server" Height="96px" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-3"></div>
        </div>


        <div class="d-flex justify-content-center mt-5 pt-1 mb-3 pb-4 mb-lg-4">
            <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-3" Text="DELETE" type="submit" Style="height: 47px; width: 165px; background-color: #f98006; color: white" OnClick="btnDelete_Click" />
            <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-light btn-lg rounded-pill mx-3" Text="SAVE CHANGES" type="submit" Style="height: 47px; width: 238px; background-color: #f98006; color: white" OnClick="btnSubmit_Click"  />
        </div>

    </div>
</asp:Content>
