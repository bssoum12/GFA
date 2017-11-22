<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="File.Htm.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Edit.File_Htm" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<dnn:DNNRichTextEditControl runat="server" id="ctlContent" width="600" height="400" />
<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plUseHtmlPage" runat="server" controlname="chkUseHtmlPage" suffix=":" />
  </td>
  <td>
   <asp:CheckBox runat="server" ID="chkUseHtmlPage" AutoPostBack="true" />
  </td>
 </tr>
 <tr runat="server" id="trTitle">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plTitle" runat="server" controlname="txtTitle" suffix=":" />
  </td>
  <td>
   <asp:TextBox runat="server" ID="txtTitle" Width="300" />
  </td>
 </tr>
 <tr runat="server" id="trPageContext">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plPageContext" runat="server" controlname="txtPageContext" suffix=":" />
  </td>
  <td>
   <asp:TextBox runat="server" ID="txtPageContext" Width="300" Height="200" TextMode="MultiLine" />
  </td>
 </tr>
</table>
