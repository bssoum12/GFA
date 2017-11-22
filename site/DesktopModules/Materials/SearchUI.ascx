<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SearchUI.ascx.cs" Inherits="VD.Modules.Materials.SearchUI" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data.Linq" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dxtl" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxwgv" %>


<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="token" TagName="token" Src="~/controls/TokenInputCtrl.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<accessModule:accessModule ID="AccModule" runat="server" />
<localizeModule:localizeModule ID="localModule" runat="server" />
<token:token ID="tokenId" runat="server" datafrom="searchmaterials" />
<script type="text/javascript" src="Helper.js"></script>
<style>
    .td_label {
        font-family: Tahoma;
        font-weight: bold;
        font-size: 12px;
        width: 100px;
    }

    .td_link {
        font-family: Tahoma;
        font-size: 12px;
        color: #AECAF0; /* #7EACB1;*/
        text-decoration: underline;
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
        border: 1px solid #AECAF0;
        margin: 0px;
        font-family: Helvetica,Arial,Verdana,sans-serif;
    }
    .xPane_header_expanded
    {
        width:100%;text-align:center;font-weight: normal;text-align: center;border-top: 1px Solid #7EACB1;border-left: 1px Solid #7EACB1;border-right: 1px Solid #7EACB1;color: #283B56;background-color:#e9f8fa;font: 12px Tahoma;       
    }
    .xPane_header_collapsed
    {
        width:100%;text-align:center;font-weight: normal;text-align: center;border: 1px Solid #7EACB1;color: #283B56;background-color:#e9f8fa;font: 12px Tahoma;
    }
</style>

<script type="text/javascript">
    var GridViewAdjustRequired = true;
    var textSeparator = ";";
    function DropDownHandler(s, e) {
        SynchronizeFocusedRow();
    }

    function DropDownHandlerNorm(s, e) {
        SynchronizeFocusedRowNorm();
    }

    function treaListInitHandlerNorm(s, e) {
        SynchronizeFocusedRowNorm();
    }

    function treaListInitHandler(s, e) {
        SynchronizeFocusedRow();
    }
    function RowClickHandler(s, e) {
        var key = e.nodeKey;
        DropDownEdit.SetKeyValue(key);
        var index = treeList.cpKeyValues.indexOf(key);
        DropDownEdit.SetValue(treeList.cpKeyValues[index]);
        DropDownEdit.SetText(treeList.cpEmployeeNames[index]);
        treeListNorm.PerformCallback('ValueChanged');

    }

    function RowClickHandlerNorm(s, e) {
        var key = e.nodeKey;        
        DropDownEditNorm.SetKeyValue(key);
        var index = treeListNorm.cpNormKeyValues.indexOf(key);
        DropDownEditNorm.SetValue(treeListNorm.cpNormKeyValues[index]);
        DropDownEditNorm.SetText(treeListNorm.cpNormNames[index]);     
    }
    

    function SynchronizeFocusedRow() {
        var keyValue = DropDownEdit.GetKeyValue();
        if (keyValue != null) {
            treeList.SetFocusedNodeKey(keyValue);
            treeList.PerformCallback(keyValue)
            UpdateEditBox();
        }
    }

    function SynchronizeFocusedRowNorm() {
        var keyValue = DropDownEditNorm.GetKeyValue();
        if (keyValue != null) {
            for (i = 0 ; i < keyValue.length ; i++)
                treeListNorm.SelectNode(keyValue);
        }
    }

    function UpdateEditBox() {
        var rowIndex = treeList.GetFocusedNodeKey();
        var focusedEmployeeName = rowIndex == -1 ? "" : rowIndex;
        var employeeNameInEditBox = DropDownEdit.GetKeyValue();
        if (employeeNameInEditBox != focusedEmployeeName)
            DropDownEdit.SetText(focusedEmployeeName);
    }
    // ]]> 

    function Search_Click(param) {
        if (param != "") {
            grdMaterials.PerformCallback(param);
        }
    }

    function FullSearch_Click(param) {
        if (param != "") {
            if ((param == "pleintext") && (cmbProperties.GetText() != ""))
                if (!ASPxClientEdit.ValidateGroup('groupprop'))
                    return;
            grdMaterialsFullText.PerformCallback(param);
        }
    }

    function ShowMaterialDetailsPopup(key) {
        var mn_DetailsMaterial = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnDetailsMaterial", ressFilePath )%>';
        popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/DetailsMaterial.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&MaterialId=" + key);
        popupCtrl.SetHeaderText(mn_DetailsMaterial);
        popupCtrl.Show();
    }

    function RefreshMaterials()
    {
        grdMaterials.Refresh();
    }
    window.parent.window['RefreshMaterials'] = RefreshMaterials;

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
    
    function SetSearchPaneVisibility(pane)
    {
        switch(pane) {
            case 1:
                HideDisplayPaneDiv(window.document.getElementById('img1'), 'header_filter1', 'div_filter1');
                SetPaneDivVisibility(window.document.getElementById('img2'), 'header_filter2', 'div_filter2', false);
                SetPaneDivVisibility(window.document.getElementById('img3'), 'header_filter3', 'div_filter3', false);
                grdMaterials.SetVisible(false);
                grdMaterialsFullText.SetVisible(true);
                grdMaterials.PerformCallback('');
                break;
            case 2:
                HideDisplayPaneDiv(window.document.getElementById('img2'), 'header_filter2', 'div_filter2');
                SetPaneDivVisibility(window.document.getElementById('img1'), 'header_filter1', 'div_filter1', false);
                SetPaneDivVisibility(window.document.getElementById('img3'), 'header_filter3', 'div_filter3', false);
                grdMaterials.SetVisible(true);
                grdMaterialsFullText.SetVisible(false);
                grdMaterialsFullText.PerformCallback('');
                break;
            case 3:
                HideDisplayPaneDiv(window.document.getElementById('img3'), 'header_filter3', 'div_filter3');
                SetPaneDivVisibility(window.document.getElementById('img1'), 'header_filter1', 'div_filter1', false);
                SetPaneDivVisibility(window.document.getElementById('img2'), 'header_filter2', 'div_filter2', false);
                grdMaterials.SetVisible(true);
                grdMaterialsFullText.SetVisible(false);
                grdMaterialsFullText.PerformCallback('');
                break;
            default:
                break;
        }           
    }
