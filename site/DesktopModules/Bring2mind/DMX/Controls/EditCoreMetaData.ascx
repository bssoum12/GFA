<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditCoreMetaData.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.EditCoreMetaData" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dmx" Assembly="Bring2mind.DNN.Modules.DMX.Core" Namespace="Bring2mind.DNN.Modules.DMX.UI.WebControls" %>

<table cellSpacing="0" cellPadding="0" border="0">
 <tr runat="server" id="trEntryType">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plEntryType" runat="server" controlname="ddEntryType" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:DropDownList runat="server" ID="ddEntryType" DataValueField="ExtensionKey" DataTextField="Name" />
  </td>
 </tr>
 <tr runat="server" id="trUploadedFiles">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plUploadedFiles" runat="server" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:PlaceHolder runat="server" ID="plhUploadedFiles" />
  </td>
 </tr>
 <tr runat="server" id="trUnzip">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plUnzip" runat="server" controlname="chkUnzip" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:CheckBox runat="server" ID="chkUnzip" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox runat="server" ID="chkUseNameAsFolder" />&nbsp;<asp:Label ID="lblUseNameAsFolder" runat="server" resourcekey="chkUseNameAsFolder" />
  </td>
 </tr>
 <tr runat="server" id="trDescription">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plDescription" runat="server" controlname="txtDescription" suffix=":" />
  </td>
  <td vAlign="top">
   <dmx:ShortTextEdit runat="server" id="steTitle" width="400px" StartMaximized="False" Required="True" Regex="^[^\~\\./:\*\?\x22<>\|]{1}[^\~\/:\*\?\x22<>\|]{0,1000}$" />
   <asp:label runat="server" id="lblDescriptionReq" cssclass="NormalRed" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plAuthor" runat="server" controlname="txtAuthor" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:textbox id="txtAuthor" runat="server" cssclass="NormalTextBox" width="400px" maxlength="500" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plKeywords" runat="server" controlname="txtKeywords" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:textbox id="txtKeywords" runat="server" cssclass="NormalTextBox" width="400px" maxlength="255" />
  </td>
 </tr>
 <tr runat="server" id="trVersionsToKeep">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plVersionsToKeep" runat="server" controlname="txtVersionsToKeep" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:textbox id="txtVersionsToKeep" runat="server" cssclass="NormalTextBox" width="50px" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plRemarks" runat="server" controlname="txtRemarks" suffix=":" />
  </td>
  <td>
   <dmx:LongTextEdit runat="server" id="lteRemarks" Width="400px" />
  </td>
 </tr>
 <tr runat="server" id="trThumbnail">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plThumbnail" runat="server" controlname="" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkUseThumbnail" />&nbsp;<asp:Label runat="server" ID="lblUseThumbnail" resourcekey="chkUseThumbnail" /><br />
   <asp:PlaceHolder runat="server" ID="plhThumbnail" />
   <asp:FileUpload runat="server" ID="uplThumbnail" />
   <asp:Button runat="server" ID="cmdRegenerateThumbnail" resourcekey="cmdRegenerateThumbnail" CssClass="dnnSecondaryAction" />
  </td>
 </tr>
</table>



