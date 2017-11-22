<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewUI.ascx.cs" Inherits="VD.Modules.Materials.ViewUI" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraCharts.v17.1.Web, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxwgv" %>
<%@ Register Assembly="DevExpress.XtraCharts.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts" TagPrefix="cc1" %>
<%@ Register TagPrefix="chartMaterials" TagName="chartMaterials" Src="ChartMaterialsBySpecifications.ascx" %>
<%@ Register TagPrefix="chartMaterialsByDiscipline" TagName="chartMaterialsByDiscipline" Src="ChartMaterialsByDiscipline.ascx" %>
<%@ Register TagPrefix="chartSpecificationsByDisciplines" TagName="chartSpecificationsByDisciplines" Src="ChartSpecificationsByDisciplines.ascx" %>


<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />


<script type="text/javascript" src="Helper.js"></script>
<style>
    .HeaderTitle {
        text-align: center;
        font-family: Tahoma;
        font-weight: bold;
        font-size: 12px;
    }

    ul.token-input-list-facebook {
        overflow: hidden;
        height: auto !important;
        width: 99%;
        cursor: text;
        min-height: 1px;
        z-index: 999;
        list-style-type: none;
        border-radius: 3px 3px 3px 3px;
        padding: 0px 5px;
        background: none repeat scroll 0% 0% rgb(255, 255, 255);
        box-shadow: 0px 0px 3px 3px rgb(255, 255, 255) inset;
        border: 1px solid #A3C0E8;
        margin: 0px;
        font-family: Helvetica,Arial,Verdana,sans-serif;
    }
</style>
<style type="text/css">
    .highlight {
        font-weight: bold;
    }

    .dxisControl .dxis-itemTextArea {
        top: 5px;
        left: 50%; /*90 px*/
        bottom: 15px; /*5 auto;*/
        width: 40%; /*110 px*/
        padding: 10px 10px 10px;
        /*padding-bottom:20px;*/
        /*height:22px;*/
        color: #fff;
        border-radius: 5px;
        /*box-shadow: 0px 4px 0px rgba(50, 50, 50, 0.3);*/
        background-color: #333333;
        background-color: rgba(0, 0, 0, 0.75);
    }

        .dxisControl .dxis-itemTextArea a {
            color: white;
            text-decoration: none;
        }

            .dxisControl .dxis-itemTextArea a:hover, a:focus {
                text-decoration: underline;
            }

        .dxisControl .dxis-itemTextArea > p {
            margin-bottom: 0 !important;
        }

    .dxisControl .dxis-nbDotsBottom {
        padding: 0;
        /*margin-top: -25px;*/
    }

        .dxisControl .dxis-nbDotsBottom.dxis-nbSlidePanel {
            left: auto !important;
            /*right: 15px;*/
        }

    .isdemoH3 {
        font-size: 10px !important;
        color: white;
        /*padding-bottom: 9px;*/
    }
