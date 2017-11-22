<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EditMaterials.ascx.cs" Inherits="VD.Modules.Materials.EditMaterials" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxp" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dxtl" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxg" %>

<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dxpc" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>
<%@ Register TagPrefix="dnn" TagName="label" Src="~/controls/labelControl.ascx" %>


<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />
<popupWin:popupWin ID="popupWin" runat="server" />

<link href="CustomSS.css" rel="stylesheet" type="text/css" />
<script src="../../Resources/Shared/Scripts/jquery/jquery.hoverIntent.min.js" type="text/javascript"></script>
<script src="../../js/dnncore.js" type="text/javascript"></script>
<script src="../../js/dnn.jquery.js" type="text/javascript"></script>


<script type="text/javascript">
    function OnPreviousClick(s, e) {
        var indexTab = (pageControl.GetActiveTab()).index;
        pageControl.SetActiveTab(pageControl.GetTab(indexTab - 1));
        var tabName = (pageControl.GetActiveTab()).name;
        if (tabName == "TabGeneral") {
            lblIntro.SetText(IntroStep1);
            lblIntroDetails.SetText(IntroStepDetail1);
        }
    }


    var m_MaterialsAlreayExiste = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mMaterialsAlreayExiste", ressFilePath )%>';
    var mn_Brands = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mnBrands", ressFilePath )%>';
    var h_Specifications = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hSpecifications", ressFilePath )%>';
    var m_SelectDiscipline = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mSelectDiscipline", ressFilePath )%>';

    function ResultAction(e) {
        if (e.result == 'ok') {
            if (window.parent.grdMaterials)
                window.parent.grdMaterials.PerformCallback();
            window.parent.dnnModal.load();

        }
        else if (e.result == 'existe') {
            alert(m_MaterialsAlreayExiste);
            return false;
        }
        //else {
        //    return false;
        //}


    }
    // <![CDATA[
    var GridViewAdjustRequired = true;
    var textSeparator = ";";
    function DropDownHandler(s, e) {
        SynchronizeFocusedRow();
    }

    function DropDownHandlerNorm(s, e) {
        SynchronizeFocusedRowNorm();
    }

    function treaListInitHandlerNorm(s, e) {
        SynchronizeFocusedRowNorm();
    }

    function treaListInitHandler(s, e) {
        SynchronizeFocusedRow();
    }
    function RowClickHandler(s, e) {
        var key = e.nodeKey;
        DropDownEdit.SetKeyValue(key);
        var index = treeList.cpKeyValues.indexOf(key);
        DropDownEdit.SetValue(treeList.cpKeyValues[index]);
        DropDownEdit.SetText(treeList.cpEmployeeNames[index]);
        treeListNorm.PerformCallback('ValueChanged');

    }

    function RowClickHandlerNorm(s, e) {
        treeListNorm.GetSelectedNodeValues("ID", RowClickHandlerNorm_Callback);
    }
    function RowClickHandlerNorm_Callback(keys) {
        
        var texts = [] ;
        var items = [] ;
        DropDownEditNorm.SetKeyValue(keys);
        for (i = 0 ; i < keys.length ; i++) {
            var index = treeListNorm.cpNormKeyValues.indexOf(keys[i].toString());            
            texts.push(treeListNorm.cpNormNames[index]);
            items.push(treeListNorm.cpNormKeyValues[index]);
        }
        var ret = items.join(textSeparator);         
        DropDownEditNorm.SetKeyValue(ret);
        DropDownEditNorm.SetText(texts.join(textSeparator));
    }

    function SynchronizeFocusedRow() {
        var keyValue = DropDownEdit.GetKeyValue();
        if (keyValue != null) {
            treeList.SetFocusedNodeKey(keyValue);
            treeList.PerformCallback(keyValue)
            UpdateEditBox();
        }
    }

    function SynchronizeFocusedRowNorm() {
        var keyValue = DropDownEditNorm.GetKeyValue();
        if (keyValue != null) {
            for (i = 0 ; i < keyValue.length ; i++)
                treeListNorm.SelectNode(keyValue);
        }
    }

    function UpdateEditBox() {
        var rowIndex = treeList.GetFocusedNodeKey();
        var focusedEmployeeName = rowIndex == -1 ? "" : rowIndex;
        var employeeNameInEditBox = DropDownEdit.GetKeyValue();
        if (employeeNameInEditBox != focusedEmployeeName)
            DropDownEdit.SetText(focusedEmployeeName);
    }
    // ]]> 

    function AddProperties() {
        grdMaterialsSpec.PerformCallback('saveproperties');
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

    function ShowPopupCustomProperties() {
        oldPopup("LoadControl.aspx?ctrl=Materials/AddCustomProperties.ascx", 400, 850, '<%= DotNetNuke.Services.Localization.Localization.GetString("mAddProperties", ressFilePath)%>');
    }

    function ShowPopupMesureSystem() {
        oldPopup("LoadControl.aspx?ctrl=Materials/AddCustomProperties.ascx", 400, 850, '<%= DotNetNuke.Services.Localization.Localization.GetString("mAddProperties", ressFilePath)%>');
    }
   
</script>

<script type="text/javascript">
    var IntroStep1 = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mIntroMaterial1", ressFilePath )%>';
    var IntroStepDetail1 = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mIntroMaterial_Details1", ressFilePath )%>';
    var IntroStep2 = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mIntroMaterial2", ressFilePath )%>';
    var IntroStepDetail2 = '<%=GlobalAPI.CommunUtility.getRessourceEntry("mIntroMaterial_Details2", ressFilePath )%>';
    $(document).ready(function () {
        $('.dnnTooltip').dnnTooltip();
        lblIntro.SetText(IntroStep1);
        lblIntroDetails.SetText(IntroStepDetail1);
    });


    function OnButtonClick(s, e) {
        window.document.getElementById('diverror').style.display = 'none';
        var indexTab = (pageControl.GetActiveTab()).index;
        var tabName = (pageControl.GetActiveTab()).name;
        if (ASPxClientEdit.ValidateGroup('group' + tabName))
            StepCallback.PerformCallback(indexTab);
    }

    function OnTabChanging(s, e) {
        var tabName = (pageControl.GetActiveTab()).name;
        e.cancel = !ASPxClientEdit.ValidateGroup('group' + tabName);
    }
    function StepCallbackComplete(s, e) {
        var ret = e.result.toString().split("#")[0];
        if (ret == "ok") {
            txtMaterialsID.SetText(e.result.toString().split("#")[2].toString());
            var indexTab = parseInt(e.result.toString().split("#")[1].toString());
            if (indexTab == 1) {
                popupValidation.ShowAtElement(pageControl.GetMainElement());
                popupValidation.UpdatePositionAtElement(pageControl.GetMainElement());
            }
            else
                pageControl.SetActiveTab(pageControl.GetTab(indexTab + 1));
            if ((indexTab + 1) == 1) {
                lblIntro.SetText(IntroStep2);
                lblIntroDetails.SetText(IntroStepDetail2);
            }
            if (indexTab == 0) {
                window.document.getElementById('table_tlsPropertiesGroups').style.display = '';
                window.document.getElementById('table_tlsPropertiesGroupsNorm').style.display = 'none';
                tlsPropertiesGroups.PerformCallback();
                CallbackPanelGeneral.PerformCallback();
            }
        }
        else if (ret == "erreur") {
            var msgerreur = e.result.toString().split("#")[1].toString();
            lblerror.SetText(msgerreur);
            window.document.getElementById('diverror').style.display = '';
        }
        else
            window.parent.dnnModal.load();
    }

    function OnFinishClick(s, e) {
        if (ASPxClientEdit.ValidateGroup('groupTabResume')) {
            /*popupValidation.ShowAtElement(pageControl.GetMainElement());
            popupValidation.UpdatePositionAtElement(pageControl.GetMainElement());//ShowTabs*/
            StepCallback.PerformCallback('1');
        }
    }

    function OnCancelClick(s, e) {
        StepCallback.PerformCallback("cancel");
    }

    function SelectPropertiesCallbackComplete(s, e) {
        grdMaterialsSpec.PerformCallback();
    }

    //Show Brand Management Popup
    function ShowBrandEditPopup() {
        oldPopup("LoadControl.aspx?ctrl=Materials/AddBrandCtrl.ascx&mode=add", 150, 600, mn_Brands);
    }

    //Show Specification Management Popup
    function ShowSpecEditPopup() {
        var disp = cmbDiscipline.GetValue();
        if (disp != null)
            oldPopup("LoadControl.aspx?ctrl=Materials/ManageSpec.ascx&DisciplineID=" + disp, 420, 650, h_Specifications);
        else
            alert(m_SelectDiscipline);
    }
</script>
<dx:ASPxCallback ID="StepCallback" runat="server" ClientIDMode="AutoID" ClientInstanceName="StepCallback"
    OnCallback="StepCallback_Callback">
    <ClientSideEvents CallbackComplete="StepCallbackComplete" />
</dx:ASPxCallback>

<dx:ASPxCallback ID="SelectPropertiesCallback" runat="server" ClientIDMode="AutoID" ClientInstanceName="SelectPropertiesCallback"
    OnCallback="SelectPropertiesCallback_Callback">
    <ClientSideEvents CallbackComplete="SelectPropertiesCallbackComplete" />
</dx:ASPxCallback>

<div class="dnnFormMessage dnnFormValidationSummary" id="diverror" style="display: none;">
    <dx:ASPxLabel ID="lblerror" runat="server" ClientInstanceName="lblerror" ClientIDMode="AutoID"></dx:ASPxLabel>
</div>
<div style="display: none;">
    <dx:ASPxTextBox ID="txtMaterialsID" ClientIDMode="AutoID" ClientInstanceName="txtMaterialsID" runat="server"></dx:ASPxTextBox>

</div>

<table style="width: 100%; border: 1px solid #4986A2; background-color: #EDF3F4; border-bottom-style: none; border-top: 3px solid #4986A2;">
    <tr>
        <td>
            <dx:ASPxLabel ID="lblIntro" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblIntro" Font-Bold="true" Text="Etape 1 :"></dx:ASPxLabel>
        </td>
    </tr>
    <tr>
        <td>
            <dx:ASPxLabel ID="lblIntroDetails" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblIntroDetails" Font-Size="10px" Text="Veuillez sélectionner "></dx:ASPxLabel>
        </td>
    </tr>
</table>

<dx:ASPxPageControl ID="pageControl" ClientInstanceName="pageControl" runat="server" Width="100%" ShowTabs="false"
    ActiveTabIndex="0" EnableHierarchyRecreation="true" Theme="Glass">
    <ClientSideEvents ActiveTabChanging="OnTabChanging" />
    <TabPages>
        <dx:TabPage Name="TabGeneral" Text="Générale">
            <ContentCollection>
                <dx:ContentControl ID="ContentControl1" runat="server">

                    <table style="width: 100%;">
                        <tr>
                            <td class="label_td">

                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label2" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblCode", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div3" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span1" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblCode_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>


                            </td>
                            <td style="width: 300px">
                                <dx:ASPxRadioButtonList ID="rdbtnListCode" runat="server" Theme="Glass" RepeatDirection="Horizontal" Border-BorderStyle="None" SelectedIndex="0"
                                    ClientInstanceName="rdbtnListCode">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
	if( rdbtnListCode.GetValue() != '0' ) txtCode.SetVisible(false); else txtCode.SetVisible(true);
}"></ClientSideEvents>
                                    <Items>
                                        <dx:ListEditItem Text="Par Défaut" Value="0" Selected="true" />
                                        <dx:ListEditItem Text="Code à barre" Value="1" />
                                        <dx:ListEditItem Text="Généré" Value="2" />
                                    </Items>
                                </dx:ASPxRadioButtonList>

                            </td>
                            <td class="label_td"></td>
                            <td>
                                <dx:ASPxTextBox ID="txtCode" runat="server" Theme="Glass" Width="100%" ClientInstanceName="txtCode"></dx:ASPxTextBox>
                                <asp:Image ID="myBarCode" Visible="false" ImageUrl="BarCode.aspx?code=31231" runat="server"></asp:Image>
                                <dx:ASPxTextBox ID="lblCodeGenerer" runat="server" Visible="false" Enabled="false" Theme="Glass" Width="100%" ClientInstanceName="lblCodeGenerer"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="label_td">

                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label1" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblName", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div1" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span2" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblName_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>

                            </td>
                            <td style="width: 300px">
                                <txtEifBox:txtEifBox ID="txtNom" runat="server" Width="300" ImageSrc="~/images/expand.gif" Theme="Glass" />
                            </td>
                            <td class="label_td">


                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label3" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblDescription", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div2" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span3" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblDescription_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>
                            </td>
                            <td style="width: 300px">
                                <txtEifBox:txtEifBox ID="txtDescription" runat="server" Width="300" ImageSrc="~/images/expand.gif" Theme="Glass" />
                            </td>
                        </tr>

                        
                            <tr>
                                <td class="label_td">

                                    <div class="dnnTooltip" style="width: 120px;">
                                        <asp:Label ID="Label10" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblEtatVente", ressFilePath)%>
                                            </a>
                                        </asp:Label>
                                        <div id="Div1" class="dnnFormHelpContent dnnClear" style="display: none;">
                                            <span id="Span2" class="dnnHelpText">
                                                <%= DotNetNuke.Services.Localization.Localization.GetString("lblEtatVente_help", ressFilePath)%>
                                            </span><a href="#" class="pinHelp"></a>
                                        </div>
                                    </div>

                                </td>
                                <td  >
                                    <dx:ASPxComboBox ID="cmbEtatVente" runat="server" Theme="Glass" Width="100%" ValueType="System.Int32">
                                        <Items>
                                            <dx:ListEditItem Text="En Vente" Value="1" />
                                            <dx:ListEditItem Text="Hors Vente" Value="0" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                    
                                </td>

                                  
                                <td class="label_td">


                                    <div class="dnnTooltip" style="width: 120px;">
                                        <asp:Label ID="Label14" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblEtatAchat", ressFilePath)%>
                                            </a>
                                        </asp:Label>
                                        <div id="Div2" class="dnnFormHelpContent dnnClear" style="display: none;">
                                            <span id="Span3" class="dnnHelpText">
                                                <%= DotNetNuke.Services.Localization.Localization.GetString("lblEtatAchat_help", ressFilePath)%>
                                            </span><a href="#" class="pinHelp"></a>
                                        </div>
                                    </div>
                                </td>
                                <td >
                                    <dx:ASPxComboBox ID="cmbEtatAchat" runat="server" Theme="Glass" Width="100%" ValueType="System.Int32">
                                        <Items>
                                            <dx:ListEditItem Text="En Achat" Value="1"  />
                                            <dx:ListEditItem Text="Hors Achat" Value="0" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>


                                
                            </tr>

                             <tr>
                               <td class="label_td">
                                    <div class="dnnTooltip" style="width: 120px;">
                                        <asp:Label ID="Label11" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblLimitstock", ressFilePath)%>
                                            </a>
                                        </asp:Label>
                                        <div id="Div2" class="dnnFormHelpContent dnnClear" style="display: none;">
                                            <span id="Span3" class="dnnHelpText">
                                                <%= DotNetNuke.Services.Localization.Localization.GetString("lblLimitstock_help", ressFilePath)%>
                                            </span><a href="#" class="pinHelp"></a>
                                        </div>
                                    </div>
                                </td>
                                <td >
                                     <dx:ASPxTextBox ID="txtStockLimit" Theme="Glass" runat="server" Width="100%" >
                                          <MaskSettings Mask="<0..999999999>.<000..999>" IncludeLiterals="DecimalSymbol" />
                                            <ValidationSettings ErrorDisplayMode="None">
                                                <ErrorFrameStyle>
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                     </dx:ASPxTextBox>

                                </td>
                                <td class="label_td">


                                    <div class="dnnTooltip" style="width: 120px;">
                                        <asp:Label ID="Label13" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblSotkcdesire", ressFilePath)%>
                                            </a>
                                        </asp:Label>
                                        <div id="Div2" class="dnnFormHelpContent dnnClear" style="display: none;">
                                            <span id="Span3" class="dnnHelpText">
                                                <%= DotNetNuke.Services.Localization.Localization.GetString("lblSotkcdesire_help", ressFilePath)%>
                                            </span><a href="#" class="pinHelp"></a>
                                        </div>
                                    </div>
                                </td>
                                <td >
                                  <dx:ASPxTextBox ID="txtStockdesire" Theme="Glass" runat="server" Width="100%" >
                                       <MaskSettings Mask="<0..999999999>.<000..999>" IncludeLiterals="DecimalSymbol" />
                                            <ValidationSettings ErrorDisplayMode="None">
                                                <ErrorFrameStyle>
                                                    <Paddings Padding="0px" />
                                                    <Border BorderWidth="0px" />
                                                </ErrorFrameStyle>
                                            </ValidationSettings>
                                  </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                 <td class="label_td">
                                    <div class="dnnTooltip" style="width: 120px;">
                                        <asp:Label ID="Label12" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblCodedouane", ressFilePath)%>
                                            </a>
                                        </asp:Label>
                                        <div id="Div2" class="dnnFormHelpContent dnnClear" style="display: none;">
                                            <span id="Span3" class="dnnHelpText">
                                                <%= DotNetNuke.Services.Localization.Localization.GetString("lblCodedouane_help", ressFilePath)%>
                                            </span><a href="#" class="pinHelp"></a>
                                        </div>
                                    </div>
                                </td>
                                <td >
                                     <dx:ASPxTextBox ID="txtcodeDouane" Theme="Glass" runat="server" Width="100%" >
                                         
                                     </dx:ASPxTextBox>

                                </td> 
                                <td class="label_td">
                                    <div class="dnnTooltip" style="width: 120px;">
                                        <asp:Label ID="Label15" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblpaysorigine", ressFilePath)%>
                                            </a>
                                        </asp:Label>
                                        <div id="Div2" class="dnnFormHelpContent dnnClear" style="display: none;">
                                            <span id="Span3" class="dnnHelpText">
                                                <%= DotNetNuke.Services.Localization.Localization.GetString("lblpaysorigine_help", ressFilePath)%>
                                            </span><a href="#" class="pinHelp"></a>
                                        </div>
                                    </div>
                                </td>
                                <td >
                                     <dx:ASPxComboBox ID="cmbPaysOrigine" runat="server" Theme="Glass"  IncrementalFilteringMode="Contains" Width="100%"  AllowNull="true" 
                                         DataSourceID="SqlPaysOrigineDS"  ValueField="ID" TextField="Designation"  ValueType="System.Int32"  >
                                     </dx:ASPxComboBox>

                                </td> 

                            </tr>


                        <tr>
                            <td class="label_td">


                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label4" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblDiscipline", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div4" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span4" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblDiscipline_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbDiscipline" ClientInstanceName="cmbDiscipline" runat="server" Theme="Glass" Width="100%" DataSourceID="SqlDisciplineDS"
                                    TextField="Designation" ValueField="Abreviation" IncrementalFilteringMode="Contains">
                                    <ClientSideEvents ValueChanged="function(s, e) {treeList.PerformCallback();}"></ClientSideEvents>
                                </dx:ASPxComboBox>
                            </td>
                            <td class="label_td">
                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label5" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblFamille", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div5" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span5" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblFamille_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>
                            </td>
                            <td style="width: 300px">
                                <table style="width: 100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <dx:ASPxDropDownEdit ID="DropDownEdit" runat="server" Width="100%" ClientInstanceName="DropDownEdit"
                                    AllowUserInput="False" EnableAnimation="False" Theme="Glass">
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="true" ErrorText="Ce champ ne peut pas ètre vide." />
                                    </ValidationSettings>
                                    <DropDownWindowStyle>
                                        <Border BorderWidth="0px" />
                                    </DropDownWindowStyle>
                                    <DropDownWindowTemplate>
                                        <dxtl:ASPxTreeList ID="treeList" runat="server" Theme="Glass" Width="100%" ClientInstanceName="treeList"
                                            AutoGenerateColumns="False" DataSourceID="SqlMaterialsSpecificationDS" EnableTheming="True" KeyFieldName="ID"
                                            ParentFieldName="Id_Parent" OnCustomCallback="treeList_CustomCallback" OnCustomJSProperties="treeList_CustomJSProperties">
                                            <SettingsBehavior AllowFocusedNode="true" />
                                            <Columns>
                                                <dxtl:TreeListDataColumn Caption="Description" FieldName="Designation">
                                                </dxtl:TreeListDataColumn>
                                            </Columns>
                                            <ClientSideEvents Init="treaListInitHandler" NodeClick="RowClickHandler" />
                                        </dxtl:ASPxTreeList>
                                        <table style="width: 100%">
                                            <tr>
                                                <td align="right">
                                                    <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Fermer" Theme="Glass">
                                                        <ClientSideEvents Click="function(s, e){ DropDownEdit.HideDropDown(); }" />
                                                    </dx:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </DropDownWindowTemplate>
                                    <ClientSideEvents DropDown="DropDownHandler" />
                                </dx:ASPxDropDownEdit>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>
                                            <img src="/images/Materials/add_large.png" style="height: 16px; width: 16px; border-width: 0px;" onclick="ShowSpecEditPopup();">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="label_td">


                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label6" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblNorm", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div6" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span6" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblNorm_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>


                            </td>
                            <td style="width: 300px">
                                <dx:ASPxDropDownEdit ID="DropDownEditNorm" runat="server" Width="100%" ClientInstanceName="DropDownEditNorm"
                                    AllowUserInput="False" EnableAnimation="False" Theme="Glass" >
                                    <ValidationSettings Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                        <RequiredField IsRequired="false" ErrorText="Ce champ ne peut pas ètre vide." />
                                    </ValidationSettings>
                                    <DropDownWindowStyle>
                                        <Border BorderWidth="0px" />
                                    </DropDownWindowStyle>
                                    <DropDownWindowTemplate>
                                        <dxtl:ASPxTreeList ID="treeListNorm" runat="server" Theme="Glass" Width="100%" ClientInstanceName="treeListNorm"
                                            AutoGenerateColumns="False" DataSourceID="SqlNormFamiliesDS" EnableTheming="True" KeyFieldName="ID"
                                            ParentFieldName="ParentID" OnCustomCallback="treeListNorm_CustomCallback" OnCustomJSProperties="treeListNorm_CustomJSProperties">
                                            <SettingsBehavior AllowFocusedNode="true" />
                                            <Columns>
                                                <dxtl:TreeListTextColumn FieldName="Designation" ReadOnly="True" VisibleIndex="0">
                                                </dxtl:TreeListTextColumn>
                                            </Columns>
                                            <SettingsSelection Enabled="True" />
                                            <ClientSideEvents Init="treaListInitHandlerNorm" SelectionChanged="RowClickHandlerNorm" />
                                        </dxtl:ASPxTreeList>
                                        <table style="width: 100%">
                                            <tr>
                                                <td align="right">
                                                    <dx:ASPxButton ID="ASPxButton1" AutoPostBack="False" runat="server" Text="Fermer" Theme="Glass">
                                                        <ClientSideEvents Click="function(s, e){ DropDownEditNorm.HideDropDown(); }" />
                                                    </dx:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>
                                    </DropDownWindowTemplate>
                                    <ClientSideEvents DropDown="DropDownHandlerNorm" />
                                </dx:ASPxDropDownEdit>
                            </td>
                             <td class="label_td">
                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label9" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("mnBrand", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div9" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span9" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lbBrand_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <table style="width: 100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbBrands" ClientInstanceName="cmbBrands" runat="server" Theme="Glass" Width="100%" DataSourceID="SqlBrandsDS"
                                                TextField="Designation" ValueField="ID" IncrementalFilteringMode="Contains" ValueType="System.Int32" OnCallback="cmbBrands_Callback">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>
                                            <img src="/images/Materials/add_large.png" style="height: 16px; width: 16px; border-width: 0px;" onclick="ShowBrandEditPopup();">
                                        </td>
                                    </tr>

                                </table>
                            </td>

                        </tr>
                    </table>

                    <hr />
                    <div align="right">
                        <table>
                            <tr>
                                 

                                <td>
                                    <dx:ASPxButton ID="btnNextGeneral" runat="server" Text="Suivant" ClientInstanceName="btnNextGeneral"
                            AutoPostBack="false" ValidationGroup="groupTabGeneral" Theme="Glass">
                            <ClientSideEvents Click="OnButtonClick" />
                        </dx:ASPxButton>
                                </td>
                                 <td style="width:100px; " align="right">                                           
                                            <dx:ASPxButton ID="btnAnnuler1" runat="server" Text="Annuler" ClientInstanceName="btnAnnuler1"
                                                AutoPostBack="false" Theme="Glass"   >
                                                <ClientSideEvents Click="OnCancelClick" />
                                            </dx:ASPxButton>
                                        </td>
                            </tr>
                        </table>
                        
                    </div>
                    <dx:ASPxValidationSummary ID="validSummaryGeneral" runat="server" ValidationGroup="groupTabGeneral" Theme="Glass">
                    </dx:ASPxValidationSummary>
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
        <dx:TabPage Name="TabDetails" Text="Date">

            <ContentCollection>
                <dx:ContentControl ID="ContentControl2" runat="server">

                    <dx:ASPxCallbackPanel ID="CallbackPanelGeneral" ClientIDMode="AutoID" ClientInstanceName="CallbackPanelGeneral" runat="server"
                        Theme="Glass" Width="100%" OnCallback="CallbackPanelGeneral_Callback">
                        <PanelCollection>
                            <dxp:PanelContent ID="panelcontentGeneral">
                                <table style="width: 100%; border: 1px solid #4986A2;">
                                    <tr>
                                        <td class="label_td">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblCode", ressFilePath)%>                                
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCode" runat="server"></asp:Label>
                                        </td>
                                        <td class="label_td">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblName", ressFilePath)%>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblName" runat="server"></asp:Label>

                                        </td>
                                    </tr>
                                    <tr>

                                        <td class="label_td">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblDescription", ressFilePath)%>
                                
                                        </td>
                                        <td style="width: 300px">
                                            <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                        </td>
                                        <td class="label_td">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblDiscipline", ressFilePath)%>
                                
                                        </td>
                                        <td>
                                            <asp:Label ID="lblDiscipline" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label_td">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblFamille", ressFilePath)%>
                                
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSpec" runat="server"></asp:Label>
                                        </td>
                                        <td class="label_td">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblNorm", ressFilePath)%>
                                
                                        </td>
                                        <td style="width: 300px">
                                            <asp:Label ID="lblNorm" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </dxp:PanelContent>
                        </PanelCollection>
                    </dx:ASPxCallbackPanel>

                    <table style="width: 100%;">
                        <tr>
                            <td class="label_td" style="width: 60px;vertical-align:middle;">


                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label7" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblFilter", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div7" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span7" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblFilter_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>


                            </td>
                            <td style="width: 200px;">
                                <dx:ASPxRadioButtonList ID="rdbtnListFilter" ClientIDMode="AutoID" ClientInstanceName="rdbtnListFilter" runat="server" Theme="Glass"
                                    Width="100%" RepeatDirection="Horizontal" SelectedIndex="0">
                                    <ClientSideEvents ValueChanged="function(s, e) { 
