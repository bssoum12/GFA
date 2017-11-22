<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="AjaxTwoPanel.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Views.AjaxTwoPanel" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%
%>
<script type="text/javascript">
 /* <![CDATA[ */
 var baseUrl = '<%= BaseUrl %>';
 var baseUrlSuffix = '<%= IIF(BaseUrl.Contains("?"), "&", "?") %>';
 var gridWidth;
 var gridHeight;
 var appPath = '<%= AppPath %>';
 var hidStuff = '<%= hidStuff.ClientId %>';
 var isSplitterLoaded=false;
 var grid1clientId ='<%= Grid1.ClientObjectId %>';
 var divFeedbackFormId =  '<%= divFeedbackForm.ClientId %>';
 var isPostBack = <%= IsPostback.ToString.ToLower %>;
 var portalId = <%= PortalId %>;
 var thumbnailPath = '<%= Bring2mind.DNN.Modules.DMX.Common.Paths.GetPath(Bring2mind.DNN.Modules.DMX.Common.Paths.PathTypes.Thumbnails) %>';
 var downloadUrl = '<%= Bring2mind.DNN.Modules.DMX.Common.Paths.DownloadPath(PortalId) %>';
 var noPermission = '<%=DotNetNuke.Services.Localization.Localization.GetString("NoPermission", LocalResourceFile)%>';
 var isLocked = '<%=DotNetNuke.Services.Localization.Localization.GetString("Locked", LocalResourceFile)%>';
 var notApproved = '<%=DotNetNuke.Services.Localization.Localization.GetString("NotApproved", LocalResourceFile)%>';

 function callbackComplete(sender, eventArgs)
 {
  <%= mnuContext.ClientID %>.showContextMenuAtPoint(_MouseX, _MouseY); 
};
/* ]]> */
</script>
<div onkeydown="captureKeys();" class="VCBox">

<div style="display:block;height:24px;overflow:hidden;" class="MenuBar">
 <div style="float: left">
 <ComponentArt:CallBack ID="MenuCallBack" runat="Server" OnCallback="MenuCallBack_Callback">
  <Content>
   <ComponentArt:Menu id="mnuMain" Orientation="Horizontal" AutoPostBackOnSelect="False"
    EnableViewState="true"
    ExpandDelay="100" ExpandOnClick="false" runat="server" AutoTheming="True">
   </ComponentArt:Menu>
  </Content>
  <ClientEvents>
   <CallbackError Eventhandler="OnCallBackError" />
   <BeforeCallback EventHandler="MenuBeforeCallback" />
   <CallbackComplete EventHandler="MenuCallbackComplete" />
  </ClientEvents>
 </ComponentArt:CallBack>
 </div>
 <div style="float: right">
  <ComponentArt:Menu id="mnuAdmin" Orientation="Horizontal" AutoPostBackOnSelect="False"
    EnableViewState="true"
    ExpandDelay="100" ExpandOnClick="false" runat="server" AutoTheming="True">
   </ComponentArt:Menu> 
  </div>
</div>