</style>
<script>
    var m_AssignOnlyChidren = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mAssignOnlyChidren", ressFilePath )%>';
    var m_UndefinedSupplierMaterial = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mUndefinedSupplierMaterial", ressFilePath )%>';
    var m_AddMaterialsLimit = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mAddMaterialsLimit", ressFilePath )%>';

    function ShowLoadingPanel(visible, control) {
        if (visible)
            ldpMaterials.ShowInElement(control);
        else {
            if (ldpMaterials.GetVisible())
                ldpMaterials.Hide();
        }
    }

    function OnSpecTree_FocusedNodeChanged(focus) {
        grdMaterials.PerformCallback("0##" + focus);
    }

    //Materials popup menu actions
    function MaterialsMenuItemClick(e) {
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "New") window.parent.ShowDuplicateMaterialPopup();
        if (name == "Edit") window.parent.ShowEditMaterialPopup();
        if (name == "Delete") window.parent.DeleteMaterial();
        if (name == "Details") window.parent.ShowMaterialsDetailsPopup();
        if (name == "EditProperties") window.parent.ShowEditMaterialPropertiesPopup();
        if (name == "Validate") window.parent.ValidateMaterial();
    }

    //Specifications popup menu actions
    function SpecMenuItemClick(e) {
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "AssignDiscipline") ShowAssignDisciplineToSpecPopup();
        if (name == "AssignSupplier") ShowAssignSupplierToSpecPopup(true);
        if (name == "AssignNorms") ShowAssignNormsToSpecPopup(true);
        if (name == "AssignProperties") ShowAssignPropertiesToSpecPopup(true);
        if (name == "AddSpecificationGroup") ShowAddSpecificationGroupPopup();
        if (name == "AddSpecification") ShowAddSpecificationPopup();
        if (name == "EditSpecification") ShowEditSpecificationPopup();
        if (name == "AddMaterial") ShowInitializedAddMaterialPopup();
    }

    function OnGetSuppliersRowValues(values) {
        if (values != null)
            grdMaterials.PerformCallback("1##" + values.toString());
    }

    //Show Assign Discipline to Spec
    function ShowAssignDisciplineToSpecPopup() {
        var key = tlsSpec.GetFocusedNodeKey();
        window.parent.ShowAssignDisciplineToSpecPopup(key);
        //if (key != null)
        //    window.parent.ShowAssignDisciplineToSpecPopup(key);
        //else
        //    alert(m_SelectMaterial);
    }



    //Show Assign Supplier To Spec Popup
    function ShowAssignSupplierToSpecPopup(IsInitialized) {
        if (IsInitialized) {
            var key = tlsSpec.GetFocusedNodeKey();
            if (tlsSpec.GetNodeState(key) != "Child") {
                alert(m_AssignOnlyChidren);
            }
            else
                window.parent.ShowAssignSupplierToSpecPopup(true, key);
        }
        else { window.parent.ShowAssignSupplierToSpecPopup(false, null); }
    }


    //Show Assign Norms To Spec Popup 
    function ShowAssignNormsToSpecPopup(IsInitialized) {
        if (IsInitialized) {
            var key = tlsSpec.GetFocusedNodeKey();
            if (tlsSpec.GetNodeState(key) != "Child") {
                alert(m_AssignOnlyChidren);
            }
            else
                window.parent.ShowAssignNormsToSpecPopup(true, key);
        }
        else { window.parent.ShowAssignNormsToSpecPopup(false, null); }
    }

    //Show Add Specification Group Popup
    function ShowAddSpecificationGroupPopup() {
        var key = tlsSpec.GetFocusedNodeKey();
        var disp = cmbDisciplines.GetValue();
        window.parent.ShowAddSpecificationGroupPopup(key, disp);
    }

    //Show Add Specification Popup
    function ShowAddSpecificationPopup() {
        var key = tlsSpec.GetFocusedNodeKey();
        var disp = cmbDisciplines.GetValue();
        window.parent.ShowAddSpecificationPopup(key, disp);
    }

    //Show Edit Specification Popup
    function ShowEditSpecificationPopup() {
        var key = tlsSpec.GetFocusedNodeKey();
        window.parent.ShowEditSpecificationPopup(key);
    }

    //Show Add Material From Specification Popup
    function ShowInitializedAddMaterialPopup() {
        var key = tlsSpec.GetFocusedNodeKey();
        var CreateOnlyOnChild = '<%= GlobalAPI.MaterialsController.GetGlobalSetting(GlobalAPI.GlobalSettings.MaterialsOnChildsOnly.ToString()) %>';
        if (CreateOnlyOnChild.toLowerCase() == 'true') {
            if (tlsSpec.GetNodeState(key) == 'Child')
                window.parent.ShowInitializedAddMaterialPopup(key);
            else
                alert(m_AddMaterialsLimit);
        }
        else
            window.parent.ShowInitializedAddMaterialPopup(key);
    }

    //Show Assign Properties To Specifications
    function ShowAssignPropertiesToSpecPopup(IsInitialized) {
        if (IsInitialized) {
            var key = tlsSpec.GetFocusedNodeKey();
            if (tlsSpec.GetNodeState(key) != "Child") {
                alert(m_AssignOnlyChidren);
            }
            else
                window.parent.ShowAssignPropertiesToSpecPopup(true, key);
        }
        else { window.parent.ShowAssignPropertiesToSpecPopup(false, null); }
    }

    //Handle tree tilter button click event
    function OnTreeFilterClick(nodeKey) {
        //cbFilterSpec.PerformCallback(nodeKey);       

        var specKey = cmbFilterSpec.GetValue();
        tlsSpec.MakeNodeVisible(specKey);
        tlsSpec.SetFocusedNodeKey(specKey);
        grdMaterials.PerformCallback('0##' + specKey);
    }

    function cbOperations_CallbackComplete(s, e) {
        //Filter materials by tokeninput field when specifications tree is selected
        if (e.parameter == 'searchFilter') {
            if (e.result != '') {
                var retTab = e.result.toString().split('@@');
                if (cmbDisciplines.GetSelectedIndex() != 0) {
                    //Set Discipline to ALL
                    cmbDisciplines.SetSelectedIndex(0);
                    //Refresh Spec Tree and filter Materials Grid in the End Callback Event
                    tlsSpec.PerformCallback(e.result);
                }
                else {
                    tlsSpec.SetFocusedNodeKey(retTab[0]);
                    tlsSpec.MakeNodeVisible(retTab[0]);
                    grdMaterials.PerformCallback('0##' + retTab[0].toString() + '##' + retTab[1].toString());
                }
            }
        }
        else {
            //Filter materials by tokeninput field when supplier grid is selected
            if (e.parameter == 'filter') {
                if (e.result != '') {
                    var retTab = e.result.toString().split('@@');
                    if (parseInt(retTab[0]) > 0) { gvwSuppliers.SetFocusedRowIndex(parseInt(retTab[3])); grdMaterials.PerformCallback('1##' + retTab[2].toString() + '##' + retTab[1].toString()); } else {
                        gvwSuppliers.SetFocusedRowIndex(-1);
                        grdMaterials.PerformCallback('1##0');
                        alert(m_UndefinedSupplierMaterial);
                    }
                }
            }
            else if (e.parameter.toString().split('#')[0] == 'filterPop') {
                //Filter materials grid when add or edit popup is closed
                if (e.result != '') {
                    var retTab = e.result.toString().split('@@');
                    if (rdbtnSlider.GetSelectedIndex() != 0) {
                        if (parseInt(retTab[0]) > 0) { gvwSuppliers.SetFocusedRowIndex(parseInt(retTab[3])); grdMaterials.PerformCallback('1##' + retTab[2].toString() + '##' + retTab[1].toString()); } else {
                            gvwSuppliers.SetFocusedRowIndex(-1);
                            grdMaterials.PerformCallback('1##0');
                            alert(m_UndefinedSupplierMaterial);
                        }
                    }
                    else {
                        if (cmbDisciplines.GetSelectedIndex() != 0) {
                            //Set Discipline to ALL
                            cmbDisciplines.SetSelectedIndex(0);
                            //Refresh Spec Tree and filter Materials Grid in the End Callback Event
                            tlsSpec.PerformCallback(retTab[5].toString() + '@@' + retTab[1].toString() + '@@' + retTab[4].toString());
                        }
                        else {
                            tlsSpec.PerformCallback('');
                            tlsSpec.SetFocusedNodeKey(retTab[5]);
                            tlsSpec.MakeNodeVisible(retTab[5]);
                            grdMaterials.PerformCallback('0##' + retTab[5].toString() + '##' + retTab[1].toString());
                        }
                    }
                }
            }
            else {
                if (e.parameter.toString().split('#')[0] == 'filterURL') {
                    if (e.result != '') {
                        var retTab = e.result.toString().split('@@');
                        if (cmbDisciplines.GetSelectedIndex() != 0) {
                            //Set Discipline to ALL
                            cmbDisciplines.SetSelectedIndex(0);
                            //Refresh Spec Tree and filter Materials Grid in the End Callback Event
                            tlsSpec.PerformCallback(e.result);
                        }
                        else {
                            tlsSpec.SetFocusedNodeKey(retTab[0]);
                            tlsSpec.MakeNodeVisible(retTab[0]);
                            grdMaterials.PerformCallback('0##' + retTab[0].toString() + '##' + retTab[1].toString());
                        }
                    }
                }
                else {
                    if (e.result != '') {
                        grdMaterials.MakeRowVisible(parseInt(e.result));
                        grdMaterials.SetFocusedRowIndex(parseInt(e.result));
                        grdMaterials.ExpandDetailRow(parseInt(e.result));
                    }
                }
            }
        }
    }

    function tlsSpec_EndCallback(s, e) {
        if (s.cpFilterBtnSpec) {
            var retTab = s.cpFilterBtnSpec.toString().split('@@');
            s.SetFocusedNodeKey(retTab[0]);
            s.MakeNodeVisible(retTab[0]);
            grdMaterials.PerformCallback('0##' + retTab[0].toString() + '##' + retTab[1].toString());
            s.cpFilterBtnSpec = null;
        }
    }

    function grdMaterials_EndCallback(s, e) {
        ShowLoadingPanel(false, grdMaterials.GetMainElement());
        if (s.cpFilterBtnMaterial) {
            cbOperations.PerformCallback(s.cpFilterBtnMaterial);
            s.cpFilterBtnMaterial = null;
        }
    }

    function SpecMenuInit(s, e) {
        try {
            //Init context menu items visibility
            s.GetItem(0).SetVisible(false);
            s.GetItem(1).SetVisible(false);
            s.GetItem(2).SetVisible(false);
            s.GetItem(3).SetVisible(false);
            s.GetItem(4).SetVisible(false);
            s.GetItem(5).SetVisible(false);
            s.GetItem(6).SetVisible(false);
            s.GetItem(7).SetVisible(false);

            if (typeof (ctxAssignDiscipline) != 'undefined')
                s.GetItem(0).SetVisible(true);
            if (typeof (ctxAssignSupplier) != 'undefined')
                s.GetItem(1).SetVisible(true);
            if (typeof (ctxAssignNorms) != 'undefined')
                s.GetItem(2).SetVisible(true);
            if (typeof (ctxAssignProperties) != 'undefined')
                s.GetItem(3).SetVisible(true);
            if (typeof (ctxAddSpecificationGroup) != 'undefined')
                s.GetItem(4).SetVisible(true);
            if (typeof (ctxAddSpecification) != 'undefined')
                s.GetItem(5).SetVisible(true);
            if (typeof (ctxEditSpecification) != 'undefined')
                s.GetItem(6).SetVisible(true);
            if (typeof (litAdd_Materials) != 'undefined')
                s.GetItem(7).SetVisible(true);
        }
        catch (err) { }
    }

    function MaterialsMenuInit(s, e) {
        try {
            //Init context menu items visibility
            s.GetItem(1).SetVisible(false);
            s.GetItem(2).SetVisible(false);
            s.GetItem(3).SetVisible(false);
            s.GetItem(4).SetVisible(false);
            s.GetItem(5).SetVisible(false);

            if (typeof (litEdit_Materials) != 'undefined')
                s.GetItem(1).SetVisible(true);
            if (typeof (ctxEditProperties) != 'undefined')
                s.GetItem(2).SetVisible(true);
            if (typeof (litDelete_Materials) != 'undefined')
                s.GetItem(3).SetVisible(true);
            if (typeof (ctxViewTechDetails_Materials) != 'undefined')
                s.GetItem(4).SetVisible(true);
            if (typeof (ctxValidate) != 'undefined')
                s.GetItem(5).SetVisible(true);
        }
        catch (err) { }
    }    
