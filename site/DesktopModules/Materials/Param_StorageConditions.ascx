<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_StorageConditions.ascx.cs" Inherits="VD.Modules.Materials.Param_StorageConditions" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxpc" %>





<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxg" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web	" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />
<style>
    .HeaderTitle {
        text-align: center;
        font-family: Tahoma;
        font-weight: bold;
        font-size: 12px;
    }

    .HeaderTree {
        border-width: 1px;
        border-style: solid;
        border-color: #7EACB1;
    }
</style>
<script type="text/javascript">
    var msgConfirmDelete = '<%=DotNetNuke.Services.Localization.Localization.GetString("msbConfirmationStorage", ressFilePath)%>';
    var popupAdd = '<%=DotNetNuke.Services.Localization.Localization.GetString("popupStorageCondition", ressFilePath)%>';
    var popupEdit = '<%=DotNetNuke.Services.Localization.Localization.GetString("popupEditStorageCondition", ressFilePath)%>';
    var msgSelect = '<%=DotNetNuke.Services.Localization.Localization.GetString("errorSelection", ressFilePath)%>';
    var msgUsed = '<%=DotNetNuke.Services.Localization.Localization.GetString("msgUsedCondition", ressFilePath)%>';
    //Handle tree tilter button click event
    function OnTreeFilterClick(nodeKey) {
        cbFilter.PerformCallback(nodeKey);
    }
    //Handle tree context menu 
    function treeListContextMenu(s, e) {
        var x = ASPxClientUtils.GetEventX(e.htmlEvent);
        var y = ASPxClientUtils.GetEventY(e.htmlEvent);
        MenuConditions.ShowAtPos(x, y);
    }
    function TreeMenuItemClick(e) {
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "ajouter") AddStorageCondition();
        if (name == "modifier") EditStorageCondition();
        if (name == "supprimer") cbAssign.PerformCallback();
        if (name == "Affecter") window.parent.parent.ShowAssignStorageConditionPopup();
    }
     <%-- Add storage condition --%>
    function AddStorageCondition() {
        var index = treeList.GetFocusedNodeKey();
        if (index != null & index != -1) {
            treeList.GetNodeValues(treeList.GetFocusedNodeKey(), 'ID', ShowAddStorageCondition);
        }
    }
    function ShowAddStorageCondition(SelectedValue) {
        popupCtrl.SetHeaderText(popupAdd);
        if (treeList.GetVisibleNodeKeys() != "") 
            popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddStorageConditions.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&iseditmode=false&FromNomen=True&IdCondition=" + SelectedValue + "&racine=false");
        else
            popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddStorageConditions.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&iseditmode=false&FromNomen=True&IdCondition=" + SelectedValue + "&racine=true");
                  popupCtrl.Show();
    }
     <%-- Get storage condition and Edit it --%>
    function EditStorageCondition() {
        treeList.GetNodeValues(treeList.GetFocusedNodeKey(), 'ID', ShowEditStorageCondition)
    }

    function ShowEditStorageCondition(SelectedValue) {
        if (SelectedValue == null) {
            alert(msgSelect); return;
        }
        else {
            popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddStorageConditions.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&iseditmode=true&IDCondition=" + SelectedValue);
            popupCtrl.SetHeaderText(popupEdit);
            popupCtrl.Show();
        }
    }

    <%-- Delete Storage condition --%>
    function DeleteStorageCondition() {
        treeList.GetNodeValues(treeList.GetFocusedNodeKey(), "ID", DeleteStorageConditionSub);
    }

    function DeleteStorageConditionSub(SelectedValue) {
        if (SelectedValue == null) {
            alert(msgSelect); return;
        }
        else {
            if (confirm(msgConfirmDelete)) {
                treeList.PerformCallback('Delete##' + SelectedValue);
            }
        }
    }
    function TreeListEndCallback(s, e) {
        if (s.cpDeleted != '') {
            alert(s.cpDeleted);
        }
    }

    function TreeStorageInit(s, e) {
        var popup = window.parent;
        popup.window['treeList'] = treeList;
    }

    function SupprimerCondition() {
        var key = treeList.GetFocusedNodeKey();
        treeList.DeleteNode(key);
    }

    function cbAssignEndCallback(s, e) {
        if (e.result == ('delete')) {
            if (confirm(msgConfirmDelete)) {
                SupprimerCondition();
                treeList.PerformCallback();
            }
        }
        if (e.result == ('dontdelete')) {
            alert(msgUsed);
        }
    }