if(rdbtnListFilter.GetValue() == 1 )
                                        {
 grdLookCases.SetEnabled(true) ;
grdLookCases.GetGridView().PerformCallback();
  window.document.getElementById('table_tlsPropertiesGroups').style.display='none';
window.document.getElementById('table_tlsPropertiesGroupsNorm').style.display='';
                                        }
 else 
                                        {
grdLookCases.SetEnabled(false) ; 
  window.document.getElementById('table_tlsPropertiesGroups').style.display='';
window.document.getElementById('table_tlsPropertiesGroupsNorm').style.display='none';
                                        }
 
}"></ClientSideEvents>
                                    <Border BorderStyle="None" />
                                    <Items>
                                        <dx:ListEditItem Text="Par Famille" Value="0" Selected="true" />
                                        <dx:ListEditItem Text="Par Norm" Value="1" />
                                    </Items>
                                </dx:ASPxRadioButtonList>
                            </td>
                            <td class="label_td" style="width: 120px;vertical-align:middle;">


                                <div class="dnnTooltip" style="width: 120px;">
                                    <asp:Label ID="Label8" runat="server" CssClass="dnnFormHelp">
                                            <a tabindex="-1" class="dnnFormHelp" style="width:120px;">
                                                 <%= DotNetNuke.Services.Localization.Localization.GetString("lblCases", ressFilePath)%>
                                            </a>
                                    </asp:Label>
                                    <div id="Div8" class="dnnFormHelpContent dnnClear" style="display: none;">
                                        <span id="Span8" class="dnnHelpText">
                                            <%= DotNetNuke.Services.Localization.Localization.GetString("lblCases_help", ressFilePath)%>
                                        </span><a href="#" class="pinHelp"></a>
                                    </div>
                                </div>


                            </td>
                            <td>
                                <dx:ASPxGridLookup ID="grdLookCases" ClientInstanceName="grdLookCases" ClientEnabled="false" ClientIDMode="AutoID" runat="server"
                                    AutoGenerateColumns="False" DataSourceID="SqlCasesByNormDS" Theme="Glass" EnableTheming="True" OnInit="grdLookCases_Init"
                                    KeyFieldName="ID" Width="240px" TextFormatString="{4} - {2}">
                                    <GridViewProperties>
                                        <SettingsBehavior AllowGroup="true" />
                                    </GridViewProperties>
                                    <Columns>
                                        <dxg:GridViewDataTextColumn FieldName="ID" Visible="false" VisibleIndex="0"></dxg:GridViewDataTextColumn>
                                        <dxg:GridViewDataTextColumn FieldName="IDCase" Visible="false" VisibleIndex="0"></dxg:GridViewDataTextColumn>
                                        <dxg:GridViewDataTextColumn FieldName="LibCase" Caption="Cas d'utlisation" VisibleIndex="1"></dxg:GridViewDataTextColumn>
                                        <dxg:GridViewDataTextColumn FieldName="IDNorm" VisibleIndex="2" Visible="false"></dxg:GridViewDataTextColumn>
                                        <dxg:GridViewDataTextColumn FieldName="NormName" VisibleIndex="3" Caption="Norme" GroupIndex="0"></dxg:GridViewDataTextColumn>
                                    </Columns>
                                    <ClientSideEvents ValueChanged="function(s, e) {