</script>





<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td valign="top" style="width: 100%;">
            <dx:ASPxSplitter ID="spltitter" Height="570px" Width="100%" runat="server"
                Theme="Glass">
                <Styles>
                    <Pane>
                        <Paddings Padding="0px" />
                        <Paddings Padding="0px"></Paddings>
                    </Pane>
                </Styles>
                <Panes>
                    <dx:SplitterPane Name="ListBoxContainer" ShowCollapseBackwardButton="True" ShowCollapseForwardButton="True"
                        ShowSeparatorImage="True" Size="27%">
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                <table width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="border-bottom: solid 1px #A3C0E8; width: 100%; background-color: #FFFFFF;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table style="width: 299px; height: 48px;">
                                                            <tr id="divSliderSpec">
                                                                <td style="width: 50px;">&nbsp;</td>
                                                                <td style="padding-left: 50px; width: 100px; background-image: url('/images/Materials/silder_1.jpg');"></td>
                                                                <td>
                                                                    <div style="height: 28px; top: 5px; left: 50%; bottom: 15px; padding: 5px 10px 0px; color: #fff; border-radius: 5px; background-color: #333333; background-color: rgba(0, 0, 0, 0.75);">
                                                                        <%= DotNetNuke.Services.Localization.Localization.GetString("hSpecifications", ressFilePath)%>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <tr id="divSliderSupplier" style="display: none;">
                                                                <td style="width: 50px;">&nbsp;</td>
                                                                <td style="padding-left: 50px; width: 100px; background-image: url('/images/Materials/silder_2.jpg');"></td>
                                                                <td>
                                                                    <div style="height: 28px; top: 5px; left: 50%; bottom: 15px; padding: 5px 10px 0px; color: #fff; border-radius: 5px; background-color: #333333; background-color: rgba(0, 0, 0, 0.75);">
                                                                        <%= DotNetNuke.Services.Localization.Localization.GetString("hSuppliers", ressFilePath)%>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="cursor: pointer; cursor: hand;">
                                                        <dx:ASPxRadioButtonList ID="rdbtnSlider" runat="server" ClientIDMode="AutoID" ClientInstanceName="rdbtnSlider" Theme="MetropolisBlue" RepeatDirection="Vertical">
                                                            <Items>
                                                                <dx:ListEditItem Text="" Value="0" Selected="true" />
                                                                <dx:ListEditItem Text="" Value="1" />
                                                            </Items>
                                                            <Border BorderStyle="None"></Border>
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                        if(s.GetSelectedIndex() == 1)
                                                        {
                                                            window.document.getElementById('divSliderSpec').style.display='none';
                                                            window.document.getElementById('divSliderSupplier').style.display='';
                                                            window.document.getElementById('specPanel').style.display='none';
                                                            window.document.getElementById('supplierPanel').style.display='';
                                                            btnFilterBySupplier.SetVisible(true);
                                                            btnFilter.SetVisible(false);
                                                            var suppKey = gvwSuppliers.GetRowKey(gvwSuppliers.GetFocusedRowIndex());
                                                            if(suppKey == null)
                                                                grdMaterials.PerformCallback('1##0');    
                                                            else
                                                                grdMaterials.PerformCallback('1##'+gvwSuppliers.GetRowKey(gvwSuppliers.GetFocusedRowIndex()));    
                                                        }
                                                        else
                                                        {
                                                            window.document.getElementById('divSliderSpec').style.display='';
                                                            window.document.getElementById('divSliderSupplier').style.display='none';
                                                            window.document.getElementById('specPanel').style.display='';
                                                            window.document.getElementById('supplierPanel').style.display='none';
                                                            btnFilterBySupplier.SetVisible(false);
                                                            btnFilter.SetVisible(true);
                                                            var specKey = tlsSpec.GetFocusedNodeKey();
                                                            if(specKey == '')
                                                                grdMaterials.PerformCallback('0##0');
                                                            else
                                                                grdMaterials.PerformCallback('0##'+tlsSpec.GetFocusedNodeKey());
                                                        }
                                                    }" />
                                                        </dx:ASPxRadioButtonList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table id="supplierPanel" style="display: none;" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <dx:ASPxGridView ID="gvwSuppliers" ClientInstanceName="gvwSuppliers" runat="server" Theme="Glass" AutoGenerateColumns="False" DataSourceID="sqlTypeContact" EnableTheming="True" KeyFieldName="ContactID" Width="100%" OnPreRender="gvwSuppliers_PreRender">
                                                <Columns>
                                                    <dx:GridViewDataTextColumn FieldName="ContactID" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                        <EditFormSettings Visible="False" />
                                                        <Settings AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataTextColumn>
                                                    <dx:GridViewDataTextColumn FieldName="ContactName" VisibleIndex="1">
                                                        <Settings AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                                <Settings ShowFilterRow="true" ShowTitlePanel="true" VerticalScrollableHeight="385" VerticalScrollBarMode="Auto" />
                                                <SettingsPager PageSize="100"></SettingsPager>
                                                <SettingsText Title="Fournisseurs" />
                                                <SettingsBehavior AllowFocusedRow="true" />
                                                <ClientSideEvents FocusedRowChanged="function(s, e){
                                                     gvwSuppliers.GetRowValues(gvwSuppliers.GetFocusedRowIndex(), 'ContactID', OnGetSuppliersRowValues);
                                                }"></ClientSideEvents>
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                    </tr>
                                </table>
                                <table id="specPanel" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td class="HeaderTitle" style="width: 100%; padding-bottom: 5px;">
                                            <asp:Label runat="server" ID="lbDiscipline"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding-left: 20px; padding-bottom: 5px; border-bottom: solid 1px #A3C0E8;">
                                            <dx:ASPxComboBox ID="cmbDisciplines" ClientInstanceName="cmbDisciplines" runat="server"
                                                ValueType="System.String" Theme="Glass" DataSourceID="DisciplinesDS" TextField="Designation" ValueField="Abreviation" Width="95%" IncrementalFilteringMode="Contains" DropDownStyle="DropDownList" OnDataBound="cmbDisciplines_DataBound">
                                                <ClientSideEvents Init="function(s, e) {s.SetSelectedIndex(-1);}" SelectedIndexChanged="function(s, e) {
                                                    grdMaterials.PerformCallback('0##0'); //added   
                                                    tlsSpec.SetFocusedNodeKey(''); //added
                                                    tlsSpec.PerformCallback();
                                                    //cmbFilterSpec.PerformCallback();
                                                }" />
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="HeaderTitle" style="width: 100%; padding: 5px; border-bottom: solid 1px #A3C0E8;">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="100%">
                                                        <asp:Label runat="server" ID="lbSpec"></asp:Label>
                                                    </td>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="imExpand2" ImageUrl="../../images/Materials/icon_expand.png" OnClientClick="tlsSpec.ExpandAll();return false;" /></td>
                                                    <td>&nbsp;</td>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="imCollapse2" ImageUrl="../../images/Materials/icon_collapse.png" OnClientClick="tlsSpec.CollapseAll();return false;" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxTreeList ID="tlsSpec" ClientInstanceName="tlsSpec" runat="server"
                                                Height="100%" EnableCallbacks="true" EnableCallbackCompression="False" DataSourceID="MaterialsSpecificationsDS"
                                                Theme="Glass" Width="100%" BackColor="#F7FBF7" KeyFieldName="ID" ParentFieldName="Id_Parent" AutoGenerateColumns="False" OnCustomCallback="tlsSpec_CustomCallback">
                                                <ClientSideEvents ContextMenu="function(s, e) {
                                                mnSpecActions.ShowAtPos(ASPxClientUtils.GetEventX(e.htmlEvent), ASPxClientUtils.GetEventY(e.htmlEvent));
                                                }"
                                                    FocusedNodeChanged="function(s, e){
                                                     ShowLoadingPanel(true,grdMaterials.GetMainElement());OnSpecTree_FocusedNodeChanged(s.GetFocusedNodeKey());
                                                }"
                                                    Init="function(s, e) { var popup = window.parent; popup.window['tlsSpec'] = tlsSpec; }"
                                                    EndCallback="tlsSpec_EndCallback"></ClientSideEvents>
                                                <Columns>
                                                    <dx:TreeListTextColumn FieldName="ID_MaterialsSpecifications" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                    </dx:TreeListTextColumn>
                                                    <dx:TreeListTextColumn FieldName="ID" ReadOnly="True" ShowInCustomizationForm="True" Visible="False">
                                                    </dx:TreeListTextColumn>
                                                    <dx:TreeListTextColumn FieldName="Id_Parent" ShowInCustomizationForm="True" VisibleIndex="3" Visible="false">
                                                    </dx:TreeListTextColumn>
                                                    <dx:TreeListTextColumn AllowSort="False" FieldName="Designation" ShowInCustomizationForm="True" VisibleIndex="4" Width="100%">
                                                        <DataCellTemplate>
                                                            <table cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td>
                                                                        <dx:ASPxImage ID="img" runat="server" ImageUrl='<%# (Eval("MaterialsNumber")!=null)?((Int32.Parse(Eval("MaterialsNumber").ToString()) > 0) ? "~/images/Materials/green_icon16x16.png":"~/images/Materials/red_icon16x16.png") :"~/images/Materials/red_icon16x16.png" %>'
                                                                            Width="12px" Height="12px" Theme="Glass">
                                                                        </dx:ASPxImage>
                                                                    </td>
                                                                    <td>&nbsp;</td>
                                                                    <td>
                                                                        <%# Eval("Designation")%>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </DataCellTemplate>
                                                    </dx:TreeListTextColumn>
                                                </Columns>
                                                <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="true" GridLines="Horizontal"
                                                    ShowColumnHeaders="True" VerticalScrollBarMode="Visible" ScrollableHeight="410" HorizontalScrollBarMode="Visible"></Settings>
                                                <SettingsBehavior ProcessFocusedNodeChangedOnServer="false" ProcessSelectionChangedOnServer="false"
                                                    AllowFocusedNode="true" AutoExpandAllNodes="True" AllowDragDrop="False" FocusNodeOnLoad="false"></SettingsBehavior>
                                                <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>
                                                <Templates>
                                                    <HeaderCaption>
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <dx:ASPxComboBox ID="cmbFilterSpec" ClientInstanceName="cmbFilterSpec" runat="server" DataSourceID="MaterialsSpecificationsDS" ValueField="ID" Width="100%"
                                                                        TextField="Designation" ValueType="System.String" Theme="Glass" IncrementalFilteringMode="Contains"
                                                                        DropDownButton-Visible="False" DropDownStyle="DropDown">
                                                                        <ClientSideEvents ValueChanged="function(s,e){
                                                                                                    OnTreeFilterClick(cmbFilterSpec.GetText());
                                                                                                    imgClear.SetImageUrl('../../images/clear.png');
                                                                                                    }" />
                                                                    </dx:ASPxComboBox>
                                                                </td>
                                                                <td>&nbsp;</td>
                                                                <td style="width: 16px;">
                                                                    <dx:ASPxImage ID="imgClear" ClientInstanceName="imgClear" runat="server" Width="16px" Height="16px"
                                                                        ImageUrl="~/images/spacer.gif" Cursor="pointer">
                                                                        <ClientSideEvents Click="function(s,e){cmbFilterSpec.SetText('');imgClear.SetImageUrl('../../images/spacer.gif');}" />
                                                                    </dx:ASPxImage>

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </HeaderCaption>
                                                </Templates>
                                            </dx:ASPxTreeList>
                                        </td>
                                    </tr>
                                </table>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                    <dx:SplitterPane Name="MainContainer">
                        <ContentCollection>
                            <dx:SplitterContentControl runat="server">




                                <dx:ASPxGridView ID="grdMaterials" runat="server" AutoGenerateColumns="False" ClientIDMode="AutoID" ClientInstanceName="grdMaterials" DataSourceID="MaterialsDS" KeyFieldName="ID" Theme="Glass" Width="100%" OnCustomCallback="grdMaterials_CustomCallback" OnLoad="grdMaterials_Load">
                                    <ClientSideEvents ContextMenu="function(s, e) {
                                                mnMaterialsActions.ShowAtPos(ASPxClientUtils.GetEventX(e.htmlEvent), ASPxClientUtils.GetEventY(e.htmlEvent));
                                                }"
                                        FocusedRowChanged="function(s, e) {  }" Init="function(s, e) { var popup = window.parent; popup.window['grdMaterials'] = grdMaterials; }"
                                        EndCallback="grdMaterials_EndCallback" />
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="ID" VisibleIndex="0" ReadOnly="True" Visible="false">
                                            <EditFormSettings Visible="False" />
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="ID_MaterialsSpecifications" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Code" ShowInCustomizationForm="True" VisibleIndex="2" Width="120px">
                                            <Settings AutoFilterCondition="Contains" />
                                           
                                        </dx:GridViewDataTextColumn>

                                        <dx:GridViewDataTextColumn FieldName="Nom" ShowInCustomizationForm="True" VisibleIndex="3">
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="Description" ShowInCustomizationForm="True" VisibleIndex="4">
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BrandDesignation" ShowInCustomizationForm="True" VisibleIndex="4" Width="120px">
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DisplayName" ShowInCustomizationForm="True" Visible="false" VisibleIndex="3">
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="CreatedOnDate" ShowInCustomizationForm="True" Visible="false" VisibleIndex="4">
                                            <Settings AutoFilterCondition="Contains" />
                                        </dx:GridViewDataDateColumn>
                                    </Columns>
                                    <SettingsBehavior AllowFocusedRow="True" />
                                    <SettingsPager PageSize="40">
                                        <PageSizeItemSettings ShowAllItem="true"></PageSizeItemSettings>
                                    </SettingsPager>
                                    <Settings ShowFilterRow="True" ShowTitlePanel="True" VerticalScrollableHeight="375" VerticalScrollBarMode="Auto" ShowGroupPanel="True" />
                                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>

                                    <SettingsText CustomizationWindowCaption="Liste des champs" Title="Liste des articles" />
                                    <SettingsCustomizationWindow Enabled="True" Height="300px" PopupVerticalAlign="TopSides" Width="250px" />
                                    <Columns>
                                        <dx:GridViewDataTextColumn FieldName="Description" ShowInCustomizationForm="True" VisibleIndex="5">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="BrandDesignation" ShowInCustomizationForm="True" Width="120px" VisibleIndex="6">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn FieldName="DisplayName" ShowInCustomizationForm="True" Visible="False" VisibleIndex="4">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataDateColumn FieldName="CreatedOnDate" ShowInCustomizationForm="True" Visible="False" VisibleIndex="7">
                                        </dx:GridViewDataDateColumn>
                                    </Columns>

                                    <SettingsDetail AllowOnlyOneMasterRowExpanded="True" ShowDetailRow="True" />
                                    <Images>
                                        <DetailCollapsedButton ToolTip="Plus de détails" Url="~/images/expand.gif">
                                        </DetailCollapsedButton>
                                        <DetailExpandedButton ToolTip="Fermer" Url="~/images/collapse.gif">
                                        </DetailExpandedButton>
                                    </Images>
                                    <Styles>
                                        <Header ImageSpacing="5px" SortingImageSpacing="5px">
                                        </Header>
                                        <DetailRow BackColor="#FFFFFF"></DetailRow>
                                    </Styles>
                                    <StylesEditors>
                                        <CalendarHeader Spacing="1px">
                                        </CalendarHeader>
                                        <ProgressBar Height="25px">
                                        </ProgressBar>
                                    </StylesEditors>
                                    <Templates>
                                        <TitlePanel>
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td class="HeaderTitle" width="100%">
                                                        <%= DotNetNuke.Services.Localization.Localization.GetString("hMaterialsList", ressFilePath)%>
                                                    </td>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="../../images/Materials/icon_expand.png" OnClientClick="grdMaterials.ExpandAllDetailRows();return false;" /></td>
                                                    <td>&nbsp;</td>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="ImageButton2" ImageUrl="../../images/Materials/icon_collapse.png" OnClientClick="grdMaterials.CollapseAllDetailRows();return false;" /></td>
                                                </tr>
                                            </table>
                                        </TitlePanel>
                                        <DetailRow>
                                            <div style="overflow: auto;">
                                                <dx:ASPxTreeList Visible="true" ID="tlsPropertiesGroups" ClientInstanceName="tlsPropertiesGroups" runat="server"
                                                    Height="100%" EnableCallbacks="true" EnableCallbackCompression="False" DataSourceID="PropertiesHiearchyDS"
                                                    Theme="Metropolis" BackColor="Transparent" Width="100%" KeyFieldName="Id" ParentFieldName="ParentId" AutoGenerateColumns="False" OnLoad="tlsPropertiesGroups_Load" OnHtmlDataCellPrepared="tlsPropertiesGroups_HtmlDataCellPrepared">
                                                    <ClientSideEvents Init="function(s, e) { var popup = window.parent; popup.window['tlsPropertiesGroups'] = tlsPropertiesGroups; }"></ClientSideEvents>
                                                    <Columns>
                                                        <dx:TreeListTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                        </dx:TreeListTextColumn>
                                                        <dx:TreeListTextColumn FieldName="ParentId" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                        </dx:TreeListTextColumn>
                                                        <dx:TreeListTextColumn FieldName="Designation" ShowInCustomizationForm="True" VisibleIndex="2">
                                                        </dx:TreeListTextColumn>
                                                        <dx:TreeListTextColumn FieldName="PropertyDesignation" ShowInCustomizationForm="True" VisibleIndex="3" Width="50%">
                                                        </dx:TreeListTextColumn>
                                                        <dx:TreeListTextColumn FieldName="Valeur" ShowInCustomizationForm="True" VisibleIndex="4" Width="20%">
                                                            <CellStyle Font-Bold="true" HorizontalAlign="Right"></CellStyle>
                                                        </dx:TreeListTextColumn>
                                                        <dx:TreeListTextColumn FieldName="UnitAbreviation" ShowInCustomizationForm="True" VisibleIndex="4" Caption="Unité">
                                                            <CellStyle Font-Bold="true" HorizontalAlign="Left"></CellStyle>
                                                        </dx:TreeListTextColumn>
                                                    </Columns>
                                                    <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="false" GridLines="Horizontal"
                                                        ShowColumnHeaders="false" ShowTreeLines="false" VerticalScrollBarMode="Hidden" ScrollableHeight="150"></Settings>
                                                    <SettingsBehavior ProcessFocusedNodeChangedOnServer="false" ProcessSelectionChangedOnServer="false"
                                                        AllowFocusedNode="false" AutoExpandAllNodes="True" AllowDragDrop="False"></SettingsBehavior>
                                                    <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>
                                                </dx:ASPxTreeList>
                                            </div>
                                        </DetailRow>
                                    </Templates>
                                </dx:ASPxGridView>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                </Panes>

            </dx:ASPxSplitter>
        </td>
    </tr>
