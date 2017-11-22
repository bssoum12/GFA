<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="FileDropDownSelect.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.FileDropDownSelect" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<script type="text/javascript">
//<![CDATA[
function NodeSelect<%=ID%>(sender, eventArgs)
{
 if(sender.get_selectedNode().get_value()=='cannotselect') {<%= cbSelectEntry.ClientID %>.collapse();return};
 document.getElementById('<%= txtEntryId.ClientId %>').value = sender.get_selectedNode().get_id();
 <%= cbSelectEntry.ClientID %>.beginUpdate();
 <%= cbSelectEntry.ClientID %>.endUpdate();
 <%= cbSelectEntry.ClientID %>.collapse();
 repairClasses();
}
function getSelectedNode<%=ID%>()
{
if (<%= tvEntries.ClientID %>.get_selectedNode) {
if (<%= tvEntries.ClientID %>.get_selectedNode() != null)
 return <%= tvEntries.ClientID %>.get_selectedNode().get_text();
else
 return "";
}
}
//]]>
</script>
<ComponentArt:ComboBox id="cbSelectEntry" runat="server"
 TextBoxClientTemplateId="test_template"
 KeyboardEnabled="false"
 AutoFilter="false"
 AutoHighlight="false"
 AutoComplete="false"
 AutoTheming="true"
 DropDownContentCssClass="dropDownContent">
 <DropdownContent>
  <ComponentArt:TreeView id="tvEntries"
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
    runat="server" >
    <ClientEvents>
     <CallbackComplete EventHandler="repairClasses" />
     <NodeExpand EventHandler="repairClasses" />
    </ClientEvents>
  </ComponentArt:TreeView>
 </DropdownContent>
</ComponentArt:ComboBox>

<div style="display:none;">
<asp:TextBox runat="server" ID="txtEntryId" />
</div>