tlsPropertiesGroupsNorm.PerformCallback();
}"></ClientSideEvents>
                                </dx:ASPxGridLookup>
                            </td>




                            <td align="right">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Image ID="Image2" runat="server" ImageUrl="~/images/Materials/add_16x16.png" />
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>
                                            <a class="dxeHyperlink_Glass" onclick="ShowPopupCustomProperties(); return false;" href="#" style="color: #4986A2; font-size: 11px; font-weight: bold;">
                                                <%= DotNetNuke.Services.Localization.Localization.GetString("PlusProperties", ressFilePath)  %>                        
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <table style="width: 100%; display: none;" id="table_tlsPropertiesGroups">
                                    <tr>
                                        <td>
                                            <dxtl:ASPxTreeList ID="tlsPropertiesGroups" ClientInstanceName="tlsPropertiesGroups" ClientIDMode="AutoID" runat="server"
                                                Height="100%" EnableCallbackCompression="False" OnCustomCallback="tlsPropertiesGroups_CustomCallback" OnHtmlRowPrepared="tlsPropertiesGroups_HtmlRowPrepared"
                                                Theme="Metropolis" BackColor="Transparent" Width="100%" KeyFieldName="Id" ParentFieldName="ParentId" AutoGenerateColumns="False"
                                                OnHtmlDataCellPrepared="tlsPropertiesGroups_HtmlDataCellPrepared" DataSourceID="PropertiesHiearchyDS">
                                                <Columns>
                                                    <dxtl:TreeListTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="ParentId" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="Designation" ShowInCustomizationForm="True" VisibleIndex="2">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="PropertyDesignation" ShowInCustomizationForm="True" VisibleIndex="3" Width="300px">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="PropertyID" ShowInCustomizationForm="True" Width="200" VisibleIndex="4">
                                                        <DataCellTemplate>
                                                            <dx:ASPxTextBox ID="txtPropertyValue" runat="server" Theme="Glass" OnInit="txtPropertyValue_Init" Width="200px"></dx:ASPxTextBox>
                                                        </DataCellTemplate>
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="PropertyID" ShowInCustomizationForm="True" VisibleIndex="5">
                                                        <DataCellTemplate>
                                                            <dx:ASPxComboBox ID="cmbMeasureUnit" runat="server" Theme="Glass" Width="150px" OnInit="cmbMeasureUnit_Init"
                                                                TextField="Designation" ValueField="ID" DataSourceID="SqlMesureUnitDS" ValueType="System.Int32" OnCallback="cmbMeasureUnit_Callback">
                                                                <ClientSideEvents GotFocus="function(s, e) { s.PerformCallback(); }"></ClientSideEvents>
                                                            </dx:ASPxComboBox>
                                                        </DataCellTemplate>
                                                    </dxtl:TreeListTextColumn>
                                                </Columns>
                                                <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="false" GridLines="Horizontal"
                                                    ShowColumnHeaders="false" ShowTreeLines="false" VerticalScrollBarMode="Hidden" ScrollableHeight="150"></Settings>
                                                <SettingsBehavior ProcessFocusedNodeChangedOnServer="false" ProcessSelectionChangedOnServer="false" AutoExpandAllNodes="False" AllowDragDrop="False"></SettingsBehavior>
                                                <SettingsSelection Enabled="True" />
                                                <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>
                                            </dxtl:ASPxTreeList>
                                        </td>
                                        <td style="width: 25px; vertical-align: top;">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="imExpand2" ImageUrl="../../images/Materials/icon_expand.png" OnClientClick="tlsPropertiesGroups.ExpandAll();return false;" /></td>
                                                    <td>&nbsp;</td>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="imCollapse2" ImageUrl="../../images/Materials/icon_collapse.png" OnClientClick="tlsPropertiesGroups.CollapseAll();return false;" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>

                                <table style="width: 100%; display: none;" id="table_tlsPropertiesGroupsNorm">
                                    <tr>
                                        <td>
                                            <dxtl:ASPxTreeList ID="tlsPropertiesGroupsNorm" ClientInstanceName="tlsPropertiesGroupsNorm" ClientIDMode="Static" runat="server" OnHtmlRowPrepared="tlsPropertiesGroupsNorm_HtmlRowPrepared"
                                                Height="100%" EnableCallbackCompression="False" DataSourceID="PropertiesHiearchyByNormDS" OnCustomCallback="tlsPropertiesGroupsNorm_CustomCallback"
                                                Theme="Metropolis" BackColor="Transparent" Width="100%" KeyFieldName="Id" ParentFieldName="ParentId" AutoGenerateColumns="False" OnHtmlDataCellPrepared="tlsPropertiesGroupsNorm_HtmlDataCellPrepared">
                                                <Columns>
                                                    <dxtl:TreeListTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="ParentId" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="Designation" ShowInCustomizationForm="True" VisibleIndex="2">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="PropertyDesignation" ShowInCustomizationForm="True" VisibleIndex="3" Width="50%">
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="PropertyID" ShowInCustomizationForm="True" Width="30%" VisibleIndex="4">
                                                        <DataCellTemplate>
                                                            <dx:ASPxTextBox ID="txtPropertyValue" runat="server" Theme="Glass" OnInit="txtPropertyValue_Init" Width="100%" AutoPostBack="false"></dx:ASPxTextBox>
                                                        </DataCellTemplate>
                                                    </dxtl:TreeListTextColumn>
                                                    <dxtl:TreeListTextColumn FieldName="PropertyID" ShowInCustomizationForm="True" Width="20%" VisibleIndex="5">
                                                        <DataCellTemplate>
                                                            <dx:ASPxComboBox ID="cmbMeasureUnitNorm" runat="server" Theme="Glass" Width="100%" OnInit="cmbMeasureUnitNorm_Init" AutoPostBack="false"
                                                                TextField="Designation" ValueField="ID" DataSourceID="SqlMesureUnitDS" ValueType="System.Int32" OnCallback="cmbMeasureUnitNorm_Callback">
                                                                <ClientSideEvents GotFocus="function(s, e) {
	s.PerformCallback();
}"></ClientSideEvents>
                                                            </dx:ASPxComboBox>
                                                        </DataCellTemplate>
                                                    </dxtl:TreeListTextColumn>
                                                </Columns>
                                                <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="false" GridLines="Horizontal"
                                                    ShowColumnHeaders="false" ShowTreeLines="false" VerticalScrollBarMode="Hidden" ScrollableHeight="150"></Settings>
                                                <SettingsBehavior ProcessFocusedNodeChangedOnServer="false" ProcessSelectionChangedOnServer="false" AutoExpandAllNodes="False" AllowDragDrop="False"></SettingsBehavior>
                                                <SettingsSelection Enabled="True" />
                                                <SettingsLoadingPanel Enabled="False"></SettingsLoadingPanel>
                                            </dxtl:ASPxTreeList>
                                        </td>
                                        <td style="width: 25px; vertical-align: top;">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="../../images/Materials/icon_expand.png" OnClientClick="tlsPropertiesGroupsNorm.ExpandAll();return false;" /></td>
                                                    <td>&nbsp;</td>
                                                    <td align="right" style="cursor: hand; cursor: pointer;">
                                                        <asp:ImageButton runat="server" ID="ImageButton2" ImageUrl="../../images/Materials/icon_collapse.png" OnClientClick="tlsPropertiesGroupsNorm.CollapseAll();return false;" /></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>



                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <div align="right" style="padding-top: 5px; padding-bottom: 5px;">
                                    <dx:ASPxButton ID="SaveProperties" runat="server" Theme="Metropolis" Width="220px" AutoPostBack="false" Text="Sélectionner">
                                        <ClientSideEvents Click="function(s,e){SelectPropertiesCallback.PerformCallback(); }" />
                                        <Image Url="~/images/Materials/vers-bas-16.png"></Image>
                                    </dx:ASPxButton>

                                </div>
                                <dxg:ASPxGridView ID="grdMaterialsSpec" runat="server" Theme="Glass" Width="100%" ClientInstanceName="grdMaterialsSpec" DataSourceID="SqlSpecByMat"
                                    OnCustomCallback="grdMaterialsSpec_CustomCallback" KeyFieldName="ID" AutoGenerateColumns="false">
                                    <Columns>
                                        <dxg:GridViewCommandColumn ButtonType="Image" Width="40px" Caption=" " VisibleIndex="0" ShowDeleteButton="true"/>
                                        <dxg:GridViewDataColumn FieldName="ID" VisibleIndex="1" Visible="false">
                                        </dxg:GridViewDataColumn>
                                        <dxg:GridViewDataColumn FieldName="DescProperties" VisibleIndex="2">
                                        </dxg:GridViewDataColumn>
                                        <dxg:GridViewDataColumn FieldName="Valeur" VisibleIndex="3">
                                            <CellStyle HorizontalAlign="Right" Font-Bold="true">
                                            </CellStyle>
                                        </dxg:GridViewDataColumn>
                                        <dxg:GridViewDataColumn FieldName="MeasureUnit" VisibleIndex="3">
                                        </dxg:GridViewDataColumn>
                                    </Columns>
                                    <SettingsCommandButton>
                                        <DeleteButton>
                                            <Image Url="../../../images/delete.gif">
                                            </Image>
                                        </DeleteButton>
                                    </SettingsCommandButton>
                                </dxg:ASPxGridView>
                            </td>
                        </tr>
                         
                    </table>

                    <hr />
                    <div align="right">
                        <table>
                            <tr>
                               <td>
                                    <dx:ASPxButton ID="btnPrevious" runat="server" Text="Précédent" Theme="Glass"
                                        AutoPostBack="false">
                                        <ClientSideEvents Click="OnPreviousClick" />
                                    </dx:ASPxButton>

                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnFinish" runat="server" Text="Terminé" ValidationGroup="groupTabContact"
                                        AutoPostBack="false" Theme="Glass">
                                        <ClientSideEvents Click="OnFinishClick" />
                                    </dx:ASPxButton>
                                </td>
                                 <td style="width:100px; " align="right">
                                    <dx:ASPxButton ID="btnCancel" runat="server" Text="Annuler" ValidationGroup="groupTabResume"
                                        AutoPostBack="false" Theme="Glass">
                                        <ClientSideEvents Click="OnCancelClick" />
                                    </dx:ASPxButton>

                                </td>
                            </tr>
                        </table>
                    </div>
                    <dx:ASPxValidationSummary ID="validSummaryDate" runat="server" ValidationGroup="groupTabDetails">
                    </dx:ASPxValidationSummary>
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
    </TabPages>
