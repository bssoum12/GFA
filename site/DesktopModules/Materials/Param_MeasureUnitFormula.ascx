<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_MeasureUnitFormula.ascx.cs" Inherits="VD.Modules.Materials.Param_MeasureUnitFormula" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web	" TagPrefix="dxpc" %>

<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>

<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />
<script type="text/javascript">
    var t_MeasureUnit = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tMeasureUnit", ressFilePath )%>';
    function AddItemToGrid() {
        window.setTimeout(function () { grdParam.AddNewRow(); }, 0)
    }
    var mode;
    function ShowPopupMesureUnit(m) {
        mode = m;
        if (mode == 'add') {
            ShowPopupMesureUnit_Callback('');
        }
        else {
            if (grdParam) {
                var index = grdParam.GetFocusedRowIndex();
                if (index == -1) {
                    //    alert(mSelectCandidature);
                }
                else {
                    grdParam.GetRowValues(index, "ID_UniteMeasure", ShowPopupMesureUnit_Callback);
                }
            }
        }
    }


    function ShowPopupMesureUnit_Callback(key) {
        popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddMeasureUnitCtrl.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&mode=" + mode + "&key=" + key);
        popupCtrl.SetHeaderText(t_MeasureUnit);
        popupCtrl.Show();
    }
    //ID_UniteMeasure
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
        if (name == "mnMeasureUnit_Add") ShowPopupMesureUnit('add');
        if (name == "mnMeasureUnit_Edit") ShowPopupMesureUnit('edit');
        
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
        text-decoration: none;
        color: Red;
        font-weight: bold;
        font-family: Tahoma;
        font-size: 12px;
    }

    .btnGlassLink
    {
        text-decoration: none;
        color: #266D8D;
        font-weight: bold;
        font-family: Tahoma;
        font-size: 12px;
    }
</style>


<div style="padding-bottom:10px;">
  <dxm:ASPxMenu ID="toolbarMenu" runat="server" EnableTheming="True" Theme="Glass"  AutoPostBack="false"    Width="100%"   ItemAutoWidth="false"  >                
    <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />
    <Items>    
        <dxm:MenuItem Name="mnFormules" Text="Formules">
            <Image Url="~/images/Materials/Formule-Icon.png" Width="16px" Height="16px"></Image>
            <SubMenuItemStyle Width="150px"   ></SubMenuItemStyle>
            <Items>
                    <dxm:MenuItem Name="mAdd" Text="Ajouter"   >                      
                        <Image Url="../../../images/add.gif" Width="16px" ></Image>
                    </dxm:MenuItem>
                    <dxm:MenuItem Name="mEdit" Text="Modifier">                        
                         <Image Url="../../../images/edit.gif" ></Image>
                    </dxm:MenuItem>
                    <dxm:MenuItem Name="mDelete" Text="Supprimer">            
                         <Image Url="../../../images/delete.gif" ></Image>
                    </dxm:MenuItem>        
                </Items>
        </dxm:MenuItem>   
        <dxm:MenuItem Name="mnMeasureUnit" Text="unité de mesure" >
            <Image Url="~/images/Materials/Units-icon.png" Width="16px" Height="16px"></Image>  
            <SubMenuItemStyle Width="150px"  ></SubMenuItemStyle>          
             <Items>
                 <dxm:MenuItem Name="mnMeasureUnit_Add" Text="Ajouter"   >                                           
                    <Image Url="../../../images/add.gif"  ></Image>
                </dxm:MenuItem>
                <dxm:MenuItem Name="mnMeasureUnit_Edit" Text="Modifier">                        
                     <Image Url="../../../images/edit.gif" ></Image>
                </dxm:MenuItem>                 
             </Items>
        </dxm:MenuItem>       
    </Items>
</dxm:ASPxMenu>
</div>   
<dxm:ASPxPopupMenu ID="popupMenu" runat="server" Theme="Glass" ClientInstanceName="popupMenu" >
    <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />
    <Items>   
         <dxm:MenuItem Name="mnFormules" Text="Formules">
            <Image Url="~/images/Materials/Formule-Icon.png" Width="16px" Height="16px"></Image>
            <SubMenuItemStyle Width="150px"  ></SubMenuItemStyle>
            <Items>    
                        <dxm:MenuItem Name="mAdd" Text="Ajouter"   >                                      
                            <Image Url="../../../images/add.gif" Width="16px" ></Image>
                        </dxm:MenuItem>
                        <dxm:MenuItem Name="mEdit" Text="Modifier">                            
                             <Image Url="../../../images/edit.gif" ></Image>
                        </dxm:MenuItem>
                        <dxm:MenuItem Name="mDelete" Text="Supprimer">            
                             <Image Url="../../../images/delete.gif" ></Image>
                        </dxm:MenuItem> 
                </Items>
                </dxm:MenuItem>       
        <dxm:MenuItem Name="mnMeasureUnit" Text="unité de mesure">
            <Image Url="~/images/Materials/Units-icon.png" Width="16px" Height="16px"></Image>  
            <SubMenuItemStyle Width="150px"  ></SubMenuItemStyle>          
             <Items>
                 <dxm:MenuItem Name="mnMeasureUnit_Add" Text="Ajouter"   >                                           
                    <Image Url="../../../images/add.gif" ></Image>
                </dxm:MenuItem>
                <dxm:MenuItem Name="mnMeasureUnit_Edit" Text="Modifier">                        
                     <Image Url="../../../images/edit.gif" ></Image>
                </dxm:MenuItem>                 
             </Items>
        </dxm:MenuItem>       
    </Items>
