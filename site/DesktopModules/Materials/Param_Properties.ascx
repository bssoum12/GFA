<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_Properties.ascx.cs" Inherits="VD.Modules.Materials.Param_Properties" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxrp" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxm" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>
<popupWin:popupWin ID="popupWin" runat="server" />
<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />

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

<script type="text/javascript">
    var editingVisibleIndex;

    function AddItemToGrid() {
        window.setTimeout(function () { grdParam.AddNewRow(); }, 0)
    }

    function DeleteProperties() {
        if (grdParam)
            grdParam.DeleteRow(editingVisibleIndex);
    }

    function EditProperties() {
        grdParam.StartEditRow(grdParam.GetFocusedRowIndex());
    }

    function AffecterUniteMesure() {

        if (grdParam)
            grdParam.GetRowValues(editingVisibleIndex, "ID", AffecterUniteMesure_Callback);
    }

    function AffecterUniteMesure_Callback(key) {

        if (key != null) {
            txtPropertiesID.SetText(key);
            grdMeasureUnit.PerformCallback(key)
            //grdMeasureUnit.SelectRowsByKey(key);
            popupAffecterUniteMesure.Show();
        }
    }


    function GridMenuItemClick(e) {

        if (e.item == null) return;
        var name = e.item.name;
        if (name == "Edit") EditProperties();
        if (name == "Delete") DeleteProperties();
        if (name == "Affecter") AffecterUniteMesure();
    }

    function ShowContextMenu(el, visibleIndex) {
        editingVisibleIndex = visibleIndex;
        menu.ShowAtElement(el);
    }

    function SetDropDownEditPropertyGrpText(focusedVal) {
        ddePropertyGrp.SetText(focusedVal[1]);
        ddePropertyGrp.HideDropDown();
        hfPropertyGrp.Set('Id_PropertyGrp', focusedVal[0]);
    }

    function ShowPupAddNewPropertyGrp() {
        //pupAddNewPropertyGrp.Show();
        oldPopup("LoadControl.aspx?ctrl=Materials/Param_GroupProperties.ascx", 600, 700, '<%= DotNetNuke.Services.Localization.Localization.GetString("mAddNewParentPropertiesGrp", ressFilePath)%>');
    }

    function oldPopup(url, height, width, title) {
        popupWind.SetSize(width, height);
        popupWind.SetHeaderText(title);
        var protocal = 'http';
        if (document.location.href.toString().indexOf('https') == 0)
            protocal = 'https';

        if (url.toString().indexOf('?') == -1)
            popupWind.SetContentUrl(protocal + "://<%= _portalAlias %>/DesktopModules/Materials/" + url + "?lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>");
        else
            popupWind.SetContentUrl(protocal + "://<%= _portalAlias %>/DesktopModules/Materials/" + url + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>");
        popupWind.Show();
    }
</script>

<div style="display: none;">
    <dxe:ASPxTextBox ID="txtPropertiesID" ClientInstanceName="txtPropertiesID" runat="server"></dxe:ASPxTextBox>
</div>

<dxm:ASPxPopupMenu ID="menu" runat="server"
    ClientInstanceName="menu"
    Theme="Glass" GutterWidth="0px"
    SeparatorColor="#7EACB1">
    <Items>
        <dxm:MenuItem Name="Edit" Text="Modifier">
            <Image Url="~/images/edit.gif" Width="16px" Height="16px" />
        </dxm:MenuItem>
        <dxm:MenuItem Name="Delete" Text="Supprimer">
            <Image Url="~/images/delete.gif"  Width="16px" Height="16px"/>
        </dxm:MenuItem>
        <dxm:MenuItem Name="Affecter" Text="Affecter Unité de mesure">
            <Image Url="~/images/restore.gif" Width="16px" Height="16px" />
        </dxm:MenuItem>
    </Items>
    <ItemStyle ImageSpacing="5px" />
    <SubMenuStyle BackColor="#EDF3F4" GutterWidth="0px" SeparatorColor="#7EACB1" />
    <ClientSideEvents ItemClick="function(s, e) {GridMenuItemClick(e);}" />
    <SubMenuItemImage Height="7px" Width="7px" />
</dxm:ASPxPopupMenu>


<table style="width: 100%">
    <tr>
        <td colspan="2">
            <table>
                <tr>
                    <td>
                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/add.gif" Width="16px" />
                    </td>
                    <td>
                        <a class="btnRedLink" href="javascript:AddItemToGrid();"><%= DotNetNuke.Services.Localization.Localization.GetString("mAddNewProperties", ressFilePath)%></a>
                    </td>
                    <td>&nbsp;
                    </td>
                </tr>
            </table>
            <dx:ASPxGridView ID="grdParam" runat="server" Width="100%" ClientInstanceName="grdParam" OnCustomCallback="grdParam_CustomCallback"
                ClientIDMode="AutoID" Theme="Glass" OnHtmlEditFormCreated="grdParam_HtmlEditFormCreated"
                AutoGenerateColumns="False" DataSourceID="SqlPropertiesDS" EnableTheming="True" KeyFieldName="ID" OnRowDeleting="grdParam_RowDeleting" >
                <SettingsBehavior AllowFocusedRow="true" />
                <Templates>
                    <EditForm>
                        <table style="width: 100%;">
                            <tr>
                                <td style="vertical-align: top;">
                                    <dxe:ASPxLabel ID="lblDesignation" runat="server"></dxe:ASPxLabel>
                                </td>
                                <td>
                                    <txtEifBox:txtEifBox ID="txtDesignation" runat="server" Width="400" ImageSrc="~/images/expand.gif" Theme="Glass" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dxe:ASPxLabel ID="lblPropertyGrp" runat="server" Text="ASPxLabel"></dxe:ASPxLabel>
                                </td>
                                <td>
                                    <dxe:ASPxDropDownEdit ID="ddePropertyGrp" ClientInstanceName="ddePropertyGrp" runat="server" Width="400" Theme="Glass">
                                        <DropDownWindowTemplate>
                                            <dx:ASPxTreeList ID="tlProtertiesGrpMgr" ClientInstanceName="tlProtertiesGrpMgr" runat="server" Theme="Glass"
                                                DataSourceID="sqlGetPropertiesGroup" ParentFieldName="ParentId" KeyFieldName="ID" Width="100%" OnDataBound="tlProtertiesGrpMgr_DataBound">
                                                <Columns>
                                                    <dx:TreeListTextColumn FieldName="ID" Visible="false">
                                                    </dx:TreeListTextColumn>
                                                    <dx:TreeListTextColumn FieldName="Designation" VisibleIndex="0">
                                                    </dx:TreeListTextColumn>
                                                </Columns>
                                                <Settings VerticalScrollBarMode="Visible" ScrollableHeight="150" />
                                                <SettingsBehavior AllowFocusedNode="true" ProcessFocusedNodeChangedOnServer="true"
                                                    ExpandCollapseAction="NodeDblClick" FocusNodeOnExpandButtonClick="true" />
                                                <SettingsEditing Mode="EditForm" />
                                                <ClientSideEvents FocusedNodeChanged="function(s,e){
                                                    s.GetNodeValues(s.GetFocusedNodeKey(), 'ID;Designation', SetDropDownEditPropertyGrpText);
                                                    }" />
                                            </dx:ASPxTreeList>
                                        </DropDownWindowTemplate>
                                    </dxe:ASPxDropDownEdit>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <dxe:ASPxLabel ID="lblFormat" runat="server" Theme="Glass" ></dxe:ASPxLabel>
                                </td>
                                <td>
                                    <dxe:ASPxTextBox ID="txtFormat" runat="server" Width="400" Theme="Glass"></dxe:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" align="right">
                                    <table>
                                        <tr>
                                            <td style="text-align: right">
                                                <dxe:ASPxButton ID="btnUpdate" runat="server" Text="Update" Theme="Glass" AutoPostBack="false">
                                                    <ClientSideEvents Click="function(s, e) {
                                                        grdParam.PerformCallback('save');}"></ClientSideEvents>
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
                    <dx:GridViewDataTextColumn Caption=" " VisibleIndex="0" Width="30px">
                        <EditFormSettings Visible="False" />
                        <DataItemTemplate>
                            <table style="width:100%;" align="Center">
                                <tr>
                                    <td>
                                        <img src="../../../images/Materials/action_settings.gif"
                                onclick="javascript:ShowContextMenu(this, <%# Container.VisibleIndex %>);"
                                title="Action" />
                                    </td>
                                </tr>
                            </table>
                        </DataItemTemplate>
                        <CellStyle Cursor="pointer">
                        </CellStyle>
                    </dx:GridViewDataTextColumn>

                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Designation" Caption="Description" VisibleIndex="3">
                    <Settings AutoFilterCondition="Contains" />
                    </dx:GridViewDataTextColumn>

                </Columns>
                <SettingsEditing Mode="EditForm"></SettingsEditing>
                <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                <SettingsPager PageSize="15">
                    <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
                    <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
                </SettingsPager>
                <Settings ShowFilterRow="True" ShowFooter="true" VerticalScrollBarMode="Auto" VerticalScrollableHeight="300" />
                <ClientSideEvents EndCallback="function(s,e){
                    if(window.parent.RefreshGrdProperties)
                            window.parent.RefreshGrdProperties();
                    }" />
            </dx:ASPxGridView>
        </td>
    </tr>
    <tr>
        <td style="padding-right: 10px;">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/Materials/properties_groups16x16.png" Width="16px" />
            <a class="btnGlassLink" href="javascript:ShowPupAddNewPropertyGrp();"><%= DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath)%></a>
        </td>
        <td>&nbsp;
        </td>
    </tr>
