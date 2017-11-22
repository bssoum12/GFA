<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_MeasureUnit.ascx.cs" Inherits="VD.Modules.Materials.Param_MeasureUnit" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web	" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>


<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />
<script type="text/javascript">
    var t_MeasureSystem = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tMeasureSystem", ressFilePath )%>';
    var t_UnitFamilies = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tUnitFamilies", ressFilePath )%>';
    function AddItemToGrid() {
        window.setTimeout(function () { grdParam.AddNewRow(); }, 0)
    }

    var mode;
    function ShowPopupMesureSystem(m) {
        mode = m;
        if (mode == 'add') {
            ShowPopupMesureSystem_Callback('');
        }
        else {
            if (grdParam) {
                var index = grdParam.GetFocusedRowIndex();
                if (index == -1) {
                    //    alert(mSelectCandidature);
                }
                else {
                    grdParam.GetRowValues(index, "ID_SystemMeasure", ShowPopupMesureSystem_Callback);
                }
            }
        }
    }

    function ShowPopupMesureSystem_Callback(key) {
        popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddMeasureSystemCtrl.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&mode=" + mode + "&key=" + key);
        popupCtrl.SetHeaderText(t_MeasureSystem);
        popupCtrl.Show();
    }

    function ShowPopupUnitFamilies(m) {
        mode = m;
        if (mode == 'add') {
            ShowPopupUnitFamilies_Callback('');
        }
        else {
            if (grdParam) {
                var index = grdParam.GetFocusedRowIndex();
                if (index == -1) {
                    //    alert(mSelectCandidature);
                }
                else {
                    grdParam.GetRowValues(index, "ID_FamilyUnites", ShowPopupUnitFamilies_Callback);
                }
            }
        }
    }

    function ShowPopupUnitFamilies_Callback(key) {
        popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddUnitFamiliesCtrl.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&mode=" + mode + "&key=" + key);
        popupCtrl.SetHeaderText(t_UnitFamilies);
        popupCtrl.Show();
    }

    function EditFocusedItem() {
        var index = grdParam.GetFocusedRowIndex();
        grdParam.StartEditRow(index);
    }
    function DeletFocusedItem() {
        var index = grdParam.GetFocusedRowIndex();
        grdParam.DeleteRow(index);
    }
    function MenuItemClick(e) {
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "mAdd") AddItemToGrid();
        if (name == "mEdit") EditFocusedItem();
        if (name == "mDelete") DeletFocusedItem();
        if (name == "mnMeasureSystems_Add") ShowPopupMesureSystem('add');
        if (name == "mnMeasureSystems_Edit") ShowPopupMesureSystem('edit');
        if (name == "mnUnitFamilies_Add") ShowPopupUnitFamilies('add');
        if (name == "mnUnitFamilies_Edit") ShowPopupUnitFamilies('edit');
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

<div style="padding-bottom:10px;">
  <dxm:ASPxMenu ID="toolbarMenu" runat="server" EnableTheming="True" Theme="Glass"  AutoPostBack="false"    Width="100%"   ItemAutoWidth="false"  >                
    <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />
    <Items>       
        <dxm:MenuItem Name="mnMeasureUnit" Text="Unité de mesure">
            <Image Url="~/images/Materials/Units-icon.png" Width="16px" Height="16px"></Image>  
            <SubMenuItemStyle Width="150px" ></SubMenuItemStyle>          
            <Items>
                    <dxm:MenuItem Name="mAdd" Text="Ajouter"   >                      
                        <Image Url="../../../images/add.gif" ></Image>
                    </dxm:MenuItem>
                    <dxm:MenuItem Name="mEdit" Text="Modifier">            
                         <Image Url="../../../images/edit.gif" ></Image>
                    </dxm:MenuItem>
                    <dxm:MenuItem Name="mDelete" Text="Supprimer">            
                         <Image Url="../../../images/delete.gif" ></Image>
                    </dxm:MenuItem> 
             </Items>
        </dxm:MenuItem>
        <dxm:MenuItem Name="mnMeasureSystems" Text="Systèmes de mesures" >
            <Image Url="~/images/Materials/measure_system.png" Width="16px" Height="16px"></Image>  
            <SubMenuItemStyle Width="150px"  ></SubMenuItemStyle>          
             <Items>
                 <dxm:MenuItem Name="mnMeasureSystems_Add" Text="Ajouter"   >                                           
                    <Image Url="../../../images/add.gif" ></Image>
                </dxm:MenuItem>
                <dxm:MenuItem Name="mnMeasureSystems_Edit" Text="Modifier">                        
                     <Image Url="../../../images/edit.gif" ></Image>
                </dxm:MenuItem>                 
             </Items>
        </dxm:MenuItem>       
        <dxm:MenuItem Name="mnUnitFamilies" Text="Familles d'unités">                       
            <Image Url="~/images/Materials/unit-families.png" Width="16px" Height="16px"></Image>
            <SubMenuItemStyle Width="150px"  ></SubMenuItemStyle>          
             <Items>
                 <dxm:MenuItem Name="mnUnitFamilies_Add" Text="Ajouter"   >                                    
                    <Image Url="../../../images/add.gif" ></Image>
                </dxm:MenuItem>
                <dxm:MenuItem Name="mnUnitFamilies_Edit" Text="Modifier">            
                     <Image Url="../../../images/edit.gif" ></Image>
                </dxm:MenuItem>                 
             </Items>
        </dxm:MenuItem>
    </Items>
