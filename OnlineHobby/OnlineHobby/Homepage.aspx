<%@Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="OnlineHobby.Homepage"  MasterPageFile="~/StudMaster.Master"%>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        .div-background {
            background-color: #fffefa;
        }
    </style>

    <div class="div-background">
        <table align="center">
                       <tr>
                           <td align="center">
                               <table style="width:80%;">
                                   <tr>
                                       <td style="width: 45%;">
                                           &nbsp;</td>
                                       <td style="width: 50px; height: 40px;">&nbsp;</td>
                                       <td style="width: 43%; vertical-align: top;">
                                           &nbsp;</td>
                                   </tr>
                                   <tr>
                                       <td style="width: 45%;">
                                           <asp:Image ID="Image4" runat="server" ImageUrl="~/Resources/home.jpg" Width="499px" Height="465px" />
                                       </td>
                                       <td style="width: 50px;">&nbsp;</td>
                                       <td style="width: 43%; vertical-align: top;">
                                           <table style="width: 100%;">
                                               <tr>
                                                   <td class="text-left">
                                                       <asp:Label ID="Label5" runat="server" Font-Bold="True" Font-Names="Gill Sans MT" Font-Size="X-Large" Text="Learn Hobby You Love"></asp:Label>
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td class="text-justify">
                                                       <span style="color: rgb(70, 70, 70); font-family: &quot;PT Serif&quot;, TimesNewRoman, &quot;Times New Roman&quot;, Times, Georgia, serif; font-size: 19px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Successful technologies often begin as hobbies. Jacques Cousteau invented scuba diving because he enjoyed exploring caves. The Wright brothers invented flying as a relief from the monotony of their normal business of selling and repairing bicycles.</span></td>
                                               </tr>
                                           </table>
                                       </td>
                                   </tr>
                               </table>
                           </td>
                       </tr>
                       <tr>
                           <td style="height: 50px;">
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td align="center">
                               <table style="width: 80%;">
                                   <tr>
                                       <td style="vertical-align: top; width: 300px;">
                                           <table style="width:100%;">
                                               <tr>
                                                   <td class="auto-style1">
                                                       <asp:Image ID="Image5" runat="server" ImageUrl="~/Resources/return.png" Width="80px" />
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td class="auto-style1">
                                                       <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Names="Gill Sans MT" Font-Size="Large" Text="14 days return"></asp:Label>
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td class="auto-style1">
                                                       <asp:Label ID="Label10" runat="server" Text="Free returns within 14 days and our best price guarantee. Smooth delivery to your door, trackable and insured." ForeColor="#666666"></asp:Label>
                                                   </td>
                                               </tr>
                                           </table>
                                       </td>
                                       <td class="text-center" style="vertical-align: top">&nbsp;</td>
                                       <td style="vertical-align: top; width: 300px;">
                                           <table style="width:100%;">
                                               <tr>
                                                   <td class="text-center">
                                                       <asp:Image ID="Image6" runat="server" ImageUrl="~/Resources/quality.png" Width="80px" />
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td class="text-center">
                                                       <asp:Label ID="Label8" runat="server" Font-Bold="True" Font-Names="Gill Sans MT" Font-Size="Large" Text="Quality"></asp:Label>
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td class="text-center">
                                                       <asp:Label ID="Label11" runat="server" Text="We provide excellent teaching quality, and the best educators in the world." ForeColor="#666666"></asp:Label>
                                                   </td>
                                               </tr>
                                           </table>
                                       </td>
                                       <td class="text-center" style="vertical-align: top">&nbsp;</td>
                                       <td style="vertical-align: top; width: 300px;">
                                           <table style="width:100%;">
                                               <tr>
                                                   <td class="text-center">
                                                       <asp:Image ID="Image7" runat="server" Height="85px" ImageUrl="~/Resources/original.png" Width="80px" />
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td class="text-center">
                                                       <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Names="Gill Sans MT" Font-Size="Large" Text="Own True Original"></asp:Label>
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td class="text-center">
                                                       <asp:Label ID="Label12" runat="server" Text="Express yourself with a unique piece created by the hands of one of our talented educators." ForeColor="#666666"></asp:Label>
                                                   </td>
                                               </tr>
                                           </table>
                                       </td>
                                   </tr>
                               </table>
                           </td>
                       </tr>
                       <tr>
                           <td>
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td>
                               &nbsp;</td>
                       </tr>
                       <tr>
                           <td>
                               &nbsp;</td>
                       </tr>
                </table>
    </div>
    
</asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="head">
    <style type="text/css">
        .auto-style1 {
            text-align: center;
            width: 267px;
        }
    </style>
</asp:Content>