<ComponentArt:Splitter runat="server" id="Splitter1" Height="590"
 ClientDependencies="window.TreeView1,window.Grid1" CssClass="Splitter"
 ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/CA/splitter/">
 <ClientEvents>
  <Load EventHandler="SplitterLoad" />
 </ClientEvents>
 <Layouts>
  <ComponentArt:SplitterLayout ID="Regular">
   <Panes Orientation="Horizontal" SplitterBarCollapseImageUrl="splitter_horCol.gif" SplitterBarCollapseHoverImageUrl="splitter_horColHover.gif" 
    SplitterBarExpandImageUrl="splitter_horExp.gif" SplitterBarExpandHoverImageUrl="splitter_horExpHover.gif" SplitterBarCollapseImageWidth="5" 
    SplitterBarCollapseImageHeight="116" SplitterBarCssClass="HorizontalSplitterBar" SplitterBarCollapsedCssClass="CollapsedHorizontalSplitterBar" 
    SplitterBarActiveCssClass="ActiveSplitterBar" SplitterBarWidth="5">
    <ComponentArt:SplitterPane PaneContentId="TreeViewContent" MinWidth="100" Width="30%" CssClass="SplitterPane">
     <ClientEvents>
      <PaneResize EventHandler="resizeTree" />
     </ClientEvents>
    </ComponentArt:SplitterPane>
    <ComponentArt:SplitterPane Width="70%" PaneContentId="GridContent" CssClass="SplitterPane">
     <ClientEvents>
      <PaneResize EventHandler="resizeGrid" />
     </ClientEvents>
    </ComponentArt:SplitterPane>
   </Panes>
  </ComponentArt:SplitterLayout>
 </Layouts>
 <Content>
  <ComponentArt:SplitterPaneContent id="TreeViewContent">
   <ComponentArt:CallBack ID="TreeviewCallBack" runat="Server">
    <Content>
     <div id="TreeContainer" class="TreeGridContainer" style="width:100%; background-color: White;">
     <ComponentArt:TreeView id="TreeView1" FillContainer="true" AutoPostBackOnSelect="false" Autoscroll="true"
      HoverPopupEnabled="true" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" 
      HoverNodeCssClass="HoverTreeNode" SelectedNodeCssClass="SelectedTreeNode" NodeEditCssClass="NodeEdit" LineImageWidth="19" LineImageHeight="20"
      DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/CA/"
      DragAndDropEnabled="true"
      NodeLabelPadding="3" CollapseImageUrl="exp.gif" ExpandImageUrl="col.gif" ShowLines="false" 
      LineImagesFolderUrl="~/DesktopModules/Bring2mind/DMX/images/CA/lines/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server">
      <ClientEvents>
       <ContextMenu EventHandler="LoadTreeViewContextMenu" />
       <NodeSelect EventHandler="TreeViewNodeSelect" />
       <NodeExpand EventHandler="repairTreeClasses" />
       <NodeMove EventHandler="dragDropNode" />
       <CallbackComplete EventHandler="tvCallbackComplete" />
      </ClientEvents>                
     </ComponentArt:TreeView>
     </div>
    </Content>
    <ClientEvents>
     <CallbackError Eventhandler="OnCallBackError" />
     <CallbackComplete EventHandler="TreeviewCallBackComplete" />
    </ClientEvents>
   </ComponentArt:CallBack>
  </ComponentArt:SplitterPaneContent>
  <ComponentArt:SplitterPaneContent id="GridContent"> 
   <ComponentArt:CallBack ID="GridCallBack" runat="Server" OnCallback="GridCallBack_Callback">
    <Content>
     <ComponentArt:Grid id="Grid1" AllowMultipleSelect="True" FillContainer="false" AutoAdjustPageSize="false" RunningMode="Client" ShowSearchBox="true" 
      SearchOnKeyPress="true" ShowHeader="true"
      ColumnResizeDistributeWidth="true" ItemDraggingEnabled="true" ItemDraggingClientTemplateId="DragTemplate" ExternalDropTargets="TreeView1,Grid1"
      GroupingNotificationText="" ShowFooter="false" ImagesBaseUrl="~/DesktopModules/Bring2mind/DMX/images/CA/grid/" Sort="IsCollection DESC, Title"
      runat="server" AllowVerticalScrolling="True" PageSize="9999" AutoTheming="True">
      <ClientEvents>
       <SortChange EventHandler="Grid1_onSortChange" />
       <ContextMenu EventHandler="LoadGridContextMenu" />
       <ItemSelect EventHandler="GridItemSelect" />
       <ItemDoubleClick EventHandler="GridItemDoubleClick" />
       <Load EventHandler="GridLoad" />
       <ItemExternalDrop EventHandler="dragDropGridItem" />
       <RenderComplete EventHandler="gridRenderComplete" />
      </ClientEvents>                
      <Levels>
       <ComponentArt:GridLevel AllowGrouping="False" DataKeyField="EntryId" ShowTableHeading="false" ShowSelectorCells="false">
        <ConditionalFormats>
         <ComponentArt:GridConditionalFormat ClientFilter="DataItem.GetMember('Deleted').Value=='1'" RowCssClass="DeletedRow" SelectedRowCssClass="SelectedRow" />
         <ComponentArt:GridConditionalFormat ClientFilter="DataItem.GetMember('IsApproved').Value=='0'" RowCssClass="UnApprovedRow" SelectedRowCssClass="SelectedRow" />
         <ComponentArt:GridConditionalFormat ClientFilter="DataItem.GetMember('IsLocked').Value=='1'" RowCssClass="LockedRow" SelectedRowCssClass="SelectedRow" />
        </ConditionalFormats>
        <Columns>
         <ComponentArt:GridColumn DataField="Icon16" DataCellClientTemplateId="IconColumnTemplate" HeadingText="&nbsp;" Visible="true" IsSearchable="False" Width="18" FixedWidth="true" AllowSorting="False" AllowReordering="False" AllowGrouping="False" AllowEditing="False" DataCellCssClass="DMXIconCell" />
         <ComponentArt:GridColumn DataField="EntryId" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="EntryType" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="Entry" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="IsCollection" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="IsApproved" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="ControlToLoad" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="Deleted" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="Thumbnail" Visible="false" IsSearchable="False" />
         <ComponentArt:GridColumn DataField="Title" DataCellClientTemplateId="FirstColumnTemplate" HeadingText="Title" SortImageJustify="false" TextWrap="True" />
         <ComponentArt:GridColumn DataCellClientTemplateId="DownloadColumnTemplate" HeadingText="&nbsp;" Visible="False" IsSearchable="False" Width="16" FixedWidth="true" AllowSorting="False" AllowReordering="False" AllowGrouping="False" AllowEditing="False" />
         <ComponentArt:GridColumn DataField="IsLocked" Visible="True" DataCellClientTemplateId="IsLockedColumnTemplate" HeadingText="&nbsp;" IsSearchable="False" Width="16" FixedWidth="true" AllowSorting="False" AllowReordering="False" AllowGrouping="False" AllowEditing="False" />
         <ComponentArt:GridColumn DataField="FileSize" DataCellClientTemplateId="SizeColumnTemplate" HeadingText="FileSize" Align="Right" SortImageJustify="true" IsSearchable="False" Width="50" FixedWidth="true" />
         <ComponentArt:GridColumn DataField="LastModified" HeadingText="LastModified" FormatString="d" SortImageJustify="false" IsSearchable="False" Width="70" FixedWidth="true" />
        </Columns>
       </ComponentArt:GridLevel>
      </Levels>
      <ClientTemplates>
       <ComponentArt:ClientTemplate Id="IconColumnTemplate">
