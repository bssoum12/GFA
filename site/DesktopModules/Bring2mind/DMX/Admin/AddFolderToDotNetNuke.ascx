<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AddFolderToDotNetNuke.ascx.vb"
 Inherits="Bring2mind.DNN.Modules.DMX.Admin.AddFolderToDotNetNuke" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls"%>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.WebControls" Namespace="DotNetNuke.UI.WebControls"%>
<%@ Register TagPrefix="dmx" TagName="FileDropDownSelect" Src="~/DesktopModules/Bring2mind/DMX/Controls/FileDropDownSelect.ascx" %>

<%=LocalizeString("ModuleHelp.Text")%>

<dnn:Label ID="plAdded" runat="server" ControlName="mappingsGrid" Suffix=":" />
<asp:DataGrid ID="mappingsGrid" CellPadding="0" CellSpacing="0" AutoGenerateColumns="false" runat="server" GridLines="None" Width="100%" CssClass="dnnGrid">
 <HeaderStyle Wrap="False" CssClass="dnnGridHeader" />
 <ItemStyle CssClass="dnnGridItem" VerticalAlign="Top" />
 <AlternatingItemStyle CssClass="dnnGridAltItem" />
 <Columns>
  <dnn:textcolumn headerStyle-width="150px" DataField="DMXPath" HeaderText="DMXPath">
   <itemstyle font-bold="true" />
  </dnn:textcolumn>
  <dnn:textcolumn headerStyle-width="150px" DataField="DNNPath" HeaderText="DNNPath">
   <itemstyle font-bold="true" />
  </dnn:textcolumn>
 </Columns>
</asp:DataGrid>
<div style="clear:both;display:block;" />
<div class="dnnForm">
 <fieldset>
  <div class="dnnFormItem">
   <dnn:Label ID="plName" runat="server" ControlName="txtName" Suffix=":" />
   <asp:TextBox runat="server" ID="txtName" />
  </div>
  <div class="dnnFormItem">
   <dnn:Label ID="plEntryId" runat="server" ControlName="ddRootSelect" Suffix=":" />
   <dmx:FileDropDownSelect runat="server" ID="dmxFolderSelect" RootId="0" />
  </div>
 </fieldset>
</div>
<p style="width:100%;text-align:center">
 <asp:LinkButton ID="cmdAdd" runat="server" CssClass="dnnPrimaryAction" BorderStyle="none" resourcekey="cmdAdd" />&nbsp;
 <asp:HyperLink ID="cmdReturn" runat="server" CssClass="dnnSecondaryAction" BorderStyle="none" resourcekey="cmdReturn" />
</p>