</script>
<%--ASPX MENU--%>
<dx:ASPxMenu ID="MenuCondition" ClientInstanceName="MenuCondition" runat="server" AllowSelectItem="True" ShowPopOutImages="True"
    AutoSeparators="RootOnly" Theme="Glass" ItemAutoWidth="False" SeparatorColor="#7EACB1" Width="100%">
    <ClientSideEvents ItemClick="function(s, e) {TreeMenuItemClick(e);}" />
    <Items>
        <dx:MenuItem Name="ConditionStockage" Text="Condition stockage" Image-Url="~/images/Materials/StorageCondition.png" Image-Height="16px">
            <Items>
                <dx:MenuItem Name="ajouter" Text="Ajouter">
                    <Image Url="../../../images/add.gif" Width="16px" Height="16px"></Image>
                </dx:MenuItem>
                <dx:MenuItem Name="modifier" Text="Modifier">
                    <Image Url="../../../images/edit.gif" Height="16px" Width="16px"></Image>
                </dx:MenuItem>
                <dx:MenuItem Name="supprimer" Text="Supprimer">
                    <Image Url="../../../images/delete.gif" Height="16px" Width="16px"></Image>
                </dx:MenuItem>
            </Items>
        </dx:MenuItem>
    </Items>
</dx:ASPxMenu>
<br />
<table  class="HeaderTree" style="width: 100%; padding-top: 5px; padding-bottom: 5px;" cellpadding="0" cellspacing="0">
    <tr>
        <td class="HeaderTitle">
           <%=DotNetNuke.Services.Localization.Localization.GetString("storageCondition", ressFilePath)%>
        </td>
    </tr>
    <tr>
        <td>
            <div style="background-color: #7EACB1; height: 1px;"></div>
            <dx:ASPxTreeList ID="treeList" runat="server" Theme="Glass" Width="100%" ClientInstanceName="treeList"
                AutoGenerateColumns="False" DataSourceID="SqlStorageCondition" EnableTheming="True" KeyFieldName="ID"
                EnableCallbacks="true" EnableCallbackCompression="False" ParentFieldName="Id_Parent" OnCustomCallback="treeList_CustomCallback"
                Settings-VerticalScrollBarMode="Visible" BackColor="#F7FBF7">
                <ClientSideEvents ContextMenu="treeListContextMenu" Init="TreeStorageInit" />
                <SettingsBehavior AllowFocusedNode="true" />
                <Columns>
                    <dx:TreeListDataColumn Caption="Designation" FieldName="Designation" AllowSort="False" ShowInCustomizationForm="True" Width="100%" VisibleIndex="2">
                    </dx:TreeListDataColumn>
                    <dx:TreeListDataColumn Caption="ID" FieldName="ID" Visible="false" VisibleIndex="0">
                    </dx:TreeListDataColumn>
                    <dx:TreeListDataColumn Caption="Id_Parent" FieldName="Id_Parent" Visible="false" VisibleIndex="1">
                    </dx:TreeListDataColumn>
                </Columns>
                <Templates>
                    <HeaderCaption>
                        <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <dx:ASPxComboBox ID="cmbFilter" ClientInstanceName="cmbFilter" runat="server" DataSourceID="SqlStorageCondition" ValueField="ID" Width="100%"
                                                    TextField="Designation" Theme="Glass" IncrementalFilteringMode="Contains"
                                                    DropDownButton-Visible="False" DropDownStyle="DropDown">
                                                    <ClientSideEvents ValueChanged="function(s,e){OnTreeFilterClick(cmbFilter.GetText());
                                                                              imgClear.SetImageUrl('../../images/clear.png');
                                                                              }" />
                                                </dx:ASPxComboBox>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td style="width: 16px;">
                                                <dx:ASPxImage ID="imgClear" ClientInstanceName="imgClear" runat="server" Width="16px" Height="16px"
                                                    ImageUrl="~/images/spacer.gif" Cursor="pointer">
                                                    <ClientSideEvents Click="function(s,e){cmbFilter.SetText('');imgClear.SetImageUrl('../../images/spacer.gif');}" />
                                                </dx:ASPxImage>

                                            </td>
                                        </tr>
                                    </table>
                    </HeaderCaption>
                </Templates>
                <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="true" GridLines="Horizontal"
                    ShowColumnHeaders="True" VerticalScrollBarMode="Visible" ScrollableHeight="550"></Settings>
                <SettingsBehavior ProcessFocusedNodeChangedOnServer="false" ProcessSelectionChangedOnServer="false"
                    AllowFocusedNode="true" AutoExpandAllNodes="True" AllowDragDrop="False"></SettingsBehavior>
                <SettingsEditing Mode="PopupEditForm" AllowRecursiveDelete="True" />

                <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>
            </dx:ASPxTreeList>
        </td>
    </tr>