## DataItem.getMember('Icon16').get_value().indexOf('/') > 0 ? '<img src="' + resolveUrl(DataItem.getMember('Icon16').get_value()) + '" width="16" height="16" border="0" alt="" />' : '<div class="dmxicon-16-' + DataItem.getMember('Icon16').get_value().toLowerCase() + '" />' ##
## itemThumbnail(DataItem.getMember('Thumbnail').get_value()) ##
       </ComponentArt:ClientTemplate>
       <ComponentArt:ClientTemplate Id="IsLockedColumnTemplate">
## DataItem.getMember('IsLocked').get_value() == false ? '' : '<div class="dmxicon-16-lock-png" />' ##
## DataItem.getMember('IsApproved').get_value() == true ? "" : '<div class="dmxicon-16-stop-png" />' ##
       </ComponentArt:ClientTemplate>
       <ComponentArt:ClientTemplate Id="DownloadColumnTemplate">
<a href="## baseUrl+baseUrlSuffix ##Command=Core_Download&EntryId=## DataItem.GetMember("EntryId").Value ##" target="_blank">
 <div class="dmxicon-16-disk_blue-png" />
</a>
       </ComponentArt:ClientTemplate>
       <ComponentArt:ClientTemplate Id="FirstColumnTemplate">
<div style="display:inline;overflow:hidden;">
## DataItem.GetMember("Title").Value ##
</div>
       </ComponentArt:ClientTemplate>
       <ComponentArt:ClientTemplate Id="SizeColumnTemplate">
          ## formatFileSize(DataItem.GetMember("FileSize").Value) ##
       </ComponentArt:ClientTemplate>
       <ComponentArt:ClientTemplate Id="DragTemplate">
        <div class="Dragging">## DataItem.getMember('Icon16').get_value().indexOf('/') > 0 ? '<img src="' + resolveUrl(DataItem.getMember('Icon16').get_value()) + '" width="16" height="16" border="0" alt="" />' : '<div class="dmxicon-16-' + DataItem.getMember('Icon16').get_value().toLowerCase() + '">&nbsp;</div>' ##
         <nobr>## DataItem.GetMember("Title").Value ##</nobr>
        </div>
       </ComponentArt:ClientTemplate>
      </ClientTemplates>
     </ComponentArt:Grid>
    </Content>
    <ClientEvents>
     <CallbackError Eventhandler="OnCallBackError" />
     <CallbackComplete EventHandler="GridCallBackComplete" />
    </ClientEvents>
   </ComponentArt:CallBack>
  </ComponentArt:SplitterPaneContent>
 </Content>          
