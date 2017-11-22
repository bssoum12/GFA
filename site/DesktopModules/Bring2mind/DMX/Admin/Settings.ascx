<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Settings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.Admin.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SectionHead" Src="~/controls/SectionHeadControl.ascx" %>
<%@ Register TagPrefix="dmx" TagName="FileDropDownSelect" Src="~/DesktopModules/Bring2mind/DMX/Controls/FileDropDownSelect.ascx" %>
<%@ Register TagPrefix="dmx" TagName="CategoryDropDownSelect" Src="~/DesktopModules/Bring2mind/DMX/Controls/CategoryDropDownSelect.ascx" %>

<h2 id="dnnPanel-ModuleGeneralDetails" class="dnnFormSectionHead">
 <a href="#" class="dnnSectionExpanded">
  <%=LocalizeString("RootSettings")%></a></h2>
<fieldset>
 <div class="dnnFormItem">
 <%=LocalizeString("RootSettings.Help")%>
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plRootColl" runat="server" controlname="ddRootSelect" suffix=":" />
   <dmx:FileDropDownSelect runat="server" id="ddRootSelect" RootId="0" />
 </div>
 <div class="dnnFormItem">
      <dnn:label id="plRootPattern" runat="server" controlname="txtRootPattern" suffix=":" />
      <asp:TextBox runat="server" ID="txtRootPattern" Width="300" />
 </div>
 <div class="dnnFormItem">
      <dnn:label id="plAutoCreateRoot" runat="server" controlname="chkAutoCreateRoot" suffix=":" />
      <asp:CheckBox runat="server" ID="chkAutoCreateRoot" />
 </div>
 <div class="dnnFormItem">
      <dnn:label id="plAutoInheritPermission" runat="server" controlname="chkAutoInheritPermission" suffix=":" />
      <asp:CheckBox runat="server" ID="chkAutoInheritPermission" />
 </div>
 <div class="dnnFormItem">
      <dnn:label id="plAutoAddViewPermission" runat="server" controlname="chkAutoAddViewPermission"
       suffix=":" />
      <asp:CheckBox runat="server" ID="chkAutoAddViewPermission" />
 </div>
 <div class="dnnFormItem">
      <dnn:label id="plAutoAddAddPermission" runat="server" controlname="chkAutoAddAddPermission"
       suffix=":" />
      <asp:CheckBox runat="server" ID="chkAutoAddAddPermission" />
 </div>
 <div class="dnnFormItem">
      <dnn:label id="plAutoAddSubscription" runat="server" controlname="chkAutoAddSubscription"
       suffix=":" />
      <asp:CheckBox runat="server" ID="chkAutoAddSubscription" />
 </div>
 <div class="dnnFormItem">
      <dnn:label id="plAutoUnifyChildren" runat="server" controlname="chkAutoUnifyChildren"
       suffix=":" />
      <asp:CheckBox runat="server" ID="chkAutoUnifyChildren" />
 </div>
</fieldset>

<h2 id="H1" class="dnnFormSectionHead">
 <a href="#" class="dnnSectionExpanded">
  <%=LocalizeString("OtherData")%></a></h2>
<fieldset>
 <div class="dnnFormItem">
   <dnn:label id="plDefaultSortOrder" runat="server" controlname="txtDefaultSortOrder"
    suffix=":" />
   <asp:TextBox runat="server" ID="txtDefaultSortOrder" Width="300" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plRootCat" runat="server" controlname="ddCatRootSelect" suffix=":" />
   <dmx:CategoryDropDownSelect runat="server" id="ddCatRootSelect" RootId="0" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plLimitCategoriesToCollection" runat="server" controlname="chkLimitCategoriesToCollection"
    suffix=":" />
   <asp:CheckBox runat="server" ID="chkLimitCategoriesToCollection" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plShowDeletedInline" runat="server" controlname="chkShowDeletedInline"
    suffix=":" />
   <asp:CheckBox runat="server" ID="chkShowDeletedInline" />
 </div>
</fieldset>

<h2 id="H2" class="dnnFormSectionHead">
 <a href="#" class="dnnSectionExpanded">
  <%=LocalizeString("UI")%></a></h2>
<fieldset>
 <div class="dnnFormItem">
   <dnn:label id="plStartup" runat="server" controlname="ddStartup" suffix=":" />
   <asp:DropDownList ID="ddStartup" runat="server" CssClass="NormalTextBox" Width="300px" AutoPostBack="true" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plDefaultEditPane" runat="server" controlname="ddDefaultEditPane" suffix=":" />
   <asp:DropDownList ID="ddDefaultEditPane" runat="server" CssClass="NormalTextBox" Width="300px" />
 </div>
</fieldset>

<h2 id="H3" class="dnnFormSectionHead">
 <a href="#" class="dnnSectionExpanded">
  <%=LocalizeString("AdvancedUI")%></a></h2>
<fieldset>
 <div class="dnnFormItem">
   <dnn:label id="plStartupOther" runat="server" controlname="txtStartup" suffix=":" />
   <asp:TextBox ID="txtStartup" runat="server" CssClass="NormalTextBox" MaxLength="255"
    Width="300" />&nbsp;
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plDefaultEditPaneOther" runat="server" controlname="txtDefaultEditPane" suffix=":" />
   <asp:TextBox ID="txtDefaultEditPane" runat="server" CssClass="NormalTextBox" MaxLength="255"
    Width="300" />&nbsp;
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plServeBootstrap" runat="server" controlname="chkServeBootstrap" suffix=":" />
   <asp:CheckBox runat="server" ID="chkServeBootstrap" />
 </div>
</fieldset>

<asp:Panel runat="server" ID="pnlViewSettings" />