</script>
    <div>
        <table id="header_filter1" class="xPane_header_expanded">
            <tr>
                <td style="width: 16px;">
                    <img id="img1" width="16px" height="16px" src="..\..\images\Materials\up.png" style="cursor: hand; cursor: pointer;" onclick="SetSearchPaneVisibility(1);">
                </td>
                <td>
                    <dx:ASPxLabel ID="lblFilter1" runat="server" Font-Bold="True" Theme="Default"></dx:ASPxLabel>
                </td>
            </tr>
        </table>
    </div>
    <div id="div_filter1" style="font-family:Tahoma;font-size:12px;border: 1px Solid #7EACB1;">
        <table style="width: 100%; padding: 5px;" cellpadding="0" cellspacing="0">
            <tr>
                <td style="width: 100%;">
                    <input type="text" autocomplete="off" style="outline: none; width: 100%;" id="token-input" onchange="if ( document.getElementById('token-input').value == '' ){document.getElementById('tabProp').style.display = 'none';}else{document.getElementById('tabProp').style.display = '';};" />
                </td>
                <td>&nbsp;</td>
                <td style="width: 100px;vertical-align:top;" rowspan="2">
                 <table>
                        <tr>
                            <td>
                                   <dx:ASPxButton ID="btnFilterPleinText" ClientInstanceName="btnFilterPleinText" runat="server" Text="" ToolTip="Rechercher" AutoPostBack="false"
                        Image-Url="~/images/SearchCrawler_16px.gif" BackgroundImage-ImageUrl="~/images/spacer.gif" Border-BorderColor="#7EACB1" BackColor="Transparent" Theme="Glass">
                        <ClientSideEvents Click=" function( s ,e ){FullSearch_Click('pleintext');return false;}" />
                    </dx:ASPxButton>
                            </td>
                            <td>&nbsp;</td>
                            <td>
                                <dx:ASPxButton ID="btnClearFilter1" ClientInstanceName="btnClearFilter1" runat="server" AutoPostBack="false"
                                    Image-Url="~/images/Materials/clear.png" BackgroundImage-ImageUrl="~/images/spacer.gif" Border-BorderColor="#7EACB1" BackColor="Transparent" Theme="Glass" Image-Width="16px" Image-Height="16px">
                                    <ClientSideEvents Click=" function( s ,e ){$('#token-input').data('tokenInputObject').clear();ASPxClientEdit.ClearEditorsInContainerById(null);grdMaterialsFullText.PerformCallback('');return false;}" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="specParam">
                        <td>
                            <table style="width: 100%; display: none;" id="tabProp">
                                <tr>
                                    <td style="width: 100px;">
                                        <%= GlobalAPI.CommunUtility.getRessourceEntry("mnProperties", ressFilePath ) %> 
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbProperties" ClientIDMode="AutoID" ClientInstanceName="cmbProperties" runat="server" Theme="Glass" Width="100%" DataSourceID="SqlPropertiesDS"
                                            TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains">
                                        </dx:ASPxComboBox>
                                    </td>
                                    <td style="width: 100px;">
                                        <%= GlobalAPI.CommunUtility.getRessourceEntry("mnValueBetween", ressFilePath )%>
                                    </td>
                                    <td style="width: 100px;">
                                        <dx:ASPxTextBox ID="txtValeurInit" ClientIDMode="AutoID" ClientInstanceName="txtValeurInit" runat="server" Theme="Glass">
                                            <MaskSettings Mask="<0..999999999>.<000..999>" IncludeLiterals="DecimalSymbol" />
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidationGroup="groupprop">
                                                <RequiredField IsRequired="true" ErrorText="Ce champ est obligatoire!" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                    <td style="width: 10px;">
                                        <%= GlobalAPI.CommunUtility.getRessourceEntry("mnAnd", ressFilePath )%>
                                    </td>
                                    <td style="width: 100px;">
                                        <dx:ASPxTextBox ID="txtValeurEnd" ClientIDMode="AutoID" ClientInstanceName="txtValeurEnd" runat="server" Theme="Glass">
                                            <MaskSettings Mask="<0..999999999>.<000..999>" IncludeLiterals="DecimalSymbol" />
                                            <ValidationSettings ErrorDisplayMode="ImageWithTooltip" ValidationGroup="groupprop">
                                                <RequiredField IsRequired="true" ErrorText="Ce champ est obligatoire!" />
                                            </ValidationSettings>
                                        </dx:ASPxTextBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td></td>
                    </tr>
            <tr>
                <td colspan="3" align="right">
                    
                </td>
            </tr>
                </table>
    </div>
    <div style="padding-top: 5px;">
        <table id="header_filter2" class="xPane_header_collapsed">
            <tr>
                <td style="width: 16px;">
                    <img id="img2" width="16px" height="16px" src="..\..\images\Materials\down.png" style="cursor: hand; cursor: pointer;" onclick="SetSearchPaneVisibility(2);"></td>
                <td>
                    <dx:ASPxLabel ID="lblFilter2" runat="server" Font-Bold="True" Theme="Default"></dx:ASPxLabel>
                </td>
            </tr>
        </table>
    </div>
    <div id="div_filter2" style="font-family:Tahoma;font-size:12px;border: 1px Solid #7EACB1;display: none;">            
        <table style="width:100%;padding:5px;">
                    <tr>
                        <td class="td_label">
                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblDiscipline", ressFilePath)%>
                        </td>
                        <td>
                            <dx:ASPxComboBox ID="cmbDiscipline" runat="server" Theme="Glass" Width="100%" DataSourceID="SqlDisciplineDS"
                                TextField="Designation" ValueField="Abreviation" IncrementalFilteringMode="Contains">
                                <ClientSideEvents ValueChanged="function(s, e) {treeList.PerformCallback();}"></ClientSideEvents>
                            </dx:ASPxComboBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td class="td_label">
                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblFamille", ressFilePath)%>
                        </td>
                        <td class="td_label">
                            <dx:ASPxDropDownEdit ID="DropDownEdit" runat="server" Width="100%" ClientInstanceName="DropDownEdit"
                                AllowUserInput="False" EnableAnimation="False" Theme="Glass" DropDownWindowHeight="200px">
                                <DropDownWindowStyle>
                                    <Border BorderWidth="0px" />
                                </DropDownWindowStyle>
                                <DropDownWindowTemplate>
                                   <div style="height: 200px; overflow: scroll;">
                                    <dxtl:ASPxTreeList ID="treeList" runat="server" Theme="Glass" Width="100%" ClientInstanceName="treeList"
                                        AutoGenerateColumns="False" DataSourceID="SqlMaterialsSpecificationDS" EnableTheming="True" KeyFieldName="ID"
                                        ParentFieldName="Id_Parent" OnCustomCallback="treeList_CustomCallback" OnCustomJSProperties="treeList_CustomJSProperties" Height="300">
                                        <SettingsBehavior AllowFocusedNode="true" />
                                        <Columns>
                                            <dxtl:TreeListDataColumn Caption="Description" FieldName="Designation">
                                            </dxtl:TreeListDataColumn>
                                        </Columns>
                                        <ClientSideEvents Init="treaListInitHandler" NodeClick="RowClickHandler" />
                                    </dxtl:ASPxTreeList>
                                    </div>
                                    <table style="width: 100%">
                                        <tr>
                                            <td align="right">
                                                <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Fermer" Theme="Glass">
                                                    <ClientSideEvents Click="function(s, e){ DropDownEdit.HideDropDown(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                </DropDownWindowTemplate>
                                <ClientSideEvents DropDown="DropDownHandler" />
                            </dx:ASPxDropDownEdit>
                        </td>
                    </tr>
                    <tr>
                        <td class="td_label">
                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblNorm", ressFilePath)%>
                        </td>
                        <td>
                            <dx:ASPxDropDownEdit ID="DropDownEditNorm" runat="server" Width="100%" ClientInstanceName="DropDownEditNorm"
                                AllowUserInput="False" EnableAnimation="False" Theme="Glass" DropDownWindowHeight="200px">
                                <DropDownWindowStyle>
                                    <Border BorderWidth="0px" />
                                </DropDownWindowStyle>
                                <DropDownWindowTemplate>
                                <div style="height: 200px; overflow: scroll;">
                                    <dxtl:ASPxTreeList ID="treeListNorm" runat="server" Theme="Glass" Width="100%" ClientInstanceName="treeListNorm"
                                        AutoGenerateColumns="False" DataSourceID="SqlNormFamiliesDS" EnableTheming="True" KeyFieldName="ID"
                                        ParentFieldName="ParentID" OnCustomCallback="treeListNorm_CustomCallback" OnCustomJSProperties="treeListNorm_CustomJSProperties">
                                        <SettingsBehavior AllowFocusedNode="true" />
                                        <Columns>
                                            <dxtl:TreeListTextColumn FieldName="Designation" ReadOnly="True" VisibleIndex="0">
                                            </dxtl:TreeListTextColumn>
                                        </Columns>                                        
                                        <ClientSideEvents Init="treaListInitHandlerNorm" NodeClick="RowClickHandlerNorm"  />
                                    </dxtl:ASPxTreeList>
                                    </div>
                                    <table style="width: 100%">
                                        <tr>
                                            <td align="right">
                                                <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Fermer" Theme="Glass">
                                                    <ClientSideEvents Click="function(s, e){ DropDownEditNorm.HideDropDown(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>
                                </DropDownWindowTemplate>
                                <ClientSideEvents DropDown="DropDownHandlerNorm" />
                            </dx:ASPxDropDownEdit>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <table>
                                <tr>
                                    <td>
                                        <dx:ASPxButton ID="btnFilterSpec" ClientInstanceName="btnFilterSpec" runat="server" Text="" ToolTip="Rechercher" AutoPostBack="false"
                                            Image-Url="~/images/SearchCrawler_16px.gif" BackgroundImage-ImageUrl="~/images/spacer.gif" Border-BorderColor="#7EACB1" BackColor="Transparent" Theme="Glass">
                                            <ClientSideEvents Click=" function( s ,e ){Search_Click('spec');return false;}" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>
                                        <dx:ASPxButton ID="btnClearFilter2" ClientInstanceName="btnClearFilter2" runat="server" AutoPostBack="false"
                                            Image-Url="~/images/Materials/clear.png" BackgroundImage-ImageUrl="~/images/spacer.gif" Border-BorderColor="#7EACB1" BackColor="Transparent" Theme="Glass" Image-Width="16px" Image-Height="16px">
                                            <ClientSideEvents Click=" function( s ,e ){ASPxClientEdit.ClearEditorsInContainerById(null);grdMaterials.PerformCallback('');return false;}" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
    </div>
