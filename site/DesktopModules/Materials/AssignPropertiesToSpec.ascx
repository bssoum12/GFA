<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AssignPropertiesToSpec.ascx.cs" Inherits="VD.Modules.Materials.AssignPropertiesToSpec" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>



<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>
<popupWin:popupWin ID="popupWin" runat="server" />
<localizeModule:localizeModule ID="localModule" runat="server" />
<script type="text/javascript" src="Helper.js"></script>
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

<script type="text/javascript" lang="javascript">
    var matSpecFilterMsg = '<%=GlobalAPI.CommunUtility.getRessourceEntry("lbMatSpecFilterMsg", ressFilePath )%>';
    var noSpecSelected = '<%=GlobalAPI.CommunUtility.getRessourceEntry("MsgAlert", ressFilePath )%>';

    function AddSpecToProperties() {
        if (tlSpec.GetVisibleSelectedNodeKeys() == '') {
            alert(noSpecSelected);
            return;
        }
        callback_AssignSpecToProperties.PerformCallback(tlSpec.GetFocusedNodeKey());
    }

    function tlMatSpecToProperties_Callback(e) {
        tlSpec.PerformCallback(e)
    }

    function refreshgrdProperties(focusedVal) {
        grdProperties.PerformCallback('refresh;' + focusedVal[0]);
        ddeSupplier.SetText(focusedVal[1]);
        ddeSupplier.HideDropDown();
    }

    function filterMatSpecTree(nodeKey) {
        if (nodeKey == null) {
            alert(matSpecFilterMsg);
            return;
        }
        //Select node by filter
        tlSpec.PerformCallback('FilterTree;' + nodeKey);
        //Update dropdown Spec text
        ddeSpec.SetText(cmbFilterSpec.GetText());
        //Select Supplier by spec
        grdProperties.PerformCallback('refreshSelection;' + nodeKey);
        ddeSpec.HideDropDown();
    }

    function SelectOneNode(s, e) {
        if (s.GetVisibleSelectedNodeKeys() == '') {
            //if no node is selected set dropdown text to nothing
            ddeSpec.SetText('');
            ddeSpec.HideDropDown();
        } else {

            //Select only one node
            var selectedNodes = s.GetVisibleSelectedNodeKeys();
            for (var i = 0; i < selectedNodes.length; i++) {
                if (selectedNodes[i] != s.GetFocusedNodeKey()) {
                    s.SelectNode(selectedNodes[i], false);
                }
            }
            s.GetNodeValues(s.GetFocusedNodeKey(), 'Designation', refreshDDESpec);
            //Select Supplier by spec
            grdProperties.PerformCallback('refreshSelection;' + s.GetFocusedNodeKey());
        }
    }

    function refreshDDESpec(e) {
        //Update dropdown Spec text
        ddeSpec.SetText(e);
    }

    function RefreshTreeGrpProperties() {
        //tlProtertiesGrp.PerformCallback();
    }

    function ShowPopSpecMgr() {
        oldPopup("LoadControl.aspx?ctrl=Materials/ManageSpec.ascx", 600, 600, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbSpecificationMgr", ressFilePath)%>');
    }


    function ShowPupAddNewPropertyGrp() {
        oldPopup("LoadControl.aspx?ctrl=Materials/Param_GroupProperties.ascx", 500, 600, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbGroupPropertiesMgr", ressFilePath)%>');
    }

    function ShowPupAddNewProperty() {
        oldPopup("LoadControl.aspx?ctrl=Materials/Param_Properties.ascx", 500, 600, '<%= DotNetNuke.Services.Localization.Localization.GetString("tProperties", ressFilePath)%>');
    }

    function RefreshGrdProperties() {
        grdProperties.PerformCallback();
    }

    function oldPopup(url, height, width, title) {
        popupWind.SetSize(width, height);
        popupWind.SetHeaderText(title);
        var protocal = 'http';
        if (document.location.href.toString().indexOf('https') == 0)
            protocal = 'https';

        if (url.toString().indexOf('?') == -1)
            popupWind.SetContentUrl(protocal + "://<%=_portalAlias %>/DesktopModules/Materials/" + url + "?lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>");
        else
            popupWind.SetContentUrl(protocal + "://<%=_portalAlias %>/DesktopModules/Materials/" + url + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>");
        popupWind.Show();
    }

</script>

<dx:ASPxCallbackPanel ID="callback_AssignSpecToProperties" ClientInstanceName="callback_AssignSpecToProperties" runat="server" Width="100%" Theme="Glass"
    OnCallback="callback_AssignSpecToProperties_Callback">
    <PanelCollection>
        <dx:PanelContent ID="callbackPC">
            <dx:ASPxHiddenField ID="hfAlertMsg" ClientInstanceName="hfAlertMsg" runat="server">
            </dx:ASPxHiddenField>
            <div>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 33%">
                            <dx:ASPxLabel ID="lblDisciplineUI" runat="server" Theme="Glass" Width="100%">
                            </dx:ASPxLabel>
                            <dx:ASPxComboBox ID="cmbDiscipline" runat="server" ValueField="Abreviation" TextField="Designation"
                                DataSourceID="sqlDiscipline" ValueType="System.String" Theme="Glass" Width="100%" IncrementalFilteringMode="Contains"
                                OnDataBound="cmbDiscipline_DataBound" SelectedIndex="-1">
                                <ClientSideEvents ValueChanged="function(s,e){
                                        ddeSpec.SetText('');
                                        tlMatSpecToProperties_Callback(s.GetValue());
                                        grdProperties.PerformCallback('Init;');
                                    }" />
                            </dx:ASPxComboBox>
                        </td>
                        <td style="width: 33%">
                            <dx:ASPxLabel ID="lblSpecUI" runat="server" Theme="Glass" Width="100%">
                            </dx:ASPxLabel>
                            <dx:ASPxDropDownEdit ID="ddeSpec" ClientInstanceName="ddeSpec" runat="server" AutoResizeWithContainer="true"
                                Width="100%" Theme="Glass" DropDownWindowWidth="500">
                                <DropDownWindowStyle VerticalAlign="Top">
                                </DropDownWindowStyle>
                                <DropDownWindowTemplate>
                                    <div>
                                        <table style="width: 100%">
                                            <tr style="vertical-align: top;">
                                                <td>
                                                    <dx:ASPxComboBox ID="cmbFilterSpec" ClientInstanceName="cmbFilterSpec" runat="server" DataSourceID="sqlFilterSpec" ValueField="ID" Width="100%"
                                                        TextField="Designation" ValueType="System.String" Theme="Glass" IncrementalFilteringMode="Contains"
                                                        DropDownButton-Visible="False" DropDownStyle="DropDown">
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxImage ID="img" runat="server" Width="16px" Height="16px"
                                                        ImageUrl="~/images/Materials/action_source.gif">
                                                        <ClientSideEvents Click="function(s,e){filterMatSpecTree(cmbFilterSpec.GetValue());}" />
                                                    </dx:ASPxImage>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <dx:ASPxTreeList ID="tlSpec" ClientInstanceName="tlSpec" runat="server" Width="98%" Height="380px" DataSourceID="sqlMatSpec" KeyFieldName="ID"
                                                        ParentFieldName="Id_Parent" Theme="Glass" AutoGenerateColumns="False" BackColor="White" SettingsBehavior-AllowDragDrop="False"
                                                        OnCustomCallback="tlSpec_CustomCallback" OnDataBound="tlSpec_DataBound" SettingsBehavior-AllowFocusedNode="False">
                                                        <Columns>
                                                            <dx:TreeListTextColumn FieldName="ID" Visible="false">
                                                            </dx:TreeListTextColumn>
                                                            <dx:TreeListTextColumn FieldName="Id_Parent" Visible="false">
                                                            </dx:TreeListTextColumn>
                                                            <dx:TreeListTextColumn FieldName="Designation">
                                                            </dx:TreeListTextColumn>
                                                        </Columns>
                                                        <ClientSideEvents Init="function(s, e) { var popup = window.parent; 
                                                        popup.window['tlSpec'] = tlSpec;}"
                                                            SelectionChanged="function(s, e){SelectOneNode(s, e);
                                                                                            ddeSpec.HideDropDown();}" />
                                                        <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="true" GridLines="None"
                                                            ShowColumnHeaders="false" VerticalScrollBarMode="Visible" ScrollableHeight="350" />
                                                        <SettingsBehavior AllowFocusedNode="true" ExpandCollapseAction="NodeDblClick"
                                                            AutoExpandAllNodes="True" FocusNodeOnExpandButtonClick="true" />
                                                        <SettingsSelection AllowSelectAll="false" Recursive="false" Enabled="true" />
                                                    </dx:ASPxTreeList>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </DropDownWindowTemplate>
                            </dx:ASPxDropDownEdit>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%">
                    <tr>
                        <td style="width: 100%; height: 100%;">
                            <dx:ASPxSplitter ID="spProperties_Group" runat="server" Theme="Glass" Width="100%" Height="420" ClientInstanceName="spProperties_Group" SeparatorVisible="false">
                                <Panes>
                                    <dx:SplitterPane Name="pGroups" Collapsed="true">
                                        <ContentCollection>
                                            <dx:SplitterContentControl ID="SplitterContentControlPropertiesGroup"  runat="server">                                               
                                                                                             
                                            </dx:SplitterContentControl>
                                        </ContentCollection>
                                    </dx:SplitterPane>
                                    <dx:SplitterPane>
                                        <ContentCollection>
                                            <dx:SplitterContentControl ID="SplitterContentControlProperties" runat="server">                                                                                            
                                                <dx:ASPxGridView ID="grdProperties" ClientInstanceName="grdProperties" runat="server"
                                                    Theme="Glass" Width="100%" DataSourceID="sqlGetProperties" KeyFieldName="ID"
                                                    AutoGenerateColumns="false" OnCustomCallback="grdProperties_CustomCallback"
                                                    SettingsBehavior-EnableRowHotTrack="True" Settings-ShowFilterBar="Hidden" Settings-ShowHeaderFilterButton="true">
                                                    <Columns>
                                                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" Width="30" ShowClearFilterButton="true">
                                                        </dx:GridViewCommandColumn>
                                                        <dx:GridViewDataTextColumn FieldName="ID" Visible="false">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="Designation" VisibleIndex="1">
                                                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn FieldName="GroupDesignation" Caption="Groupe de propriétés" VisibleIndex="3" Visible="true" Settings-AllowAutoFilter="True" Settings-AutoFilterCondition="Contains">                                                     
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                    <SettingsBehavior EnableRowHotTrack="True"></SettingsBehavior>
                                                    <SettingsPager Mode="ShowPager" PageSize="13">
                                                        <PageSizeItemSettings ShowAllItem="True" Visible="true">
                                                        </PageSizeItemSettings>
                                                    </SettingsPager>
                                                    <Settings VerticalScrollableHeight="320" VerticalScrollBarMode="Visible" ShowGroupPanel="false" ShowFilterRow="True"></Settings>
                                                </dx:ASPxGridView>                                                              
                                                <table style="display:none;width: 100%;font-family:Tahoma;font-size:11px;" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                        <td style="width: 150px;">
                                                            <%=GlobalAPI.CommunUtility.getRessourceEntry("lbShowAllProperties", ressFilePath )%>
                                                        </td>
                                                        <td style="width: 20px;">
                                                                <dx:ASPxCheckBox ID="chkAllItems" ClientInstanceName="chkAllItems" runat="server" Theme="Glass" Checked="true" Width="100%" ClientEnabled="false">
                                                                <ClientSideEvents CheckedChanged="function(s,e){ if(s.GetChecked()){ var pane = spProperties_Group.GetPaneByName('pGroups'); pane.Collapse(pane);/*tlProtertiesGrp.SetFocusedNodeKey('');*/ grdProperties.PerformCallback('-1');}else{var pane = spProperties_Group.GetPaneByName('pGroups'); pane.Expand(pane);/*tlProtertiesGrp.SetFocusedNodeKey('');*/ grdProperties.PerformCallback('');}}" />                                                               
                                                            </dx:ASPxCheckBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:SplitterContentControl>
                                        </ContentCollection>
                                    </dx:SplitterPane>
                                </Panes>
                            </dx:ASPxSplitter>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table style="width: 100%;">
                    <tr>
                        <td align="left">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/Materials/spec-icon.png" Width="16px" />
                                    </td>
                                    <td style="padding-right: 10px;">
                                        <a class="btnGlassLink"  href="javascript:ShowPopSpecMgr();"><%= DotNetNuke.Services.Localization.Localization.GetString("hSpecifications", ressFilePath)%></a>
                                    </td>
                                    <td>
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/Materials/properties_groups16x16.png" Width="16px" />
                                    </td>
                                    <td style="padding-right: 10px;">
                                        <a class="btnGlassLink"  href="javascript:ShowPupAddNewPropertyGrp();"><%= DotNetNuke.Services.Localization.Localization.GetString("hGrpProperties", ressFilePath)%></a>
                                    </td>
                                    <td>
                                        <asp:Image ID="Image3" runat="server" ImageUrl="~/images/Materials/properties-icons32x32.png" Width="16px" />
                                    </td>
                                    <td style="padding-right: 10px;">
                                        <a class="btnGlassLink"  href="javascript:ShowPupAddNewProperty();"><%= DotNetNuke.Services.Localization.Localization.GetString("hProperties", ressFilePath)%></a>
                                    </td>
                                    <td>&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td align="right">
                            <table>
                                <tr>
                                    <td>
                                        <dx:ASPxButton ID="btnApply" runat="server" Theme="Glass" AutoPostBack="false">
                                            <ClientSideEvents Click="function(s,e){AddSpecToProperties();}" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td>
                                        <dx:ASPxButton ID="btnCloseWin" runat="server" Theme="Glass">
                                            <ClientSideEvents Click="function(s,e){
                                                if(window.parent.popupWind)
                                                    window.parent.popupWind.Hide();
                                                if(window.parent.dnnModal)
                                                    window.parent.dnnModal.load();
                                                }" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </dx:PanelContent>
    </PanelCollection>
    <ClientSideEvents EndCallback="function(s,e){
        lblAlertMsg.SetText(hfAlertMsg.Get('lblAlertMsg'));
        pupAssignSpecToProperties.Show();}" />
