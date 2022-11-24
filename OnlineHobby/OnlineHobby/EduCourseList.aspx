<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EduCourseList.aspx.cs" Inherits="OnlineHobby.EduCourseList" MasterPageFile="~/StudMaster.Master" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        .button2 {
            height: 45px;
            background-color: #ffedcf;
            color: black;
            border: 1px solid;
            font-size: 12pt;
            border-radius: 3px;
        }

            .button2:hover {
                background-color: #f5d8a4;
                color: black;
            }

        .div-background {
            background-color: #fffefa;
            min-height: 610px;
        }
    </style>
    <div class="text-center div-background" style="min-height: 600px">
        <br />
        <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="XX-Large" Font-Underline="False" ForeColor="#993333" Text="My Courses"></asp:Label>
        <br />
        <br />
        <asp:Button ID="btnAdd" runat="server" Font-Bold="True" Font-Italic="False" Font-Size="Large" ForeColor="Black" PostBackUrl="~/AddCourse.aspx" Text="ADD COURSE" CssClass="button2" />
        &nbsp;&nbsp;&nbsp;
            <br />
        <br />
        <div class="text-center div-background">
            <asp:DataList ID="dlCourse" runat="server" DataSourceID="SqlDataSource1" HorizontalAlign="Center" RepeatDirection="Horizontal" RepeatColumns="5" OnItemCommand="dlCourse_ItemCommand" CellSpacing="15">
                <ItemTemplate>
                    <div class="card" style="text-align: left !important; margin-right: 15px;">
                        <asp:ImageButton ID="imgbMaterial" class="card-img-top" runat="server" Height="250px" Width="250px" ImageUrl='<%# Eval("courseImage") %>' CommandArgument='<%# Eval("courseId") %>' CommandName="viewModify" BorderStyle="Solid" BorderWidth="3px" ImageAlign="Middle" />
                        <asp:LinkButton ID="linkMaterial" class="card-body" CssClass="text-center"  runat="server" CommandArgument='<%# Eval("courseId") %>' CommandName="viewModify" Font-Underline="False" ForeColor="#993333" Height="50px" Width="250px"><%# Eval("courseName") %> </asp:LinkButton>
                    </div>
                </ItemTemplate>
            </asp:DataList>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [courseId], [courseName], [courseImage] FROM [Course] WHERE (([eduId] = @eduId) AND ([availability] = 'available'))">
            <SelectParameters>
                <asp:SessionParameter Name="eduId" SessionField="UserId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
    </div>
</asp:Content>
