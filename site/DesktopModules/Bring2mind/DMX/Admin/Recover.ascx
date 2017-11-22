<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Recover.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Admin.Recover" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<a href="#" id="btnExpandAll"><%=LocalizeString("btnExpandAll")%></a> - <a href="#" id="btnCheckAll"><%=LocalizeString("btnCheckAll")%></a>
<script>
 document.getElementById('btnExpandAll').onclick = function () {
  tvDocuments.expandAll();
 }
 document.getElementById('btnCheckAll').onclick = function () {
  tvDocuments.checkAll();
 }
</script>

<ComponentArt:TreeView id="tvDocuments" AutoPostBackOnSelect="false" Autoscroll="true"
  HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/16/"
  ParentNodeImageUrl="folder.png" LeafNodeImageUrl="document.png" ShowLines="false"  CollapseNodeOnSelect="false" EnableViewState="true" runat="server" AutoTheming="True">
 <ClientEvents>
  <NodeCheckChange EventHandler="SelectChildren" />
 </ClientEvents>
</ComponentArt:TreeView>

<p style="margin-top:20px;width:100%;text-align:center;">
 <asp:linkbutton id="cmdCancel" CssClass="dnnPrimaryAction" runat="server" resourcekey="cmdCancel" causesvalidation="False" borderstyle="None" />
 <asp:LinkButton runat="server" ID="cmdImport" resourcekey="cmdImport" CssClass="dnnSecondaryAction" />
</p>