</table>
<table style="padding-top: 10px;" cellpadding="0" cellspacing="0">
    <tr>
        <td style="width: 22%">
            <chartMaterials:chartMaterials ID="chartMaterialsCtrl" runat="server" />
        </td>
        <td style="width: 10px">&nbsp;</td>
        <td style="width: 56%">
            <chartMaterialsByDiscipline:ChartMaterialsByDiscipline ID="chartMaterialsByDisciplineCtrl" runat="server" />
        </td>
        <td style="width: 10px">&nbsp;</td>
        <td style="width: 22%">
            <chartSpecificationsByDisciplines:chartSpecificationsByDisciplines ID="chartSpecificationsByDisciplines" runat="server" />
        </td>
    </tr>
</table>

<asp:SqlDataSource ID="MaterialsDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Materials_GetMaterials" SelectCommandType="StoredProcedure" OnSelecting="MaterialsDS_Selecting">
    <SelectParameters>
        <asp:SessionParameter Name="FilterID" SessionField="FilterID" Type="Int32" />
        <asp:SessionParameter Name="FilterType" SessionField="FilterType" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="DisciplinesDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Materials_GetAllInUseDisciplines" SelectCommandType="StoredProcedure" OnSelecting="DisciplinesDS_Selecting">
    <SelectParameters>
        <asp:Parameter Name="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<div style="text-align: center; display: none;">
    <table>
        <tr>
            <td class="buttonCell">
                <dx:ASPxButton ID="btnPdfExport" ClientInstanceName="btnPdfExport" runat="server"
                    Theme="Glass"
                    OnClick="btnPdfExport_Click" Text="Exporter PDF" UseSubmitBehavior="False">
                    <ClientSideEvents Init="function(s, e) {
                                    var popup = window.parent;
                                    popup.window['btnExportPDF_Materials'] = btnPdfExport;}" />
                </dx:ASPxButton>
            </td>
            <td class="buttonCell">
                <dx:ASPxButton ID="btnXlsExport" ClientInstanceName="btnXlsExport" runat="server"
                    Theme="Glass"
                    OnClick="btnXlsExport_Click" Text="Exporter Excel" UseSubmitBehavior="False">
                    <ClientSideEvents Init="function(s, e) {
                                    var popup = window.parent;
                                    popup.window['btnExportExcel_Materials'] = btnXlsExport;}" />
                </dx:ASPxButton>
            </td>
            <td class="buttonCell">&nbsp;</td>
            <td class="buttonCell">&nbsp;</td>
        </tr>
    </table>
