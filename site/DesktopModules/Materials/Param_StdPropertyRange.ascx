<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_StdPropertyRange.ascx.cs" Inherits="VD.Modules.Materials.Param_StdPropertyRange" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>

<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="accModule" runat="server" />
<style type="text/css">
    .header
    {
        height: 20px;
        background-color: #e0e0e0;
    }

    .pageBorder
    {
        border: 1px solid #e0e0e0;
    }

    .btnRedLink
    {
        text-decoration: none;
        color: Red;
        font-weight: bold;
        font-family: Tahoma;
        font-size: 12px;
    }
</style>

<script lang="javascript" type="text/javascript" >
    function ParentCallback() {
        var parentWin = window.parent;
        if (parentWin.ReloadGrdProperty) parentWin.ReloadGrdProperty();
        parentWin.popupWind.Hide();
    }

    function SetDropDownEditPropertyGrpText(focusedVal) {
        ddePropertyGrp.SetText(focusedVal[1]);
        ddePropertyGrp.HideDropDown();
        cmbProp.PerformCallback(focusedVal[0]);
    }

</script>

<div class="pageBorder">
    <table style="width: 100%;">
        <tr>
            <td style="width:auto">
                <dx:ASPxLabel ID="lblPropGrp" runat="server" Theme="Glass" Width="120"></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxDropDownEdit ID="ddePropertyGrp" ClientInstanceName="ddePropertyGrp" runat="server" Width="200" Theme="Glass">
                    <DropDownWindowTemplate>
                        <dx:ASPxTreeList ID="tlProtertiesGrpMgr" ClientInstanceName="tlProtertiesGrpMgr" runat="server" Theme="Glass"
                            DataSourceID="sqlGetPropertiesGroup" ParentFieldName="ParentId" KeyFieldName="ID" Width="100%" 
                            OnDataBound="tlProtertiesGrpMgr_DataBound" OnLoad="tlProtertiesGrpMgr_Load">
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
                </dx:ASPxDropDownEdit>
            </td>
            <td style="width:auto">
                <dx:ASPxLabel ID="lblProp" runat="server" Theme="Glass" Width="120"></dx:ASPxLabel>
            </td>
            <td >
                <dx:ASPxComboBox ID="cmbProp" ClientInstanceName="cmbProp" runat="server" Width="200"
                    DataSourceID="sqlGetProperties" TextField="Designation" ValueField="ID"
                    ValueType="System.Int32" Theme="Glass" IncrementalFilteringMode="Contains" 
                    OnCallback="cmbProp_Callback">
                    <ClientSideEvents ValueChanged="function(s,e){cmbUnite.PerformCallback(s.GetValue());}"  />
                </dx:ASPxComboBox>
            </td>
        </tr>
        <tr>
            <td style="width:auto">
                <dx:ASPxLabel ID="lblMinVal" runat="server" Theme="Glass" Width="120"></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxTextBox ID="txtRefMinVal" runat="server" Width="200" Theme="Glass">
                    <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom">
                        <RegularExpression ValidationExpression="-?[0-9]+([.,][0-9]+)?([eE]-?[0-9]+)?( 10[eE]-?[0-9]+)?"  />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </td>
            <td style="width:auto">
                <dx:ASPxLabel ID="lblMaxVal" runat="server" Theme="Glass" Width="120"></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxTextBox ID="txtRefMaxVal" runat="server" Width="200" Theme="Glass">
                    <ValidationSettings Display="Dynamic" ErrorTextPosition="Bottom">
                        <RegularExpression ValidationExpression="-?[0-9]+([.,][0-9]+)?([eE]-?[0-9]+)?( 10[eE]-?[0-9]+)?" />
                    </ValidationSettings>
                </dx:ASPxTextBox>
            </td>
        </tr>
        <tr>
            
            <td style="width:auto">
                <dx:ASPxLabel ID="lblUnite" runat="server" Theme="Glass" Width="120"></dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxComboBox ID="cmbUnite" ClientInstanceName="cmbUnite" runat="server" Width="200"
                    DataSourceID="SqlMeasureUnit" ValueField="ID_UniteMeasure" TextField="Unit" OnCallback="cmbUnite_Callback"
                    ValueType="System.Int32" Theme="Glass" IncrementalFilteringMode="Contains" >
                </dx:ASPxComboBox>
            </td>
            <td algin="right" colspan="2">
                <dx:ASPxCheckBox ID="cbIsOptional" runat="server" Theme="Glass" ></dx:ASPxCheckBox>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <dx:ASPxLabel ID="lblHelp" runat="server" Theme="Glass" Font-Size="Smaller"></dx:ASPxLabel>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        </table>
    <table>
        <tr>
            <td style="width:100%;">&nbsp;
            </td>
            <td>
                <dx:ASPxButton ID="btnSubmit" runat="server" Theme="Glass" OnClick="btnSubmit_Click" Width="100">
                </dx:ASPxButton>
            </td>
            <td>
                <dx:ASPxButton ID="btnCancel" runat="server" Theme="Glass" Width="100">
                    <ClientSideEvents Click="function(s,e){
                        window.parent.popupWind.Hide();
                        }" />
                </dx:ASPxButton>
            </td>
        </tr>
    </table>
</div>

<dx:ASPxPopupControl ID="popupValidation" runat="server"
    Theme="Glass" ClientInstanceName="popupValidation" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Modal="True" Width="250px">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
            <table>
                <tr>
                    <td>
                       <br />
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <dx:ASPxButton ID="cmdValiderPopup" runat="server" AutoPostBack="False"
                            CausesValidation="False"
                            Theme="Glass" Width="100px">
                            <ClientSideEvents Click="function(s, e) {
	                        popupValidation.Hide();
                            ParentCallback();
}" />
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="17px" Width="17px" />
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <HeaderTemplate><%= DotNetNuke.Services.Localization.Localization.GetString("lbComment", ressFilePath)%></HeaderTemplate>
</dx:ASPxPopupControl>

<asp:SqlDataSource ID="sqlGetPropertiesGroup" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesGroup"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="sqlGetProperties" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetPropertiesRequirement"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="GroupId" SessionField="GroupId" Type="Int32" />
        <asp:SessionParameter Name="IDNC" SessionField="IDNC" Type="Int32" />
        <asp:SessionParameter Name="IsEditMode" SessionField="IsEditMode" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlMeasureUnit" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetMeasureUnit_Famille_ByIdProperty" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="IdProperty" SessionField="ID_Property" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

