<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TemplateSettings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Views.Settings.TemplateSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<h2 id="H1" class="dnnFormSectionHead">
 <a href="#" class="dnnSectionExpanded">
  <%=LocalizeString("TemplateSettings")%></a></h2>
<fieldset>
 <div class="dnnFormItem">
   <dnn:label id="plTemplates" runat="server" controlname="ddTemplates" suffix=":" />
   <asp:DropDownList runat="server" ID="ddTemplates" AutoPostBack="true" />
 </div>
</fieldset>