</dxm:ASPxPopupMenu>


<dx:ASPxGridView ID="grdMeasureUnitFormula" runat="server" Width="100%" ClientInstanceName="grdParam"
    ClientIDMode="AutoID" Theme="Glass" 
    AutoGenerateColumns="False" DataSourceID="SqlMeasureUnitFormula" EnableTheming="True" KeyFieldName="ID">
    <ClientSideEvents ContextMenu="grid_ContextMenu" />
    <SettingsBehavior AllowFocusedRow="true" />
    <Columns>
        <dx:GridViewCommandColumn ButtonType="Image" Visible="false" Width="40px" Caption=" " VisibleIndex="0" ShowEditButton="True" ShowDeleteButton="True"/>
        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>

        <dx:GridViewDataComboBoxColumn FieldName="ID_UniteMeasure" VisibleIndex="1" Caption="De">
            <PropertiesComboBox DataSourceID="SqlMeasureUnitDS" TextField="Designation" ValueField="ID" ValueType="System.Int32"
                Width="100%" IncrementalFilteringMode="Contains">
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataComboBoxColumn FieldName="ID_UniteMeasure_To" VisibleIndex="2" Caption="à">
            <PropertiesComboBox DataSourceID="SqlMeasureUnitDS" TextField="Designation" ValueField="ID" ValueType="System.Int32"
                Width="100%" IncrementalFilteringMode="Contains">
            </PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
        <dx:GridViewDataTextColumn FieldName="Formula" VisibleIndex="3" Caption="Formule">
            <PropertiesTextEdit Width="100%"></PropertiesTextEdit>
        </dx:GridViewDataTextColumn>
        <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowSelectCheckbox="True" Visible="False" VisibleIndex="7" ShowCancelButton="True" ShowUpdateButton="True" ShowClearFilterButton="True"/>
    </Columns>
    <SettingsEditing Mode="EditForm"></SettingsEditing>
    <SettingsLoadingPanel Mode="ShowOnStatusBar" />
    <SettingsPager PageSize="10">
        <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
        <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
    </SettingsPager>
    <Settings ShowFilterRow="True" ShowFooter="true" />
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



<dxpc:ASPxPopupControl ID="popupCtrl" runat="server" AllowDragging="True" AllowResize="True"
    ContentUrl="~/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/Param_MeasureUnit.ascx"
    EnableViewState="False" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" Width="700px"
    Height="250px" HeaderText="Système de mesure" ClientInstanceName="popupCtrl" EnableHierarchyRecreation="True" Theme="Glass" ShowPinButton="True" ShowRefreshButton="True" ShowCollapseButton="True" ShowMaximizeButton="True">
    <clientsideevents closeup="function(s, e) {
	grdParam.PerformCallback();
}"></clientsideevents>
    <contentcollection>
<dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True"></dx:PopupControlContentControl>
</contentcollection>
</dxpc:ASPxPopupControl>


<asp:SqlDataSource ID="SqlMeasureUnitFormula" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllMeasureUnitFormula" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeleteMeasureUnitFormula" DeleteCommandType="StoredProcedure"
    InsertCommand="Materials_InsertMeasureUnitFormula" InsertCommandType="StoredProcedure"
    UpdateCommand="Materials_UpdateMeasureUnitFormula" UpdateCommandType="StoredProcedure"
    OnInserting="SqlMeasureUnitFormula_Inserting" OnUpdating="SqlMeasureUnitFormula_Updating">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="ID_UniteMeasure" Type="Int32" />
        <asp:Parameter Name="ID_UniteMeasure_To" Type="Int32" />
        <asp:Parameter Name="Formula" Type="String" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" Type="Int32" />
        <asp:Parameter Name="ID_UniteMeasure" Type="Int32" />
        <asp:Parameter Name="ID_UniteMeasure_To" Type="Int32" />
        <asp:Parameter Name="Formula" Type="String" />
    </UpdateParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlMeasureUnitDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllMeasureUnit" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
