<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Settings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Services.Search.IndexingServiceSearchProvider.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table width="100%" cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="SubHead" width="200">
   <dnn:label id="plIndexCatalog" runat="server" controlname="txtIndexCatalog" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtIndexCatalog" runat="server" width="200" cssclass="NormalTextBox" />&nbsp;
   <asp:linkbutton id="cmdDropServer" runat="server" CssClass="dnnSecondaryAction" causesvalidation="False" borderstyle="none" text="Drop" resourcekey="cmdDropServer" />
   <asp:linkbutton id="cmdLinkServer" runat="server" CssClass="dnnSecondaryAction" causesvalidation="False" borderstyle="none" text="Attach" resourcekey="cmdLinkServer" />
  </td>
 </tr>
 <tr>
  <td class="SubHead" width="200">
   <dnn:label id="plLocalFilePath" runat="server" controlname="txtLocalFilePath" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtLocalFilePath" runat="server" width="400" cssclass="NormalTextBox" />&nbsp;
  </td>
 </tr>
</table>

<div style="width:100%;text-align:left"><asp:label id="lblHelp" resourcekey="lblHelp" runat="server" cssclass="Normal" /></div>

<p><asp:label id="lblError" runat="server" cssclass="NormalRed" /></p>

