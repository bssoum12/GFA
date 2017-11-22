<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddCustomProperties.ascx.cs" Inherits="VD.Modules.Materials.AddCustomProperties" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dxtl" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxpc" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>


<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />
<script>
    function ShowAddPropertyPopup() {
        var m_AddNewProperties = '<%= DotNetNuke.Services.Localization.Localization.GetString("mAddNewProperties", ressFilePath)%>';
        popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/Forms/PropertyForm.ascx&IsNewProperty=true&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>");
        popupCtrl.SetHeaderText(m_AddNewProperties);
        popupCtrl.Show();
    }

    function RefreshGrdProperties() {
        tlsPropertiesGroupsCustom.PerformCallback();
    }
</script>
<table style="width: 100%">
    <tr>
        <td align="left">
            <table width="100%" cellpadding="0" cellspacing="0" style="font-family:Tahoma;font-size:11px;color:#21698C;">
                <tr>
                    <td align="right" style="width: 16px; cursor: hand; cursor: pointer;">
                        <asp:ImageButton runat="server" ID="imExpand2" ImageUrl="../../images/task/icon_expand.png" OnClientClick="tlsPropertiesGroupsCustom.ExpandAll();return false;" />
                    </td>
                    <td>&nbsp;</td>
                    <td style="width:150px;"><%= DotNetNuke.Services.Localization.Localization.GetString("mnExpandTree", ressFilePath)%></td>
                    <td>&nbsp;</td>
                    <td align="right" style="width: 16px; cursor: hand; cursor: pointer;">
                        <asp:ImageButton runat="server" ID="imCollapse2" ImageUrl="../../images/task/icon_collapse.png" OnClientClick="tlsPropertiesGroupsCustom.CollapseAll();return false;" /></td>
                    <td>&nbsp;</td>
                    <td><%= DotNetNuke.Services.Localization.Localization.GetString("mnCollapseTree", ressFilePath)%></td>
                </tr>
            </table>
        </td>
        <td></td>
    </tr>
                <tr>
                    <td>
                        <dxtl:ASPxTreeList ID="tlsPropertiesGroupsCustom" ClientInstanceName="tlsPropertiesGroupsCustom" runat="server"  
                            Height="100%" EnableCallbackCompression="False" OnHtmlRowPrepared="tlsPropertiesGroupsCustom_HtmlRowPrepared"
                            Theme="Metropolis" BackColor="Transparent" Width="100%" KeyFieldName="Id" ParentFieldName="ParentId" AutoGenerateColumns="False" 
                            OnHtmlDataCellPrepared="tlsPropertiesGroupsCustom_HtmlDataCellPrepared" DataSourceID="PropertiesHiearchyCustomDS" OnCustomCallback="tlsPropertiesGroupsCustom_CustomCallback">
                            <Columns>
                                <dxtl:TreeListTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                                </dxtl:TreeListTextColumn>
                                <dxtl:TreeListTextColumn FieldName="ParentId" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                </dxtl:TreeListTextColumn>
                                <dxtl:TreeListTextColumn FieldName="Designation" ShowInCustomizationForm="True" VisibleIndex="2">
                                </dxtl:TreeListTextColumn>
                                <dxtl:TreeListTextColumn FieldName="PropertyDesignation" ShowInCustomizationForm="True" VisibleIndex="3" Width="200px">
                                </dxtl:TreeListTextColumn>
                                <dxtl:TreeListTextColumn FieldName="PropertyID" ShowInCustomizationForm="True" VisibleIndex="4">
                                    <DataCellTemplate>
                                        <dx:ASPxTextBox ID="txtPropertyValue" runat="server" Theme="Glass" OnInit="txtPropertyValue_Init" Width="130px"></dx:ASPxTextBox>
                                    </DataCellTemplate>
                                </dxtl:TreeListTextColumn>
                                <dxtl:TreeListTextColumn FieldName="PropertyID" ShowInCustomizationForm="True" VisibleIndex="5">
                                    <DataCellTemplate>
                                        <dx:ASPxComboBox ID="cmbMeasureUnit_C" runat="server" Theme="Glass" Width="140px" OnInit="cmbMeasureUnit_C_Init" AutoPostBack="false"
                                            TextField="Designation" ValueField="ID" DataSourceID="SqlMesureUnitDS" ValueType="System.Int32" OnCallback="cmbMeasureUnit_C_Callback">
                                            <ClientSideEvents GotFocus="function(s, e) { s.PerformCallback();}"></ClientSideEvents>
                                        </dx:ASPxComboBox>
                                    </DataCellTemplate>
                                </dxtl:TreeListTextColumn>
                            </Columns>
                            <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="false" GridLines="Horizontal"  
                                ShowColumnHeaders="true" ShowTreeLines="false" VerticalScrollBarMode="Visible" ScrollableHeight="350"></Settings>                            
                            <SettingsBehavior ProcessFocusedNodeChangedOnServer="false" ProcessSelectionChangedOnServer="false" AutoExpandAllNodes="True" AllowDragDrop="False"></SettingsBehavior>
                            <SettingsSelection Enabled="True" />
                            <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>                         
                            <Styles><Header Font-Bold="true"></Header></Styles>
                        </dxtl:ASPxTreeList>
                    </td>
                    <td style="padding-top:5px; vertical-align:top;">
                        <img src="../../images/MenuEtude/add_large.png" style="cursor:hand;cursor:pointer;" id="imgAddProperty" width="16px" height="16px" onclick="ShowAddPropertyPopup();" 
                            alt="<%= DotNetNuke.Services.Localization.Localization.GetString("AddProperties", ressFilePath) %>" 
                            title="<%= DotNetNuke.Services.Localization.Localization.GetString("AddProperties", ressFilePath) %>" />
                    </td>
                </tr>
                <tr>
                    <td align="center" colspan="2">
                        <dx:ASPxButton ID="SaveCustomProperties" runat="server" Theme="Glass" Text="Enregistrer" AutoPostBack="false" OnClick="SaveCustomProperties_Click">                            
                            <ClientSideEvents />
                            <Image Url="~/images/save.gif"></Image>                            
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
 

