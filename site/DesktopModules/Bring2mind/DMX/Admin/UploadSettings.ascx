<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="UploadSettings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.UploadSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<asp:label runat="server" id="lblNotePortal" resourcekey="lblNotePortal" cssclass="NormalRed" />

<style>
td.DMX_EditTitle
{
 white-space: nowrap;
 padding-right: 20px;
}
</style>

<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plUploadProvider" runat="server" controlname="ddUploadProvider" suffix=":" />
  </td>
  <td>
 	 <asp:dropdownlist id="ddUploadProvider" runat="server" width="300px" AutoPostBack="true" DataTextField="FriendlyName" DataValueField="ProviderName" />
  </td>
 </tr>
</table>

<asp:PlaceHolder runat="server" ID="plhSettings" />

<p>
 <asp:linkbutton id="cmdUpdate" runat="server" CssClass="dnnPrimaryAction" borderstyle="none" text="Update" resourcekey="cmdUpdate" />&nbsp; 
 <asp:hyperlink id="cmdCancel" runat="server" CssClass="dnnSecondaryAction" borderstyle="none" text="Cancel" resourcekey="cmdCancel" />
</p>
