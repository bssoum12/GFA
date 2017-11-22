<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LicenseManualCall.aspx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.LicenseManualCall" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title>DotNetNuke</title>
  <link rel="stylesheet" type="text/css" href="~/Install/Install.css">
  <link rel="stylesheet" type="text/css" href="~/Portals/_default/Default.css">
</head>
<body style="padding: 20px;">
 <p><img src="logo.gif" border="0"></p>
 <form id="form1" runat="server">
 <div>
  <h2><asp:Label runat="server" ID="plStatusT" resourcekey="plStatus.Text" CssClass="SubHead" /></h2>
  <p><asp:Label runat="server" ID="plStatusH" resourcekey="plStatus.Help" CssClass="Normal" /></p>
  <p><%=(New Bring2mind.DNN.Modules.DMX.Services.Licensing.License()).Status.Replace(vbCrLf, "<br />")%></p>
  <hr />

  <h2><asp:Label runat="server" ID="lblDetails" resourcekey="Details.Help" /></h2>
  <hr />

  <p><asp:Label runat="server" ID="plTrialLicenseT" resourcekey="plTrialLicense.Text" CssClass="SubHead" /><br />
  <asp:Label runat="server" ID="plTrialLicenseH" resourcekey="plTrialLicense.Help" CssClass="Normal" /></p>
  <p><asp:CheckBox ID="chkTrialLicense" runat="server" AutoPostBack="true" /></p>
  <hr />

  <p><asp:Label runat="server" ID="plAccountT" resourcekey="plAccount.Text" CssClass="SubHead" /><br />
  <asp:Label runat="server" ID="plAccountH" resourcekey="plAccount.Help" CssClass="Normal" /></p>
  <p><asp:TextBox runat="server" ID="txtAccount" Width="300" /></p>
  <hr />

  <p><asp:Label runat="server" ID="plInvoiceT" resourcekey="plInvoice.Text" CssClass="SubHead" /><br />
  <asp:Label runat="server" ID="plInvoiceH" resourcekey="plInvoice.Help" CssClass="Normal" /></p>
  <p><asp:TextBox runat="server" ID="txtInvoice" Width="300" /></p>
  <hr />

  <h2><asp:Label runat="server" ID="lblServerKey" resourcekey="ServerKey.Help" /></h2>
  <hr />

  <p><asp:Button runat="server" ID="cmdGenerateServerKey" resourcekey="cmdGenerateServerKey" CssClass="dnnSecondaryAction" /></p>
  <p><asp:Label runat="server" ID="plServerIdT" resourcekey="plServerId.Text" CssClass="SubHead" /><br />
  <asp:Label runat="server" ID="plServerIdH" resourcekey="plServerId.Help" CssClass="Normal" /></p>
  <p><asp:TextBox runat="server" ID="txtServerId" TextMode="MultiLine" Width="400" Height="250" /></p>
  <hr />

  <p><asp:Label runat="server" ID="lblHelp" resourcekey="DirectEntry.Help" /></p>
  <hr />
 
 
  <h2><asp:Label runat="server" ID="lblActivate" resourcekey="Activate.Help" /></h2>
  <hr />

  <p><asp:Label runat="server" ID="plActivationKeyT" resourcekey="plActivationKey.Text" CssClass="SubHead" /><br />
  <asp:Label runat="server" ID="plActivationKeyH" resourcekey="plActivationKey.Help" CssClass="Normal" /></p>
  <p><asp:TextBox runat="server" ID="txtActivationKey" TextMode="MultiLine" Width="400" Height="150" /></p>
  <hr />
  
  <p><asp:Button runat="server" ID="cmdUpload" resourcekey="cmdUpload" CssClass="dnnSecondaryAction" /></p>
  <p><asp:Label runat="server" ID="lblReport" /></p>
  <hr />
 
 </div>
 <p style="width:100%;text-align:center">
  <asp:linkbutton id="cmdReturn" runat="server" CssClass="dnnPrimaryAction" borderstyle="none" text="Return" resourcekey="cmdReturn" />
 </p>
 </form>
 <p>&nbsp;</p>
</body>
</html>