<div style="padding-top: 5px;">
        <table id="header_filter3" class="xPane_header_collapsed">
            <tr>
                <td style="width: 16px;">
                    <img id="img3" width="16px" height="16px" src="..\..\images\Materials\down.png" style="cursor: hand; cursor: pointer;" onclick="SetSearchPaneVisibility(3);"></td>
                <td>
                    <dx:ASPxLabel ID="lblFilter3" runat="server" Font-Bold="True" Theme="Default"></dx:ASPxLabel>
                </td>
            </tr>
        </table>
    </div>
    <div id="div_filter3" style="font-family:Tahoma;font-size:12px;border: 1px Solid #7EACB1;display: none;">            
        <table style="width:100%;padding:5px;">
                    <tr>
                        <td class="td_label">
                            <%= DotNetNuke.Services.Localization.Localization.GetString("hSupplier", ressFilePath)%>
                        </td>
                        <td>
                            <dx:ASPxComboBox ID="cmbSuppliers" runat="server" Theme="Glass" Width="100%" DataSourceID="sqlTypeContact"
                                TextField="ContactName" ValueField="ContactID" IncrementalFilteringMode="Contains">
                            </dx:ASPxComboBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td class="td_label">
                            <%= DotNetNuke.Services.Localization.Localization.GetString("mnBrand", ressFilePath)%>
                        </td>
                        <td>
                            <dx:ASPxComboBox ID="cmbBrands" runat="server" Theme="Glass" Width="100%" DataSourceID="sqlBrandDS"
                                TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains">
                            </dx:ASPxComboBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <table>
                                <tr>
                                    <td>
                                        <dx:ASPxButton ID="btnFilter3" ClientInstanceName="btnFilter3" runat="server" Text="" ToolTip="Rechercher" AutoPostBack="false"
                                            Image-Url="~/images/SearchCrawler_16px.gif" BackgroundImage-ImageUrl="~/images/spacer.gif" Border-BorderColor="#7EACB1" BackColor="Transparent" Theme="Glass">
                                            <ClientSideEvents Click=" function( s ,e ){Search_Click('supp'); return false;}" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>
                                        <dx:ASPxButton ID="btnClearFilter3" ClientInstanceName="btnClearFilter3" runat="server" AutoPostBack="false"
                                            Image-Url="~/images/Materials/clear.png" BackgroundImage-ImageUrl="~/images/spacer.gif" Border-BorderColor="#7EACB1" BackColor="Transparent" Theme="Glass" Image-Width="16px" Image-Height="16px">
                                            <ClientSideEvents Click=" function( s ,e ){ASPxClientEdit.ClearEditorsInContainerById(null);grdMaterials.PerformCallback('');return false;}" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
    </div>
    <div style="padding-top: 5px;" align="right">
              <dx:ASPxGridView ID="grdMaterials" runat="server" ClientIDMode="AutoID" ClientInstanceName="grdMaterials" Theme="Glass" Width="100%"
    OnCustomCallback="grdMaterials_CustomCallback" DataSourceID="LinqSearchFullTextDS" KeyFieldName="ID" AutoGenerateColumns="False" ClientVisible="false">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="Code" VisibleIndex="0" Width="150px" SortOrder=Ascending>
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
             
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Nom" VisibleIndex="1" Width="200px">
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Name="Specification" FieldName="Materials_MaterialsSpecifications.Designation" VisibleIndex="2">
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
        </dx:GridViewDataTextColumn>
        
    </Columns>
    <ClientSideEvents  ContextMenu="function(s, e) {
                                                mnMaterialsActions.ShowAtPos(ASPxClientUtils.GetEventX(e.htmlEvent), ASPxClientUtils.GetEventY(e.htmlEvent));
                                                }" Init="function(s, e) { var popup = window.parent; popup.window['grdMaterials'] = grdMaterials; }"/>
    <SettingsPager Mode="ShowPager" PageSize="20">
        <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
    </SettingsPager>
    <Settings ShowTitlePanel="true" ShowFilterRow="True" ShowGroupPanel="True" VerticalScrollBarMode="Visible" VerticalScrollableHeight="380" ShowFooter="True"></Settings>
    <TotalSummary>
        <dx:ASPxSummaryItem FieldName="Materials_MaterialsSpecifications.Designation" SummaryType="Count" DisplayFormat="{0}" />
    </TotalSummary>
    <Styles Footer-Font-Bold="true" Footer-HorizontalAlign="Right"></Styles>
    <SettingsBehavior AllowFocusedRow="true" />