<dxpc:ASPxPopupControl ID="popupValProperties" runat="server"
    Theme="Glass"
    HeaderText="Ajouter Propriété"
    ClientInstanceName="popupValProperties" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Modal="True" Width="300px">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <table width="100%">
                <tr>
                    <td align="center">
                        <%=  DotNetNuke.Services.Localization.Localization.GetString("hSuccessSaveProperties", ressFilePath)  %>  </td>
                </tr>
                <tr>
                    <td align="center">
                        <input type="button" style="width: 100px" value="Ok" onclick="popupValProperties.Hide(); window.parent['popupWind'].Hide(); window.parent['grdMaterialsSpec'].PerformCallback(); window.parent['tlsPropertiesGroups'].PerformCallback();" />
                    </td>
                </tr>
            </table>
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="17px" Width="17px" />
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
</dxpc:ASPxPopupControl>


<dxpc:ASPxPopupControl ID="popupCtrl" runat="server" AllowDragging="True" AllowResize="True"
    EnableViewState="False" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="False" Width="600px" Height="200px"
     ClientInstanceName="popupCtrl" EnableHierarchyRecreation="True" Theme="Glass" ShowPinButton="True" ShowRefreshButton="True" ShowCollapseButton="True" ShowMaximizeButton="True">
    <contentstyle>            
        <Paddings Padding="0px"></Paddings>
    </contentstyle>
    <contentcollection>
<dxpc:PopupControlContentControl runat="server" SupportsDisabledAttribute="True"></dxpc:PopupControlContentControl>
</contentcollection>
</dxpc:ASPxPopupControl>

<asp:SqlDataSource ID="PropertiesHiearchyCustomDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="EIF_Materials_GetAllPropertiesHiearchy" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter SessionField="Locale" Name="LocaleParam" Type="String"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlMesureUnitDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="EIFMaterials_GetMeasureUnitByProperty" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String"></asp:SessionParameter>
        <asp:SessionParameter SessionField="ID_Properties" Name="ID_Properties" Type="Int32"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>