<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Languages.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.Languages" %>
<%@ Register TagPrefix="dmx" Namespace="Bring2mind.DNN.Modules.DMX.Common" Assembly="Bring2mind.DNN.Modules.DMX.Core" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/LabelControl.ascx" %>

<style>
td.DMX_EditTitle
{
 white-space: nowrap;
 padding-right: 20px;
}
</style>

<asp:Label runat="server" ID="lblHelp" resourcekey="ModuleHelp" />

<table cellspacing="4" cellpadding="0" border="0">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plLocale" runat="server" controlname="ddLocale" suffix=":" />
  </td>
  <td>
   <asp:DropDownList runat="server" ID="ddLocale" DataTextField="Text" DataValueField="Code" AutoPostBack="true" />
  </td>
 </tr>
</table>

<p><dmx:XslTransformation runat="server" id="trLanguagePacks" /></p>

<p><ComponentArt:CallBack ID="cbFeedBack" runat="Server" RefreshInterval="2000">
</ComponentArt:CallBack></p>

<p>
 <asp:LinkButton runat="server" ID="cmdDownload" resourcekey="cmdDownload" CssClass="dnnSecondaryAction" />&nbsp;
 <asp:LinkButton runat="server" ID="cmdReturn" resourcekey="cmdReturn" CssClass="dnnPrimaryAction" />
</p>


