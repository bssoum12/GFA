<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewUI.ascx.cs" Inherits="VD.Modules.GestionTiers.ViewUI" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />

 <script type="text/javascript">
        function btnCustomWindow_Click(s, e) {
            
            if (grdTiers.IsCustomizationWindowVisible())
                grdTiers.HideCustomizationWindow();
            else
                grdTiers.ShowCustomizationWindow();
        }
</script>

 <div style=" display:none ; ">
 <dx:aspxbutton runat="server" ID="btnCustomWindow" ClientInstanceName="btnCustomWindow" 
            Text="Afficher fenêtre de personnalisation" UseSubmitBehavior="False" AutoPostBack="False" 
             Theme="Glass" 
            >
            
            <ClientSideEvents Init="function(s, e) {
                                    var popup = window.parent;
                                    popup.window['btnCustomWindow'] = btnCustomWindow;}" Click="btnCustomWindow_Click" />
        </dx:aspxbutton>

        </div>

<dx:ASPxGridView ID="grdTiers" runat="server" Width="100%" Theme="Glass" ClientInstanceName="grdTiers" AutoGenerateColumns="False" DataSourceID="SqlTiersDS" KeyFieldName="ID">
    <Settings ShowFilterRow="True" ShowGroupPanel="True" ShowFooter="true"  />
    <SettingsCustomizationWindow Enabled="True"   PopupHorizontalAlign="RightSides" PopupVerticalAlign="TopSides" Width="250px"  Height="300px" />
    <SettingsDataSecurity AllowEdit="False" AllowInsert="False" />
    <SettingsSearchPanel Visible="True" />
    <SettingsPager AlwaysShowPager="True" PageSizeItemSettings-ShowAllItem="True"  >
                   <Summary AllPagesText="Pages: {0} - {1}" Text="Page {0} sur {1}" />
               </SettingsPager>
    <Columns>
        <dx:GridViewCommandColumn ShowClearFilterButton="True" Caption=" " VisibleIndex="0">
        </dx:GridViewCommandColumn>
        <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" Visible="False" VisibleIndex="1" ShowInCustomizationForm="false">
            <EditFormSettings Visible="False" />
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Raison Sociale" FieldName="RaisonSociale" VisibleIndex="2">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Abbréviation" FieldName="Abbr" VisibleIndex="5">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Code Client" FieldName="CodeClient" VisibleIndex="3">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Code Fournisseur" FieldName="CodeSupplier" VisibleIndex="4">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Adresse" Visible="False" VisibleIndex="10">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="CodePostal" Visible="False" VisibleIndex="11">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Ville" Visible="False" VisibleIndex="12">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Pays" FieldName="ID_Pays" Visible="False" VisibleIndex="13">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Département" FieldName="ID_Departement" Visible="False" VisibleIndex="14">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Email" VisibleIndex="18">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="SiteWeb" Visible="False" VisibleIndex="19">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Telephone" VisibleIndex="16">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Fax" VisibleIndex="17">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Registre de Commerce" FieldName="RC" Visible="False" VisibleIndex="20">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="MatriculeFiscal" Visible="False" VisibleIndex="21">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="CodeDouane" Visible="False" VisibleIndex="22">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="BAN" Visible="False" VisibleIndex="23">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Numéro TVA" FieldName="NumTVA" VisibleIndex="15">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataCheckColumn FieldName="Assujetti" Visible="False" VisibleIndex="24">
        </dx:GridViewDataCheckColumn>
        <dx:GridViewDataTextColumn Caption="Type" FieldName="ID_Type" Visible="False" VisibleIndex="25">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Forme Juriduqe" FieldName="ID_FormeJuridique" Visible="False" VisibleIndex="26">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn FieldName="Capital" Visible="False" VisibleIndex="27">
        </dx:GridViewDataTextColumn>
        <dx:GridViewDataTextColumn Caption="Devise" FieldName="ID_Devise" Visible="False" VisibleIndex="28">
        </dx:GridViewDataTextColumn>
    </Columns>
</dx:ASPxGridView>


<asp:SqlDataSource ID="SqlTiersDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Tiers_GetAllTiers" SelectCommandType="StoredProcedure">    
</asp:SqlDataSource>