</dx:ASPxGridView>
    </div>
<dx:ASPxGridView ID="grdMaterialsFullText" runat="server" ClientIDMode="AutoID" ClientInstanceName="grdMaterialsFullText" Theme="Glass" Width="100%"
    OnCustomCallback="grdMaterialsFullText_CustomCallback" DataSourceID="SqlSearchMaterialsDS" KeyFieldName="ID" AutoGenerateColumns="False">
    <Columns>
        <dx:GridViewDataTextColumn FieldName="Code" VisibleIndex="0" Width="150px">
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
            <DataItemTemplate>                
                <a href="javascript:PrintART(DxWinPopup, 800 , 550 , <%# Eval("ID") %> , '<%# Eval("Code") %>'  );"> <%# Eval("Code") %> </a>
            </DataItemTemplate>
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Nom" VisibleIndex="1" Width="200px">
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Description" VisibleIndex="2">
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Name="Specification" FieldName="ID_MaterialsSpecifications" VisibleIndex="2">
            <Settings AutoFilterCondition="Contains" FilterMode="DisplayText" />
            <DataItemTemplate>
                <%# GlobalAPI.SpecificationController.GetSpecificationById(Int32.Parse(Eval("ID_MaterialsSpecifications").ToString()),System.Threading.Thread.CurrentThread.CurrentCulture.Name).Designation  %>                
            </DataItemTemplate>
            <CellStyle HorizontalAlign="Left"></CellStyle>
        </dx:GridViewDataTextColumn>        
    </Columns>
    <ClientSideEvents  ContextMenu="function(s, e) {
                                                mnMaterialsActions.ShowAtPos(ASPxClientUtils.GetEventX(e.htmlEvent), ASPxClientUtils.GetEventY(e.htmlEvent));
                                                }" Init="function(s, e) { var popup = window.parent; popup.window['grdMaterialsFullText'] = grdMaterialsFullText; }"/>
    <SettingsPager Mode="ShowPager" PageSize="20">
        <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
    </SettingsPager>
    <Settings ShowTitlePanel="true" ShowFilterRow="True" ShowGroupPanel="True" VerticalScrollBarMode="Visible" VerticalScrollableHeight="380" ShowFooter="True"></Settings>
  
    <Styles Footer-Font-Bold="true" Footer-HorizontalAlign="Right"></Styles>
    <SettingsBehavior AllowFocusedRow="true" />
