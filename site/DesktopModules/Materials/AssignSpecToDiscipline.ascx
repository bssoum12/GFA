<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AssignSpecToDiscipline.ascx.cs" Inherits="VD.Modules.Materials.AssignSpecToDiscipline" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register TagPrefix="token" TagName="token" Src="~/controls/TokenInputCtrl.ascx" %>
<token:token ID="tokenId" runat="server" datafrom="spec" />  

<style type="text/css">
    .treeNav
    {
        /*height: 380px;
        background-color: #D3E9F0;
        overflow: auto;
        border-style: inset;
        border-width: 2px;*/
    }

    
</style>

<script type="text/javascript">

    function tlMatSpecToDiscipline_Callback(e) {
        tlMatSpecToDiscipline.PerformCallback(e);
    }

    function assignSpecToDiscipline() {
        callback.PerformCallback();
    }

</script>

<dx:ASPxCallbackPanel ID="callback" ClientInstanceName="callback" runat="server" Width="100%" Theme="Glass" OnCallback="callback_Callback" >
    <ClientSideEvents EndCallback="function(s,e){
        lblAlertMsg.SetText(hiddenField.Get('lblAlertMsg'));
        pupAlert.Show();}" />
    <PanelCollection>
        <dx:PanelContent ID="callbackPC">
            <dx:ASPxHiddenField ID="hiddenField" ClientInstanceName="hiddenField" runat="server">
            </dx:ASPxHiddenField>
            <div>
                <table style="width:100%;">
                    <tr>
                        <td align="right">
                            <table>
                                <tr>
                                    <td>
                                        <dx:ASPxLabel ID="lblDisciplineUI" runat="server" Theme="Glass">
                                        </dx:ASPxLabel>
                                    </td>
                                    <td>
                                        <dx:ASPxComboBox ID="cmbDiscipline" runat="server" ValueField="Abreviation" TextField="Designation"
                                            DataSourceID="sqlDiscipline" ValueType="System.String" Theme="Glass" IncrementalFilteringMode="Contains" >
                                            <ClientSideEvents ValueChanged="function(s,e){
                                                tlMatSpecToDiscipline_Callback(s.GetValue());}" />
                                        </dx:ASPxComboBox>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                
            </div>
            <div class="treeNav">
                <table style="width:100%;border:1px solid #7EACB1;" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="text-align:right;border-bottom:1px solid #7EACB1;">
                            <table>
                                <tr>
                                    <td style="width:180px;">
                                        </td>
                                    <td style="width:100%;">
                                        <input type="text" autocomplete="off" style="outline: none; width: 100%;" id="token-input" size="50" />
                                    </td>
                                    <td style="width:80px;">
                                        <dx:ASPxButton ID="btnFilter" runat="server" OnClick="btnFilter_Click" Theme="Glass">
                                        </dx:ASPxButton>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <dx:ASPxTreeList ID="tlMatSpecToDiscipline" ClientInstanceName="tlMatSpecToDiscipline" runat="server" Width="100%" Height="380px" DataSourceID="sqlMatSpec" KeyFieldName="ID"
                                ParentFieldName="Id_Parent" Theme="Glass" AutoGenerateColumns="False" BackColor="White" SettingsBehavior-AllowDragDrop="False"
                                OnCustomCallback="tlMatSpecToDiscipline_CustomCallback">
                                <Columns>
                                    <dx:TreeListTextColumn FieldName="ID" Visible="false">
                                    </dx:TreeListTextColumn>
                                    <dx:TreeListTextColumn FieldName="Id_Parent" Visible="false">
                                    </dx:TreeListTextColumn>
                                    <dx:TreeListTextColumn FieldName="Designation">
                                    </dx:TreeListTextColumn>
                                </Columns>
                                <ClientSideEvents Init="function(s, e) { 
                                            var popup = window.parent; 
                                            popup.window['tlMatSpecToDiscipline'] = tlMatSpecToDiscipline; 
                                     }" />
                                <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="true" GridLines="None" VerticalScrollBarMode="Visible" ScrollableHeight="350" />
                                <SettingsBehavior AllowFocusedNode="true" ExpandCollapseAction="NodeDblClick"
                                    AutoExpandAllNodes="True" FocusNodeOnExpandButtonClick="true" />
                                <SettingsSelection AllowSelectAll="True" Enabled="True" Recursive="False" />
                            </dx:ASPxTreeList>
                        </td>
                    </tr>
                </table>
            </div>
            <div>
                <table style="width: 100%;">
                    <tr align="right">
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <dx:ASPxButton ID="btnApply" runat="server" Theme="Glass" AutoPostBack="false" >
                                            <ClientSideEvents Click="function(s,e){assignSpecToDiscipline();}" />
                                        </dx:ASPxButton>
                                    </td>
                                    <td>
                                        <dx:ASPxButton ID="btnCloseWin" runat="server" Theme="Glass">
                                            <ClientSideEvents Click="function(s,e){
                                            if(window.parent.popupWind){
                                                window.parent.popupWind.Hide();
                                            }
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
</dx:ASPxCallbackPanel>

<dx:ASPxPopupControl ID="pupAlert" ClientInstanceName="pupAlert" runat="server" Theme="Glass" Modal="true" ShowShadow="true"
    PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True" Width="420px">
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <ContentCollection>
        <dx:PopupControlContentControl runat="server">
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
                                            <ClientSideEvents Click="function(s,e){pupAlert.Hide();}" />
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
    SelectCommand="Framework_GetAllDisciplines" SelectCommandType="StoredProcedure">
        <SelectParameters>
        <asp:SessionParameter Name ="Locale" SessionField="lang" Type ="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlMatSpec" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_MaterialsSpecification_Select" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name ="lang" SessionField="lang" Type ="String" />
    </SelectParameters>
</asp:SqlDataSource>