</dxm:ASPxMenu>
</div>   

<dxm:ASPxPopupMenu ID="popupMenu" runat="server" Theme="Glass" ClientInstanceName="popupMenu">
    <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />
     <Items>     
         <dxm:MenuItem Name="mnMeasureUnit" Text="Unité de mesure">
            <Image Url="~/images/Materials/Units-icon.png" Width="16px" Height="16px"></Image>  
            <SubMenuItemStyle Width="150px" ></SubMenuItemStyle>          
            <Items>  
                    <dxm:MenuItem Name="mAdd" Text="Ajouter"   >                      
                        <Image Url="../../../images/add.gif" ></Image>
                    </dxm:MenuItem>
                    <dxm:MenuItem Name="mEdit" Text="Modifier">            
                         <Image Url="../../../images/edit.gif" ></Image>
                    </dxm:MenuItem>
                    <dxm:MenuItem Name="mDelete" Text="Supprimer">            
                         <Image Url="../../../images/delete.gif" ></Image>
                    </dxm:MenuItem> 
                </Items>
                </dxm:MenuItem>
        <dxm:MenuItem Name="mnMeasureSystems" Text="Systèmes de mesures" >
            <Image Url="~/images/Materials/measure_system.png" Width="16px" Height="16px" ></Image>  
            <SubMenuItemStyle Width="150px" ></SubMenuItemStyle>          
             <Items>
                 <dxm:MenuItem Name="mnMeasureSystems_Add" Text="Ajouter"   >                                           
                    <Image Url="../../../images/add.gif" ></Image>
                </dxm:MenuItem>
                <dxm:MenuItem Name="mnMeasureSystems_Edit" Text="Modifier">                        
                     <Image Url="../../../images/edit.gif" ></Image>
                </dxm:MenuItem>                 
             </Items>
        </dxm:MenuItem>       
        <dxm:MenuItem Name="mnUnitFamilies" Text="Familles d'unités" >
            <Image Url="~/images/Materials/unit-families.png"  Width="16px" Height="16px"></Image>
            <SubMenuItemStyle Width="150px" ></SubMenuItemStyle>          
             <Items>
                 <dxm:MenuItem Name="mnUnitFamilies_Add" Text="Ajouter"   >                                    
                    <Image Url="../../../images/add.gif" ></Image>
                </dxm:MenuItem>
                <dxm:MenuItem Name="mnUnitFamilies_Edit" Text="Modifier">            
                     <Image Url="../../../images/edit.gif" ></Image>
                </dxm:MenuItem>                 
             </Items>
        </dxm:MenuItem>
    </Items>
</dxm:ASPxPopupMenu>



