<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TemplateView.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Views.TemplateView" %>
<%@ Register TagPrefix="dmx" Assembly="Bring2mind.DNN.Modules.DMX.Core" Namespace="Bring2mind.DNN.Modules.DMX.Services.Templating" %>

<dmx:ViewTemplate runat="server" id="vtContents" />

<asp:panel runat="server" ID="pnlAdmin">
 <p style="margin-top:40px;">
  <asp:CheckBox runat="server" ID="chkShowDeleted" AutoPostBack="true" resourcekey="chkShowDeleted" />&nbsp;
  <asp:LinkButton runat="server" ID="cmdEditTemplates" resourcekey="cmdEditTemplates" />
 </p>
</asp:panel>