</dx:ASPxCallbackPanel>

<dx:ASPxPopupControl ID="pupAssignSpecToProperties" ClientInstanceName="pupAssignSpecToProperties" runat="server" Theme="Glass" Modal="true" ShowShadow="true"
    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True" Width="420px">
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <ContentCollection>
        <dx:PopupControlContentControl ID="pupCCAssignSpecToSupplier" runat="server">
            <div>
                <table style="width: 100%;">
                    <tr>
                        <td>
                            <dx:ASPxLabel ID="lblAlertMsg" ClientInstanceName="lblAlertMsg" Theme="Glass" runat="server"
                                Font-Bold="false" Font-Size="Medium">
                            </dx:ASPxLabel>
                        </td>
                    </tr>
                </table>
                <table style="width: 100%;">
                    <tr style="text-align: right;">
                        <td>
                            <table style="width: 100%;">
                                <tr>
                                    <td align="right">
                                        <dx:ASPxButton ID="btnClose" runat="server" Theme="Glass">
                                            <ClientSideEvents Click="function(s,e){pupAssignSpecToProperties.Hide();}" />
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

<asp:SqlDataSource ID="sqlDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="SELECT [Designation], [Abreviation] FROM [Discipline]">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlMatSpec" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_MaterialsSpecification_SelectByDiscipline" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Id_Discipline" SessionField="Id_Discipline" DbType="String" DefaultValue="all" />
        <asp:SessionParameter Name="lang" SessionField="lang" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlFilterSpec" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetLastNodesMatSpec" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Id_Discipline" SessionField="Id_Discipline" DbType="String" DefaultValue="all" />
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="sqlGetPropertiesGroup" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesGroup"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />        
        <asp:Parameter Name="NonAssignedTrad" DefaultValue="(Non affectés)" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlGetProperties" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesByGroup"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="lang" Type="String" />
        <asp:Parameter Name="GroupId" Type="Int32" DefaultValue="-1" />
    </SelectParameters>
</asp:SqlDataSource>
<script type="text/javascript">
    window.onload = new function () {
        var k = getQueryString('specid', window.document.location.href);
        if (k != '') {
            grdProperties.PerformCallback('refreshSelection;' + k);
        };
        //chkAllItems.SetChecked(true);
        //if (chkAllItems.GetChecked()) {
            //var pane = spProperties_Group.GetPaneByName('pGroups');
            //pane.Collapse(pane); tlProtertiesGrp.SetFocusedNodeKey('');
            //grdProperties.PerformCallback('-1')
        //}
        //grdProperties.PerformCallback('-1');
    }
</script>