</dx:ASPxGridView>

<asp:SqlDataSource ID="SqlDisciplineDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetAllInUseDisciplines"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
    <SelectParameters>        
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlSearchMaterialsDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_SearchFullText"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>" OnSelecting="SqlSearchMaterialsDS_Selecting">
    <SelectParameters>
        <asp:SessionParameter Name="SearchText" SessionField="SearchText" Type="String" />
        <asp:SessionParameter Name="PropertyId" SessionField="PropertiesID" Type="String" />
        <asp:ControlParameter Name="MinValue" ControlID="txtValeurInit" PropertyName="Text" />
        <asp:ControlParameter Name="MaxValue" ControlID="txtValeurEnd" PropertyName="Text" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlMaterialsSpecificationDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetMaterialsSpecificationsByDiscipline">
    <SelectParameters>
        <asp:SessionParameter SessionField="ID_Discipline" Name="ID_Discipline" Type="String" />
        <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="SqlPropertiesDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetAllProperties">
    <SelectParameters>
        <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlNormFamiliesDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetNormByFamilies"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="ID_MaterialsSpecification" SessionField="SpecID" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>


<cc1:LinqServerModeDataSource ID="LinqSearchFullTextDS" ContextTypeName="DataLayer.MaterialsDataContext" OnSelecting="LinqSearchFullTextDS_Selecting" runat="server" />


