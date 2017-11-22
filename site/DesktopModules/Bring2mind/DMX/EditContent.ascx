<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditContent.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.EditContent" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<style>
td.DMX_EditTitle
{
 white-space: nowrap;
 padding-right: 20px;
}
</style>
<table cellspacing="4" cellpadding="0" border="0">
 <tr runat="server" id="trFilename">
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plFilename" runat="server" controlname="txtFilename" suffix=":" />
  </td>
  <td>
   <asp:TextBox runat="server" ID="txtFilename" Width="300" />
  </td>
 </tr>
 <tr>
  <td colspan="2" class="SubHead">
   <dnn:label id="plContent" runat="server" controlname="plhEditControl" suffix=":" />
  </td>
 </tr>
 <tr>
  <td colspan="2">
   <asp:PlaceHolder runat="server" ID="plhEditControl" />
  </td>
 </tr>
</table>

<p>
 <asp:linkbutton id="cmdSave" CssClass="dnnPrimaryAction" runat="server" resourcekey="cmdSave" />
 <asp:linkbutton id="cmdCancel" CssClass="dnnSecondaryAction" runat="server" resourcekey="cmdCancel" />
</p>
