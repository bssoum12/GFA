<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_Brands.ascx.cs" Inherits="VD.Modules.Materials.Param_Brands" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxm" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web	" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>


<%@ Register assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.WebControls" tagprefix="asp" %>



<localizeModule:localizeModule ID="localModule" runat="server"/>
<accessModule:accessModule ID="AccModule" runat="server"/>
<script type="text/javascript">
    var mn_Brands = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnBrands", ressFilePath )%>';
    var m_SelectBrand = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mSelectBrand", ressFilePath )%>';
            
    function DeleteFocusedItem() {
        var index = grdParam.GetFocusedRowIndex();
        grdParam.DeleteRow(index);
    }

    function MenuItemClick(e) {
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "mAdd") ShowAddBrandPopup();
        if (name == "mEdit") ShowEditBrandPopup();
        if (name == "mDelete") DeleteFocusedItem();
    }

    // ----------------------Context Menu------------------- /
    var x = -1;
    var y = -1;
    function grid_ContextMenu(s, e) {
        if (e.objectType == "row") {
            x = ASPxClientUtils.GetEventX(e.htmlEvent);
            y = ASPxClientUtils.GetEventY(e.htmlEvent);
            grdParam.SetFocusedRowIndex(e.index);
            popupMenu.ShowAtPos(x, y);
        }
    }
    //----------------------------------------------------------- / 
    function ShowAddBrandPopup() {
        popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddBrandCtrl.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&mode=add");
        popupCtrl.SetHeaderText(mn_Brands);
        popupCtrl.Show();
    }

    function ShowEditBrandPopup() {
        var key = grdParam.GetRowKey(grdParam.GetFocusedRowIndex());
        if (key != '') {
            popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddBrandCtrl.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&mode=edit&key=" + key);
            popupCtrl.SetHeaderText(mn_Brands);
            popupCtrl.Show();
        }
        else {
            alert(m_SelectBrand);
        }
    }
</script>
<style>
    .btnRedLink
    {
        text-decoration: none; color: Red; font-weight: bold; font-family: Tahoma; font-size: 12px;
    }
    .btnGlassLink
    {
        text-decoration: none; color: #266D8D; font-weight: bold; font-family: Tahoma; font-size: 12px;
    }    
</style>

<div style="padding-bottom: 10px;">
    <dxm:ASPxMenu ID="toolbarMenu" runat="server" EnableTheming="True" Theme="Glass" AutoPostBack="false" Width="100%"  ItemAutoWidth="false">
        <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />
        <Items>
            <dxm:MenuItem Name="mManageBrands" Text="Marques" >                
                <Image Url="~/images/Materials/measure_system.png" Width="16px" Height="16px"></Image>
                <SubMenuItemStyle Width="150px"></SubMenuItemStyle>
                <Items>
                        <dxm:MenuItem Name="mAdd" Text="Ajouter">
                            <Image Url="../../../images/add.gif" Width="16px"></Image>
                        </dxm:MenuItem>
                        <dxm:MenuItem Name="mEdit" Text="Modifier">
                            <Image Url="../../../images/edit.gif"></Image>
                        </dxm:MenuItem>
                        <dxm:MenuItem Name="mDelete" Text="Supprimer">
                            <Image Url="../../../images/delete.gif"></Image>
                        </dxm:MenuItem>
                    </Items>
                </dxm:MenuItem>
        </Items>
    </dxm:ASPxMenu>
</div>   

<dxm:ASPxPopupMenu ID="popupMenu" runat="server" Theme="Glass" ClientInstanceName="popupMenu">
    <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />    
   <Items>
            <dxm:MenuItem Name="mAdd" Text="Ajouter">                
                <Image Url="../../../images/add.gif" Width="16px"></Image>
            </dxm:MenuItem>
            <dxm:MenuItem Name="mEdit" Text="Modifier">                
                <Image Url="../../../images/edit.gif"></Image>
            </dxm:MenuItem>
            <dxm:MenuItem Name="mDelete" Text="Supprimer">
                <Image Url="../../../images/delete.gif"></Image>
            </dxm:MenuItem>
        </Items>
