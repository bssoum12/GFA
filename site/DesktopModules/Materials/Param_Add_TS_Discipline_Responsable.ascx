<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_Add_TS_Discipline_Responsable.ascx.cs" Inherits="VD.Modules.Materials.Param_Add_TS_Discipline_Responsable" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>




<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>


<popupWin:popupWin ID="popupWin" runat="server" />

<localizeModule:localizeModule ID="localModule" runat="server" />
<accessModule:accessModule ID="AccModule" runat="server" />

<link href="CustomSS.css" rel="stylesheet" type="text/css" />


<script src="../../Resources/Shared/Scripts/jquery/jquery.hoverIntent.min.js" type="text/javascript"></script>
<script src="../../js/dnncore.js" type="text/javascript"></script>
<script src="../../js/dnn.jquery.js" type="text/javascript"></script>


<script>
    var mSelectEmploye = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hSelectMaterialsMen", ressFilePath )%>';
    var mSelectFunctions = '<%=GlobalAPI.CommunUtility.getRessourceEntry("hSelectMaterialsMenFunctions", ressFilePath )%>';
    function CloseGridLookup() {
        grdLookEmp.ConfirmCurrentSelection();
        grdLookEmp.HideDropDown();
    }


 
 
    function RefreshParentGrid(grdName) {
        try {
            var iframe = window.parent.document.getElementById('ifrDetails');
            var innerDoc = (iframe.contentDocument) ? iframe.contentDocument : iframe.contentWindow.document;
            var iframe2 = innerDoc.getElementById('ifrDetails');
            var grdParam = iframe2.contentWindow[grdName];
            grdParam.PerformCallback();
        }
        catch (exception) { }
    }

    function Save_Functions_Selection() {
        if (ASPxClientEdit.ValidateEditorsInContainerById('tblOrga')) {
            if (lsFunction.GetItemCount() == 0) {
                alert(mSelectFunctions);
                e.processOnServer = false;
            }
            else {
                hdSelectionType.SetText('0');
            }
        }
        else {
            e.processOnServer = false;
        }
    }

    function Save_Employes_Selection() {
        if (ASPxClientEdit.ValidateEditorsInContainerById('tblEmploye')) {
            if (grdLookEmp.GetSelectedRowCount() == 0) {
                alert(mSelectEmploye);
                e.processOnServer = false;
            }
            else {
                hdSelectionType.SetText('1');
            }
        }
        else {
            e.processOnServer = false;
        }
    }