</div>
<dxwgv:ASPxGridViewExporter runat="server" GridViewID="grdMaterials" ID="gridExport"></dxwgv:ASPxGridViewExporter>


<asp:SqlDataSource ID="MaterialsSpecificationsDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Materials_MaterialsSpecification_SelectByDiscipline" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="lang" SessionField="Locale" DefaultValue="fr-fr" />
        <asp:SessionParameter Name="Id_Discipline" SessionField="DisciplineID" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="PropertiesHiearchyDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Materials_GetMaterialPropertiesHiearchy" SelectCommandType="StoredProcedure" OnSelecting="PropertiesHiearchyDS_Selecting">
    <SelectParameters>
        <asp:SessionParameter Name="MaterialID" SessionField="MaterialID" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:LinqDataSource ID="MaterialsPropertiesDS" runat="server" ContextTypeName="DataLayer.MaterialsDataContext"
    TableName="Materials_Materials_Properties" OnSelecting="MaterialsPropertiesDS_Selecting">
</asp:LinqDataSource>

<asp:SqlDataSource ID="MaterialsByDisciplinesDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Materials_GetMaterialsByDisciplines" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

<dx:ASPxPopupMenu ID="mnMaterialsActions" runat="server"
    ClientInstanceName="mnMaterialsActions"
    Theme="Glass" GutterWidth="0px"
    SeparatorColor="#A3C0E8">
    <Items>
        <dx:MenuItem Name="New" ClientVisible="false" Text="Duppliquer article">
            <Image Url="~/images/Materials/duplicate-icon.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="Edit" Text="Modifier article">
            <Image Url="~/images/edit.gif" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="EditProperties" Text="Modifier les propriétés">
            <Image Url="~/images/edit.gif" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="Delete" Text="Supprimer article">
            <Image Url="~/images/delete.gif" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="Details" Text="Details article">
            <Image Url="~/images/Blue-Info.gif" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="Validate" Text="Valider article">
            <Image Url="~/images/Materials/check.png" Width="16px" Height="16px" />
        </dx:MenuItem>
    </Items>
    <ItemStyle ImageSpacing="5px" Font-Bold="true" Font-Size="11px" />
    <SubMenuStyle BackColor="#EDF3F4" GutterWidth="0px" SeparatorColor="#A3C0E8" />
    <ClientSideEvents ItemClick="function(s, e) {MaterialsMenuItemClick(e);}" Init="MaterialsMenuInit" />
    <SubMenuItemImage Height="7px" Width="7px" />