</dx:ASPxPageControl>


<dxpc:ASPxPopupControl ID="popupValidation" runat="server"
    Theme="Glass"
    HeaderText="Ajouter Article"
    ClientInstanceName="popupValidation" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Modal="True" Width="300px">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dxpc:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
            <table width="100%">
                <tr>
                    <td align="center">
                        <%=  DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath)  %>  </td>
                </tr>
                <tr>
                    <td align="center">
                        <input type="button" style="width: 100px" value="Ok" onclick="popupValidation.Hide(); window.parent.dnnModal.load();
    if (window.parent['cbOperations']) { window.parent['cbOperations'].PerformCallback('filterPop#' + txtMaterialsID.GetText()); }; if (window.parent.RefreshMaterials) { window.parent.RefreshMaterials(); }" />
                    </td>
                </tr>
            </table>
        </dxpc:PopupControlContentControl>
    </ContentCollection>
    <CloseButtonImage Height="17px" Width="17px" />
    <HeaderStyle>
        <Paddings PaddingLeft="10px" PaddingRight="6px" PaddingTop="1px" />
    </HeaderStyle>
    <HeaderTemplate><%= DotNetNuke.Services.Localization.Localization.GetString("popEditArticle", ressFilePath)%></HeaderTemplate>
</dxpc:ASPxPopupControl>