</script>
<table style="width: 100%;">
    <tr>
        <td class="label_td">
            <dx:ASPxPageControl ID="pcAssignments" ClientInstanceName="pcAssignments" runat="server"
                Theme="Glass" Width="100%" Height="400px" ActiveTabIndex="0">
                <TabPages>
                    <dx:TabPage Name="tpFunctions" ClientEnabled="true" Text="Par organisation">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl1" runat="server" SupportsDisabledAttribute="True">
                                <table id="tblOrga" style="width: 100%;background-color: #EDF3F4;">
                                    <tr>
                                        <td class="label_td">
                                            <div class="dnnTooltip" style="width: 150px;">
                                                <asp:Label ID="Label3" runat="server" CssClass="dnnFormHelp">
                                                  <a tabindex="-1" class="dnnFormHelp" style="width:150px;">
                                                     <%= DotNetNuke.Services.Localization.Localization.GetString("lblDiscipline", ressFilePath)%>&nbsp;(*)
                                                  </a>
                                                </asp:Label>
                                                <div id="Div1" class="dnnFormHelpContent dnnClear" style="display: none;">
                                                    <span id="Span2" class="dnnHelpText"></span><a href="#" class="pinHelp"></a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbDiscipline" ClientInstanceName="cmbDiscipline" runat="server" Theme="Glass" Width="100%" DataSourceID="SqlDisciplineDS" TextField="Designation" ValueField="Abreviation" IncrementalFilteringMode="Contains" OnDataBound="cmbDiscipline_DataBound">
												<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="True" ValidationGroup="groupTabOrga" Display="Dynamic">
                                                    <RequiredField ErrorText="Ce champ est obligatoire !" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label_td">
                                            <div class="dnnTooltip" style="width: 150px;">
                                                <asp:Label ID="Label2" runat="server" CssClass="dnnFormHelp">
                                                  <a tabindex="-1" class="dnnFormHelp" style="width:150px;">
                                                     <%= DotNetNuke.Services.Localization.Localization.GetString("hSoft", ressFilePath)%>&nbsp;(*)
                                                  </a>
                                                </asp:Label>
                                                <div id="Div3" class="dnnFormHelpContent dnnClear" style="display: none;">
                                                    <span id="Span1" class="dnnHelpText"></span><a href="#" class="pinHelp"></a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
											<dx:ASPxComboBox ID="cmbtechnicalSoftware" ClientInstanceName="cmbtechnicalSoftware" runat="server" ValueType="System.Int32" Theme="Glass" Width="100%" IncrementalFilteringMode="Contains" DataSourceID="SqlTechnicalSoftwareDS" ValueField="ID" TextField="Name" DropDownStyle="DropDownList"> 
												<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="True" ValidationGroup="groupTabOrga" Display="Dynamic">
                                                    <RequiredField ErrorText="Ce champ est obligatoire !" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label_td">
                                            <div class="dnnTooltip" style="width: 150px;">
                                                <asp:Label ID="Label5" runat="server" CssClass="dnnFormHelp">
                                                  <a tabindex="-1" class="dnnFormHelp" style="width:150px;">
                                                     <%= DotNetNuke.Services.Localization.Localization.GetString("mnRoles", ressFilePath)%>&nbsp;(*)
                                                  </a>
                                                </asp:Label>
                                                <div id="Div5" class="dnnFormHelpContent dnnClear" style="display: none;">
                                                    <span id="Span5" class="dnnHelpText"></span><a href="#" class="pinHelp"></a>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="width: 100%;">
                                            <dx:ASPxGridView ID="grdLookRoles" ClientInstanceName="grdLookRoles" runat="server" Theme="Glass"
                                                DataSourceID="SqlRolesDS" KeyFieldName="RoleID" Width="100%">
                                                <SettingsPager Mode="ShowAllRecords" Visible="false">
                                                </SettingsPager>
                                                <Columns>
                                                    <dx:GridViewCommandColumn Caption=" " ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0" Width="50px">
                                                    </dx:GridViewCommandColumn>
                                                    <dx:GridViewDataColumn Caption="Nom" FieldName="RoleName" ShowInCustomizationForm="True" VisibleIndex="1" Width="150px">
                                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataColumn Caption="Description" FieldName="Description" ShowInCustomizationForm="True" VisibleIndex="2" Width="100%">
                                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataColumn>
                                                </Columns>
                                                <ClientSideEvents SelectionChanged="function(s,e){}" />
                                                <Settings ShowFilterRow="True" VerticalScrollableHeight="350" VerticalScrollBarMode="Auto" />
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div align="center">
                                                <dx:ASPxButton ID="btnSave" runat="server" Theme="Glass" Width="200px" OnClick="btnSave_Click" Text="Enregistrer" AutoPostBack="false">
                                                    <ClientSideEvents Click="Save_Functions_Selection" />
                                                </dx:ASPxButton>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                    <dx:TabPage Name="tpEmploye" ClientEnabled="true" Text="Par organisation">
                        <ContentCollection>
                            <dx:ContentControl ID="ContentControl2" runat="server" SupportsDisabledAttribute="True">
                                <table id="tblEmploye" style="width: 100%; background-color: #EDF3F4;">
                                    <tr>
                                        <td class="label_td">
                                            <div class="dnnTooltip" style="width: 150px;">
                                                <asp:Label ID="Label1" runat="server" CssClass="dnnFormHelp">
                                                  <a tabindex="-1" class="dnnFormHelp" style="width:150px;">
                                                     <%= DotNetNuke.Services.Localization.Localization.GetString("lblDiscipline", ressFilePath)%>&nbsp;(*)
                                                  </a>
                                                </asp:Label>
                                                <div id="Div2" class="dnnFormHelpContent dnnClear" style="display: none;">
                                                    <span id="Span3" class="dnnHelpText"></span><a href="#" class="pinHelp"></a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbDiscipline2" ClientInstanceName="cmbDiscipline2" runat="server" Theme="Glass" Width="100%" DataSourceID="SqlDisciplineDS" TextField="Designation" ValueField="Abreviation" IncrementalFilteringMode="Contains" OnDataBound="cmbDiscipline2_DataBound">
                                        		<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="True" ValidationGroup="groupTabGeneral" Display="Dynamic">
                                                    <RequiredField ErrorText="Ce champ est obligatoire !" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label_td">
                                            <div class="dnnTooltip" style="width: 150px;">
                                                <asp:Label ID="Label4" runat="server" CssClass="dnnFormHelp">
                          <a tabindex="-1" class="dnnFormHelp" style="width:150px;">
                             <%= DotNetNuke.Services.Localization.Localization.GetString("hSoft", ressFilePath)%>&nbsp;(*)
                          </a>
                                                </asp:Label>
                                                <div id="Div4" class="dnnFormHelpContent dnnClear" style="display: none;">
                                                    <span id="Span4" class="dnnHelpText"></span><a href="#" class="pinHelp"></a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbtechnicalSoftware2" ClientInstanceName="cmbtechnicalSoftware" runat="server" ValueType="System.Int32" Theme="Glass" Width="100%" IncrementalFilteringMode="Contains" DataSourceID="SqlTechnicalSoftwareDS" ValueField="ID" TextField="Name" DropDownStyle="DropDownList">
												<ValidationSettings ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="True" ValidationGroup="groupTabGeneral" Display="Dynamic">
                                                    <RequiredField ErrorText="Ce champ est obligatoire !" IsRequired="True" />
                                                </ValidationSettings>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td class="label_td">
                                            <div class="dnnTooltip" style="width: 150px;">
                                                <asp:Label ID="Label6" runat="server" CssClass="dnnFormHelp">
                                                  <a tabindex="-1" class="dnnFormHelp" style="width:150px;">
                                                     <%= DotNetNuke.Services.Localization.Localization.GetString("hEmploye", ressFilePath)%>&nbsp;(*)
                                                  </a>
                                                </asp:Label>
                                                <div id="Div6" class="dnnFormHelpContent dnnClear" style="display: none;">
                                                    <span id="Span6" class="dnnHelpText"></span><a href="#" class="pinHelp"></a>
                                                </div>
                                            </div>
                                        </td>
                                        <td style="width: 100%;">
                                            <dx:ASPxGridView ID="grdLookEmp" ClientInstanceName="grdLookEmp" runat="server" Theme="Glass"
                                                DataSourceID="SqlEmployeeDS" KeyFieldName="UserID" Width="100%">
                                                <SettingsPager Mode="ShowAllRecords" Visible="false">
                                                </SettingsPager>
                                                <Columns>
                                                    <dx:GridViewCommandColumn Caption=" " ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0" Width="50px">
                                                    </dx:GridViewCommandColumn>
                                                    <dx:GridViewDataColumn Caption="Nom d'utilisateur" FieldName="Username" ShowInCustomizationForm="True" VisibleIndex="1" Width="150px">
                                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataColumn>
                                                    <dx:GridViewDataColumn Caption="Nom et prénom" FieldName="DisplayName" ShowInCustomizationForm="True" VisibleIndex="2" Width="100%">
                                                        <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                    </dx:GridViewDataColumn>
                                                </Columns>
                                                <ClientSideEvents SelectionChanged="function(s,e){}" />
                                                <Settings ShowFilterRow="True" VerticalScrollableHeight="350" VerticalScrollBarMode="Auto" />
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 150px; vertical-align: top;">&nbsp;
                                        </td>
                                        <td style="color: #808080; font-size: 11px; vertical-align: top;"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div align="center">
                                                <dx:ASPxButton ID="btnSave2" runat="server" Theme="Glass" Width="200px" OnClick="btnSave2_Click" Text="Enregistrer" AutoPostBack="false">
                                                    <ClientSideEvents Click="Save_Employes_Selection" />
                                                </dx:ASPxButton>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </dx:ContentControl>
                        </ContentCollection>
                    </dx:TabPage>
                </TabPages>
            </dx:ASPxPageControl>
        </td>
    </tr>
