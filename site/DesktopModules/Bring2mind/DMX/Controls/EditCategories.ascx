<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditCategories.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.EditCategories" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<ComponentArt:TreeView id="ctlCategories"
  runat="server"
  AllowTextSelection="True"
  DragAndDropEnabled="false" 
  KeyboardEnabled="true"
  CssClass="DMXTreeView" 
  NodeCssClass="DMXTreeNode" 
  SelectedNodeCssClass="DMXSelectedTreeNode" 
  HoverNodeCssClass="DMXHoverTreeNode"
  NodeEditCssClass="DMXNodeEdit"
  LineImageWidth="19" 
  LineImageHeight="20"
  DefaultImageWidth="16" 
  DefaultImageHeight="16"
  ItemSpacing="0" 
  NodeLabelPadding="3"
  ShowLines="true" 
  LineImagesFolderUrl="~/DesktopModules/Bring2mind/DMX/images/CA/lines"
  ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/CA"
  EnableViewState="true"
  CollapseNodeOnSelect="false"
  />

