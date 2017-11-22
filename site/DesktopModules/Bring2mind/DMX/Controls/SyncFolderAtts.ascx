<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SyncFolderAtts.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.SyncFolderAtts" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<p><asp:Label runat="server" ID="lblAdminOnly" CssClass="NormalRed" /></p>
<table cellSpacing="0" cellPadding="0" border="0">
 <tr>
  <td class="SubHead" vAlign="top" width="200">
   <dnn:label id="plSyncPath" runat="server" controlname="txtSyncPath" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:TextBox runat="server" ID="txtSyncPath" Width="300" />
   <asp:CustomValidator runat="server" id="custFolderCheck"
        ControlToValidate="txtSyncPath"
        ClientValidationFunction="CheckFolder" />
  </td>
 </tr>
 <tr>
  <td class="SubHead" vAlign="top" width="200">
   <dnn:label id="plConflict" runat="server" controlname="ddConflict" suffix=":" />
  </td>
  <td vAlign="top">
   <asp:DropDownList runat="server" ID="ddConflict">
    <asp:ListItem Value="Import" resourceKey="optImport" />
    <asp:ListItem Value="Export" resourceKey="optExport" />
    <asp:ListItem Value="SourceLeading" resourceKey="optSourceLeading" />
    <asp:ListItem Value="DMXLeading" resourceKey="optDMXLeading" />
    <asp:ListItem Value="NoResolution" resourceKey="optNoResolution" />
    <asp:ListItem Value="CopyBothWays" resourceKey="optCopyBothWays" />
   </asp:DropDownList>
  </td>
 </tr>
 <tr><td colspan="2">&nbsp;</td></tr>
 <tr>
  <td colspan="2" class="dmx_warning">
   <asp:Image runat="server" ID="imgWarning" ImageUrl="~/images/yellow-warning.gif" ImageAlign="Left" />
   <%=DotNetNuke.Services.Localization.Localization.GetString("lblWarning", LocalResourceFile)%>
  </td>
 </tr>
</table>
<script language="JavaScript">
<!--
 function CheckFolder(sender, args) {
  args.IsValid = (args.Value.indexOf("^<%=PortalSettings.HomeDirectoryMapPath.Replace("\","\\")%>")==0);
}
// -->
</script>
