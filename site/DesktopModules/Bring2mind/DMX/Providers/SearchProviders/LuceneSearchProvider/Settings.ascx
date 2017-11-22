<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Settings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Services.Search.LuceneSearchProvider.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSearchDescending" runat="server" controlname="chkSearchDescending" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:checkbox runat="server" id="chkSearchDescending" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
  <dnn:label id="plMaxContentsSearchResults" runat="server" controlname="txtMaxContentsSearchResults" suffix=":" />
  </td>
  <td class="SubHead">
   <asp:TextBox runat="server" ID="txtMaxContentsSearchResults" Width="300" />
  </td>
 </tr>
</table>
