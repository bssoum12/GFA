<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SearchSettings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.SearchSettings" %>
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
   <dnn:label id="plMaxSearchResults" runat="server" controlname="txtMaxSearchResults" suffix=":" />
  </td>
  <td>
   <asp:TextBox runat="server" ID="txtMaxSearchResults" Width="100" />
   <asp:CompareValidator runat="server" ID="valMaxSearchResults" ControlToValidate="txtMaxSearchResults" CssClass="NormalRed"
    Operator="DataTypeCheck" Type="Integer" ResourceKey="WholeNumber.Error" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSearchProvider" runat="server" controlname="ddSearchProvider" suffix=":" />
  </td>
  <td>
 	 <asp:dropdownlist id="ddSearchProvider" runat="server" width="300px" AutoPostBack="true" DataTextField="FriendlyName" DataValueField="ProviderName" />
  </td>
 </tr>
</table>

<asp:PlaceHolder runat="server" ID="plhSettings" />

<p>
 <asp:linkbutton id="cmdUpdate" runat="server" CssClass="dnnPrimaryAction" borderstyle="none" text="Update" resourcekey="cmdUpdate" />&nbsp; 
 <asp:hyperlink id="cmdCancel" runat="server" CssClass="dnnSecondaryAction" borderstyle="none" text="Cancel" resourcekey="cmdCancel" />
</p>