<dx:ASPxPopupControl ID="popupCtrl" runat="server" AllowDragging="True" AllowResize="True"
    
    EnableViewState="False" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="False" Width="800px" Height="500px" 
    HeaderText="" ClientInstanceName="popupCtrl" EnableHierarchyRecreation="True" Theme="Glass" ShowPinButton="True" ShowRefreshButton="True" ShowCollapseButton="True" ShowMaximizeButton="True" Modal="true">

    <clientsideevents closeup="function(s, e) {grdParam.PerformCallback();}"></clientsideevents>

    <contentstyle>
            
<Paddings Padding="0px"></Paddings>
        
</contentstyle>

    <contentcollection>
<dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" SupportsDisabledAttribute="True"></dx:PopupControlContentControl>
</contentcollection>
</dx:ASPxPopupControl>
<div style="text-align:center;display:none;">
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
                    <td class="buttonCell">
                        &nbsp;</td>
                    <td class="buttonCell">
                        &nbsp;</td>
                </tr>
            </table>
        </div>
<dxwgv:ASPxGridViewExporter runat="server" GridViewID="grdMaterials" ID="gridExport"></dxwgv:ASPxGridViewExporter>
<dx:ASPxPopupMenu ID="mnMaterialsActions" runat="server" 
    ClientInstanceName="mnMaterialsActions"  
    Theme="Glass" GutterWidth="0px"  
    SeparatorColor="#7EACB1">
    <Items>                               
        <dx:MenuItem Name="New" ClientVisible="false" Text="Duppliquer article" >
            <Image Url="~/images/Materials/duplicate-icon.png"  Width="16px" Height="16px"/>
        </dx:MenuItem>
        <dx:MenuItem Name="Edit" Text="Modifier article">
            <Image Url="~/images/edit.gif"   Width="16px" Height="16px" />
        </dx:MenuItem>
        <dx:MenuItem Name="EditProperties" Text="Modifier les propriétés">
            <Image Url="~/images/edit.gif"  Width="16px" Height="16px"  />
        </dx:MenuItem>      
        <dx:MenuItem Name="Delete" Text="Supprimer article">
            <Image Url="~/images/delete.gif"  Width="16px" Height="16px"  />
        </dx:MenuItem>                                  
        <dx:MenuItem Name="Details" Text="Details article">
            <Image Url="~/images/Blue-Info.gif"  Width="16px" Height="16px"  />
        </dx:MenuItem> 
        <dx:MenuItem Name="Validate" Text="Valider article">
            <Image Url="~/images/Materials/check.png"  Width="16px" Height="16px"  />
        </dx:MenuItem> 
    </Items>
    <ItemStyle ImageSpacing="5px" Font-Bold="true" Font-Size="11px" />
    <SubMenuStyle BackColor="#EDF3F4" GutterWidth="0px" SeparatorColor="#7EACB1" />      
    <ClientSideEvents ItemClick="function(s, e) {MaterialsMenuItemClick(e);}" />     
    <SubMenuItemImage Height="7px" Width="7px" />
</dx:ASPxPopupMenu>
<asp:SqlDataSource ID="sqlTypeContact" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetMaterialsAndSuppliers" SelectCommandType="StoredProcedure" >
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlBrandDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllBrands" SelectCommandType="StoredProcedure" >
    <SelectParameters>
        <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
