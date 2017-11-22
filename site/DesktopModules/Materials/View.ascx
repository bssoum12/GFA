<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="VD.Modules.Materials.View" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<script type="text/javascript">
    
    //Localized javascript variables
    var t_NotificationsCategoriesUsers = '<%= GlobalAPI.CommunUtility.getRessourceEntry("tNotificationsCategoriesUsers", ressFilePath )%>';
    var t_AssignPermissions = '<%= GlobalAPI.CommunUtility.getRessourceEntry("tAssignPermissions", ressFilePath )%>';
    var t_TechDetails = '<%= GlobalAPI.CommunUtility.getRessourceEntry("lbTechDetails", ressFilePath )%>';
    var t_MeasureUnit = '<%= GlobalAPI.CommunUtility.getRessourceEntry("tMeasureUnit", ressFilePath )%>';
    var t_MeasureUnitFormula = '<%= GlobalAPI.CommunUtility.getRessourceEntry("tMeasureUnitFormula", ressFilePath )%>';
    var t_Norm = '<%= GlobalAPI.CommunUtility.getRessourceEntry("tNorm", ressFilePath )%>';
    var t_Properties = '<%= GlobalAPI.CommunUtility.getRessourceEntry("tProperties", ressFilePath )%>';
    var mn_PropertiesGroup = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnPropertiesGroup", ressFilePath )%>';
    var t_UnitFamilies = '<%= GlobalAPI.CommunUtility.getRessourceEntry("tUnitFamilies", ressFilePath )%>';
    var h_SystemMeasure = '<%= GlobalAPI.CommunUtility.getRessourceEntry("hSystemMeasure", ressFilePath )%>';
    var mn_Add = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnAdd", ressFilePath )%>';
    var mn_AddMaterials = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnAddMaterials", ressFilePath )%>';
    var m_SelectMaterial = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mSelectMaterial", ressFilePath )%>';
    var m_DeleteConfirm = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mDeleteConfirm", ressFilePath )%>';
    var mn_Edit = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnEdit", ressFilePath )%>';
    var mn_EditMaterial = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnEditMaterial", ressFilePath )%>';
    var mn_Duplicate = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnDuplicate", ressFilePath )%>';
    var mn_Affectations = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnAffectations", ressFilePath )%>';
    var h_Specifications = '<%= GlobalAPI.CommunUtility.getRessourceEntry("hSpecifications", ressFilePath )%>';
    var h_editSpec = '<%= GlobalAPI.CommunUtility.getRessourceEntry("editSpec", ressFilePath )%>';
    var mn_EitProperties = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnEitProperties", ressFilePath )%>';
    var mn_NormRequirements = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnNormRequirements", ressFilePath )%>';
    var mn_ValidateMaterial = '<%= GlobalAPI.CommunUtility.getRessourceEntry("mnValidateMaterial", ressFilePath )%>';
    var h_CorrespSpec = '<%= GlobalAPI.CommunUtility.getRessourceEntry("hCorrespSpec", ressFilePath )%>';
    var h_MaterialsMatching = '<%= GlobalAPI.CommunUtility.getRessourceEntry("hMaterialsMatching", ressFilePath )%>';
    var h_EquivalentMaterials = '<%= GlobalAPI.CommunUtility.getRessourceEntry("hEquivalentMaterials", ressFilePath )%>';
    var mn_AssignToDisciplines = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnAssignToDisciplines", ressFilePath )%>';
    var mn_AssignToSuppliers = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnAssignToSuppliers", ressFilePath )%>';
    var mn_PropertiesAssignment = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnPropertiesAssignment", ressFilePath )%>';
    var mn_AssignNorms = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnAssignNorms", ressFilePath )%>';
    /*function alert(m) {
        $.dnnAlert({
            okText: 'OK',
            text: m,
            title: 'Message'
        });
    }*/



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

    //Call DNN Modal Popup Window for given URL
    function popup(url, height, width, title) {
        var protocal = 'http';
        if (document.location.href.toString().indexOf('https') == 0)
            protocal = 'https';
        dnnModal.title = title;       
        if (url.toString().indexOf('?') == -1)
            return dnnModal.show(protocal + "://<%=_portalAlias %>/DesktopModules/Materials/" + url + "?lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&popUp=true&ModuleId=<%= ModuleId %>&TabId=" + TabId, /*showReturn*/true, height, width, false, "");
        else
            return dnnModal.show(protocal + "://<%=_portalAlias %>/DesktopModules/Materials/" + url + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&popUp=true&ModuleId=<%= ModuleId %>&TabId=" + TabId, /*showReturn*/true, height, width, false, "");
   }

    //Show Specification Management Popup
    function ShowSpecEditPopup() {
        popup("LoadControl.aspx?ctrl=Materials/ManageSpec.ascx", 620, 650, h_Specifications);
    }



    //Show Specification Assignment Popup
    function ShowSpecAssignPopup() {
        popup("LoadControl.aspx?ctrl=Materials/AssignSpecToDiscipline.ascx", 480, 650, mn_AssignToDisciplines);
    }

    //Expand Materials Grid
    function Materials_ExpandCollapse(obj) {
        if (grdMaterials)
            grdMaterials.ExpandAllDetailRows();
    }

    //Expand Materials Grid To PDF
    function Materials_ExportPDF() {
        if (btnExportPDF_Materials) { btnExportPDF_Materials.DoClick(); };
    }

    //Expand Materials Grid To Excel
    function Materials_ExportExcel() {
        if (btnExportExcel_Materials) { btnExportExcel_Materials.DoClick(); };
    }

    //Update iframe content by loading given ctrl
    function SetSplitterPane(ctrl) {
        var protocal = 'http';
        if (document.location.href.toString().indexOf('https') == 0)
            protocal = 'https';
        window.frames['ifrDetails'].location.href = protocal + "://<%= _portalAlias %>/DesktopModules/Materials/LoadControl.aspx?ctrl=" + ctrl + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&ModuleId=<%= ModuleId %>&TabId=<%= TabId %>";
    }

    //Export Report To PDF
    function ReportsViwer_ExportPDF() {
        if (reportViewer) {
            reportViewer.exportReport("PDF");
        }
    }

    //Export Report To Excel
    function ReportsViwer_ExportExcel() {
        if (reportViewer)
            reportViewer.exportReport("Excel");
    }

    //Expand Collapse Reports Treeview
    function ReportsViewer_ExpandCollapse() {
        var winObj = window.frames["ifrDetails"];
        if (winObj) {
            winObj.document.getElementById('btnExpandCollapse').click();
        };
    }

    //Verify if crurrent browser is internet explroer
    function detectIE() {
        var ua = window.navigator.userAgent;
        var msie = ua.indexOf('MSIE ');
        if (msie > 0) {
            // IE 10 or older => return version number
            //return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
            return true;
        }

        var trident = ua.indexOf('Trident/');
        if (trident > 0) {
            // IE 11 => return version number
            var rv = ua.indexOf('rv:');
            //return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
            return true;
        }

        var edge = ua.indexOf('Edge/');
        if (edge > 0) {
            // Edge (IE 12+) => return version number
            //return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
            return true;
        }

        // other browser
        return false;
    }

    
    



    

    //Show Add Materials Popup
    function ShowAddMaterialsPopup() {        
        popup("LoadControl.aspx?ctrl=Materials/AddMaterials.ascx", 450, 1010, mn_AddMaterials);
    }


    //Show Add prerequiste Popup 
    function ShowAddPrerequisitePopup() {
        popup("LoadControl.aspx?ctrl=Materials/AddPrerequisite.ascx", 450, 950, mn_AddPrerequisite);
    }

    //Show Edit prerequiste Popup 
    function ShowEditPrerequisitePopup() {
        if (window['grdPrerequis'] != undefined) {
            var index = grdPrerequis.GetFocusedRowIndex();
            if (index != -1) {
                var isGroupRow = grdPrerequis.IsGroupRow(index)
                if (!isGroupRow)
                    popup("LoadControl.aspx?ctrl=Materials/EditPrerequisite.ascx&ModuleKey=<%=ModuleId %>&key=" + grdPrerequis.GetRowKey(index) + "&Mode=edit", 450, 950, mn_EditPrerequisite);
                else
                    alert(m_SelectPrerequisite);
            }
            else
                alert(m_SelectPrerequisite);
        }
        else
            alert(m_SelectPrerequisite);
    }

    //Show Add Material Details Popup
    function ShowAddMaterialDetailsPopup() {
        if (window['grdMaterials'] != undefined) {
            var index = grdMaterials.GetFocusedRowIndex();
            
            if (index != -1)
            {
                var key = grdMaterials.GetRowKey(index); 
                popup("LoadControl.aspx?ctrl=Materials/AddMaterialDetails.ascx&MaterialId=" + key, 570, 830, t_TechDetails);
            }
            else
                alert(m_SelectMaterial);
        }
        else
            alert(m_SelectMaterial);
    }

    



     


    function ShowPopupDetailsMaterial_Callback(values) {
        popup("LoadControl.aspx?ctrl=Materials/DetailsMaterial.ascx&ModuleKey=<%=ModuleId %>&MaterialId=" + values + "&Mode=edit", 500, 900, mn_detailsmaterial);
    }

    //Show Edit Material Popup
    function ShowEditMaterialPopup() {
        if (window['grdMaterials'] != undefined) {
            var index = grdMaterials.GetFocusedRowIndex();
            if (index != -1)
            {
                var key = grdMaterials.GetRowKey(index);
                popup("LoadControl.aspx?ctrl=Materials/EditMaterials.ascx&ModuleKey=<%=ModuleId %>&key=" + key + "&Mode=edit", 450, 1010, mn_EditMaterial);
            }
            else
                alert(m_SelectMaterial);
        }
        else
            alert(m_SelectMaterial);
    }

    

    //Delete Material
    function DeleteMaterial() {
        if (window['grdMaterials'] != undefined) {
            if (confirm(m_DeleteConfirm)) {
                var index = grdMaterials.GetFocusedRowIndex();
                if (index != -1)
                    grdMaterials.GetRowValues(index, 'ID;ID_MaterialsSpecifications', DeleteMaterial_Callback);
                else
                    alert(m_SelectMaterial);
            }
        }
        else
            alert(m_SelectMaterial);
    }

    function DeleteMaterial_Callback(values) {
        cbMaterialsOp.PerformCallback("0@@" + values[0] + "@@" + values[1]);
    }

    //Show Duplicate Material Popup
    function ShowDuplicateMaterialPopup() {
        if (window['grdMaterials'] != undefined) {
            var index = grdMaterials.GetFocusedRowIndex();
            if (index != -1)
                grdMaterials.GetRowValues(index, 'ID', ShowDuplicateMaterialPopup_Callback);
            else
                alert(m_SelectMaterial);
        }
        else
            alert(m_SelectMaterial);
    }

    //Show Standards Management Popup
    function ShowNormManagementPopup() {
        popup("LoadControl.aspx?ctrl=Materials/Param_Standard.ascx", 600, 1000, t_Norm);
    }

    //Show Standards Management Popup
    function ShowStandardPropertiesManagementPopup() {
        popup("LoadControl.aspx?ctrl=Materials/Param_StdProperties.ascx", 600, 1000, mn_NormRequirements);
    }



    //Show Properties Management Popup
    function ShowPropertiesManagementPopup() {
        popup("LoadControl.aspx?ctrl=Materials/Param_Properties.ascx", 550, 750, t_Properties);
    }

    //Show Properties Groups Management Popup
    function ShowPropertiesGroupsManagementPopup() {
        popup("LoadControl.aspx?ctrl=Materials/Param_GroupProperties.ascx", 450, 650, mn_PropertiesGroup);
    }

    


    function ShowDuplicateMaterialPopup_Callback(values) {
        //popup("LoadControl.aspx?ctrl=Materials/AddMaterialDetails.ascx&MaterialId=" + values, 570, 820, mn_Add);
        popup("LoadControl.aspx?ctrl=Materials/EditMaterials.ascx&ModuleKey=<%=ModuleId %>&key=" + values + "&Mode=duplicat", 450, 1010, mn_Duplicate);
    }



    //Show Add New Specification  Group Popup
    function ShowAddSpecificationGroupPopup(key, discipline) {
        if (discipline != 'ALL')
            popup("LoadControl.aspx?ctrl=Materials/AddNewGroupSpec.ascx&specid=" + key + "&DisciplineID=" + discipline, 150, 350, mn_Add);
        else
            popup("LoadControl.aspx?ctrl=Materials/AddNewGroupSpec.ascx&specid=" + key, 150, 350, mn_Add);
    }

    //Show Add Specification Popup
    function ShowAddSpecificationPopup(key, discipline) {
        if (discipline != 'ALL')
            popup("LoadControl.aspx?ctrl=Materials/AddNewSpec.ascx&specid=" + key + "&DisciplineID=" + discipline, 150, 350, mn_Add);
        else
            popup("LoadControl.aspx?ctrl=Materials/AddNewSpec.ascx&specid=" + key, 150, 350, mn_Add);
    }

    //Show Edit Specification Popup
    function ShowEditSpecificationPopup(key) {
        popup("LoadControl.aspx?ctrl=Materials/EditMatSpec.ascx&specid=" + key, 150, 350, h_editSpec);
    }

    //Show Add Material From Spec
    function ShowInitializedAddMaterialPopup(SpecKey) {
        popup("LoadControl.aspx?ctrl=Materials/AddMaterials.ascx&SpecKey=" + SpecKey, 450, 1010, mn_AddMaterials);
    }

    //Show Edit Material Properties Popup
    function ShowEditMaterialPropertiesPopup() {
        var index = grdMaterials.GetFocusedRowIndex();
        if (index != -1)
            grdMaterials.GetRowValues(index, 'ID', ShowEditMaterialPropertiesPopup_Callback);
        else
            alert(m_SelectMaterial);
    }

    function ShowEditMaterialPropertiesPopup_Callback(key) {
        popup("LoadControl.aspx?ctrl=Materials/EditProperties.ascx&key=" + key, 450, 950, mn_EitProperties);
    }

    //Show validation report Material Popup
    function ValidateMaterial() {
        var index = grdMaterials.GetFocusedRowIndex();
        if (index != -1)
            grdMaterials.GetRowValues(index, 'ID', ValidateMaterial_Callback);
        else
            alert(m_SelectMaterial);
    }

    function ValidateMaterial_Callback(key) {
        popup("LoadControl.aspx?ctrl=Materials/ValidateMat.ascx&idmat=" + key, 540, 780, mn_ValidateMaterial);
    }

    //Show Assign Properties To Specifications Popup
    function ShowAssignPropertiesToSpecPopup(IsInitialized, SpecKey) {
        if (IsInitialized)
            popup("LoadControl.aspx?ctrl=Materials/AssignPropertiesToSpec.ascx&specid=" + SpecKey, 550, 750, mn_PropertiesAssignment);
        else
            popup("LoadControl.aspx?ctrl=Materials/AssignPropertiesToSpec.ascx", 550, 750, mn_PropertiesAssignment);
    }

    //Show Assign Properties To Norm Popup
    function ShowAssignPropertiesToNormPopup(IsInitialized, SpecKey) {
        if (IsInitialized)
            popup("LoadControl.aspx?ctrl=Materials/AssignPropertiesToNorms.ascx&specid=" + SpecKey, 550, 750, mn_Affectations);
        else
            popup("LoadControl.aspx?ctrl=Materials/AssignPropertiesToNorms.ascx", 550, 750, mn_Affectations);
    }
    //Show matching specification to Spec
    function ShowCorrespSpecPopup() {
        popup("LoadControl.aspx?ctrl=Materials/Param_CorrespSpec.ascx", 550, 750, h_CorrespSpec); //Param_CorrespSpec
    }

   

    //Show materials Matching ui
    function ShowEquivalentMaterialsPopup(offer, material) {
        if (offer && material)
            popup("LoadControl.aspx?ctrl=Materials/EquivalentMaterialsUI.ascx&mkey=" + material + "&okey=" + offer, 600, 950, h_EquivalentMaterials); //Param_CorrespSpec            
        else
            popup("LoadControl.aspx?ctrl=Materials/EquivalentMaterialsUI.ascx", 600, 950, h_EquivalentMaterials); //Param_CorrespSpec
    }

    //Show Assign Supplier to Spec
    function ShowAssignSupplierToSpecPopup(IsInitialized, key) {
        
        if (IsInitialized)
            popup("LoadControl.aspx?ctrl=Materials/AssignSupplier.ascx&specid=" + key, 600, 1024, mn_AssignToSuppliers);
        else
            popup("LoadControl.aspx?ctrl=Materials/AssignSpecToSupplier.ascx", 600, 1024, mn_AssignToSuppliers);
    }




    //Show Assign Norms to Spec
    function ShowAssignNormsToSpecPopup(IsInitialized, key) {
        if (IsInitialized)
            popup("LoadControl.aspx?ctrl=Materials/AssignNormToSpec.ascx&specid=" + key, 510, 700, mn_AssignNorms);
        else
            popup("LoadControl.aspx?ctrl=Materials/AssignNormToSpec.ascx", 580, 750, mn_AssignNorms);
    }


  


    //Refresh Specification Tree
    function RefreshTreeSpec() {
        tlsSpec.PerformCallback();
    }

   

    

</script>

<script type="text/javascript">
    function OnRibonItemClick(s, e) {
        
        switch (e.item.name) {
            case "rtArticle":
                SetSplitterPane('Materials/ViewUI.ascx');
                break;
            case "rbiAdd":
                ShowAddMaterialsPopup();
                break;
            case "rbiEdit":
                ShowEditMaterialPopup(); 
                break;
            case "rbiDelete":
                DeleteMaterial();
                break;      
            case "rbiDetails":
                ShowAddMaterialDetailsPopup();
                break;
            case "rbiFamilles":
                ShowSpecEditPopup();
                break;
            case "rbiGroupeDis":
                ShowSpecAssignPopup();
                break;
            case "rbiGroupeFournis":
                ShowAssignSupplierToSpecPopup(false);
                break;
            case "rbiProperties":
                ShowPropertiesManagementPopup();
                break;
            case "rbiGroupeProp":
                ShowPropertiesGroupsManagementPopup();
                break;
            case "rbiGroupeFamille":
                ShowAssignPropertiesToSpecPopup();
                break;
            case "rbiNormes":
                ShowNormManagementPopup();
                break;
            case "rbiFamileNorm":
                ShowAssignNormsToSpecPopup();
                break;
            case "rbiExigenNorme":
                ShowStandardPropertiesManagementPopup();
                break;
            case "rbiSearch" :
                SetSplitterPane('Materials/SearchUI.ascx');
                break;
            case "rbiConfig":
                SetSplitterPane('Materials/ConfigUI.ascx');
                break;   
            case "rbiArticles":
                SetSplitterPane('Materials/ViewUI.ascx');
                break;   
                
            case "mitExportExcel_Actions":
                Materials_ExportExcel(this);
                break;
            case "mitExpandTree_Actions":
                Materials_ExpandCollapse(this);
                break;
            case "mitExportPDF_Actions":
                Materials_ExportPDF(this);
                break;
            default:

                break;
        }
    }
</script>

<div style="font-size: 12px;">
    <dx:ASPxRibbon ID="ribMenu" runat="server" Theme="Glass"   >
        <FileTabTemplate>
            <div id="FileTabTemplateDiv" style="color:white;font-size:12px"  > &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
        </FileTabTemplate>
        <ClientSideEvents CommandExecuted="function( s ,e )  { OnRibonItemClick(s, e) ; }" />
            <Tabs>
        <dx:RibbonTab Name="rtArticle" Text="Produits / Services"  TabStyle-Font-Size="12px"  >
            
            <Groups>
                <dx:RibbonGroup Name="rgArticles" Text="Editions"  >
                    <Items>
                        <dx:RibbonButtonItem Name="rbiArticles"  ItemStyle-Font-Size="12px"
                          Text="Articles" Size="Large">                            
                            <LargeImage  IconID="layout_list_32x32devav" />
                        </dx:RibbonButtonItem>  
                        <dx:RibbonButtonItem Name="rbiAdd"  ItemStyle-Font-Size="12px"
                          Text="Ajouter" Size="Large">                            
                            <LargeImage  IconID="actions_add_32x32" />
                        </dx:RibbonButtonItem>         
                        <dx:RibbonButtonItem Name="rbiEdit"  ItemStyle-Font-Size="12px"
                          Text="Modifer" Size="Large">                            
                            <LargeImage  IconID="edit_edit_32x32" />
                        </dx:RibbonButtonItem>  
                           <dx:RibbonButtonItem Name="rbiDelete"  ItemStyle-Font-Size="12px"
                          Text="Supprimer" Size="Large">                            
                            <LargeImage  IconID="edit_remove_32x32office2013" />
                        </dx:RibbonButtonItem>  
                         <dx:RibbonButtonItem Name="rbiDetails"  ItemStyle-Font-Size="12px"
                          Text="Détails" Size="Large">                            
                            <LargeImage  IconID="businessobjects_boreport_32x32" />
                        </dx:RibbonButtonItem>
                         <dx:RibbonButtonItem Name="rbiSearch"  ItemStyle-Font-Size="12px"
                          Text="Rechercher" Size="Large">                            
                            <LargeImage  IconID="find_find_32x32gray" />
                        </dx:RibbonButtonItem>
                        
                                              
                    </Items>
                </dx:RibbonGroup>
                <dx:RibbonGroup Name="rgFamilles" Text="Familles"  >
                    <Items>
                        <dx:RibbonButtonItem Name="rbiFamilles"  ItemStyle-Font-Size="12px"
                          Text="Familles" Size="Large">                            
                            <LargeImage  IconID="reports_groupfieldcollection_32x32office2013"  />
                        </dx:RibbonButtonItem>         
                        <dx:RibbonButtonItem Name="rbiGroupeDis"  ItemStyle-Font-Size="12px"
                          Text="Groupement par disciplines" Size="Small">                            
                            <SmallImage  IconID="actions_group_16x16office2013" />
                        </dx:RibbonButtonItem>  
                           <dx:RibbonButtonItem Name="rbiGroupeFournis"  ItemStyle-Font-Size="12px"
                          Text="Groupement par fournisseurs" Size="Small">                                         
                            <SmallImage  IconID="people_usergroup_16x16" />
                        </dx:RibbonButtonItem>  
                        
                    </Items>
                </dx:RibbonGroup>
                <dx:RibbonGroup Name="rgProperties" Text="Propriétés"  >
                    <Items>
                        <dx:RibbonButtonItem Name="rbiProperties"  ItemStyle-Font-Size="12px"
                          Text="Propriétés" Size="Large">                            
                            <LargeImage  IconID="setup_properties_32x32office2013"  />
                        </dx:RibbonButtonItem>         
                        <dx:RibbonButtonItem Name="rbiGroupeProp"  ItemStyle-Font-Size="12px"
                          Text="Groupes de propriétés" Size="Small">                            
                            <SmallImage  IconID="reports_groupfieldcollection_16x16office2013" />
                        </dx:RibbonButtonItem>  
                           <dx:RibbonButtonItem Name="rbiGroupeFamille"  ItemStyle-Font-Size="12px"
                          Text="Propriétés des familles" Size="Small">                                         
                            <SmallImage  IconID="setup_properties_16x16office2013" />
                        </dx:RibbonButtonItem>  
                        
                    </Items>
                </dx:RibbonGroup>
                 <dx:RibbonGroup Name="rgNormes" Text="Normes"  >
                    <Items>
                        <dx:RibbonButtonItem Name="rbiNormes"  ItemStyle-Font-Size="12px"
                          Text="Normes" Size="Large">                            
                            <LargeImage  IconID="support_issue_32x32office2013"  />
                        </dx:RibbonButtonItem>         
                        <dx:RibbonButtonItem Name="rbiFamileNorm"  ItemStyle-Font-Size="12px"
                          Text="Groupement par familles" Size="Small">                            
                            <SmallImage  IconID="actions_group_16x16office2013" />
                        </dx:RibbonButtonItem>  
                           <dx:RibbonButtonItem Name="rbiExigenNorme"  ItemStyle-Font-Size="12px"
                          Text="Exigences des normes" Size="Small" Visible="false">                                         
                            <SmallImage  IconID="support_issue_16x16office2013" />
                        </dx:RibbonButtonItem>  
                        
                    </Items>
                </dx:RibbonGroup>
                <dx:RibbonGroup Name="rgActions" Text="Actions" >
                    <Items>                         
                        <dx:RibbonButtonItem Name="mitExportExcel_Actions" ItemStyle-Font-Size="12px" ToolTip="Export sous format Excel"
                          Text="Export Excel">
                            <SmallImage 
                              IconID="export_exporttoxlsx_16x16" />
                        </dx:RibbonButtonItem>
                        <dx:RibbonButtonItem Name="mitExportPDF_Actions" ItemStyle-Font-Size="12px" Tooltip="Export sous format PDF" 
                          Text="Export PDF">
                            <SmallImage 
                              IconID="export_exporttopdf_16x16" />
                        </dx:RibbonButtonItem>
                         <dx:RibbonButtonItem Name="mitExpandTree_Actions" ItemStyle-Font-Size="12px"
                          Text="Développer l'arborescence">
                            <SmallImage 
                              IconID="filterelements_autoexpand_16x16" />
                        </dx:RibbonButtonItem>
                        
                    </Items>
                </dx:RibbonGroup>

                <%-- And other groups with items --%>
            </Groups>
        </dx:RibbonTab>
                <dx:RibbonTab Name="rtConfig" Text="Paramètres"  TabStyle-Font-Size="12px"  >
            
            <Groups>
                <dx:RibbonGroup Name="rgConfig" Text="Configuration"  >
                    <Items>
                        <dx:RibbonButtonItem Name="rbiConfig"  ItemStyle-Font-Size="12px"
                          Text="Paramètres" Size="Large">                            
                            <LargeImage  IconID="actions_viewsetting_32x32devav" />
                        </dx:RibbonButtonItem>  
                        </Items>
                    </dx:RibbonGroup>
                </Groups>
                    </dx:RibbonTab>

                
    </Tabs>
</dx:ASPxRibbon>

</div>




<div style="padding-right: 0px;">
    <iframe name="ifrDetails" style="border-right: 1px solid #C0C0C0; border-left: 1px solid #C0C0C0; border-bottom: 1px solid #C0C0C0; background-color: Transparent;"
        width="100%"
        height="800px" frameborder="0" scrolling="no" id="ifrDetails" src="/DesktopModules/Materials/LoadControl.aspx?ctrl=Materials/ViewUI.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&ModuleId=<%= ModuleId %>"></iframe>
</div>
<dx:ASPxCallback ID="cbMaterialsOp" ClientInstanceName="cbMaterialsOp" runat="server" OnCallback="cbMaterialsOp_Callback">
    <ClientSideEvents CallbackComplete="function(s, e) {        
        if(e.parameter != '')
        {
            var tabParam = e.parameter.split('@@');
            if(tabParam[0].indexOf('0') == 0)
            {    
                grdMaterials.PerformCallback('0##'+tabParam[2]);
                
                if(e.result != '')
                {
                    alert(e.result);
                    tlsSpec.SetFocusedNodeKey(tabParam[2]);tlsSpec.PerformCallback('');
                }
            }
        }
    }" />
</dx:ASPxCallback>


