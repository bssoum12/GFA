<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ViewTemplateEdit.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.ViewTemplateEdit" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
/* <![CDATA[ */
 var confirmSave = '<%=DotNetNuke.Services.Localization.Localization.GetString("confirmSave", LocalResourceFile)%>';
 var ddTemplateId = '<%=ddTemplates.ClientId%>'
/* ]]> */
</script>
<table width="100%" cellspacing="4" cellpadding="0" border="0" runat="server" id="tblSelect">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plTemplates" runat="server" controlname="ddTemplates" suffix=":" />
  </td>
  <td>
   <asp:DropDownList runat="server" ID="ddTemplates" AutoPostBack="true" />
   &nbsp;
   <asp:LinkButton runat="server" ID="cmdDownload" resourcekey="cmdDownload" CssClass="dnnSecondaryAction" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plCopy" runat="server" controlname="txtCopy" suffix=":" />
  </td>
  <td>
   <asp:textbox runat="server" ID="txtCopy" Width="200" />
   &nbsp;
   <asp:LinkButton runat="server" ID="cmdCopy" resourcekey="cmdCopy" CssClass="dnnSecondaryAction" />
  </td>
 </tr>
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plUpload" runat="server" controlname="txtUpload" suffix=":" />
  </td>
  <td>
   <asp:FileUpload runat="server" ID="ctlUpload" />
   &nbsp;
   <asp:textbox runat="server" ID="txtUpload" Width="200" />
   <asp:LinkButton runat="server" ID="cmdUpload" resourcekey="cmdUpload" CssClass="dnnSecondaryAction" />
  </td>
 </tr>
 <tr>
  <td colspan="2" style="text-align:center;">
   <asp:LinkButton runat="server" ID="cmdEdit" resourcekey="cmdEdit" CssClass="dnnSecondaryAction" />
   <asp:LinkButton runat="server" ID="cmdDelete" resourcekey="cmdDelete" CssClass="dnnSecondaryAction" />
  </td>
 </tr>
</table>

<table width="100%" cellspacing="4" cellpadding="0" border="0" runat="server" id="tblEdit">
 <tr>
  <td class="DMX_EditTitle SubHead">
   <dnn:label id="plFile" runat="server" controlname="ddFile" suffix=":" />
  </td>
  <td>
   <asp:DropDownList runat="server" ID="ddFile" />
  </td>
 </tr>
 <tr>
  <td colspan="2" class="SubHead">
   <dnn:label id="plContent" runat="server" controlname="txtContent" />
  </td>
 </tr>
 <tr>
  <td colspan="2">
   <ComponentArt:CallBack ID="ContentCallBack" runat="Server">
    <Content>
     <asp:TextBox runat="server" ID="txtContent" TextMode="MultiLine" Width="800" Height="400" />
    </Content>
   </ComponentArt:CallBack>
  </td>
 </tr>
 <tr>
  <td colspan="2">
   <input type="button" class="dnnSecondaryAction" name="cmdSave" id="cmdSave" onclick="saveTemplate();" value="<%=DotNetNuke.Services.Localization.Localization.GetString("cmdSave", LocalResourceFile)%>" disabled="true" />
  </td>
 </tr>
</table>

<p style="width:100%;text-align:center;margin-top:30px;">
 <asp:Label runat="server" ID="lblError" CssClass="NormalRed" />
 <asp:LinkButton runat="server" ID="cmdReturn" resourcekey="cmdReturn" CssClass="dnnPrimaryAction" />
</p>

<ComponentArt:CallBack ID="SaveCallBack" runat="Server" />
