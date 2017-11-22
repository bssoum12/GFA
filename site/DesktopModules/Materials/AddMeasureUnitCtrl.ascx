<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddMeasureUnitCtrl.ascx.cs" Inherits="VD.Modules.Materials.AddMeasureUnitCtrl" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxe" %>
<%@ Register TagPrefix="dx" Namespace="DevExpress.Web" Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" %>

<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>



<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />
<style  >
    .label_td {
        background-color: #D3E9F0;
        border: 1px solid #4986A2;
        padding-left: 2px;
        
    } 
</style>
<script  type="text/javascript" >
    var t_MeasureSystem = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tMeasureSystem", ressFilePath )%>';
    var t_UnitFamilies = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tUnitFamilies", ressFilePath )%>';
    function ShowPopupMesureSystem() {
        popupCtrl.SetContentUrl("/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddMeasureSystemCtrl.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&mode=add" );
         popupCtrl.SetHeaderText(t_MeasureSystem);
         popupCtrl.Show();
    }

    function ShowPopupUnitFamilies() {
        var url = "/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddUnitFamiliesCtrl.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&mode=add";         
        popupUnitFamiliesCtrl.SetContentUrl(url);
        popupUnitFamiliesCtrl.SetHeaderText(t_UnitFamilies);
        popupUnitFamiliesCtrl.Show();
    }
</script>

<dx:ASPxPopupControl ID="popupCtrl" runat="server" AllowDragging="True" AllowResize="True"
    ContentUrl="~/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddMeasureSystemCtrl.ascx"
    EnableViewState="False" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="False" Width="600px"  Height="133px"
     HeaderText="Système de mesure" ClientInstanceName="popupCtrl" EnableHierarchyRecreation="True" Theme="Glass"  ShowPinButton="True" ShowRefreshButton="True" ShowCollapseButton="True" ShowMaximizeButton="True">
    <ClientSideEvents CloseUp="function(s, e) {if (cmbSystemeMesure)cmbSystemeMesure.PerformCallback();}" />        
</dx:ASPxPopupControl>

<dx:ASPxPopupControl ID="popupUnitFamiliesCtrl" runat="server" AllowDragging="True" AllowResize="True"
    ContentUrl="~/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/AddMeasureSystemCtrl.ascx"
    EnableViewState="False" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" ShowFooter="False" Width="600px"  Height="133px"
     HeaderText="Système de mesure" ClientInstanceName="popupUnitFamiliesCtrl" EnableHierarchyRecreation="True" Theme="Glass"  ShowPinButton="True" ShowRefreshButton="True" ShowCollapseButton="True" ShowMaximizeButton="True">
    <ClientSideEvents CloseUp="function(s, e) {if (cmbFamilyUnit)cmbFamilyUnit.PerformCallback();}" />        
</dx:ASPxPopupControl>




<table style="width: 100%">
    <tr>
        <td style="vertical-align: top;" class="label_td">
            <asp:Label ID="lblDescription" runat="server" Text="Description"></asp:Label>
        </td>
        <td style="width: 200px;">
            <txtEifBox:txtEifBox ID="txtDesignation" runat="server" Width="200" ImageSrc="~/images/expand.gif" Theme="Glass" />
        </td>
        <td class="label_td">
            <asp:Label ID="lblAbbreviation" runat="server" Text="Abbréviation"></asp:Label>
        </td>
        <td style="width: 200px;">
            <dxe:ASPxTextBox ID="txtAbbreviation" runat="server" Theme="Glass" Width="100%"></dxe:ASPxTextBox>
        </td>
    </tr>
    <tr>
        <td class="label_td">
            <asp:Label ID="lblSystemMesure" runat="server" Text="Système de mesure"></asp:Label>
        </td>
        <td style="width: 200px;">
            <table style="width: 100%;">
                <tr>
                    <td>
                        <dxe:ASPxComboBox ID="cmbSystemeMesure" ClientInstanceName="cmbSystemeMesure" runat="server" Theme="Glass" DataSourceID="SqlSystemMeasureDS" Width="100%"
                            TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains" ValueType="System.Int32" OnCallback="cmbSystemeMesure_Callback">
                        </dxe:ASPxComboBox>
                    </td>
                    <td style="cursor:pointer;width:16px; ">
                        <img src="../../../images/add.gif"  onclick="ShowPopupMesureSystem();" alt="Ajouter système de mesure" title="Ajouter système de mesure" />
                    </td>
                </tr>
            </table>

        </td>
        <td class="label_td">
            <asp:Label ID="lblFamilleUnit" runat="server" Text="Famille d'unité"></asp:Label>
        </td>
        <td style="width: 200px;">
              <table style="width: 100%;">
                <tr>
                    <td>
                        <dxe:ASPxComboBox ID="cmbFamilyUnit" ClientInstanceName="cmbFamilyUnit" runat="server" Theme="Glass" DataSourceID="SqlUnitFamiliesDS" Width="100%"
                TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains" ValueType="System.Int32" OnCallback="cmbFamilyUnit_Callback">
            </dxe:ASPxComboBox>
                    </td>
                    <td style="cursor:pointer;width:16px; ">
                        <img src="../../../images/add.gif"  onclick="ShowPopupUnitFamilies();" alt="Ajouter famille d'unité" title="Ajouter famille d'unité" />
                    </td>
                </tr>
            </table>


            
        </td>
    </tr>
    <tr>
        <td colspan="4" align="right">
            <dxe:ASPxButton ID="btnSave" runat="server" Theme="Glass" Width="150px" OnClick="btnSave_Click"></dxe:ASPxButton>
        </td>
    </tr>
</table>


<dx:ASPxPopupControl ID="popupValidation" runat="server"
    Theme="Glass"
    HeaderText="Ajouter Système de mesure"
    ClientInstanceName="popupValidation" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Modal="True" Width="300px">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <table width="100%">
                <tr>
                    <td align="center">                        
                        <%= DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath)%>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <input type="button" style="width: 100px" value="Ok" onclick="popupValidation.Hide(); if (window.parent['popupCtrl']) window.parent['popupCtrl'].Hide(); " />
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="17px" Width="17px" />
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <HeaderTemplate><%= DotNetNuke.Services.Localization.Localization.GetString("popAddMeasureUnit", ressFilePath)%></HeaderTemplate>


</dx:ASPxPopupControl>

<asp:SqlDataSource ID="SqlSystemMeasureDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllMeasureSystem" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlUnitFamiliesDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllUnitFamilies" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