</table>
<%--CALBACK--%>
<dx:ASPxCallback ID="cbFilter" ClientInstanceName="cbFilter" runat="server" OnCallback="cbFilter_Callback">
    <ClientSideEvents CallbackComplete="function(s, e) {
        if(e.result != '')
        {   
            treeList.MakeNodeVisible(e.result);    
            treeList.SetFocusedNodeKey(e.result);    
        }
}" />
</dx:ASPxCallback>

<%--Popup Menus--%>
<dx:ASPxPopupMenu ID="MenuConditions" runat="server" ClientInstanceName="MenuConditions" Theme="Aqua" GutterWidth="0px" SeparatorColor="#7EACB1">
    <Items>
                <dx:MenuItem Name="ajouter" Text="Ajouter">
                    <Image Url="../../../images/add.gif" Width="16px" Height="16px"></Image>
                </dx:MenuItem>
                <dx:MenuItem Name="modifier" Text="Modifier">
                    <Image Url="../../../images/edit.gif" Height="16px" Width="16px"></Image>
                </dx:MenuItem>
                <dx:MenuItem Name="supprimer" Text="Supprimer">
                    <Image Url="../../../images/delete.gif" Height="16px" Width="16px"></Image>
                </dx:MenuItem>
    </Items>
    <ItemStyle ImageSpacing="5px" />
    <SubMenuStyle BackColor="#EDF3F4" GutterWidth="0px" SeparatorColor="#7EACB1" />
    <ClientSideEvents ItemClick="function(s, e) {TreeMenuItemClick(e);}" />
    <SubMenuItemImage Height="7px" Width="7px" />
</dx:ASPxPopupMenu>

<%--POPUP--%>
<dx:ASPxPopupControl ID="popupCtrl" runat="server" AllowDragging="True" AllowResize="True"
    ContentUrl="~/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddStorageConditions.ascx"
    EnableViewState="False" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="False" Width="550px"
    ClientInstanceName="popupCtrl" EnableHierarchyRecreation="True" Theme="Glass" ShowPinButton="True" ShowRefreshButton="True" ShowCollapseButton="True"
    ShowMaximizeButton="True" Height="150px">

    <clientsideevents closeup="function(s, e) {treeList.PerformCallback();}"
        init="function(s, e) {
	var popup = window.parent;
    popup.window['popupCtrl'] = popupCtrl;}"></clientsideevents>

    <contentstyle>
            
<Paddings Padding="0px"></Paddings>
        
</contentstyle>

    <contentcollection>
<dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True"></dx:PopupControlContentControl>
</contentcollection>
</dx:ASPxPopupControl>


<%--SQL DATA SOURCE--%>

<asp:SqlDataSource ID="SqlStorageCondition" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Materials_GetAllStorageCondition" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeleteStorageCondition" DeleteCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
</asp:SqlDataSource>
<%--CALLBACK--%>
<dx:ASPxCallback ID="cbAssign" ClientInstanceName="cbAssign" runat="server" OnCallback="cbAssign_Callback">
    <ClientSideEvents CallbackComplete="cbAssignEndCallback" />
</dx:ASPxCallback>
