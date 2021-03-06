﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_UnitFamilies.ascx.cs" Inherits="VD.Modules.Materials.Param_UnitFamilies" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxm" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxe" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>

<localizeModule:localizeModule ID="localModule" runat="server"/>
<accessModule:accessModule ID="AccModule" runat="server"/>
<script type="text/javascript">
    var index = -1;
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
    
    
    .dnnFormMessage {
    -moz-border-radius: 3px;
    border-radius: 3px;
    padding: 10px 10px 10px 40px;
    line-height: 1.4;
    margin: 0.5em 1em;
}
.dnnFormMessage span {
    float: none;
    padding: 0;
    width: 100%;
    text-align: left;
    text-shadow: 0px 1px 1px #fff;
}

.dnnFormValidationSummary {
    background: #f7eaea url(../../images/error-icn.png) no-repeat 10px center;
    text-shadow: 0px 1px 1px #fff;
    color: #900;
    border: 2px #df4a40 solid;
}  
</style>





<div style="padding-bottom: 10px;">
    <dxm:ASPxMenu ID="toolbarMenu" runat="server" EnableTheming="True" Theme="Glass" AutoPostBack="false" Width="100%" ItemAutoWidth="false"
         ClientInstanceName="toolbarMenu">
        <ClientSideEvents ItemClick="function(s,e){ MenuItemClick(e);  }" />
        <Items>
            <dxm:MenuItem Name="mManageUnitFamilies" Text="Gestion familles d'unités" >                
                <Image Url="~/images/Materials/unit-families.png" Width="16px" Height="16px"></Image>
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
    ClientIDMode="AutoID" Theme="Glass" OnHtmlEditFormCreated="grdParam_HtmlEditFormCreated" 
    AutoGenerateColumns="False" DataSourceID="SqlParamDS" EnableTheming="True" KeyFieldName="ID">
    <ClientSideEvents ContextMenu="grid_ContextMenu" />
    <SettingsBehavior AllowFocusedRow="true" />
    <Templates>
        <EditForm>
            <table style="width: 100%;">
                <tr>
                    <td style="vertical-align: top;">
                        <asp:Label ID="lblDesignation" runat="server" Text="Description"></asp:Label>
                    </td>
                    <td>
                        <txtEifBox:txtEifBox ID="txtDesignation" runat="server" Width="400" ImageSrc="~/images/expand.gif" Theme="Glass" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
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
                                        <ClientSideEvents Click="function(s, e) {	grdParam.CancelEdit();}"></ClientSideEvents>
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


   

<asp:SqlDataSource ID="SqlParamDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>" 
    SelectCommand="Materials_GetAllUnitFamilies" SelectCommandType="StoredProcedure" 
    DeleteCommand="Materials_DeleteUnitFamilies" DeleteCommandType="StoredProcedure" 
    InsertCommand="Materials_InsertUnitFamilies" InsertCommandType="StoredProcedure"
    UpdateCommand="Materials_UpdateUnitFamilies" UpdateCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>        
</asp:SqlDataSource>
