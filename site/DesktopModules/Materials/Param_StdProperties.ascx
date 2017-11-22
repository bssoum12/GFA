<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_StdProperties.ascx.cs" Inherits="VD.Modules.Materials.Param_StdProperties" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>
<popupWin:popupWin ID="popupWind" runat="server" />
<style type="text/css">
    .header
    {
        height: 20px;
        background-color: #c0e0e3;
    }

    .pageBorder
    {
        border: 1px solid #c0e0e3;
    }

    .btnRedLink
    {
        text-decoration: none;
        color: Red !important;
        font-weight: bold !important;
        font-family: Tahoma !important;
        font-size: 12px !important;
        cursor: pointer !important;
    }
</style>

<script type="text/javascript" language="javascript">

    var nullGrpPropText = '<%= DotNetNuke.Services.Localization.Localization.GetString("lbSelectGrpProperty", ressFilePath) %>';
    var nullPropText = '<%= DotNetNuke.Services.Localization.Localization.GetString("lbSelectProperty", ressFilePath) %>';
    var nullUniteText = '<%= DotNetNuke.Services.Localization.Localization.GetString("lbSelectMeasureUnit", ressFilePath) %>';
    var nullCaseText = '<%= DotNetNuke.Services.Localization.Localization.GetString("lbSelectUseCase", ressFilePath) %>'; 

    function popup(url, height, width, title) {
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

    function SetddeStdText(values) {
        ddeStd.SetText(values[1]);
        cmbCase.PerformCallback(values[0]);
        ddeStd.HideDropDown();
    }

    function SetCmbProp(values) {
        ddeGrpProp.SetText(values[1]);
        cmbProp.PerformCallback(values[0]);
        cmbProp.HideDropDown();
    }

    function InitCmbOnInit(s, e) {
        InitCmbOnLostFocus(s, e);
    }

    function InitCmbOnGotFocus(s, e) {
        var input = s.GetInputElement();
        if (input.value == nullGrpPropText || input.value == nullPropText || input.value == nullUniteText) {
            input.value = "";
            input.style.color = "black";
        }
    }

    function InitCmbOnLostFocus(s, e) {
        if (s.GetValue() != "" && s.GetValue() != null)
            return;

        var input = s.GetInputElement();
        input.style.color = "gray";

        if (input.name.indexOf("ddeGrpProp") != -1) {
            input.value = nullGrpPropText;
        }
        if (input.name.indexOf("cmbProp") != -1) {
            input.value = nullPropText;
        }
        if (input.name.indexOf("cmbUnite") != -1) {
            input.value = nullUniteText;
        }
    }

    function ValidateMaxRange(s, e) {
        s.Validate();
    }

    function ValidateMinRange(s, e) {
        s.Validate();
    }

    function OpenNewMXRequirment() {
        DefPropFct(grdPropDetail.cpMasterRowKeyValue);
    }

    function DefPropRef() {
        PageControl.SetActiveTab(PageControl.GetTab(2));
        if (cmbCase.GetValue() == null) {
            alert(nullCaseText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_MXR_Standard.ascx&IsEdit=false&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath) %>');
    }

    function EditPropRef(e) {
        PageControl.SetActiveTab(PageControl.GetTab(2));
        if (e == null) {
            alert(nullPropText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_MXR_Standard.ascx&IsEdit=true&id=' + e + '&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("mnEitProperties", ressFilePath) %>');
    }

    function DefPropFct(e) {
        PageControl.SetActiveTab(PageControl.GetTab(2));
        if (e == null) {
            alert(nullPropText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_MXR_FctStandard.ascx&IsEdit=false&idncp=' + grdPropDetail.cpMasterRowKeyValue + '&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath) %>');
    }

    function EditPropFct(e) {
        PageControl.SetActiveTab(PageControl.GetTab(2));
        if (e == null) {
            alert(nullPropText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_MXR_FctStandard.ascx&IsEdit=true&id=' + e + '&idncp=' + grdPropDetail.cpMasterRowKeyValue + '&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("mnEitProperties", ressFilePath) %>');
    }

    function ReloadGrdProperty() {
        grdProperty.PerformCallback(cmbCase.GetValue());
    }

    function ReloadGrdPropertyStep() {
        grdPropertyStep.PerformCallback(cmbCase.GetValue());
    }

    function ReloadParentMXData() {
        grdMatProperty.PerformCallback(cmbCase.GetValue());
    }

    function ReloadMXData() {
        grdMatProperty.GetRowValues(grdMatProperty.GetFocusedRowIndex(), 'ID', DetailCallBack);
    }

    function DetailCallBack(e) {
        grdPropDetail.PerformCallback(e);
    }

    function MenuItemClick(e) {
        //Definir les action de chaque Item des menus contextuel et toolBar  
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "addRange") SetNewRange();
        if (name == "editRange") grdProperty.GetRowValues(grdProperty.GetFocusedRowIndex(), 'ID', EditRange);
        if (name == "deleteRange") DeleteRange();
        if (name == "addStep") SetNewStep();
        if (name == "editStep") grdPropertyStep.GetRowValues(grdPropertyStep.GetFocusedRowIndex(), 'ID', EditStep);
        if (name == "deleteStep") DeleteStep();
        if (name == "addMX") DefPropRef();
        if (name == "editMX") EditMX();
        if (name == "deleteMX") DeleteMX();
        if (name == "addMXDepend") OpenNewMXRequirment();
        if (name == "editMXDepend") EditMXDepend();
        if (name == "deleteMXDepend") DeleteMXDepend();
    }

    function SetNewRange() {
        PageControl.SetActiveTab(PageControl.GetTab(0));
        if (cmbCase.GetValue() == null) {
            alert(nullCaseText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_StdPropertyRange.ascx&IsEdit=false&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath) %>');
    }

    function EditRange(e) {
        
        PageControl.SetActiveTab(PageControl.GetTab(0));
        if (grdProperty.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_StdPropertyRange.ascx&IsEdit=true&id=' + e + '&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath) %>');
    }

    function DeleteRange() {
        PageControl.SetActiveTab(PageControl.GetTab(0));
        if (grdProperty.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
        grdProperty.DeleteRow(grdProperty.GetFocusedRowIndex());
    }

    function SetNewStep() {
        PageControl.SetActiveTab(PageControl.GetTab(1));
        if (cmbCase.GetValue() == null) {
            alert(nullCaseText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_StdPropertyStep.ascx&IsEdit=false&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath) %>');
    }

    function EditStep(e) {
        PageControl.SetActiveTab(PageControl.GetTab(1));
        if (grdPropertyStep.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
        popup('LoadControl.aspx?ctrl=Materials/Param_StdPropertyStep.ascx&IsEdit=true&id=' + e + '&idnc=' + cmbCase.GetValue(), 250, 800, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath) %>');
    }

    function DeleteStep() {
        PageControl.SetActiveTab(PageControl.GetTab(1));
        if (grdPropertyStep.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
        grdPropertyStep.DeleteRow(grdPropertyStep.GetFocusedRowIndex());
    }

    function EditMX() {
        PageControl.SetActiveTab(PageControl.GetTab(2));
        if (grdMatProperty.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
        grdMatProperty.GetRowValues(grdMatProperty.GetFocusedRowIndex(), 'ID', EditPropRef);
    }

    function DeleteMX() {
        PageControl.SetActiveTab(PageControl.GetTab(2));
        if (grdMatProperty.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
        grdMatProperty.DeleteRow(grdMatProperty.GetFocusedRowIndex());
    }

    function EditMXDepend() {
        if (grdPropDetail.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
         grdPropDetail.GetRowValues(grdPropDetail.GetFocusedRowIndex(), 'ID', EditPropFct);
    }

    function DeleteMXDepend() {
        PageControl.SetActiveTab(PageControl.GetTab(2));
        if (grdPropDetail.GetFocusedRowIndex() == -1) {
            alert(nullPropText);
            return;
        }
        grdPropDetail.DeleteRow(grdPropDetail.GetFocusedRowIndex());
    }

</script>

<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="accModule" runat="server" />

<div class="pageBorder">
    <table style="width: 100%;">
        <tr>
            <td>
                <dx:ASPxMenu ID="mnuMain" ClientInstanceName="mnuMain" runat="server"
                    AutoSeparators="RootOnly" Theme="Glass" ItemAutoWidth="False" Width="100%">
                    <Items>
                        <dx:MenuItem Name="rangeGrp">
                            <Image Url="~/images/Materials/range.png" Width="44px" Height="12px"></Image>
                            <Items>
                                <dx:MenuItem Name="addRange">
                                    <Image Url="~/images/add.gif" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="editRange">
                                    <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="deleteRange">
                                    <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                            </Items>
                        </dx:MenuItem>
                        <dx:MenuItem Name="stepGrp">
                            <Image Url="~/images/Materials/ensemble.png" Width="44px" Height="12px"></Image>
                            <Items>
                                <dx:MenuItem Name="addStep">
                                    <Image Url="~/images/add.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="editStep">
                                    <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="deleteStep">
                                    <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                            </Items>
                        </dx:MenuItem>
                        <dx:MenuItem Name="MX">
                            <Image Url="~/images/Materials/pFunction.png" Width="44px" Height="12px"></Image>
                            <Items>
                                <dx:MenuItem Name="addMX">
                                    <Image Url="~/images/add.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="editMX">
                                    <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="MXDepend">
                                    <Image Url="~/images/Materials/depend.png" Width="16px" Height="16px"></Image>
                                    <Items>
                                        <dx:MenuItem Name="addMXDepend">
                                            <Image Url="~/images/add.gif" Width="16" Height="16"></Image>
                                        </dx:MenuItem>
                                        <dx:MenuItem Name="editMXDepend">
                                            <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
                                        </dx:MenuItem>
                                        <dx:MenuItem Name="deleteMXDepend">
                                            <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
                                        </dx:MenuItem>
                                    </Items>
                                </dx:MenuItem>
                                <dx:MenuItem Name="deleteMX">
                                    <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
                                </dx:MenuItem>
                            </Items>
                        </dx:MenuItem>
                    </Items>
                    <ClientSideEvents ItemClick="function(s, e) {MenuItemClick(e);}" />
                </dx:ASPxMenu>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <br />
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td style="padding-right:1em;">
                <dx:ASPxLabel ID="lblStd" runat="server" Theme="Glass" Font-Bold="true"></dx:ASPxLabel>
            </td>
            <td style="padding-right:2em;">
                <dx:ASPxDropDownEdit ID="ddeStd" ClientInstanceName="ddeStd" runat="server" Theme="Glass" Width="180">
                    <DropDownWindowTemplate>
                        <dx:ASPxTreeList ID="tlNorm" ClientInstanceName="tlNorm" runat="server" Theme="Glass" Width="100%" Height="90%"
                            DataSourceID="sqlGetNorm" ParentFieldName="ParentID" KeyFieldName="ID" >
                            <Columns>
                                <dx:TreeListTextColumn FieldName="Designation">
                                </dx:TreeListTextColumn>
                            </Columns>
                            <Settings ShowPreview="false" GridLines="Horizontal" />
                            <SettingsBehavior AllowFocusedNode="true" AutoExpandAllNodes="true" />
                            <ClientSideEvents Init="function(s, e) {
                                                s.SetFocusedNodeKey(null);
                                            }" FocusedNodeChanged="function(s,e){
                                            tlNorm.GetNodeValues(tlNorm.GetFocusedNodeKey(), 'ID;Designation', SetddeStdText);}" />
                        </dx:ASPxTreeList>
                    </DropDownWindowTemplate>
                </dx:ASPxDropDownEdit>
            </td>
            <td style="padding-right:1em;">
                <dx:ASPxLabel ID="lblCase" runat="server" Theme="Glass" Font-Bold="true" ></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxComboBox ID="cmbCase" ClientInstanceName="cmbCase" runat="server" Theme="Glass" OnCallback="cmbCase_Callback" Width="180"
                    DataSourceID="SqlGetCases" TextField="LibCase" ValueField="IDNC" ValueType="System.String" IncrementalFilteringMode="Contains">
                    <ClientSideEvents ValueChanged="function(s,e){
                        grdProperty.PerformCallback(s.GetValue());
                        grdPropertyStep.PerformCallback(s.GetValue());
                        grdMatProperty.PerformCallback(s.GetValue());
                        }"
                        EndCallback="function(s,e){
                        grdProperty.PerformCallback(s.GetValue());
                        grdPropertyStep.PerformCallback(s.GetValue());
                        grdMatProperty.PerformCallback(s.GetValue());
                        }" />
                </dx:ASPxComboBox>
            </td>
        </tr>
    </table>
    <table style="width: 100%;">
        <tr>
            <td>
                <dx:ASPxPageControl ID="PageControl" ClientInstanceName="PageControl" runat="server" Width="100%" Theme="Glass" Height="390">
                    <TabPages>
                        <dx:TabPage Name="rangeTab">
                            <ContentCollection>
                                <dx:ContentControl ID="cc1" runat="server">
                                    <div class="pageBorder">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 16px;">
                                                    <dx:ASPxImage ID="imgAddRange" runat="server" Theme="Glass"
                                                        ImageUrl="~/images/add.gif" Width="16" Height="16">
                                                        <ClientSideEvents Click="function(s,e){SetNewRange();}" />
                                                    </dx:ASPxImage>
                                                </td>
                                                <td>
                                                    <dx:ASPxHyperLink ID="hlAddRange" runat="server" CssClass="btnRedLink" Theme="Default">
                                                        <ClientSideEvents Click="function(s,e){SetNewRange();}" />
                                                    </dx:ASPxHyperLink>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <dx:ASPxGridView ID="grdProperty" ClientInstanceName="grdProperty" runat="server"
                                                        Theme="Glass" Width="100%" DataSourceID="sqlGetPropertyRange" KeyFieldName="ID"
                                                        OnCustomCallback="grdProperty_CustomCallback" OnRowDeleting="grdProperty_RowDeleting"
                                                        OnCustomErrorText="grdProperty_CustomErrorText" OnCustomColumnDisplayText="grdProperty_CustomColumnDisplayText"
                                                        SettingsBehavior-AllowFocusedRow="True" SettingsBehavior-AutoExpandAllGroups="True" Settings-ShowFilterRow="True">
                                                        <ClientSideEvents RowDblClick="function(s,e){s.StartEditRow(e.visibleIndex);}"
                                                            ContextMenu="function(s, e) {
                                                                var x = ASPxClientUtils.GetEventX(e.htmlEvent);
                                                                var y = ASPxClientUtils.GetEventY(e.htmlEvent);
	                                                            mnuGrdRange.ShowAtPos(x,y);}"
                                                            CustomButtonClick="function(s,e){
                                                            if(e.buttonID == 'editRange')
                                                            {
                                                                grdProperty.GetRowValues(grdProperty.GetFocusedRowIndex(), 'ID', EditRange);
                                                            } 
                                                            }" />
                                                        <Columns>
                                                            <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Width="60" ButtonType="Image" ShowEditButton="false" ShowDeleteButton="True">
                                                                <CustomButtons>
                                                                    <dx:GridViewCommandColumnCustomButton ID="editRange" Text="">
                                                                        <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                        </Image>
                                                                    </dx:GridViewCommandColumnCustomButton>
                                                                </CustomButtons>
                                                            </dx:GridViewCommandColumn>
                                                            <dx:GridViewDataColumn FieldName="ID" Visible="false">
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataTextColumn FieldName="DesignationGrp" Visible="true" GroupIndex="0" VisibleIndex="1">
                                                                <EditFormSettings Visible="False" />
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="GroupId" Visible="false">
                                                                <EditFormSettings Visible="True" VisibleIndex="1" />
                                                                <PropertiesComboBox DataSourceID="sqlGetPropertiesGroup" TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains">
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Designation" Visible="true" VisibleIndex="2">
                                                                <EditFormSettings Visible="False" />
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="ID_Properties" Visible="false" VisibleIndex="2">
                                                                <EditFormSettings Visible="True" VisibleIndex="2" />
                                                                <PropertiesComboBox EnableSynchronization="False" IncrementalFilteringMode="Contains">
                                                                    <ValidationSettings>
                                                                        <RequiredField IsRequired="true" />
                                                                    </ValidationSettings>
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataTextColumn FieldName="ValMin" Visible="true" VisibleIndex="3">
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="ValMax" Visible="true" VisibleIndex="4">
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="ID_UniteMeasure" Visible="true" VisibleIndex="5">
                                                                <EditFormSettings Visible="True" VisibleIndex="5" />
                                                                <PropertiesComboBox DataSourceID="SqlMeasureUnitDS" TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains">
                                                                    <ValidationSettings>
                                                                        <RequiredField IsRequired="true" />
                                                                    </ValidationSettings>
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataTextColumn FieldName="IsOptional" >
                                                                <Settings AllowAutoFilter="True" AllowGroup="True" AllowHeaderFilter="True"
                                                                    AllowSort="True" FilterMode="DisplayText" SortMode="DisplayText" />
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <SettingsBehavior AllowGroup="true" AllowFocusedRow="True" />
                                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                        <Settings ShowGroupPanel="true" ShowTitlePanel="true" VerticalScrollableHeight="400"
                                                            UseFixedTableLayout="true" VerticalScrollBarMode="Auto" />
                                                        <SettingsEditing Mode="PopupEditForm" />
                                                        <SettingsPopup>
                                                            <EditForm Modal="true" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" Height="150" Width="600" />
                                                        </SettingsPopup>
                                                        <SettingsCommandButton>
                                                            <EditButton>
                                                                <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                </Image>
                                                            </EditButton>
                                                            <DeleteButton>
                                                                <Image Url="~/images/delete.gif" Height="16" Width="16">
                                                                </Image>
                                                            </DeleteButton>
                                                            <CancelButton>
                                                                <Image Url="~/images/cancel.gif" Height="16" Width="16">
                                                                </Image>
                                                            </CancelButton>
                                                            <UpdateButton>
                                                                <Image Url="~/images/save.gif" Height="16" Width="16">
                                                                </Image>
                                                            </UpdateButton>
                                                        </SettingsCommandButton>
                                                    </dx:ASPxGridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="stepTab">
                            <ContentCollection>
                                <dx:ContentControl ID="cc2" runat="server" SupportsDisabledAttribute="True">
                                    <div class="pageBorder">
                                        <table>
                                            <tr>
                                                <td style="width: 16px;">
                                                    <dx:ASPxImage ID="imgAddStep" runat="server"
                                                        ImageUrl="~/images/add.gif" Width="16" Height="16">
                                                        <ClientSideEvents Click="function(s,e){SetNewRange();}" />
                                                    </dx:ASPxImage>
                                                </td>
                                                <td>
                                                    <dx:ASPxHyperLink ID="hlAddStep" runat="server" CssClass="btnRedLink"  Theme="Default">
                                                        <ClientSideEvents Click="function(s,e){SetNewStep();}" />
                                                    </dx:ASPxHyperLink>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <dx:ASPxGridView ID="grdPropertyStep" ClientInstanceName="grdPropertyStep" runat="server"
                                                        Theme="Glass" Width="100%" DataSourceID="sqlGetPropertyStep" KeyFieldName="ID"
                                                        OnCustomCallback="grdPropertyStep_CustomCallback" OnRowDeleting="grdPropertyStep_RowDeleting"
                                                          OnCustomColumnDisplayText="grdPropertyStep_CustomColumnDisplayText"
                                                        SettingsBehavior-AllowFocusedRow="True" SettingsBehavior-AutoExpandAllGroups="True" 
                                                        Settings-ShowFilterRow="True" Settings-ShowTitlePanel="True">
                                                        <ClientSideEvents RowDblClick="function(s,e){s.StartEditRow(e.visibleIndex);}"
                                                            ContextMenu="function(s, e) {
                                                            var x = ASPxClientUtils.GetEventX(e.htmlEvent);
                                                            var y = ASPxClientUtils.GetEventY(e.htmlEvent);
	                                                        mnuGrdStep.ShowAtPos(x,y);}" 
                                                            CustomButtonClick="function(s,e){
                                                            if(e.buttonID == 'editStep')
                                                            {
                                                                grdPropertyStep.GetRowValues(grdPropertyStep.GetFocusedRowIndex(), 'ID', EditStep);
                                                            } 
                                                            }"/>
                                                        <Columns>
                                                            <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Width="60" ButtonType="Image" ShowEditButton="false" ShowDeleteButton="True">
                                                                <CustomButtons>
                                                                    <dx:GridViewCommandColumnCustomButton ID="editStep" Text="">
                                                                        <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                        </Image>
                                                                    </dx:GridViewCommandColumnCustomButton>
                                                                </CustomButtons>
                                                            </dx:GridViewCommandColumn>
                                                            <dx:GridViewDataColumn FieldName="ID" Visible="false">
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataTextColumn FieldName="DesignationGrp" Visible="true" GroupIndex="0" VisibleIndex="1">
                                                                <EditFormSettings Visible="False" />
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="GroupId" Visible="false">
                                                                <EditFormSettings Visible="True" VisibleIndex="1" />
                                                                <PropertiesComboBox DataSourceID="sqlGetPropertiesGroup" TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains">
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Designation" Visible="true" VisibleIndex="2">
                                                                <EditFormSettings Visible="False" />
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="ID_Properties" Visible="false" VisibleIndex="2">
                                                                <EditFormSettings Visible="True" VisibleIndex="2" />
                                                                <PropertiesComboBox EnableSynchronization="False" IncrementalFilteringMode="Contains">
                                                                    <ValidationSettings>
                                                                        <RequiredField IsRequired="true" />
                                                                    </ValidationSettings>
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataTextColumn FieldName="ValueSet" Visible="true" VisibleIndex="3">
                                                                <EditFormSettings VisibleIndex="3" />
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                                <PropertiesTextEdit>
                                                                </PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataComboBoxColumn FieldName="ID_UniteMeasure" Visible="true" VisibleIndex="5">
                                                                <PropertiesComboBox DataSourceID="SqlMeasureUnitDS" TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains">
                                                                </PropertiesComboBox>
                                                            </dx:GridViewDataComboBoxColumn>
                                                            <dx:GridViewDataTextColumn FieldName="IsOptional" VisibleIndex="6" >
                                                                <Settings AllowAutoFilter="True" AllowGroup="True" AllowHeaderFilter="True"
                                                                    AllowSort="True" FilterMode="DisplayText" SortMode="DisplayText" />
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <SettingsBehavior AllowGroup="true" AllowFocusedRow="True" />
                                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                        <Settings ShowGroupPanel="true" ShowTitlePanel="true" VerticalScrollableHeight="400"
                                                            UseFixedTableLayout="true" VerticalScrollBarMode="Auto" />
                                                        <SettingsEditing Mode="PopupEditForm" />
                                                        <SettingsPopup>
                                                            <EditForm Modal="true" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" Height="150" Width="600" />
                                                        </SettingsPopup>
                                                        <SettingsCommandButton>
                                                            <EditButton>
                                                                <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                </Image>
                                                            </EditButton>
                                                            <DeleteButton>
                                                                <Image Url="~/images/delete.gif" Height="16" Width="16">
                                                                </Image>
                                                            </DeleteButton>
                                                            <CancelButton>
                                                                <Image Url="~/images/cancel.gif" Height="16" Width="16">
                                                                </Image>
                                                            </CancelButton>
                                                            <UpdateButton>
                                                                <Image Url="~/images/save.gif" Height="16" Width="16">
                                                                </Image>
                                                            </UpdateButton>
                                                        </SettingsCommandButton>
                                                    </dx:ASPxGridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="matrixTab">
                            <ContentCollection>
                                <dx:ContentControl runat="server" SupportsDisabledAttribute="True">
                                    <div class="pageBorder">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td style="width: 16px;">
                                                    <dx:ASPxImage ID="img3" runat="server" Theme="Glass"
                                                        ImageUrl="~/images/add.gif" Width="16" Height="16">
                                                        <ClientSideEvents Click="function(s,e){DefPropRef();}" />
                                                    </dx:ASPxImage>
                                                </td>
                                                <td>
                                                    <dx:ASPxHyperLink ID="hlDefPropRef" runat="server" CssClass="btnRedLink"  Theme="Default">
                                                        <ClientSideEvents Click="function(s,e){DefPropRef();}" />
                                                    </dx:ASPxHyperLink>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <dx:ASPxGridView ID="grdMatProperty" ClientInstanceName="grdMatProperty" runat="server"
                                                        Theme="Glass" Width="100%" DataSourceID="sqlGetMatrixPropertyRequirement" KeyFieldName="ID"
                                                        OnCustomCallback="grdMatProperty_CustomCallback" OnRowDeleting="grdMatProperty_RowDeleting" OnCustomColumnDisplayText="grdMatProperty_CustomColumnDisplayText" 
                                                        SettingsBehavior-AutoExpandAllGroups="False" Settings-ShowTitlePanel="True" Settings-ShowFilterRow="True">
                                                        <ClientSideEvents CustomButtonClick="function(s,e){
                                                            if(e.buttonID == 'edit')
                                                            {
                                                                grdMatProperty.GetRowValues(grdMatProperty.GetFocusedRowIndex(), 'ID', EditPropRef);
                                                            } 
                                                            }"
                                                            RowDblClick="function(s,e){s.ExpandDetailRow(s.GetFocusedRowIndex());}"
                                                            ContextMenu="function(s, e) {
                                                            var x = ASPxClientUtils.GetEventX(e.htmlEvent);
                                                            var y = ASPxClientUtils.GetEventY(e.htmlEvent);
	                                                        mnuGrdMX.ShowAtPos(x,y);}" />
                                                        <Columns>
                                                            <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Width="60" ButtonType="Image" ShowEditButton="false" ShowDeleteButton="True">
                                                                <CustomButtons>
                                                                    <dx:GridViewCommandColumnCustomButton ID="edit" Text="">
                                                                        <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                        </Image>
                                                                    </dx:GridViewCommandColumnCustomButton>
                                                                </CustomButtons>
                                                            </dx:GridViewCommandColumn>
                                                            <dx:GridViewDataColumn FieldName="ID" Visible="false">
                                                            </dx:GridViewDataColumn>
                                                            <dx:GridViewDataTextColumn FieldName="DesignationGrp" Visible="true" GroupIndex="0" VisibleIndex="1">
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Designation" Visible="true" VisibleIndex="2">
                                                                <EditFormSettings Visible="False" />
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="ValMin" Visible="true" VisibleIndex="3">
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="ValMax" Visible="true" VisibleIndex="4">
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="Measure" Visible="true" VisibleIndex="5">
                                                                <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn FieldName="IsOptional" >
                                                                <Settings AllowAutoFilter="True" AllowGroup="True" AllowHeaderFilter="True"
                                                                    AllowSort="True" FilterMode="DisplayText" SortMode="DisplayText" />
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>
                                                        <Templates>
                                                            <DetailRow>
                                                                <div class="pageBorder">
                                                                    <table style="width: 100%;">
                                                                        <tr>
                                                                            <td style="width: 16px;">
                                                                                <dx:ASPxImage ID="img4" runat="server" Theme="Glass"
                                                                                    ImageUrl="~/images/add.gif" Width="16" Height="16">
                                                                                </dx:ASPxImage>
                                                                            </td>
                                                                            <td>
                                                                                <a href="#" class="btnRedLink" onclick="javascript:OpenNewMXRequirment(); return false;">
                                                                                    <%# DotNetNuke.Services.Localization.Localization.GetString("lbNewRange", ressFilePath)%></a>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <dx:ASPxGridView ID="grdPropDetail" ClientInstanceName="grdPropDetail" Theme="Glass" SettingsBehavior-AutoExpandAllGroups="true"
                                                                                    runat="server" Width="100%" DataSourceID="sqlGetPropertyMR" KeyFieldName="ID" OnRowDeleting="grdPropDetail_RowDeleting"
                                                                                    OnBeforePerformDataSelect="grdPropDetail_BeforePerformDataSelect" OnLoad="grdPropDetail_Load" 
                                                                                    SettingsBehavior-AllowFocusedRow="True" Settings-ShowFilterRow="True" Settings-ShowTitlePanel="True">
                                                                                    <ClientSideEvents CustomButtonClick="function(s,e){
                                                                                            if(e.buttonID == 'edit')
                                                                                            {
                                                                                                grdPropDetail.GetRowValues(grdPropDetail.GetFocusedRowIndex(), 'ID', EditPropFct);
                                                                                            } 
                                                                                            }"
                                                                                        RowDblClick="function(s,e){
                                                                                        grdPropDetail.GetRowValues(grdPropDetail.GetFocusedRowIndex(), 'ID', EditPropFct);}"
                                                                                        ContextMenu="function(s, e) {
                                                                                        var x = ASPxClientUtils.GetEventX(e.htmlEvent);
                                                                                        var y = ASPxClientUtils.GetEventY(e.htmlEvent);
	                                                                                    mnuGrdMXDepend.ShowAtPos(x,y);}" />
                                                                                    <Columns>
                                                                                        <dx:GridViewCommandColumn ShowInCustomizationForm="True" VisibleIndex="0" Width="60" ButtonType="Image" ShowEditButton="false" ShowDeleteButton="True">
                                                                                            <CustomButtons>
                                                                                                <dx:GridViewCommandColumnCustomButton ID="edit" Text="">
                                                                                                    <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                                                    </Image>
                                                                                                </dx:GridViewCommandColumnCustomButton>
                                                                                            </CustomButtons>
                                                                                        </dx:GridViewCommandColumn>
                                                                                        <dx:GridViewDataColumn FieldName="ID" Visible="false">
                                                                                        </dx:GridViewDataColumn>
                                                                                        <dx:GridViewDataColumn FieldName="IDNCP" Visible="false">
                                                                                        </dx:GridViewDataColumn>
                                                                                        <dx:GridViewDataComboBoxColumn FieldName="DesignationGrp" Visible="true" GroupIndex="0" VisibleIndex="1">
                                                                                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                                                        </dx:GridViewDataComboBoxColumn>
                                                                                        <dx:GridViewDataTextColumn FieldName="Designation" Visible="true" VisibleIndex="2">
                                                                                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn FieldName="ValMin" Visible="true" VisibleIndex="3">
                                                                                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn FieldName="ValMax" Visible="true" VisibleIndex="4">
                                                                                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                        <dx:GridViewDataTextColumn FieldName="Measure" Visible="true" VisibleIndex="5">
                                                                                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                                                        </dx:GridViewDataTextColumn>
                                                                                    </Columns>
                                                                                    <Templates>
                                                                                        <TitlePanel><%=DotNetNuke.Services.Localization.Localization.GetString("lbMatrixTab", ressFilePath) %></TitlePanel>
                                                                                    </Templates>
                                                                                    <SettingsBehavior AllowGroup="true" AllowFocusedRow="True" />
                                                                                    <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                                                    <Settings ShowGroupPanel="true" ShowTitlePanel="true" VerticalScrollableHeight="100"
                                                                                        UseFixedTableLayout="true" VerticalScrollBarMode="Auto" />
                                                                                    <SettingsCommandButton>
                                                                                        <EditButton>
                                                                                            <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                                            </Image>
                                                                                        </EditButton>
                                                                                        <DeleteButton>
                                                                                            <Image Url="~/images/delete.gif" Height="16" Width="16">
                                                                                            </Image>
                                                                                        </DeleteButton>
                                                                                        <CancelButton>
                                                                                            <Image Url="~/images/cancel.gif" Height="16" Width="16">
                                                                                            </Image>
                                                                                        </CancelButton>
                                                                                        <UpdateButton>
                                                                                            <Image Url="~/images/save.gif" Height="16" Width="16">
                                                                                            </Image>
                                                                                        </UpdateButton>
                                                                                    </SettingsCommandButton>
                                                                                </dx:ASPxGridView>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </DetailRow>
                                                        </Templates>
                                                        <SettingsBehavior AllowGroup="true" AllowFocusedRow="True" AutoExpandAllGroups="true" />
                                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                        <Settings ShowGroupPanel="true" ShowTitlePanel="true" VerticalScrollableHeight="400"
                                                            UseFixedTableLayout="true" VerticalScrollBarMode="Auto" />
                                                        <SettingsEditing Mode="PopupEditForm" />
                                                        <SettingsPopup>
                                                            <EditForm Modal="true" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter" Height="150" Width="500" />
                                                        </SettingsPopup>
                                                        <SettingsDetail AllowOnlyOneMasterRowExpanded="true" ShowDetailRow="true" ShowDetailButtons="true" />
                                                        <SettingsCommandButton>
                                                            <EditButton>
                                                                <Image Url="~/images/edit.gif" Height="16" Width="16">
                                                                </Image>
                                                            </EditButton>
                                                            <DeleteButton>
                                                                <Image Url="~/images/delete.gif" Height="16" Width="16">
                                                                </Image>
                                                            </DeleteButton>
                                                            <CancelButton>
                                                                <Image Url="~/images/cancel.gif" Height="16" Width="16">
                                                                </Image>
                                                            </CancelButton>
                                                            <UpdateButton>
                                                                <Image Url="~/images/save.gif" Height="16" Width="16">
                                                                </Image>
                                                            </UpdateButton>
                                                        </SettingsCommandButton>
                                                    </dx:ASPxGridView>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                    </TabPages>
                </dx:ASPxPageControl>
            </td>
        </tr>
    </table>
</div>

<dx:ASPxPopupMenu ID="mnuGrdRange" ClientInstanceName="mnuGrdRange" runat="server" Theme="Glass">
    <Items>
        <dx:MenuItem Name="addRange">
            <Image Url="~/images/add.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="editRange">
            <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="deleteRange">
            <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
    </Items>
    <ClientSideEvents ItemClick="function(s, e) {MenuItemClick(e);}" />
</dx:ASPxPopupMenu>

<dx:ASPxPopupMenu ID="mnuGrdStep" ClientInstanceName="mnuGrdStep" runat="server" Theme="Glass">
    <Items>
        <dx:MenuItem Name="addStep">
            <Image Url="~/images/add.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="editStep">
            <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="deleteStep">
            <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
    </Items>
    <ClientSideEvents ItemClick="function(s, e) {MenuItemClick(e);}" />
</dx:ASPxPopupMenu>

<dx:ASPxPopupMenu ID="mnuGrdMX" ClientInstanceName="mnuGrdMX" runat="server" Theme="Glass">
    <Items>
        <dx:MenuItem Name="addMX">
            <Image Url="~/images/add.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="editMX">
            <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="deleteMX">
            <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
    </Items>
    <ClientSideEvents ItemClick="function(s, e) {MenuItemClick(e);}" />
</dx:ASPxPopupMenu>

<dx:ASPxPopupMenu ID="mnuGrdMXDepend" ClientInstanceName="mnuGrdMXDepend" runat="server" Theme="Glass">
    <Items>
        <dx:MenuItem Name="addMXDepend">
            <Image Url="~/images/add.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="editMXDepend">
            <Image Url="~/images/edit.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="deleteMXDepend">
            <Image Url="~/images/delete.gif" Width="16" Height="16"></Image>
        </dx:MenuItem>
    </Items>
    <ClientSideEvents ItemClick="function(s, e) {MenuItemClick(e);}" />
</dx:ASPxPopupMenu>


<asp:SqlDataSource ID="sqlGetNorm" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetAllNorm"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" DefaultValue="fr-FR" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlGetCases" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetStdCasesByIDStd"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="IDNorme" SessionField="IDNorme" Type="Int32" />
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" DefaultValue="fr-FR" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlGetPropertyRange" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesRange"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="IDNC" SessionField="IDNC" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlGetPropertyStep" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesSetValue"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="IDNC" SessionField="IDNC" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="sqlGetMatrixPropertyRequirement" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetMatrixPropertyRequirement"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="IDNC" SessionField="IDNC" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlGetPropertyMR" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertyMatrixRequirement"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="IDNCP" SessionField="IDNCP" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlGetPropertiesGroup" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesGroup"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlGetProperties" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesByGroup"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="GroupId" SessionField="GroupId" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlMeasureUnitDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllProperties_MeasureUnit" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