</table>



<asp:SqlDataSource ID="SqlDisciplineDS" runat="server" SelectCommandType="StoredProcedure"
    SelectCommand="Materials_GetAllInUseDisciplines"
    ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>">
      <SelectParameters>
            <asp:SessionParameter SessionField="Locale" Name="Locale" Type="String" />
        </SelectParameters>
</asp:SqlDataSource>


<asp:SqlDataSource ID="SqlTechnicalSoftwareDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllTechnicalSoftware" SelectCommandType="StoredProcedure"  >    
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
</asp:SqlDataSource> 




<asp:SqlDataSource ID="SqlEmployeeDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Framework_GetAllUsers" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

<asp:SqlDataSource ID="SqlRolesDS" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    SelectCommand="Framework_GetAllRoles" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

<dx:ASPxPopupControl ID="popupValidation" runat="server"
    Theme="Glass"
    ClientInstanceName="popupValidation" PopupHorizontalAlign="WindowCenter"
    PopupVerticalAlign="WindowCenter" Modal="True" Width="250px">
    <SizeGripImage Height="12px" Width="12px" />
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
            <table>
                <tr>
                    <td>
                        <%= DotNetNuke.Services.Localization.Localization.GetString("lbSuccesOp", ressFilePath)%>
                    </td>
                </tr>
                <tr>
                    <td align="center">
                        <dx:ASPxTextBox runat="server" ID="hdSelectionType" ClientInstanceName="hdSelectionType" ClientVisible="false"></dx:ASPxTextBox>
                        <dx:ASPxButton ID="cmdValiderPopup0" runat="server" AutoPostBack="False"
                            CausesValidation="False"
                            Theme="Glass" Text="ok" Width="100px">
                            <ClientSideEvents Click="function(s, e) {                                
	                        popupValidation.Hide();window.parent.dnnModal.load();
                            if(hdSelectionType.GetText()=='0')
                                RefreshParentGrid('grdParam');
                            else
                                RefreshParentGrid('grdEmploye');
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
    <HeaderTemplate><%= DotNetNuke.Services.Localization.Localization.GetString("mnAddNotif", ressFilePath)%></HeaderTemplate>
</dx:ASPxPopupControl>


