<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AssignSupplier.ascx.cs" Inherits="VD.Modules.Materials.AssignSupplierToSpec" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>

<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />

<script type="text/javascript" lang="javascript">

    function refreshGrdSupplier(focusedVal) {
        grdSupplier.PerformCallback('refresh;' + focusedVal[0]);
        ddeSupplier.SetText(focusedVal[1]);
        ddeSupplier.HideDropDown();
    }

    function hidePup() {
        if (window.parent.popupWind)
            window.parent.popupWind.Hide();
        if (window.parent.dnnModal)
            window.parent.dnnModal.load();
    }

</script>

<div>
    <dx:ASPxLabel ID="lblSpecUI" runat="server" Theme="Glass">
    </dx:ASPxLabel>
</div>
<div>
    
    <table style="width: 100%">
        <tr>
            <td style="width: 100%; height: 100%;">
                <dx:ASPxGridView ID="grdSupplier" ClientInstanceName="grdSupplier" runat="server"
                    Theme="Glass" Width="100%" DataSourceID="sqlContact" KeyFieldName="ContactID"
                    AutoGenerateColumns="false" OnCustomCallback="grdSupplier_CustomCallback" 
                    SettingsBehavior-EnableRowHotTrack="True" Settings-ShowFilterBar="Hidden">
                    <Columns>
                        <dx:GridViewCommandColumn ShowSelectCheckbox="True" VisibleIndex="0" Width="30">
                        </dx:GridViewCommandColumn>
                        <dx:GridViewDataTextColumn FieldName="ContactID" Visible="false">
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="ContactName" VisibleIndex="1">
                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="LibePays" VisibleIndex="2">
                            <Settings FilterMode="DisplayText" AutoFilterCondition="Contains" />
                        </dx:GridViewDataTextColumn>
                        
                    </Columns>
                    <SettingsBehavior EnableRowHotTrack="True"></SettingsBehavior>
                    <SettingsPager Mode="ShowAllRecords">
                        <PageSizeItemSettings ShowAllItem="True"></PageSizeItemSettings>
                    </SettingsPager>
                    <Settings VerticalScrollableHeight="380" VerticalScrollBarMode="Visible"  ShowFilterRow="True"></Settings>

                    <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                </dx:ASPxGridView>
            </td>
        </tr>
    </table>
</div>
<div>
    <table style="width:100%;">
        <tr align="right">
            <td>
                <table>
                    <tr>
                        <td>
                            <dx:ASPxButton ID="btnApply" runat="server" Theme="Glass" OnClick="btnApply_Click">
                            </dx:ASPxButton>
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnClose" runat="server" Theme="Glass">
                                <ClientSideEvents Click="function(s,e){hidePup();}" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

<asp:SqlDataSource ID="sqlTypeContact" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient"
    SelectCommand="EIFContactMgr_GetTypeContact"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="TypeContactID" DbType="Int32" DefaultValue="2" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="sqlContact" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="gTiers_ContactListByType"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="TypeContactID" SessionField="TypeContactID" Type="Int32" DefaultValue="2" />
    </SelectParameters>
</asp:SqlDataSource>
