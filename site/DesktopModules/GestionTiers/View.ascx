<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="VD.Modules.GestionTiers.View" %>



<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<script type="text/javascript">
  //Update iframe content by loading given ctrl
    function SetSplitterPane(ctrl) {
        var protocal = 'http';
        if (document.location.href.toString().indexOf('https') == 0)
            protocal = 'https';
        window.frames['ifrDetails'].location.href = protocal + "://<%=_portalAlias %>/DesktopModules/GestionTiers/LoadControl.aspx?ctrl=" + ctrl + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&ModuleId=<%= ModuleId %>";
    }

    //Call DNN Modal Popup Window for given URL
    function popup(url, height, width, title) {
        var protocal = 'http';
        if (document.location.href.toString().indexOf('https') == 0)
            protocal = 'https';
        dnnModal.title = title;
        if (url.toString().indexOf('?') == -1)
            return dnnModal.show(protocal + "://<%=_portalAlias %>/DesktopModules/GestionTiers/" + url + "?lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&popUp=true&ModuleId=<%= ModuleId %>&TabId=" + TabId  , /*showReturn*/true, height, width, false, "");
        else
            return dnnModal.show(protocal + "://<%=_portalAlias %>/DesktopModules/GestionTiers/" + url + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>&popUp=true&ModuleId=<%= ModuleId %>&TabId=" + TabId  , /*showReturn*/true, height, width, false, "");
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
    function ShowCustomWindow() {
        if (btnCustomWindow) { btnCustomWindow.DoClick(); };
    }
    
    function ReportsViwer_ExportPDF() {
        if (reportViewer) {
            reportViewer.exportReport("PDF");
        }
    }
    function ReportsViwer_ExportExcel() {
        if (reportViewer)
            reportViewer.exportReport("Excel");
    }
    function ReportsViewer_ExpandCollapse() {
        var winObj = window.frames["ifrDetails"];
        if (winObj) {
            winObj.document.getElementById('btnExpandCollapse').click();
        };
    }

    function OnRibonItemClick(s, e)
    {
        
        switch (e.item.name) {
            case "rgTiers":
                SetSplitterPane('GestionTiers/ViewUI.ascx'); 
                break;
            case "rbiAddTiers":
                popup("LoadControl.aspx?ctrl=GestionTiers/AddTiers.ascx", 600, 950, "Ajout tier");
                break; 
            case "mitExportExcel_Actions":
                ReportsViwer_ExportExcel();
                break;
            case "mitExpandTree_Actions":
                ReportsViewer_ExpandCollapse(); 
                break;
            case "mitExportPDF_Actions":
                ReportsViwer_ExportPDF();
                break;
              default:
                
                break;
        }
    }
</script>


<div style="font-size: 12px;">
    <dx:ASPxRibbon ID="ribMenu" runat="server" Theme="Glass"   >
        <FileTabTemplate>
            <div id="FileTabTemplateDiv" class="fileTabTemplateDiv"></div>
        </FileTabTemplate>
        <ClientSideEvents CommandExecuted="function( s ,e )  { OnRibonItemClick(s, e) ; }" />
            <Tabs>
        <dx:RibbonTab Name="rtTiers" Text="Gestion des tiers"  >
            
            <Groups>
                <dx:RibbonGroup Name="rgTiers" Text="Tiers" >
                    <Items>
                        <dx:RibbonButtonItem Name="rbiTiers"  ItemStyle-Font-Size="12px"
                          Text="Tiers" Size="Large">                            
                            <LargeImage 
                              IconID="businessobjects_bocontact2_32x32" />
                        </dx:RibbonButtonItem>
                        <dx:RibbonButtonItem Name="rbiAddTiers" ItemStyle-Font-Size="12px"
                          Text="Ajouter">
                            <SmallImage 
                              IconID="mail_newcontact_16x16office2013" />
                        </dx:RibbonButtonItem>
                        <dx:RibbonButtonItem Name="rbiEdit"  ItemStyle-Font-Size="12px"
                          Text="Modifier">
                            <SmallImage 
                              IconID="mail_editcontact_16x16" />
                        </dx:RibbonButtonItem>
                         <dx:RibbonButtonItem Name="rbiDelete"  ItemStyle-Font-Size="12px"
                          Text="Supprimer">
                            <SmallImage 
                              IconID="edit_delete_16x16office2013" />
                        </dx:RibbonButtonItem>
                        
                    </Items>
                </dx:RibbonGroup>
                
                <dx:RibbonGroup Name="rgTiers" Text="Actions" >
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
    </Tabs>
</dx:ASPxRibbon>

</div>

</div>
<div style="padding-right: 2px;">
    <iframe name="ifrDetails" style="border-right: 1px solid #C0C0C0; border-left: 1px solid #C0C0C0; border-bottom: 1px solid #C0C0C0; background-color: Transparent;"
        width="100%" height="580px" frameborder="0" scrolling="no" id="ifrDetails" 
        src="http://<%=_portalAlias %>/DesktopModules/GestionTiers/LoadControl.aspx?ctrl=GestionTiers/ViewUI.ascx&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>">
    </iframe>
</div>