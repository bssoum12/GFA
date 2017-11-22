<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Import.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.Import" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table cellspacing="0" cellpadding="0" width="750" border="0" summary="Module Settings Design Table">
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plDirectory" runat="server" controlname="txtDirectory" suffix=":" /></td>
  <td valign="top">
   <asp:textbox id="txtDirectory" width="400px" maxlength="255" cssclass="NormalTextBox" runat="server" />&nbsp;
   <asp:linkbutton id="cmdTest" CssClass="dnnSecondaryAction" runat="server" resourcekey="cmdTest" borderstyle="None" />
  </td>
 </tr>
</table>
<p>&nbsp;</p>
<p><asp:label id="lblImport" runat="server" cssclass="NormalRed" /></p>
<br />
<asp:linkbutton id="cmdImport" CssClass="dnnPrimaryAction" runat="server" borderstyle="None" resourcekey="cmdImport" Text="Import" />&nbsp;
<asp:linkbutton id="cmdCancel" CssClass="dnnSecondaryAction" runat="server" causesvalidation="False" borderstyle="None" />