<dx:ASPxGridView ID="grdParam" runat="server" Width="100%" ClientInstanceName="grdParam" OnCustomCallback="grdParam_CustomCallback"
    ClientIDMode="AutoID" Theme="Glass" OnHtmlEditFormCreated="grdParam_HtmlEditFormCreated"
    AutoGenerateColumns="False" DataSourceID="SqlMeasureUnitDS" KeyFieldName="ID">
    <ClientSideEvents  ContextMenu="grid_ContextMenu"/>
    <SettingsBehavior AllowFocusedRow="true" />
    <Templates>
        <EditForm>
            <table style="width: 100%">
                <tr>
                    <td style="vertical-align: top;">
                        <%= GlobalAPI.CommunUtility.getRessourceEntry("lblDescription", ressFilePath )%>
                    </td>
                    <td style="width: 200px;">
                        <txtEifBox:txtEifBox ID="txtDesignation" runat="server" Width="200" ImageSrc="~/images/expand.gif" Theme="Glass" />
                    </td>
                    <td>                        
                        <%= GlobalAPI.CommunUtility.getRessourceEntry("lblAbbreviation", ressFilePath )%>
                    </td>
                    <td style="width: 200px;">
                        <dxe:ASPxTextBox ID="txtAbbreviation" runat="server" Theme="Glass"></dxe:ASPxTextBox>
                    </td>
                </tr>
                <tr>
                    <td>                        
                        <%= GlobalAPI.CommunUtility.getRessourceEntry("hSystemMeasure", ressFilePath )%>
                    </td>
                    <td style="width: 200px;">
                        <dxe:ASPxComboBox ID="cmbSystemeMesure" runat="server" Theme="Glass" DataSourceID="SqlSystemMeasureDS" Width="100%"
                            TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains" ValueType="System.Int32">
                              <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                <RequiredField IsRequired="true" ErrorText="Ce champ ne peut pas ètre vide." />
                                </ValidationSettings>
                        </dxe:ASPxComboBox>
                    </td>
                    <td>                        
                        <%= GlobalAPI.CommunUtility.getRessourceEntry("mnUnitFamilies", ressFilePath ).Replace(@"\","") %>
                    </td>
                    <td style="width: 200px;">
                        <dxe:ASPxComboBox ID="cmbFamilyUnit" runat="server" Theme="Glass" DataSourceID="SqlUnitFamiliesDS"
                            TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains" ValueType="System.Int32">
                        </dxe:ASPxComboBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="right">
                        <table>
                            <tr>
                                <td style="text-align: right">
                                    <dxe:ASPxButton ID="btnUpdate" runat="server" Text="Update" Theme="Glass" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) {grdParam.PerformCallback('save');}"></ClientSideEvents>
                                        <ClientSideEvents />
                                    </dxe:ASPxButton>
                                </td>
                                <td style="text-align: left">
                                    <dxe:ASPxButton ID="btnCancel" runat="server" Text="Cancel" Theme="Glass" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) {grdParam.CancelEdit();}"></ClientSideEvents>
                                        <ClientSideEvents />
                                    </dxe:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </EditForm>
    </Templates>
    <Columns>
        <dx:GridViewCommandColumn ButtonType="Image" Visible="false" Width="40px" Caption=" " VisibleIndex="0" ShowEditButton="true" ShowDeleteButton="true">
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Designation" Caption="Description" VisibleIndex="1" Width="150px">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Abreviation" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataComboBoxColumn FieldName="ID_SystemMeasure" Caption="Système de mesure" VisibleIndex="3" Visible="true" Width="150px">
            <PropertiesComboBox DataSourceID="SqlSystemMeasureDS" TextField="Designation" ValueField="ID"
                IncrementalFilteringMode="Contains" ValueType="System.Int32">
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataComboBoxColumn FieldName="ID_FamilyUnites" Caption="Famille d'unité" VisibleIndex="4" Visible="true" Width="150px">
            <PropertiesComboBox DataSourceID="SqlUnitFamiliesDS" TextField="Designation" ValueField="ID"
                IncrementalFilteringMode="Contains" ValueType="System.Int32">
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
    </Columns>
    <Settings VerticalScrollableHeight="450" VerticalScrollBarMode="Auto" />
    <SettingsEditing Mode="EditForm"></SettingsEditing>
    <SettingsLoadingPanel Mode="ShowOnStatusBar" />
    <SettingsPager PageSize="10">
        <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
        <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
    </SettingsPager>
    <Settings ShowFilterRow="True" ShowFooter="true" />
    <SettingsCommandButton>
        <EditButton>
                <Image Url="../../../images/edit.gif"></Image>
            </EditButton>
            <DeleteButton>
                <Image Url="../../../images/delete.gif"></Image>
            </DeleteButton>
    </SettingsCommandButton>
</dx:ASPxGridView>
 

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



<asp:SqlDataSource ID="SqlMeasureUnitDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllMeasureUnit" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeleteMeasureUnit" DeleteCommandType="StoredProcedure"    >
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
   
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlSystemMeasureDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllMeasureSystem" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlUnitFamiliesDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllUnitFamilies" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
