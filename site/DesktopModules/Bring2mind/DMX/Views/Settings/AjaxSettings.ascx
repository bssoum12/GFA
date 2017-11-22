<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AjaxSettings.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Views.Settings.AjaxSettings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<h2 id="H1" class="dnnFormSectionHead">
 <a href="#" class="dnnSectionExpanded">
  <%=LocalizeString("AjaxSettings")%></a></h2>
<fieldset>
 <div class="dnnFormItem">
   <dnn:label id="plMenu" runat="server" controlname="ddMenu" suffix=":" />
   <asp:DropDownList runat="server" ID="ddMenu" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plAdminMenu" runat="server" controlname="ddAdminMenuMenu" suffix=":" />
   <asp:DropDownList runat="server" ID="ddAdminMenu" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plShowCollectionsButton" runat="server" controlname="chkShowCollectionsButton"
    suffix=":" />
   <asp:CheckBox runat="server" ID="chkShowCollectionsButton" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plShowCategoriesButton" runat="server" controlname="chkShowCategoriesButton"
    suffix=":" />
   <asp:CheckBox runat="server" ID="chkShowCategoriesButton" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plShowSearchButton" runat="server" controlname="chkShowSearchButton"
    suffix=":" />
   <asp:CheckBox runat="server" ID="chkShowSearchButton" />
 </div>
 <div class="dnnFormItem">
   <dnn:label id="plShowMySubscriptionsButton" runat="server" controlname="chkShowMySubscriptionsButton"
    suffix=":" />
   <asp:CheckBox runat="server" ID="chkShowMySubscriptionsButton" />
 </div>
</fieldset>