</dx:ASPxPopupMenu>
<dx:ASPxPopupMenu ID="mnSpecActions" runat="server"
    ClientInstanceName="mnSpecActions"
    Theme="Glass" GutterWidth="0px"
    SeparatorColor="#A3C0E8">
    <Items>
        <dx:MenuItem Name="AssignDiscipline">
            <Image Url="~/images/Materials/assign_spec.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="AssignSupplier">
            <Image Url="~/images/Materials/assign_supplier.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="AssignNorms">
            <Image Url="~/images/Materials/normes.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="AssignProperties">
            <Image Url="~/images/Materials/properties-icons.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="AddSpecificationGroup" Text="Ajouter groupe spécification">
            <Image Url="~/images/Materials/process-add-icon.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="AddSpecification" Text="Ajouter spécification">
            <Image Url="~/images/Materials/process-add-icon.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="EditSpecification" Text="Modifier spécification">
            <Image Url="~/images/Materials/process-edit-icon.png" Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="AddMaterial" Text="Ajouter article">
            <Image Url="~/images/Materials/add_material.png" Width="16px" Height="16px" />
        </dx:MenuItem>
    </Items>
    <ItemStyle ImageSpacing="5px" Font-Bold="true" Font-Size="11px" />
    <SubMenuStyle BackColor="#EDF3F4" GutterWidth="0px" SeparatorColor="#A3C0E8" />
    <ClientSideEvents ItemClick="function(s, e) {SpecMenuItemClick(e);}" Init="SpecMenuInit" />
    <SubMenuItemImage Height="7px" Width="7px" />
