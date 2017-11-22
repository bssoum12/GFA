<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RssSettings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.RssSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<asp:label runat="server" id="lblNoteModule" resourcekey="lblNoteModule" cssclass="NormalRed" />

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
   <dnn:label id="plEnabled" runat="server" controlname="chkEnabled" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkEnabled" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plShowIcon" runat="server" controlname="chkShowIcon" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkShowIcon" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plOnlyAnon" runat="server" controlname="chkOnlyAnon" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkOnlyAnon" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDownloadLinks" runat="server" controlname="chkDownloadLinks" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkDownloadLinks" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plNumberOfItems" runat="server" controlname="txtNumberOfItems" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtNumberOfItems" runat="server" width="60" maxlength="10" cssclass="NormalTextBox" />&nbsp;
   <asp:comparevalidator ID="Comparevalidator1" runat="server" errormessage="Not a valid whole number!" operator="DataTypeCheck" type="Integer" controltovalidate="txtNumberOfItems" display="Dynamic" />&nbsp;
   <asp:requiredfieldvalidator ID="Requiredfieldvalidator1" runat="server" errormessage="Required!" controltovalidate="txtNumberOfItems" display="Dynamic" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plMaxAge" runat="server" controlname="txtMaxAge" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtMaxAge" runat="server" width="60" maxlength="10" cssclass="NormalTextBox" />&nbsp;
   <asp:comparevalidator ID="Comparevalidator2" runat="server" errormessage="Not a valid whole number!" operator="DataTypeCheck" type="Integer" controltovalidate="txtMaxAge" display="Dynamic" />&nbsp;
   <asp:requiredfieldvalidator ID="Requiredfieldvalidator2" runat="server" errormessage="Required!" controltovalidate="txtMaxAge" display="Dynamic" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plCategoryId" runat="server" controlname="txtCategoryId" suffix=":" />
  </td>
  <td>
   <asp:dropdownlist id="ddCategory" runat="server" datatextfield="CategoryName" datavaluefield="CategoryId" />&nbsp;
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plRowFilter" runat="server" controlname="txtRowFilter" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtRowFilter" runat="server" width="400" cssclass="NormalTextBox" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSortOrder" runat="server" controlname="txtSortOrder" suffix=":" />
  </td>
  <td>
   <asp:textbox id="txtSortOrder" runat="server" width="400" cssclass="NormalTextBox" />
  </td>
 </tr>
</table>

<p>
 <asp:linkbutton id="cmdUpdate" runat="server" CssClass="dnnPrimaryAction" borderstyle="none" text="Update" resourcekey="cmdUpdate" />&nbsp; 
 <asp:linkbutton id="cmdCancel" runat="server" CssClass="dnnSecondaryAction" borderstyle="none" text="Cancel" resourcekey="cmdCancel" />
</p>
