<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="ConfigUI.ascx.cs" Inherits="VD.Modules.Materials.ConfigUI" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.XtraCharts.v17.1.Web, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>




<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />

 <script type="text/javascript">
     //Localized javascript variables
     var t_MeasureUnit = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tMeasureUnit", ressFilePath )%>';
     var t_MeasureUnitFormula = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tMeasureUnitFormula", ressFilePath )%>';        
     var t_UnitFamilies = '<%=GlobalAPI.CommunUtility.getRessourceEntry("tUnitFamilies", ressFilePath )%>';
     var h_SystemMeasure = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hSystemMeasure", ressFilePath )%>';
     var h_SystemMeasure = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hSystemMeasure", ressFilePath )%>';
     var h_TechnicalSoftware = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnTechnicalSoftware", ressFilePath )%>';
     var h_SoftwareSpecification = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hSoftwareSpecification", ressFilePath )%>';
     var h_CorrespSpec = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hCorrespSpec", ressFilePath )%>';
     var h_DatasheetStatus = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hDatasheetStatus", ressFilePath )%>';
     var h_CommandStatus = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hCommandStatus", ressFilePath )%>';
     var h_ConsultationStatus = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hConsultationStatus", ressFilePath )%>';
     var mn_AddGridPurchaseServises = '<%=GlobalAPI.CommunUtility.getRessourceEntry("AddGridPurchaseServises", ressFilePath )%>';
     var h_TypePurchase = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hTypePurchase", ressFilePath )%>';
     var t_variousFees = '<%=GlobalAPI.CommunUtility.getRessourceEntry("t_Frais", ressFilePath )%>';
     var t_assign = '<%=GlobalAPI.CommunUtility.getRessourceEntry("t_assign", ressFilePath )%>';
     var h_PurchaseStatus = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hPurchaseStatus", ressFilePath )%>';
     var h_NumerotationDocument = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hNumerotationDocument", ressFilePath )%>';
     var h_TypeDocument = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hTypeDocument", ressFilePath )%>';
     var h_RequestedDocument = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hRequestedDocument", ressFilePath )%>';
     var h_RequestedDocumentType = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hRequestedDocumentType", ressFilePath )%>';
     var h_DeliveryMethod = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hDeliveryMethod", ressFilePath )%>';
     var h_Incoterms = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hIncoterms", ressFilePath )%>';
     var h_PersonToNotify = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hPersonToNotify", ressFilePath )%>';
     var h_InvoiceStatus = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hInvoiceStatus", ressFilePath )%>';
     var h_PaymentTerms = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hPaymentTerms", ressFilePath )%>';
     var h_PaymentSchedules = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hPaymentSchedules", ressFilePath )%>';
     var h_PaymentDay = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hPaymentDay", ressFilePath )%>';
     var h_AssetGroup = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hAssetGroup", ressFilePath )%>';
     var h_TaxGroups = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hTaxGroups", ressFilePath )%>';
     var h_Taxes = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hTaxes", ressFilePath )%>';
     var h_ExtranetUsers = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hExtranetUsers", ressFilePath )%>';
     var h_MaterialsMenToNotify = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hMaterialsMenToNotify", ressFilePath )%>'; 

     function MenuItemClick(e) {
         switch (e.item.name)
         {
             case "itemMeasureSystem":
                 ShowMeasureSystemManagementPopup();
                 break;
             case "itemMeasureUnit":
                 ShowMeasureUnitsManagementPopup();
                 break;
             case "itemUnitFamilies":
                 ShowUnitFamiliesManagementPopup();
                 break;
             case "itemFormulas":
                 ShowMeasureUnitFormulaManagementPopup();
                 break;
             case "itemTechnicalSoftware":
                 ShowTechnicalSoftwareManagementPopup();
                 break;
             case "itemSoftwareSpecifcation":
                 ShowSoftwareSpecificationManagementPopup();
                 break;
             case "itemDatasheetStatus":
                 ShowDatasheetStatusManagementPopup();
                 break;
             case "itemCommandStatus":
                 ShowCommandStatusManagementPopup();
                 break;
             case "itemConsultationStatus":
                 ShowConsultationStatusManagementPopup();
                 break;
             case "itemPaymentMethod":
                 ShowPaymentMethodManagementPopup();
                 break;
             case "itemExemptionCertificate":
                 ShowExemptionCertificateManagementPopup();
                 break;
             case "itemServiceAchat":
                 ShowAddPurchaseServisesPopup();
                 break;
             case "itemPurchaseType":
                 ShowPurchaseRequestTypePopup(); 
                 break;
             case "itemVariousFees":
                 ShowVariousFeesPopup();
                 break;
             case "itemAssignEcoresCategory":
                 ShowAssignEcoresCategoryPopup();
                 break;
             case "itemStorageCondition":
                 ShowStorageConditionPopup();
                 break;
             case "itemAssignStorageConditionToSpec":
                 ShowAssignStorageConditionToSpecPopup();
                 break;
             case "itemPurchaseRequestStatus":
                 ShowPurchaseRequestStatusPopup();
                 break;
             case "itemNumerotationDocument":
                 ShowNumerotationDocumentPopup();
                 break;
             case "itemTypeDocument":
                 ShowTypeDocumentPopup();
                 break;
             case "itemRequestedDocument":
                 ShowRequestedDocumentPopup();
                 break;
             case "itemRequestedDocumentType":
                 ShowRequestedDocumentTypePopup();
                 break;
             case "itemDeliveryMethod":
                 ShowDeliveryMethodPopup();
                 break;
             case "itemIncoTerms":
                 ShowIncoTermsPopup();
                 break;
             case "itemPersonToNotify":
                 ShowPersonToNotifyPopup();
                 break;
             case "itemBrands":
                 ShowBrandsPopup();
                 break;
             case "itemInvoiceStatus":
                 ShowInvoiceStatusPopup();
                 break;
             case "itemPaymentTerms":
                 ShowPaymentTermsPopup();
                 break;
             case "itemPaymentSchedules":
                 ShowPaymentSchedules();
                 break;
             case "itemPaymentDay":
                 ShowPaymentDay();
                 break;
             case "itemAssetGroup":
                 ShowAssetGroup();
                 break;
             case "itemTaxGroup":
                 ShowTaxGroup();
                 break;
             case "itemTaxes":
                 ShowTaxes();
                 break;
             case "itemExtranetUsers":
                 ShowExtranetUsers();
                 break;
             case "itemMaterialMenToNotify":
                 ShowMaterialMenToNotify();
                 break;
                 
             default:
                 return;
         }
     }
              
     function ShowPaymentTermsPopup() {
         SetSplitterPane("Materials/Param_PaymentTerms.ascx", 450, 650, h_PaymentTerms);
     }

  

     
     function ShowMaterialMenToNotify() {
         SetSplitterPane("Materials/Param_TechnicalSoftware_Discipline_Responsable.ascx", 450, 650, h_MaterialsMenToNotify);
     }

     

     // Show delivery method
     function ShowIncoTermsPopup() {
         SetSplitterPane("Materials/Param_IncoTerms.ascx", 450, 650, h_Incoterms);
     }


     // Show delivery method
     function ShowDeliveryMethodPopup() {
         SetSplitterPane("Materials/Param_DeliveryMethod.ascx", 450, 650, h_DeliveryMethod);
     }


     // Show Type Document
     function ShowTypeDocumentPopup() {
         SetSplitterPane("Materials/Param_TypeDocument.ascx", 450, 650, h_NumerotationDocument);
     } 

     //Show numerotation Document
     function ShowNumerotationDocumentPopup() {
         SetSplitterPane("Materials/Param_NumerotationDocument.ascx", 450, 650, h_NumerotationDocument);
     }

     // show purchase request type Popup
     function ShowPurchaseRequestStatusPopup() {
         SetSplitterPane("Materials/Param_PurchaseRequestStatus.ascx", 450, 650, h_PurchaseStatus);
     }


     // show purchase request type Popup
     function ShowPurchaseRequestTypePopup() {
         SetSplitterPane("Materials/Param_PurchaseRequestType.ascx", 450, 650, h_TypePurchase);
     }
     //Show Consultation Status Management Popup
     function ShowConsultationStatusManagementPopup() {
         SetSplitterPane("Materials/Param_ConsultationStatus.ascx", 450, 650, h_CommandStatus);
     }
     
     //Show Command Status Management Popup
     function ShowCommandStatusManagementPopup() {
         SetSplitterPane("Materials/Param_CommandStatus.ascx", 450, 650, h_CommandStatus);
     }


     //Show Datasheet Status Management Popup
     function ShowDatasheetStatusManagementPopup() {
         SetSplitterPane("Materials/Param_DatasheetStatus.ascx", 450, 650, h_DatasheetStatus);
     }


     //Show Technical Software Management Popup
     function ShowTechnicalSoftwareManagementPopup() {
         SetSplitterPane("Materials/Param_TechnicalSoftware.ascx", 450, 650, h_TechnicalSoftware);
     }

     //Show Technical Software Management Popup
     function ShowSoftwareSpecificationManagementPopup() {
         SetSplitterPane("Materials/Param_SoftwareSpecification.ascx", 450, 650, h_SoftwareSpecification);
     }

     //Show Measure System Management Popup
     function ShowMeasureSystemManagementPopup() {
         SetSplitterPane("Materials/Param_MeasureSystem.ascx", 450, 650, h_SystemMeasure);
     }

     //Show Measure Units Management Popup
     function ShowMeasureUnitsManagementPopup() {
         SetSplitterPane("Materials/Param_MeasureUnit.ascx", 450, 650, t_MeasureUnit);
     }

     //Show Measure Units Formula Management Popup
     function ShowMeasureUnitFormulaManagementPopup() {
         SetSplitterPane("Materials/Param_MeasureUnitFormula.ascx", 500, 750, t_MeasureUnitFormula);
     }
         
     //Show Unit Families Management Popup
     function ShowUnitFamiliesManagementPopup() {
         SetSplitterPane("Materials/Param_UnitFamilies.ascx", 450, 650, t_UnitFamilies);
     }


      
     // Show Brands
     function ShowBrandsPopup() {
         SetSplitterPane("Materials/Param_Brands.ascx");
     }
     
      
     // Show Manage Extranet Users
     function ShowExtranetUsers() {
         //SetSplitterPane("EIF.PM.ETDM/Customer_ManageUsers.ascx", 450, 650, h_ExtranetUsers);
         SetSplitterPane("Materials/Param_ExtranetUsers.ascx", 450, 650, h_ExtranetUsers);
     }

     //Update iframe content by loading given ctrl
     function SetSplitterPane(ctrl) {
         var protocal = 'http';
         if (document.location.href.toString().indexOf('https') == 0)
             protocal = 'https';
         window.frames['ifrDetails'].location.href = protocal + "://<%= _portalAlias %>/DesktopModules/Materials/LoadControl.aspx?ctrl=" + ctrl + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&ModuleId=<%= ModuleId %>&TabId=<%= HttpContext.Current.Request.QueryString["TabId"] %>";
    }
 </script>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
        <td valign="top" style="width:100%;">
            <dx:ASPxSplitter ID="spltitter" Height="680px" Width="100%" runat="server"
                Theme="Glass">
                <Styles>
                    <Pane>
                        <Paddings Padding="0px" />
                        <Paddings Padding="0px"></Paddings>
                    </Pane>
                </Styles>
                <Panes>
                    <dx:SplitterPane Name="ListBoxContainer" ShowCollapseBackwardButton="True" ShowCollapseForwardButton="True"
                        ShowSeparatorImage="True" Size="27%" ScrollBars="Vertical">
                        <ContentCollection>
                            <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                <table id="specPanel" width="100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>                                                        
                                            <!-- Navigation Pane -->
                                                <div style="float: left; width: 100%; margin-right: 2%">
                                                     <dx:ASPxNavBar ID="nbMain" ClientInstanceName="nbMain" runat="server" AllowSelectItem="True" EnableAnimation="True"
                                                        Width="100%" Theme="Metropolis">
                                                        <GroupHeaderStyle HorizontalAlign="Left" />
                                                        <ItemStyle HorizontalAlign="Left" />
                                                         <ClientSideEvents ItemClick="function(s, e) { MenuItemClick(e); }">
                                                        </ClientSideEvents>                                                         
                                                        <Groups>
                                                            <dx:NavBarGroup Text="Materials">
                                                                <Items>
                                                                    <dx:NavBarItem Name="itemMeasureSystem" Text="Measure system">
                                                                        <Image Url="~/images/Materials/measure_system.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem>
                                                                    <dx:NavBarItem Name="itemMeasureUnit" Text="MasterCard">
                                                                        <Image Url="~/images/Materials/Units-icon.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem>
                                                                    <dx:NavBarItem Name="itemUnitFamilies" Text="Union">
                                                                        <Image Url="~/images/Materials/unit-families.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem>
                                                                    <dx:NavBarItem Name="itemFormulas" Text="American Express">
                                                                        <Image Url="~/images/Materials/Formule-Icon.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem>
                                                                    <dx:NavBarItem Name="itemTechnicalSoftware" Text="Technical Software">
                                                                        <Image Url="~/images/Materials/logiciels-32.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem>
                                                                    <dx:NavBarItem Name="itemSoftwareSpecifcation" Text="Software Specification">
                                                                        <Image Url="~/images/Materials/proprietes-logiciels-32.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem>
                                                                                                                         
                                                                    <dx:NavBarItem Name="itemBrands">
                                                                        <Image Url="~/images/Materials/brand_icon_24x24.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem> 
                                                                    <dx:NavBarItem Name="itemMaterialMenToNotify">
                                                                        <Image Url="~/images/Materials/materialsman_32x32.png" Height="24px" Width="24px" />
                                                                    </dx:NavBarItem>     
                                                                </Items>
                                                            </dx:NavBarGroup>
                                                            
                                                            
                                                        </Groups>
                                                    </dx:ASPxNavBar>
                                                    <dx:ASPxMenu ID="mnLinks" ClientInstanceName="mnLinks" runat="server" AllowSelectItem="True"
                                                        Orientation="Vertical" EnableViewState="False" Width="100%" Theme="Metropolis" Visible="false">
                                                        <ItemStyle HorizontalAlign="Left" />
                                                        <ClientSideEvents ItemClick="function(s, e) { MenuItemClick(e); }">
                                                        </ClientSideEvents>
                                                        <Items>
                                                            <dx:MenuItem Name="itemMeasureSystem" Text="Measure system">
                                                                <Image Url="~/images/Materials/measure_system.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>
                                                            <dx:MenuItem Name="itemMeasureUnit" Text="MasterCard">
                                                                <Image Url="~/images/Materials/Units-icon.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>
                                                            <dx:MenuItem Name="itemUnitFamilies" Text="Union">
                                                                <Image Url="~/images/Materials/unit-families.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>
                                                            <dx:MenuItem Name="itemFormulas" Text="American Express">
                                                                <Image Url="~/images/Materials/Formule-Icon.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>
                                                            <dx:MenuItem Name="itemTechnicalSoftware" Text="Technical Software">
                                                                <Image Url="~/images/Materials/logiciels-32.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>
                                                            <dx:MenuItem Name="itemSoftwareSpecifcation" Text="Software Specification">
                                                                <Image Url="~/images/Materials/proprietes-logiciels-32.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>                                                                                                                                                                                 
                                                            <dx:MenuItem Name="itemBrands">
                                                                <Image Url="~/images/Materials/brand_icon_24x24.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>                                                             
                                                            <dx:MenuItem Name="itemMaterialMenToNotify">
                                                                <Image Url="~/images/Materials/email-go-32.png" Height="24px" Width="24px" />
                                                            </dx:MenuItem>   
                                                                                                                      
                                                        </Items>
                                                    </dx:ASPxMenu>
                                                </div>
                                        </td>
                                    </tr>
                                </table>
                            </dx:SplitterContentControl>
                        </ContentCollection>
                    </dx:SplitterPane>
                    <dx:SplitterPane Name="MainContainer">
                        <Panes>
                            <dx:SplitterPane Name="DetailsContainer" ShowCollapseBackwardButton="True" ShowCollapseForwardButton="True"
                                ShowSeparatorImage="True">
                                <ContentCollection>
                                    <dx:SplitterContentControl ID="SplitterContentControl3" runat="server">
                                        <div style="padding-right: 2px;">
                                            <iframe name="ifrDetails" style="border-right: 1px solid #C0C0C0; border-left: 1px solid #C0C0C0; border-bottom: 1px solid #C0C0C0; background-color: Transparent;"
                                                width="100%"
                                                height="700px" frameborder="0" scrolling="no" id="ifrDetails" src="/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/Param_MeasureSystem.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>"></iframe>
                                        </div>
                                    </dx:SplitterContentControl>
                                </ContentCollection>
                            </dx:SplitterPane>
                        </Panes>
                    </dx:SplitterPane>
                </Panes>
                <Styles>
                    <Pane>
                        <Paddings Padding="0px"></Paddings>
                    </Pane>
                </Styles>
                <Images>
                </Images>
            </dx:ASPxSplitter>
        </td>
    </tr>
</table>
<script type="text/javascript">
    window.onload = new function () {
        //mnLinks.SetSelectedItem(mnLinks.GetItemByName("itemMeasureSystem"));
    }
</script>