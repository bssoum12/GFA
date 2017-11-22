<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Settings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Services.Storage.S3StorageProvider.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plAccessKeyId" runat="server" controlname="txtAccessKeyId" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:TextBox runat="server" ID="txtAccessKeyId" Width="300" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plSecretAccessKey" runat="server" controlname="txtSecretAccessKey" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:TextBox runat="server" ID="txtSecretAccessKey" Width="300" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead" valign="top">
   <dnn:label id="lblRegion" runat="server" controlname="ddRegion" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:DropDownList runat="server" ID="ddRegion"/>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead" valign="top">
   <dnn:label id="plBucketName" runat="server" controlname="txtBucketName" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:TextBox runat="server" ID="txtBucketName" Width="300" />&nbsp;<asp:Button runat="server" ID="cmdTest" resourcekey="cmdTest" CssClass="dnnSecondaryAction" />&nbsp;<asp:Button runat="server" ID="cmdCreate" resourcekey="cmdCreate" CssClass="dnnSecondaryAction" /><br />
   <pre><asp:Label runat="server" ID="lblResponse" CssClass="NormalRed" /></pre>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plRedirectionMechanism" runat="server" controlname="ddRedirectionMechanism" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:DropDownList runat="server" ID="ddRedirectionMechanism">
    <asp:ListItem resourcekey="optNone" Value="NONE" />
    <asp:ListItem resourcekey="optSecure" Value="SECURE" />
   </asp:DropDownList>
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="lblRedirectTimeout" runat="server" controlname="txtRedirectTimeout" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:TextBox runat="server" ID="txtRedirectTimeout" Width="300" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="lblSSE" runat="server" controlname="chkSSE" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:CheckBox runat="server" ID="chkSSE" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plTimeout" runat="server" controlname="txtTimeout" suffix=":" />
  </td>
  <td class="NormalBold">
   <asp:TextBox runat="server" ID="txtTimeout" Width="300" />
  </td>
 </tr>
</table>
