<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AssignNormToSpec.ascx.cs" Inherits="VD.Modules.Materials.AssignNormToSpec" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>



<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>



<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>
<popupWin:popupWin ID="popupWin" runat="server" />
<localizeModule:localizeModule ID="localModule" runat="server" />

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
        callback_AssignSpecToNormes.PerformCallback(tlSpec.GetFocusedNodeKey());
    }

    function tlMatSpecToProperties_Callback(e) {
        tlSpec.PerformCallback(e)
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
        grdNormes.PerformCallback('refreshSelection;' + nodeKey);
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
            grdNormes.PerformCallback('refreshSelection;' + s.GetFocusedNodeKey());
        }
    }


    function refreshDDESpec(e) {
        //Update dropdown Spec text
        ddeSpec.SetText(e);
    }

    function ShowPopNormMgr() {
        oldPopup("LoadControl.aspx?ctrl=Materials/Param_Norm.ascx", 380, 600, '<%=GlobalAPI.CommunUtility.getRessourceEntry("tNorm", ressFilePath )%>');
    }

    function ShowPopSpecMgr() {
        oldPopup("LoadControl.aspx?ctrl=Materials/ManageSpec.ascx", 550, 420, '<%=GlobalAPI.CommunUtility.getRessourceEntry("lbSpecificationMgr", ressFilePath )%>');
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
<dx:ASPxCallbackPanel ID="callback_AssignSpecToNormes" ClientInstanceName="callback_AssignSpecToNormes" runat="server" Width="100%" Theme="Glass"
    OnCallback="callback_AssignSpecToNormes_Callback">
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
                                OnDataBound="cmbDiscipline_DataBound">
                                <ClientSideEvents ValueChanged="function(s,e){
                                        ddeSpec.SetText('');
                                        tlMatSpecToProperties_Callback(s.GetValue());
                                        grdNormes.PerformCallback('Init;');
                                    }"
                                  />
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
                                    <div >
                                        <table style="width: 100%">
                                            <tr style="vertical-align:top;">
                                                <td>
                                                    <dx:ASPxComboBox ID="cmbFilterSpec" ClientInstanceName="cmbFilterSpec" runat="server" DataSourceID="sqlFilterSpec" ValueField="ID"  Width="100%"
                                                        TextField="Designation" ValueType="System.String" Theme="Glass" IncrementalFilteringMode="Contains"  
                                                        DropDownButton-Visible="False" DropDownStyle="DropDown" >
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
                                                        OnCustomCallback="tlSpec_CustomCallback" OnDataBound="tlSpec_DataBound" >
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
                                                                                            ddeSpec.HideDropDown();}"/>
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
                            <dx:ASPxGridView ID="grdNormes" ClientInstanceName="grdNormes" runat="server"
                                Theme="Glass" Width="100%" DataSourceID="sqlNormes" KeyFieldName="ID"
                                AutoGenerateColumns="false" OnCustomCallback="grdNormes_CustomCallback" 
                                SettingsBehavior-EnableRowHotTrack="True" Settings-ShowFilterBar="Hidden" OnDataBound="grdNormes_DataBound">
                                <Columns>
                                    <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" Width="30">
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" Visible="false">
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="Designation" VisibleIndex="1">
                                        <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                                    </dx:GridViewDataTextColumn>
                                </Columns>
                                <SettingsBehavior EnableRowHotTrack="True"></SettingsBehavior>
                                <SettingsPager Mode="ShowAllRecords">
                                    <PageSizeItemSettings ShowAllItem="True"></PageSizeItemSettings>
                                </SettingsPager>
                                <Settings VerticalScrollableHeight="380" VerticalScrollBarMode="Visible" ShowGroupPanel="True" ShowFilterRow="True"></Settings>
                            </dx:ASPxGridView>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table style="width: 100%;">
                    <tr>
                        <td  align="left">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/Materials/normes.png" Width="16px" />
                                    </td>
                                    <td style="padding-right: 10px;">
                                        <a class="btnGlassLink"  href="javascript:ShowPopNormMgr();"><%= DotNetNuke.Services.Localization.Localization.GetString("mnNormes", ressFilePath)%></a>
                                    </td>
                                    <td>
                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/Materials/spec-icon.png" Width="16px" />
                                    </td>
                                    <td style="padding-right: 10px;">
                                        <a class="btnGlassLink" href="javascript:ShowPopSpecMgr();"><%= DotNetNuke.Services.Localization.Localization.GetString("hSpecifications", ressFilePath)%></a>
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
                                        <dx:ASPxButton ID="btnApply" runat="server" Theme="Glass" AutoPostBack="false" >
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
        pupAssignSpecToNormes.Show();}" />
</dx:ASPxCallbackPanel>

<%--popup alert--%>
<dx:ASPxPopupControl ID="pupAssignSpecToNormes" ClientInstanceName="pupAssignSpecToNormes" runat="server" Theme="Glass" Modal="true" ShowShadow="true"
    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True" Width="420px">
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <ContentCollection>
        <dx:PopupControlContentControl ID="pupCCAssignSpecToNormes" runat="server">
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
                                            <ClientSideEvents Click="function(s,e){pupAssignSpecToNormes.Hide();}" />
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

<%--DataSources--%>
<asp:SqlDataSource ID="sqlDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="SELECT [Designation], [Abreviation] FROM [Discipline]">
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlMatSpec" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_MaterialsSpecification_SelectByDiscipline" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Id_Discipline" SessionField="Id_Discipline" DbType="String" DefaultValue="all" />
        <asp:SessionParameter Name ="lang" SessionField="lang" Type ="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlFilterSpec" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetLastNodesMatSpec" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Id_Discipline" SessionField="Id_Discipline" DbType="String" DefaultValue="all" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlNormes" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetAllNorm"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name ="Locale" SessionField="lang" Type ="String" />
    </SelectParameters>
</asp:SqlDataSource>
