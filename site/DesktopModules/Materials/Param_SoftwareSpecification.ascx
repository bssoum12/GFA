<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_SoftwareSpecification.ascx.cs" Inherits="VD.Modules.Materials.Param_SoftwareSpecification" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxm" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxe" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>


<localizeModule:localizeModule ID="localModule" runat="server"/>
<accessModule:accessModule ID="AccModule" runat="server"/>
<script type="text/javascript">
    function AddItemToGrid() {
        window.setTimeout(function () { grdParam.AddNewRow(); }, 0)
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

<div style="padding-bottom: 10px;">
    <dxm:ASPxMenu ID="toolbarMenu" runat="server" EnableTheming="True" Theme="Glass" AutoPostBack="false" Width="100%"  ItemAutoWidth="false">
        <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />
        <Items>
            <dxm:MenuItem Name="mManageSpecSoftware" Text="Spécification logiciel" >                
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

<dx:ASPxGridView ID="grdParam" runat="server" Width="100%" ClientInstanceName="grdParam" 
   ClientIDMode="AutoID" Theme="Glass"  AutoGenerateColumns="False" DataSourceID="SqlParamDS" EnableTheming="True" KeyFieldName="ID">
    <ClientSideEvents  ContextMenu="grid_ContextMenu"/>
    <SettingsBehavior AllowFocusedRow="true" />    
    <Columns>
        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
            <EditFormSettings Visible="False"></EditFormSettings>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Name" Caption="Nom" VisibleIndex="2" Width="50%"></dx:GridViewDataTextColumn>        
        <dx:GridViewDataComboBoxColumn FieldName="ID_TechnicalSoftwares" Caption="Logiciel" VisibleIndex="1" Width="50%" >
            <PropertiesComboBox DataSourceID="SqlTechnicalSoftwareDS" ValueField="ID" TextField="Name" IncrementalFilteringMode="Contains"></PropertiesComboBox>
        </dx:GridViewDataComboBoxColumn>
    </Columns>
    <SettingsEditing Mode="EditForm"></SettingsEditing>
    <SettingsLoadingPanel Mode="ShowOnStatusBar" />
    <SettingsPager PageSize="10">
        <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
        <Summary AllPagesText="Pages: {0} - {1} ({2} éléments)" Text="Page {0} sur {1} ({2} éléments)" />
    </SettingsPager>
    <Settings ShowFilterRow="True" ShowFooter="true" />    
</dx:ASPxGridView>


<asp:SqlDataSource ID="SqlParamDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllSoftwareSpecification" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeleteSoftwareSpecification" DeleteCommandType="StoredProcedure" InsertCommand="EIFMaterials_AddSoftwareSpecification" InsertCommandType="StoredProcedure" UpdateCommand="EIFMaterials_UpdateSoftwareSpecification" UpdateCommandType="StoredProcedure">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="Name" Type="String" />
        <asp:Parameter Name="ID_TechnicalSoftwares" Type="Int32" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="ID" Type="Int32" />
        <asp:Parameter Name="Name" Type="String" />
        <asp:Parameter Name="ID_TechnicalSoftwares" Type="Int32" />
    </UpdateParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlTechnicalSoftwareDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllTechnicalSoftware" SelectCommandType="StoredProcedure"    >    
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource> 