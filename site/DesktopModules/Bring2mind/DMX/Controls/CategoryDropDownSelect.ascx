<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="CategoryDropDownSelect.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.CategoryDropDownSelect" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<script type="text/javascript">
//<![CDATA[
function CategoryDropDownSelectTV_onNodeSelect(sender, eventArgs)
{
 if(<%= tvCategories.ClientID %>.get_selectedNode().get_value()=='cannotselect') {cbSelectCategory.collapse();return};
 document.getElementById('<%= txtCategoryId.ClientId %>').value = <%= tvCategories.ClientID %>.get_selectedNode().get_id();
 cbSelectCategory.beginUpdate();
 cbSelectCategory.endUpdate();
 cbSelectCategory.collapse();
}
function getCatSelectedNode()
{
if (<%= tvCategories.ClientID %>.get_selectedNode() != null)
 return <%= tvCategories.ClientID %>.get_selectedNode().get_text();
else
 return "";
}
//]]>
</script>
<ComponentArt:ComboBox id="cbSelectCategory" runat="server"
 TextBoxClientTemplateId="test_template"
 KeyboardEnabled="false"
 AutoFilter="false"
 AutoHighlight="false"
 AutoComplete="false"
 AutoTheming="true"
 DropDownContentCssClass="dropDownContent">
 <DropdownContent>
  <ComponentArt:TreeView id="tvCategories"
    Width="100%"
    DragAndDropEnabled="false"
    NodeEditingEnabled="false"
    KeyboardEnabled="true"
    CssClass="TreeView"
    NodeCssClass="TreeNode"
    SelectedNodeCssClass="SelectedTreeNode"
    HoverNodeCssClass="HoverTreeNode"
    NodeEditCssClass="NodeEdit"
    LineImageWidth="19"
    LineImageHeight="20"
    DefaultImageWidth="16"
    DefaultImageHeight="16"
    ItemSpacing="0"
    NodeLabelPadding="3"
    ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/ca/"
    LineImagesFolderUrl="~/DesktopModules/Bring2mind/DMX/images/ca/lines/"
    ParentNodeImageUrl="folders.gif"
    LeafNodeImageUrl="folder.gif"
    ShowLines="true"
    EnableViewState="false"
    runat="server">
   <ClientEvents>
     <NodeSelect EventHandler="CategoryDropDownSelectTV_onNodeSelect" />
     <CallbackComplete EventHandler="repairClasses" />
     <NodeExpand EventHandler="repairClasses" />
   </ClientEvents>
  </ComponentArt:TreeView>
 </DropdownContent>
  <ClientTemplates>
  <ComponentArt:ClientTemplate ID="test_template">
    <div class="comboItem">## getCatSelectedNode() ##</div>
  </ComponentArt:ClientTemplate>
  </ClientTemplates>
</ComponentArt:ComboBox>

<div style="display:none;">
<asp:TextBox runat="server" ID="txtCategoryId" />
</div>