</ComponentArt:Splitter>

<ComponentArt:CallBack ID="ContextMenuCallBack" runat="Server" OnCallback="ContextMenuCallBack_Callback">
  <ClientEvents>
   <CallbackError Eventhandler="OnCallBackError" />
   <CallbackComplete EventHandler="callbackComplete" />
  </ClientEvents>
    <Content>
     <ComponentArt:Menu ID="mnuContext" 
      Orientation="Vertical"
      AutoPostBackOnSelect="False"
      EnableViewState="true"
      ExpandOnClick="false"
      ContextMenu="Custom"
      ShadowEnabled="true"
	  CollapseDelay="0"
	  CollapseDuration="0"
	  ExpandDelay="0"
	  ExpandDuration="0"
      runat="server" AutoTheming="True">
      </ComponentArt:Menu>
     </Content>
</ComponentArt:CallBack>
</div>


<ComponentArt:CallBack ID="CommandCallBack" runat="Server">
 <ClientEvents>
  <CallbackComplete EventHandler="CommandCallBackComplete" />
 </ClientEvents>
</ComponentArt:CallBack>

<ComponentArt:Dialog HeaderCssClass="dialogHeaderCssClass" FooterCssClass="dialogFooterCssClass" ContentCssClass="dialogContentCssClass" ModalMaskCssClass="modalMaskCssClass" Title="ComponentArt Dialog" AllowDrag="true" Alignment="MiddleCentre" ID="Dialog2" runat="server" Width="780" CssClass="dialogDMX">
   <Header>
    <table cellpadding="0" cellspacing="0" width="100%" style="filter:alpha(opacity=60);" height="35">
			  <tr>
				  <td width="9" height="35" class="ca-dialog-top-left-png"></td>
				  <td height="35" style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/top-mid.png');height:35px!important;" valign="middle">
					  <div style="color:White;font-size:15px;font-family:Arial;font-weight:bold;padding:8px;"><%=DotNetNuke.Services.Localization.Localization.GetString("Search", LocalResourceFile)%></div>
				  </td>
				  <td width="40" height="35" valign="top" class="ca-dialog-top-right-png">
				   <div class="ca-dialog-close-png" style="cursor:default;padding-top:4px;margin-top:4px;" onmousedown="this.className='ca-dialog-close-down-png';" onmouseup="this.className='ca-dialog-close-hover-png';" onclick="Dialog2.Close();" onmouseover="this.className='ca-dialog-close-hover-png';" onmouseout="this.className='ca-dialog-close-png';" alt="" />
				  </td>
			  </tr>
		  </table>
   </Header>
			<Content>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/left.png');filter:alpha(opacity=60);" width="7"></td>
					<td style="background-color:white;font-size:12px;font-family:Arial;width:766px;padding:4px;" 
					 onkeydown="return __dnn_KeyDown('13', 'javascript:showSearch();', event);">
      <ComponentArt:TabStrip id="TabStrip2" 
        AutoTheming="True"
        DefaultGroupTabSpacing="1"
        MultiPageId="MultiPage2"
        runat="server">
       <ItemLooks>
         <ComponentArt:ItemLook LookId="DefaultTabLook" CssClass="DefaultTab1" HoverCssClass="DefaultTabHover1" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="5" LabelPaddingBottom="4" LeftIconUrl="../spacer.gif" RightIconUrl="../spacer.gif" HoverLeftIconUrl="../spacer.gif" HoverRightIconUrl="../spacer.gif" LeftIconWidth="3" LeftIconHeight="21" RightIconWidth="3" RightIconHeight="21" />
         <ComponentArt:ItemLook LookId="SelectedTabLook" CssClass="SelectedTab1" LabelPaddingLeft="10" LabelPaddingRight="10" LabelPaddingTop="4" LabelPaddingBottom="4" LeftIconUrl="../spacer.gif" RightIconUrl="../spacer.gif" LeftIconWidth="3" LeftIconHeight="21" RightIconWidth="3" RightIconHeight="21" />
       </ItemLooks>
       <Tabs>
        <ComponentArt:TabStripTab runat="server" ID="tabQuickSearch" Value="quicksearch" />
        <ComponentArt:TabStripTab runat="server" ID="tabRegularSearch" Value="regularsearch" />
       </Tabs>
      </ComponentArt:TabStrip>
      <ComponentArt:MultiPage id="MultiPage2" CssClass="MultiPage" runat="server">
       <ComponentArt:PageView ID="PageView0" CssClass="PageContent" runat="server">
 <table cellspacing="0" cellpadding="5" border="0">
  <tr>
   <td class="DMX_EditTitle SubHead">
    <asp:TextBox runat="server" ID="txtQuickSearch" Width="300" />
   </td>
   <td class="NormalBold" colspan="2">
    <asp:RadioButtonList runat="server" ID="rblFields" RepeatDirection="Horizontal" CssClass="Normal">
     <asp:ListItem Text="Core" Value="core" Selected="True" />
     <asp:ListItem resourcekey="optAllFields" Text="All" Value="all" />
    </asp:RadioButtonList><br />
    <asp:RadioButtonList runat="server" ID="rblScopeQ" RepeatDirection="Horizontal" CssClass="Normal">
     <asp:ListItem resourcekey="optFolder" Text="Folder" Value="folder" />
     <asp:ListItem resourcekey="optAll" Text="All" Value="all" Selected="True" />
    </asp:RadioButtonList>
   </td>
  </tr>
 </table>
       </ComponentArt:PageView>
       <ComponentArt:PageView ID="PageView1" CssClass="PageContent" runat="server">
 <table cellspacing="0" cellpadding="5" border="0">
  <tr>
   <td class="DMX_EditTitle SubHead leftAlignLabel"><dnn:label id="plField" runat="server" /></td>
   <td class="DMX_EditTitle SubHead leftAlignLabel"><dnn:label id="plSelection" runat="server" /></td>
   <td class="DMX_EditTitle SubHead leftAlignLabel"><dnn:label id="plSearchString" runat="server" /></td>
   <td class="DMX_EditTitle SubHead leftAlignLabel"><dnn:label id="plExact" runat="server" Visible="false" /></td>
  </tr>
  <tr>
   <td>
    <asp:DropDownList id="dd1Field" runat="server" DataTextField="Text" DataValueField="Value" />
   </td>
   <td>
    <asp:DropDownList id="dd1Selection" runat="server">
     <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
     <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
     <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
     <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
     <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
    </asp:DropDownList>
   </td>
   <td><asp:textbox runat="server" id="txt1Search" Width="300" /></td>
   <td style="display:none;"><asp:CheckBox runat="server" ID="chk1Exact" /></td>
  </tr>
  <tr>
   <td>
    <asp:DropDownList id="dd2Field" runat="server" DataTextField="Text" DataValueField="Value" />
   </td>
   <td>
    <asp:DropDownList id="dd2Selection" runat="server">
     <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
     <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
     <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
     <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
     <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
    </asp:DropDownList>
   </td>
   <td><asp:textbox runat="server" id="txt2Search" Width="300" /></td>
   <td style="display:none;"><asp:CheckBox runat="server" ID="chk2Exact" /></td>
  </tr>
  <tr>
   <td>
    <asp:DropDownList id="dd3Field" runat="server" DataTextField="Text" DataValueField="Value" />
   </td>
   <td>
    <asp:DropDownList id="dd3Selection" runat="server">
     <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
     <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
     <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
     <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
     <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
    </asp:DropDownList>
   </td>
   <td><asp:textbox runat="server" id="txt3Search" Width="300" /></td>
   <td style="display:none;"><asp:CheckBox runat="server" ID="chk3Exact" /></td>
  </tr>
  <tr>
   <td>
    <asp:DropDownList id="dd4Field" runat="server" DataTextField="Text" DataValueField="Value" />
   </td>
   <td>
    <asp:DropDownList id="dd4Selection" runat="server">
     <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
     <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
     <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
     <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
     <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
    </asp:DropDownList>
   </td>
   <td><asp:textbox runat="server" id="txt4Search" Width="300" /></td>
   <td style="display:none;"><asp:CheckBox runat="server" ID="chk4Exact" /></td>
  </tr>
  <tr>
   <td class="DMX_EditTitle SubHead leftAlignLabel"><dnn:label id="plCombination" runat="server" /></td>
   <td>
     <asp:DropDownList id="ddCombination" runat="server">
     <asp:ListItem Value="OR" Text="OR" resourcekey="optOr" />
     <asp:ListItem Value="AND" Text="AND" resourcekey="optAnd" />
    </asp:DropDownList>
   </td>
   <td class="NormalBold">
	   <asp:checkbox runat="server" id="chkAllVersions" text="All Versions" resourcekey="chkAllVersions" />
   </td>
  </tr>
  <tr>
   <td class="DMX_EditTitle SubHead leftAlignLabel"><dnn:label id="plScope" runat="server" /></td>
   <td class="NormalBold" colspan="2">
    <asp:RadioButtonList runat="server" ID="rblScope" RepeatDirection="Horizontal" CssClass="Normal">
     <asp:ListItem resourcekey="optFolder" Text="Folder" Value="folder" Selected="True" />
     <asp:ListItem resourcekey="optAll" Text="All" Value="all" />
    </asp:RadioButtonList>
   </td>
  </tr>
 </table>
       </ComponentArt:PageView>
      </ComponentArt:MultiPage>
					 <input type='button' onclick='showSearch();' value='<%=DotNetNuke.Services.Localization.Localization.GetString("Search", LocalResourceFile)%>'/>
     </td>
					<td style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/right.png');filter:alpha(opacity=60);" width="7"></td>
				</tr>
			</table>
			</Content>
	  <Footer>
    <table cellpadding="0" cellspacing="0" width="100%" style="filter:alpha(opacity=80);">
				  <tr>
					  <td width="9" class="ca-dialog-bottom-left-png"></td>
					  <td style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/bottom-mid.png');"><div style="height:7px;overflow:hidden;">&nbsp;</div></td>
					  <td width="9" class="ca-dialog-bottom-right-png"></td>
				  </tr>
		  </table>
	  </Footer>
	  <ClientEvents>
	   <OnShow EventHandler="Dialog2_onShow" />
	  </ClientEvents>
