<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Url.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Url" %>
<table cellspacing="0" cellpadding="0" border="0">
 <tr id="TypeRow" runat="server">
  <td nowrap>
   <br>
   <asp:Label ID="lblURLType" runat="server" EnableViewState="False" resourcekey="Type"
    CssClass="NormalBold"></asp:Label><br>
   <asp:RadioButtonList ID="optType" CssClass="NormalBold" AutoPostBack="True" RepeatDirection="Vertical"
    runat="server">
   </asp:RadioButtonList><br>
  </td>
 </tr>
 <tr id="URLRow" runat="server">
  <td nowrap>
   <asp:Label ID="lblURL" runat="server" EnableViewState="False" resourcekey="URL" CssClass="NormalBold"></asp:Label>
   <asp:TextBox ID="txtUrl" runat="server" CssClass="NormalTextBox" Width="300"></asp:TextBox>
  </td>
 </tr>
 <tr id="TabRow" runat="server">
  <td nowrap>
   <asp:Label ID="lblTab" runat="server" EnableViewState="False" resourcekey="Tab" CssClass="NormalBold"></asp:Label>
   <asp:DropDownList ID="cboTabs" runat="server" DataTextField="TabName" DataValueField="TabId" CssClass="NormalTextBox"
    Width="300">
   </asp:DropDownList></td>
 </tr>
</table>