</table>
<dx:ASPxHiddenField ID="hfPropertyGrp" ClientInstanceName="hfPropertyGrp" runat="server">
</dx:ASPxHiddenField>
<asp:SqlDataSource ID="SqlPropertiesDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllProperties" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<dxpc:ASPxPopupControl ID="popupAffecterUniteMesure" runat="server" Theme="Glass" HeaderText="Affecter unité de mesure"
    ClientInstanceName="popupAffecterUniteMesure" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Height="450px" Width="600px" CloseAction="CloseButton">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <dx:ASPxGridView ID="grdMeasureUnit" runat="server" Width="100%" ClientInstanceName="grdMeasureUnit"
                            ClientIDMode="AutoID" Theme="Glass" OnCustomCallback="grdMeasureUnit_CustomCallback"
                            AutoGenerateColumns="False" DataSourceID="SqlMeasureUnitDS" EnableTheming="True" KeyFieldName="ID">
                            <Columns>
                                <dx:GridViewCommandColumn ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                </dx:GridViewCommandColumn>
                                <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="false">
                                    <EditFormSettings Visible="False" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Designation" Caption="Description" VisibleIndex="2">
                                    <Settings AutoFilterCondition="Contains" />
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn FieldName="Abreviation" VisibleIndex="3" Width="60px">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataComboBoxColumn FieldName="ID_SystemMeasure" Caption="Système de mesure" VisibleIndex="3" Visible="true">
                                    <PropertiesComboBox DataSourceID="SqlSystemMeasureDS" TextField="Designation" ValueField="ID"
                                        IncrementalFilteringMode="Contains" ValueType="System.Int32">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                                <dx:GridViewDataComboBoxColumn FieldName="ID_FamilyUnites" Caption="Famille d'unité" VisibleIndex="4" Visible="true">
                                    <PropertiesComboBox DataSourceID="SqlUnitFamiliesDS" TextField="Designation" ValueField="ID"
                                        IncrementalFilteringMode="Contains" ValueType="System.Int32">
                                    </PropertiesComboBox>
                                </dx:GridViewDataComboBoxColumn>
                            </Columns>
                            <SettingsEditing Mode="EditForm"></SettingsEditing>
                            <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                            <SettingsPager PageSize="10">
                                <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
                                <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
                            </SettingsPager>
                            <Settings ShowFilterRow="True" ShowFooter="true" ShowGroupPanel="True" VerticalScrollableHeight="150" />
                        </dx:ASPxGridView>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <dxe:ASPxButton ID="btnSaveUniteMesure" runat="server" Text="valider" Theme="Glass"
                            OnClick="btnSaveUniteMesure_Click">
                        </dxe:ASPxButton>

                    </td>
                </tr>
            </table>
            <asp:SqlDataSource ID="SqlMeasureUnitDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
                SelectCommand="Materials_GetAllMeasureUnit" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
                </SelectParameters>
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
            <br />
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="17px" Width="17px" />
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
</dxpc:ASPxPopupControl>

<asp:SqlDataSource ID="sqlGetPropertiesGroup" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>" ProviderName="System.Data.SqlClient"
    SelectCommand="Materials_GetPropertiesGroup" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