</dxm:ASPxPopupMenu>

<dx:ASPxGridView ID="grdParam" runat="server" Width="100%" ClientInstanceName="grdParam" OnCustomCallback="grdParam_CustomCallback"
    ClientIDMode="AutoID" Theme="Glass" AutoGenerateColumns="False" DataSourceID="SqlParamDS" EnableTheming="True" KeyFieldName="ID" Settings-VerticalScrollBarMode="Auto" Settings-VerticalScrollableHeight="450" OnCustomErrorText="grdParam_CustomErrorText">
    <ClientSideEvents  ContextMenu="grid_ContextMenu"/>
    <SettingsBehavior AllowFocusedRow="true" />
    <Columns>
        <dx:GridViewCommandColumn ButtonType="Image" Visible="false" Width="40px" Caption=" " VisibleIndex="0" ShowEditButton="True" ShowDeleteButton="True"/>
        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Designation" VisibleIndex="1">
        </dx:GridViewDataTextColumn>
        <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowSelectCheckbox="True" Visible="False" VisibleIndex="7" ShowCancelButton="True" ShowUpdateButton="True" ShowClearFilterButton="True"/>
    </Columns>
    <SettingsEditing Mode="EditForm"></SettingsEditing>
    <SettingsLoadingPanel Mode="ShowOnStatusBar" />
    <SettingsPager PageSize="10" >
        <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
        <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
    </SettingsPager>
    <Settings ShowFilterRow="True" ShowFooter="true" />
    <Images>
        <LoadingPanelOnStatusBar Url="~/App_Themes/Glass/GridView/gvLoadingOnStatusBar.gif">
        </LoadingPanelOnStatusBar>
        <LoadingPanel Url="~/App_Themes/Glass/GridView/Loading.gif">
        </LoadingPanel>
    </Images>
    <ImagesFilterControl>
        <LoadingPanel Url="~/App_Themes/Glass/Editors/Loading.gif">
        </LoadingPanel>
    </ImagesFilterControl>
    <Styles>
        <Header ImageSpacing="5px" SortingImageSpacing="5px">
        </Header>
    </Styles>
    <StylesEditors>
        <CalendarHeader Spacing="1px">
        </CalendarHeader>
        <ProgressBar Height="25px">
        </ProgressBar>
    </StylesEditors>
    <SettingsCommandButton>
        <EditButton>
            <Image Url="../../../images/edit.gif">
            </Image>
        </EditButton>
        <DeleteButton>
            <Image Url="../../../images/delete.gif">
            </Image>
        </DeleteButton>
    </SettingsCommandButton>
</dx:ASPxGridView>


<asp:SqlDataSource ID="SqlParamDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllBrands" SelectCommandType="StoredProcedure"
     DeleteCommand="Materials_DeleteBrand" DeleteCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>       
</asp:SqlDataSource>

<dx:ASPxPopupControl ID="popupCtrl" runat="server" AllowDragging="True" AllowResize="True"
    ContentUrl="~/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/Param_MeasureSystem.ascx"
    EnableViewState="False" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="False" Width="600px"
    HeaderText="Système de mesure" ClientInstanceName="popupCtrl" EnableHierarchyRecreation="True" Theme="Glass" ShowPinButton="True" ShowRefreshButton="True" ShowCollapseButton="True" ShowMaximizeButton="True">

    <clientsideevents closeup="function(s, e) {grdParam.PerformCallback();}"></clientsideevents>

    <contentstyle>
            
<Paddings Padding="0px"></Paddings>
        
</contentstyle>

    <contentcollection>
<dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True"></dx:PopupControlContentControl>
</contentcollection>
</dx:ASPxPopupControl>
  

