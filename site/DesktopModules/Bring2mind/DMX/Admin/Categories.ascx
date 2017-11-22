<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Categories.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.Categories" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<%@ Register TagPrefix="dmx" Assembly="Bring2mind.DNN.Modules.DMX.Core" Namespace="Bring2mind.DNN.Modules.DMX.UI.WebControls" %>

<script type="text/javascript">
 //<![CDATA[
 var ddLanguagesId = '<%= ddLanguages.ClientId %>';
 var catDeleteConfirm = '<%=DotNetNuke.Services.Localization.Localization.GetString("CatDeleteConfirm", LocalResourceFile)%>';
 var newNodeDefText = '<%=DotNetNuke.Services.Localization.Localization.GetString("NewCategory", LocalResourceFile)%>';
 var newNodeJSON = '<%=GetNewNodeJSON%>';
 //]]>
</script>

<asp:Panel runat="server" ID="pnlMain">

<asp:DropDownList runat="server" ID="ddLanguages" Width="400" /><br />
<ComponentArt:TreeView id="tvCategories" Width="400" AutoAssignNodeIDs="true"
  EnableViewState="true"
  DragAndDropEnabled="true"
  NodeEditingEnabled="true"
  DropSiblingEnabled="true"
  KeyboardEnabled="true"
  MultipleSelectEnabled="true"
  KeyboardCutCopyPasteEnabled="true"
  DisplayMargin="false"
  DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" LineImageWidth="19" LineImageHeight="20"
  ShowLines="false"
  ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/16/"
  AutoTheming="true"
  runat="server">
  <ClientEvents>
   <NodeRename EventHandler="nodeRename" />
   <NodeSelect EventHandler="nodeSelect" />
  </ClientEvents>
</ComponentArt:TreeView><br />
<input type="button" id="btnExpandAll" value="<%=DotNetNuke.Services.Localization.Localization.GetString("btnExpandAll", LocalResourceFile)%>" onclick="tvCategories.expandAll();" />
<input type="button" id="btnCollapseAll" value="<%=DotNetNuke.Services.Localization.Localization.GetString("btnCollapseAll", LocalResourceFile)%>" onclick="tvCategories.collapseAll();" />
<input type="button" id="btnAddNode" value="<%=DotNetNuke.Services.Localization.Localization.GetString("btnAddNode", LocalResourceFile)%>" onclick="addNode();" />
<input type="button" id="btnDeleteNode" value="<%=DotNetNuke.Services.Localization.Localization.GetString("btnDeleteNode", LocalResourceFile)%>" onclick="nodeDelete();" disabled="true" />

<p style="width:100%;text-align:center;margin-top:30px;">
 <asp:LinkButton runat="server" ID="cmdUpdate" resourcekey="cmdUpdate" CssClass="dnnPrimaryAction" />
 <asp:LinkButton runat="server" ID="cmdCancel" resourcekey="cmdCancel" CssClass="dnnSecondaryAction" />
 <asp:LinkButton runat="server" ID="cmdNoAjaxEdit" resourcekey="cmdNoAjaxEdit" CssClass="dnnSecondaryAction" />
 <asp:LinkButton runat="server" ID="cmdBulkAdd" resourcekey="cmdBulkAdd" CssClass="dnnSecondaryAction" />
</p>

</asp:Panel>
<asp:PlaceHolder runat="server" ID="plhLegacy" />