</ComponentArt:Dialog>

<ComponentArt:Dialog ID="dlgFeedback" HeaderCssClass="dialogHeaderCssClass" FooterCssClass="dialogFooterCssClass" ContentCssClass="dialogContentCssClass" ModalMaskCssClass="modalMaskCssClass" Title="ComponentArt Dialog" AllowDrag="true" Alignment="MiddleCentre" runat="server" Height="151" Width="680" Modal="true" CssClass="dialogDMX">
   <Header>
    <table cellpadding="0" cellspacing="0" width="100%" style="filter:alpha(opacity=60);" height="35">
			  <tr>
				  <td width="9" height="35" class="ca-dialog-top-left-png"></td>
				  <td height="35" style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/top-mid.png');height:35px !important;" valign="middle">
					  <span style="color:White;font-size:15px;font-family:Arial;font-weight:bold;">&nbsp;</span>
				  </td>
				  <td width="40" height="35" valign="top" class="ca-dialog-top-right-png">
				   <div class="ca-dialog-close-png" style="cursor:default;padding-top:4px;margin-top:4px;" onmousedown="this.className='ca-dialog-close-down-png';" onmouseup="this.className='ca-dialog-close-hover-png';" onclick="dlgFeedback.Close();" onmouseover="this.className='ca-dialog-close-hover-png';" onmouseout="this.className='ca-dialog-close-png';" alt="" />
				  </td>
			  </tr>
		  </table>
   </Header>
			<Content>
			<table cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/left.png');filter:alpha(opacity=60);" width="7"></td>
					<td style="background-color:white;font-size:12px;font-family:Arial;background-image:url(<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/bottom_content.gif);padding:10px;" 
					 onkeydown="return __dnn_KeyDown('13', 'dlgFeedback.Close();', event);">
      <div runat="server" id="divFeedbackForm">
      </div>
     </td>
					<td style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/right.png');filter:alpha(opacity=60);" width="7"></td>
				</tr>
			</table>
			</Content>
	  <Footer>
    <table cellpadding="0" cellspacing="0" width="100%" style="filter:alpha(opacity=80);">
				  <tr>
					  <td width="9" class="ca-dialog-bottom-left-png"></td>
					  <td style="background-image:url('<%= AppPath %>DesktopModules/Bring2mind/DMX/images/ca/dialog/bottom-mid.png');"><div style="height:7px;overflow:hidden;">&nbsp;</div></td>
					  <td width="9" class="ca-dialog-bottom-right-png"></td>
				  </tr>
		  </table>
	  </Footer>