</dx:ASPxPopupMenu>
<asp:SqlDataSource ID="sqlTypeContact" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Materials_GetMaterialsAndSuppliers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
<dx:ASPxCallback ID="cbOperations" ClientInstanceName="cbOperations" runat="server" OnCallback="cbOperations_Callback">
    <ClientSideEvents Init="function(s, e) { var popup = window.parent; popup.window['cbOperations'] = cbOperations; }"
        CallbackComplete="cbOperations_CallbackComplete" />
</dx:ASPxCallback>
<dx:ASPxCallback ID="cbFilterSpec" ClientInstanceName="cbFilterSpec" runat="server" OnCallback="cbFilterSpec_Callback">
    <ClientSideEvents CallbackComplete="function(s, e) {
        if(e.result != '')
        {   
            //tlsSpec.ExpandNode(e.result);  
            tlsSpec.MakeNodeVisible(e.result);    
            tlsSpec.SetFocusedNodeKey(e.result);    
            grdMaterials.PerformCallback('0##' + e.result);    
            //tlsSpec.ExpandAll();
            //tlsSpec.MakeNodeVisible(e.result);  
            //tlsSpec.ExpandNode(e.result); 
        }
}" />
</dx:ASPxCallback>
<dx:ASPxLoadingPanel ID="ldpMaterials" runat="server" ClientInstanceName="ldpMaterials" Theme="Glass">
</dx:ASPxLoadingPanel>
<script type="text/javascript">
    window.onload = new function () {
        var k = getQueryString('MaterialKey', window.parent.document.location.href);
        if (k != '') {
            cbOperations.PerformCallback('filterURL#' + k);
            //cbOperations.PerformCallback(k);
            tlsSpec.MakeNodeVisible(tlsSpec.GetFocusedNodeKey());
        };
    }
</script>

<dx:ASPxLabel ID="ctxAssignDiscipline" ClientInstanceName="ctxAssignDiscipline"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxAssignSupplier" ClientInstanceName="ctxAssignSupplier"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxAssignNorms" ClientInstanceName="ctxAssignNorms"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxAssignProperties" ClientInstanceName="ctxAssignProperties"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxAddSpecificationGroup" ClientInstanceName="ctxAddSpecificationGroup"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxAddSpecification" ClientInstanceName="ctxAddSpecification"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxEditSpecification" ClientInstanceName="ctxEditSpecification"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="litAdd_Materials" ClientInstanceName="litAdd_Materials"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="litEdit_Materials" ClientInstanceName="litEdit_Materials"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxEditProperties" ClientInstanceName="ctxEditProperties"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="litDelete_Materials" ClientInstanceName="litDelete_Materials"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxViewTechDetails_Materials" ClientInstanceName="ctxViewTechDetails_Materials"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>
<dx:ASPxLabel ID="ctxValidate" ClientInstanceName="ctxValidate"
    runat="server" Text="" Visible="false" EnableClientSideAPI="true" Theme="Glass">
</dx:ASPxLabel>

