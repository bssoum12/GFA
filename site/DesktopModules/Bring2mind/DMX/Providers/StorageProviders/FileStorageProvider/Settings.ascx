<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Settings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Services.Storage.FileStorageProvider.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead"><dnn:label id="plRepLoc" runat="server" controlname="txtDMXExternal" suffix=":" /></td>
  <td class="SubHead">
   <asp:radiobutton id="optDMXDefault" runat="server" autopostback="True" groupname="DMXDirectory" />&nbsp;
   <asp:label runat="server" id="lblDefText" resourcekey="lblDefText" text="Default"/>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">&nbsp;</td>
  <td><asp:radiobutton id="optDMXExternal" runat="server" autopostback="True" groupname="DMXDirectory" />&nbsp;
   <asp:textbox id="txtDMXExternal" runat="server" cssclass="NormalTextBox" maxlength="255" width="300" />&nbsp;
   <asp:CustomValidator runat="server" ID="valDMXExternal" ControlToValidate="txtDMXExternal" ErrorMessage="*" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSubDir" runat="server" controlname="cboSubDir" suffix=":" />
  </td>
  <td>
	  <asp:dropdownlist id="cboSubDir" runat="server" cssclass="NormalTextBox" width="300px">
    <asp:ListItem Value="None" Text="None" resourcekey="optSubDirNone" />
    <asp:ListItem Value="Daily" Text="Daily" resourcekey="optSubDirDaily" />
    <asp:ListItem Value="Monthly" Text="Monthly" resourcekey="optSubDirMonthly" />
    <asp:ListItem Value="Yearly" Text="Yearly" resourcekey="optSubDirYearly" />
   </asp:dropdownlist>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plChangeFileExtensions" runat="server" controlname="chkChangeFileExtensions" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:checkbox runat="server" id="chkChangeFileExtensions" resourcekey="chkChangeFileExtensions" />
  </td>
 </tr>
</table>