</ComponentArt:Dialog>

<ComponentArt:CallBack ID="ViewCallBack" runat="Server">
 <ClientEvents>
  <CallbackComplete EventHandler="ViewCallBackComplete" />
 </ClientEvents>
</ComponentArt:CallBack>
          
<span id="oWebFolder" style="behavior:url('#default#httpFolder')" />

<div style="display:none">
<asp:TextBox runat="server" ID="hidStuff" Width="500"></asp:TextBox>
</div>

<div runat="server" id="divAdmin">
 <asp:LinkButton runat="server" ID="cmdResetMenus" resourcekey="cmdResetMenus" CssClass="dnnSecondaryAction" Visible="false" />
</div>

<script language="javascript">
 var txt1Search = document.getElementById("<%= txt1Search.ClientId %>");
 var txt2Search = document.getElementById("<%= txt2Search.ClientId %>");
 var txt3Search = document.getElementById("<%= txt3Search.ClientId %>");
 var txt4Search = document.getElementById("<%= txt4Search.ClientId %>");
 var txtQuickSearch = document.getElementById("<%= txtQuickSearch.ClientId %>");
 var dd1Field = document.getElementById("<%= dd1Field.ClientId %>");
 var dd2Field = document.getElementById("<%= dd2Field.ClientId %>");
 var dd3Field = document.getElementById("<%= dd3Field.ClientId %>");
 var dd4Field = document.getElementById("<%= dd4Field.ClientId %>");
 var dd1Selection = document.getElementById("<%= dd1Selection.ClientId %>");
 var dd2Selection = document.getElementById("<%= dd2Selection.ClientId %>");
 var dd3Selection = document.getElementById("<%= dd3Selection.ClientId %>");
 var dd4Selection = document.getElementById("<%= dd4Selection.ClientId %>");
 var ddCombination = document.getElementById("<%= ddCombination.ClientId %>");
 var chkAllVersions = document.getElementById("<%= chkAllVersions.ClientId %>");
 var rblScope = document.getElementsByName('<%= rblScope.ClientId.Replace("_","$") %>');
 var rblScopeQ = document.getElementsByName('<%= rblScopeQ.ClientId.Replace("_","$") %>');
 var rblFields = document.getElementsByName('<%= rblFields.ClientId.Replace("_","$") %>');
 var chk1Exact = document.getElementById("<%= chk1Exact.ClientId %>");
 var chk2Exact = document.getElementById("<%= chk2Exact.ClientId %>");
 var chk3Exact = document.getElementById("<%= chk3Exact.ClientId %>");
 var chk4Exact = document.getElementById("<%= chk4Exact.ClientId %>");

 var dmxData = {
  dnnVer: <%= DotNetNuke.Application.DotNetNukeContext.Current.Application.CurrentVersion.Major %>,
  gridId: '<%= Grid1.ClientID %>',
  moduleId: <%= ModuleId %>,
  tabId: <%= PortalSettings.ActiveTab.TabID %>,
  selectedId: <%= IIF(Query.EntryId < 1, RootId, Query.EntryId) %>,
  maxLength: <%= DotNetNuke.Common.Utilities.Config.GetMaxUploadSize() %>
 };
</script>

<div class="modal fade" tabindex="-1" role="dialog" id="dmxProgressModal">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="dmxProgressFilename">Upload Progress</h4>
      </div>
      <div class="modal-body">
        <div class="progress">
          <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%;" id="dmxProgressBar">
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" tabindex="1" role="dialog" id="dmxShowLink">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Link</h4>
      </div>
      <div class="modal-body">
       <div>
       <input type="text" class="form-control" id="dmxShowLinkText" />
       </div>
       <div style="padding:15px 0;">
        <a href="#" id="dmxShowLinkLink"></a>
       </div>
      </div>
    </div>
  </div>
</div>

