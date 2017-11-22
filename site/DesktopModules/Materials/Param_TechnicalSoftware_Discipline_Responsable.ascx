<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_TechnicalSoftware_Discipline_Responsable.ascx.cs" Inherits="VD.Modules.Materials.Param_TechnicalSoftware_Discipline_Responsable" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxm" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>


<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />
<script type="text/javascript">

    var mn_AddNotif = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnAddRespTSNotif", ressFilePath )%>';
    var mn_EditNotif = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnEditNotif", ressFilePath )%>';
    var mn_SelectNotif = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnSelectNotif", ressFilePath )%>';

    var index = -1;
    function AddItemToGrid() {
        window.parent.parent.popup("LoadControl.aspx?ctrl=Materials/Param_Add_TS_Discipline_Responsable.ascx&ActiveTab=" + pcAssignments.GetActiveTabIndex(), 600, 850, mn_AddNotif);
    }
    
    function DeleteFocusedItem() {
        if (pcAssignments.GetActiveTabIndex() == 0) {
            var index = grdParam.GetFocusedRowIndex();
            grdParam.DeleteRow(index);
        }
        else {
            var index = grdEmploye.GetFocusedRowIndex();
            grdEmploye.DeleteRow(index);
        }
    }
    function MenuItemClick(e) {
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "mAdd") AddItemToGrid();
        if (name == "mEdit") EditFocusedItem();
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
    function grdEmploye_ContextMenu(s, e) {
        if (e.objectType == "row") {
            x = ASPxClientUtils.GetEventX(e.htmlEvent);
            y = ASPxClientUtils.GetEventY(e.htmlEvent);
            grdEmploye.SetFocusedRowIndex(e.index);
            popupMenu.ShowAtPos(x, y);
        }
    }
    //----------------------------------------------------------/ 
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


    .dnnFormMessage
    {
        -moz-border-radius: 3px;
        border-radius: 3px;
        padding: 10px 10px 10px 40px;
        line-height: 1.4;
        margin: 0.5em 1em;
    }

        .dnnFormMessage span
        {
            float: none;
            padding: 0;
            width: 100%;
            text-align: left;
            text-shadow: 0px 1px 1px #fff;
        }

    .dnnFormValidationSummary
    {
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
            <dxm:MenuItem Name="mManageNotification" Text="Gestion Notification">
                <Image Url="~/images/Materials/unit-families.png" Width="16px" Height="16px"></Image>
                <SubMenuItemStyle Width="150px"></SubMenuItemStyle>
                <Items>
                    <dxm:MenuItem Name="mAdd" Text="Ajouter">
                        <Image Url="../../../images/add.gif" Width="16px"></Image>
                    </dxm:MenuItem>
                    <dxm:MenuItem Name="mEdit" Text="Modifier" Visible="false">
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
        <dxm:MenuItem Name="mEdit" Text="Modifier" Visible="false">
            <Image Url="../../../images/edit.gif"></Image>
        </dxm:MenuItem>
        <dxm:MenuItem Name="mDelete" Text="Supprimer">
            <Image Url="../../../images/delete.gif"></Image>
        </dxm:MenuItem>
    </Items>
</dxm:ASPxPopupMenu>
<dx:ASPxPageControl ID="pcAssignments" ClientInstanceName="pcAssignments" runat="server"
    Theme="Glass" Width="100%" Height="400px" ActiveTabIndex="0">
    <TabPages>
        <dx:TabPage Name="tpFunctions" ClientEnabled="true" Text="Par organisation">
            <ContentCollection>
                <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                    <dx:ASPxGridView ID="grdParam" runat="server" Width="100%" ClientInstanceName="grdParam" OnCustomCallback="grdParam_CustomCallback"
                        ClientIDMode="AutoID" Theme="Glass"
                        AutoGenerateColumns="False" DataSourceID="SqlParamDS" EnableTheming="True" KeyFieldName="ID">
                        <ClientSideEvents ContextMenu="grid_ContextMenu" Init="function( s ,e ){var popup = window.parent; popup.window['grdParam'] = grdParam; }" />
                        <SettingsBehavior AllowFocusedRow="true" />
                        <Columns>
                            <dx:GridViewCommandColumn ButtonType="Image" Visible="false" Width="40px" Caption=" " VisibleIndex="0" ShowDeleteButton="True"/>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Discipline" VisibleIndex="1" Width="120px" GroupIndex="1">
                                <DataItemTemplate>
                                    <%# DBNull.Value.Equals(Eval("Discipline")) ? GlobalAPI.CommunUtility.getRessourceEntry("lbTous", ressFilePath ) : (Eval("Discipline") == null ? GlobalAPI.CommunUtility.getRessourceEntry("lbTous", ressFilePath ) : Eval("Discipline").ToString()) %>
                                </DataItemTemplate>                                
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="TechnicalSoftwareName" VisibleIndex="2" Width="100px" GroupIndex="0">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ID_Function" VisibleIndex="3" Visible="false">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="NomFonction" VisibleIndex="3">
                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                             <dx:GridViewDataTextColumn FieldName="nom_organisation" Caption="Organisation" VisibleIndex="4" Width="200px">
                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn> 
                            <dx:GridViewDataTextColumn FieldName="NomSociete" Caption="Société" VisibleIndex="4" Width="150px">
                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>    
                            <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowSelectCheckbox="True" Visible="False" VisibleIndex="7" ShowCancelButton="True" ShowUpdateButton="True" ShowClearFilterButton="True"/>
                        </Columns>
                        <SettingsEditing Mode="EditForm"></SettingsEditing>
                        <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                        <SettingsPager PageSize="18">
                            <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
                            <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
                        </SettingsPager>
                        <SettingsBehavior AutoExpandAllGroups="true" />
                        <Settings ShowFilterRow="True" ShowFooter="False" ShowTitlePanel="true" ShowGroupPanel="true" VerticalScrollBarMode="Auto" VerticalScrollableHeight="400" />
                        <Templates>                            
                            <TitlePanel>
                                <table width="100%" cellpadding="0" cellspacing="0" style="width: 100%; padding: 5px; text-align: center; font-family: Tahoma; font-weight: bold; font-size: 12px;">
                                    <tr>
                                        <td width="100%">
                                            <%=GlobalAPI.CommunUtility.getRessourceEntry("hMaterialsMenFunctionsList", ressFilePath )%>
                                        </td>
                                        <td align="right" style="cursor: hand; cursor: pointer;">
                                            <asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="../../images/task/icon_expand.png" OnClientClick="grdParam.ExpandAll();return false;" /></td>
                                        <td>&nbsp;</td>
                                        <td align="right" style="cursor: hand; cursor: pointer;">
                                            <asp:ImageButton runat="server" ID="ImageButton2" ImageUrl="../../images/task/icon_collapse.png" OnClientClick="grdParam.CollapseAll();return false;" /></td>
                                    </tr>
                                </table>
                            </TitlePanel> 
                            <GroupRowContent>
                                <%# Container.GroupText==""?GlobalAPI.CommunUtility.getRessourceEntry("lbTous", ressFilePath ):Container.GroupText %>
                            </GroupRowContent>                           
                        </Templates>
                        <SettingsCommandButton>
                            <DeleteButton>
                                <Image Url="../../../images/delete.gif">
                                </Image>
                            </DeleteButton>
                        </SettingsCommandButton>
                    </dx:ASPxGridView>
                </dx:ContentControl>



            </ContentCollection>
        </dx:TabPage>
        <dx:TabPage Name="tpEmploye" ClientEnabled="true" Text="Par organisation">
            <ContentCollection>
                <dx:ContentControl ID="ContentControl2" runat="server" SupportsDisabledAttribute="True">
                    <dx:ASPxGridView ID="grdEmploye" runat="server" Width="100%" ClientInstanceName="grdEmploye" OnCustomCallback="grdEmploye_CustomCallback"
                        ClientIDMode="AutoID" Theme="Glass"
                        AutoGenerateColumns="False" DataSourceID="SqlEmployeParamDS" EnableTheming="True" KeyFieldName="ID">
                        <ClientSideEvents ContextMenu="grdEmploye_ContextMenu" Init="function( s ,e ){var popup = window.parent; popup.window['grdEmploye'] = grdEmploye; }" />
                        <SettingsBehavior AllowFocusedRow="true" />
                        <Columns>
                            <dx:GridViewCommandColumn ButtonType="Image" Visible="false" Width="40px" Caption=" " VisibleIndex="0" ShowDeleteButton="True"/>
                            <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                                <EditFormSettings Visible="False" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="Discipline" VisibleIndex="1" Width="120px">
                                <DataItemTemplate>
                                    <%# DBNull.Value.Equals(Eval("Discipline")) ? GlobalAPI.CommunUtility.getRessourceEntry("lbTous", ressFilePath ) : (Eval("Discipline") == null ? GlobalAPI.CommunUtility.getRessourceEntry("lbTous", ressFilePath ) : Eval("Discipline").ToString()) %>
                                </DataItemTemplate>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="TechnicalSoftwareName" VisibleIndex="2" Width="100px" GroupIndex="0">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="empName" VisibleIndex="4">
                                <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewCommandColumn ButtonType="Button" Caption=" " ShowSelectCheckbox="True" Visible="False" VisibleIndex="7" ShowCancelButton="True" ShowUpdateButton="True" ShowClearFilterButton="True"/>
                        </Columns>
                        <SettingsEditing Mode="EditForm"></SettingsEditing>
                        <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                        <SettingsPager PageSize="18">
                            <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
                            <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
                        </SettingsPager>
                         <SettingsBehavior AutoExpandAllGroups="true" />
                        <Settings ShowFilterRow="True" ShowFooter="False" ShowTitlePanel="true" ShowGroupPanel="true"  VerticalScrollBarMode="Auto" VerticalScrollableHeight="400" />
                        <Templates>                            
                            <TitlePanel>
                                <table width="100%" cellpadding="0" cellspacing="0" style="width: 100%; padding: 5px; text-align: center; font-family: Tahoma; font-weight: bold; font-size: 12px;">
                                    <tr>
                                        <td width="100%">
                                            <%=GlobalAPI.CommunUtility.getRessourceEntry("hMaterialsMenList", ressFilePath )%>
                                        </td>
                                        <td align="right" style="cursor: hand; cursor: pointer;">
                                            <asp:ImageButton runat="server" ID="ImageButton3" ImageUrl="../../images/task/icon_expand.png" OnClientClick="grdEmploye.ExpandAll();return false;" /></td>
                                        <td>&nbsp;</td>
                                        <td align="right" style="cursor: hand; cursor: pointer;">
                                            <asp:ImageButton runat="server" ID="ImageButton4" ImageUrl="../../images/task/icon_collapse.png" OnClientClick="grdEmploye.CollapseAll();return false;" /></td>
                                    </tr>
                                </table>
                            </TitlePanel>
                            <GroupRowContent>
                                <%# Container.GroupText==""?GlobalAPI.CommunUtility.getRessourceEntry("lbTous", ressFilePath ):Container.GroupText %>
                            </GroupRowContent>
                        </Templates>
                        <SettingsCommandButton>
                            <DeleteButton>
                                <Image Url="../../../images/delete.gif">
                                </Image>
                            </DeleteButton>
                        </SettingsCommandButton>
                    </dx:ASPxGridView>
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
    </TabPages>
</dx:ASPxPageControl>

<asp:SqlDataSource ID="SqlParamDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllTechnicalSoftwareDisciplineResponsable" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeleteTechnicalSoftwareDisciplineResponsable" DeleteCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:Parameter Name="Type" Type="Int32" DefaultValue="0" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlEmployeParamDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllTechnicalSoftwareDisciplineResponsable" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeleteTechnicalSoftwareDisciplineResponsable" DeleteCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:Parameter Name="Type" Type="Int32" DefaultValue="1" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>
</asp:SqlDataSource>