<asp:SqlDataSource ID="SqlPaysOrigineDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Framework_GetAllPays"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
    <SelectParameters>        
        <asp:SessionParameter SessionField="Locale" Name="locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlMaterialsSpecificationDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetMaterialsSpecificationsByDiscipline"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
    <SelectParameters>
        <asp:SessionParameter SessionField="ID_Discipline" Name="ID_Discipline" Type="String" />
        <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlNormFamiliesDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetNormByFamilies"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
        <asp:SessionParameter Name="ID_MaterialsSpecification" SessionField="SpecID" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlDisciplineDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetAllInUseDisciplines"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
    <SelectParameters>
            <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String" />
        </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="PropertiesHiearchyDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetPropertiesHiearchyBySpec" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter SessionField="SpecID" Name="SpecID" Type="Int32"></asp:SessionParameter>
        <asp:SessionParameter SessionField="Locale" Name="LocaleParam" Type="String"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>



<asp:SqlDataSource ID="PropertiesHiearchyByNormDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetPropertiesHiearchyByNormCases" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter SessionField="IDNormCase" Name="IDNormCase" Type="String"></asp:SessionParameter>
        <asp:SessionParameter SessionField="Locale" Name="LocaleParam" Type="String"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="SqlMesureUnitDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetMeasureUnitByProperty" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String"></asp:SessionParameter>
        <asp:SessionParameter SessionField="ID_Properties" Name="ID_Properties" Type="Int32"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlSpecByMat" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetPropertiesByMaterials" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeleteMaterialsPropertiesByID" DeleteCommandType="StoredProcedure">
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
    </DeleteParameters>
    <SelectParameters>
        <asp:SessionParameter SessionField="ArticleID" Name="ID_Articles" Type="Int32"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlCasesByNormDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetCasesByNorm" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter SessionField="NormList" Name="NormList" Type="String"></asp:SessionParameter>
        <asp:SessionParameter SessionField="Locale" Name="LocaleParam" Type="String"></asp:SessionParameter>
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlBrandsDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetAllBrands"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<script>
    window.onload = function () {
        try {
            window.parent.$(".ui-dialog-titlebar-close").hide();
        } catch (e) {
        }
    }

    window.onunload = function () {
        try {
            window.parent.$(".ui-dialog-titlebar-close").show();
        } catch (e) {
        }
    }
</script>
