<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ManageSpec.ascx.cs" Inherits="VD.Modules.Materials.EIF_Materials_ManageSpec" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register TagPrefix="token" TagName="token" Src="~/controls/TokenInputCtrl.ascx" %>
<token:token ID="tokenId" runat="server" datafrom="spec" />
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>
<popupWin:popupWin ID="popupWin" runat="server" />

<style>
    .HeaderTitle {
        text-align: center;
        font-family: Tahoma;
        font-weight: bold;
        font-size: 12px;
    }
    .btnRedLink
    {
        text-decoration: none; color: Red; font-weight: bold; font-family: Tahoma; font-size: 12px;
    }
    .btnGlassLink
    {
        text-decoration: none; color: #266D8D; font-weight: bold; font-family: Tahoma; font-size: 12px;
    }    
</style>

<script type="text/javascript">
    var alertDelete = '<%=GlobalAPI.CommunUtility.getRessourceEntry("DeleteMsg", ressFilePath )%>';
    var MsgAlert = '<%=GlobalAPI.CommunUtility.getRessourceEntry("MsgAlert", ressFilePath )%>';
    var pupAddSpecTitle = '<%=GlobalAPI.CommunUtility.getRessourceEntry("addSpec", ressFilePath )%>'; 
    var pupAddSpecGrpTitle = '<%=GlobalAPI.CommunUtility.getRessourceEntry("lbAddNewGroupSpecUI", ressFilePath )%>'; 
    var pupEditSpecTitle = '<%=GlobalAPI.CommunUtility.getRessourceEntry("editSpec", ressFilePath )%>'; 

    function mnuItemClick(e) {
        //mnuControlDoc item functions
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "editSpec") editSpec();
        if (name == "deleteSpec") deleteSpec();
        if (name == "assignToDiscipline") AssignDisciplineToSpec();
        if (name == "assignToSupplier") AssignSupplierToSpec();
        if (name == "assignToProperties") AssignSpecToProperties();
    }

    function AssignDisciplineToSpec() {
        popup("LoadControl.aspx?ctrl=Materials/AssignDiscipline.ascx&specid=" + tlMatSpec.GetFocusedNodeKey(), 200, 400, '<%= DotNetNuke.Services.Localization.Localization.GetString("mnAssignToDisciplines", ressFilePath)%>');
    }

    function AssignSupplierToSpec() {
        popup("LoadControl.aspx?ctrl=Materials/AssignSupplier.ascx&specid=" + tlMatSpec.GetFocusedNodeKey(), 600, 600, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbPupS2SHeader", ressFilePath)%>');
    }

    function AssignSpecToProperties() {
        popup("LoadControl.aspx?ctrl=Materials/AssignPropertiesToSpec.ascx&specid=" + tlMatSpec.GetFocusedNodeKey(), 600, 600, '<%= DotNetNuke.Services.Localization.Localization.GetString("lbAddSpecToProperties", ressFilePath)%>'); 
    }


    function addNewSpecGrp() {
        //Nouvelle famille spec
        var disciplineID = getQueryString("DisciplineID", window.document.URL);
        if (disciplineID != "")
            popup("LoadControl.aspx?ctrl=Materials/AddNewGroupSpec.ascx&DisciplineID=" + disciplineID, 200, 400, pupAddSpecGrpTitle);
        else
            popup("LoadControl.aspx?ctrl=Materials/AddNewGroupSpec.ascx", 200, 400, pupAddSpecGrpTitle);
    }

    function addSpec() {
        var fNode =tlMatSpec.GetFocusedNodeKey();
        //Nouvel spec
        if (fNode == null) {
            alert(MsgAlert);
            return;
        }
        else {
            var disciplineID = getQueryString("DisciplineID", window.document.URL);
            if (disciplineID != "")
                popup("LoadControl.aspx?ctrl=Materials/AddNewSpec.ascx&DisciplineID=" + disciplineID + "&specid=" + fNode, 200, 400, pupAddSpecTitle);
            else
                popup("LoadControl.aspx?ctrl=Materials/AddNewSpec.ascx&specid=" + fNode, 200, 400, pupAddSpecTitle);
       }
    }

    function editSpec() {
        //Edit Spec
        popup("LoadControl.aspx?ctrl=Materials/EditMatSpec.ascx&specid=" + tlMatSpec.GetFocusedNodeKey(), 200, 400, pupEditSpecTitle);
        //tlMatSpec.StartEdit(tlMatSpec.GetFocusedNodeKey());
    }

    function deleteSpec() {
        //Suppression
        if (confirm(alertDelete) == true)
            tlMatSpec.DeleteNode(tlMatSpec.GetFocusedNodeKey());
    }

    function closePup() {
        window.parent.dnnModal.load();
    }

    function RefreshTreeSpec() {
        tlMatSpec.PerformCallback();
    }

    function popup(url, height, width, title) {
        popupWind.SetSize(width, height);
        popupWind.SetHeaderText(title);
        var protocal = 'http';
        if (document.location.href.toString().indexOf('https') == 0)
            protocal = 'https';

        if (url.toString().indexOf('?') == -1)
            popupWind.SetContentUrl(protocal + "://<%=_portalAlias %>/DesktopModules/Materials/" + url + "?lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>");
        else
            popupWind.SetContentUrl(protocal + "://<%=_portalAlias %>/DesktopModules/Materials/" + url + "&lang=<%= System.Threading.Thread.CurrentThread.CurrentCulture.Name%>");
        popupWind.Show();
    }

    function PopupClosed()
    {
        if (window.parent.RefreshSpecTree)
            window.parent.RefreshSpecTree();
    }

    function getQueryString(name, url) {
        name = name.toString().toUpperCase();
        url = url.toString().toUpperCase();
        name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
        var regexS = "[\\?&]" + name + "=([^&#]*)";
        var regex = new RegExp(regexS);
        var results = regex.exec(url);
        if (results == null)
            return "";
        else
            return results[1];
    }
</script>

<div>
    <table>
        <tr>
            <td>
                <asp:Image ID="Image2" runat="server" ImageUrl="~/images/add.gif" Width="16px" />
            </td>
            <td style="padding-right: 10px;">
                <a class="btnRedLink"  href="javascript:addNewSpecGrp();"><%= DotNetNuke.Services.Localization.Localization.GetString("addSpecGrp", ressFilePath)%></a>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/add.gif" Width="16px" />
            </td>
            <td style="padding-right: 10px;">
                <a class="btnRedLink"  href="javascript:addSpec();"><%= DotNetNuke.Services.Localization.Localization.GetString("addSpec", ressFilePath)%></a>
            </td>
            <td>&nbsp;
            </td>
        </tr>
    </table>
</div>
<div class="treeNav">
    <table style="width: 100%; border: 1px solid #7EACB1;" cellpadding="0" cellspacing="0">
    
        <tr>
            <td style="text-align: right; border-bottom: 1px solid #7EACB1;">
                <table style="width: 100%;">
                    <tr>
                        <td style="width: 100%;">
                            <input type="text" autocomplete="off" style="outline: none; width: 100%;" id="token-input" />
                        </td>
                        <td style="width: 80px;">
                            <dx:ASPxButton ID="btnFilter" runat="server" OnClick="btnFilter_Click" Theme="Glass">
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
                                        <td class="HeaderTitle" style="width: 100%; padding: 5px;border-bottom: solid 1px #A3C0E8;">
                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                <td width="100%"><asp:label runat="server" ID="lbSpec"><%=GlobalAPI.CommunUtility.getRessourceEntry("hSpecifications", ressFilePath)%></asp:label>
                                                    </td>
                                                    <td align="right" style="cursor:hand;cursor:pointer;"><asp:ImageButton runat="server" ID="imgExpand" ImageUrl="../../images/Materials/icon_expand.png" OnClientClick="tlMatSpec.ExpandAll();return false;"  /></td>
                                                    <td>&nbsp;</td>
                                                    <td align="right" style="cursor:hand;cursor:pointer;"><asp:ImageButton runat="server" ID="imgCollapse" ImageUrl="../../images/Materials/icon_collapse.png" OnClientClick="tlMatSpec.CollapseAll();return false;" /></td>
                                                </tr>
                                            </table>   
                                        </td>
                                    </tr>
        <tr>
            <td style="text-align: right; border-bottom: 1px solid #7EACB1;">
                <dx:ASPxTreeList ID="tlMatSpec" ClientInstanceName="tlMatSpec" runat="server" Width="100%" Height="380px" SettingsPager-Mode="ShowAllNodes"
                    DataSourceID="sqlMatSpec" ParentFieldName="Id_Parent" KeyFieldName="ID"
                    Theme="Glass" AutoGenerateColumns="False" BackColor="White" SettingsBehavior-AllowDragDrop="False" SettingsPager-PageSize="3"
                    OnNodeInserting="tlMatSpec_NodeInserting" OnNodeUpdating="tlMatSpec_NodeUpdating" OnNodeDeleting="tlMatSpec_NodeDeleting" OnInitNewNode="tlMatSpec_InitNewNode"
                    OnCustomCallback="tlMatSpec_CustomCallback" OnCustomErrorText="tlMatSpec_CustomErrorText" OnDataBound="tlMatSpec_DataBound">
                    <Columns>
                        <dx:TreeListCommandColumn Name="CommandColumn" ButtonType="Button" Visible="false">
                        </dx:TreeListCommandColumn>
                        <dx:TreeListTextColumn FieldName="ID" Visible="false">
                        </dx:TreeListTextColumn>
                        <dx:TreeListTextColumn FieldName="Id_Parent" Visible="false">
                        </dx:TreeListTextColumn>
                        <dx:TreeListTextColumn FieldName="Designation">
                            <DataCellTemplate>
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxImage ID="img" runat="server" ImageUrl="~/images/Materials/icon_hostsettings_32px.gif"
                                                Width="16px" Height="16px" Theme="Glass">
                                                <ClientSideEvents Click="function(s, e) {
                                                        var x = ASPxClientUtils.GetEventX(e.htmlEvent);
                                                        var y = ASPxClientUtils.GetEventY(e.htmlEvent);
	                                                    pupMnuManageSpec.ShowAtPos(x,y);}" />
                                            </dx:ASPxImage>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblDesignation" runat="server" Text='<%# Eval("Designation") %>' Theme="Glass">
                                            </dx:ASPxLabel>
                                        </td>
                                    </tr>
                                </table>
                            </DataCellTemplate>
                            <PropertiesTextEdit>
                                <ValidationSettings>
                                    <RequiredField IsRequired="true" />
                                </ValidationSettings>
                            </PropertiesTextEdit>
                        </dx:TreeListTextColumn>
                    </Columns>
                    <ClientSideEvents Init="function(s, e) { 
                                            var popup = window.parent; 
                                            popup.window['tlMatSpec'] = tlMatSpec;}"  ContextMenu="function(s, e) {
                                                pupMnuManageSpec.ShowAtPos(ASPxClientUtils.GetEventX(e.htmlEvent), ASPxClientUtils.GetEventY(e.htmlEvent));
                                                }" />
                    <Settings ShowRoot="true" ShowPreview="false" SuppressOuterGridLines="true" GridLines="None" VerticalScrollBarMode="Visible" ScrollableHeight="350" />
                    <SettingsBehavior AllowFocusedNode="true" ExpandCollapseAction="NodeDblClick"
                        AutoExpandAllNodes="False" FocusNodeOnExpandButtonClick="true" ProcessFocusedNodeChangedOnServer="False" />
                    <SettingsEditing AllowRecursiveDelete="false" Mode="PopupEditForm" AllowNodeDragDrop="true" />
                    <SettingsPopupEditForm Height="100px" HorizontalAlign="WindowCenter" VerticalAlign="WindowCenter"
                        Width="480px" Modal="True" />
                </dx:ASPxTreeList>
            </td>
        </tr>
    </table>
</div>
<dx:ASPxPopupMenu ID="pupMnuManageSpec" ClientInstanceName="pupMnuManageSpec" runat="server" Theme="Glass">
    <Items>
        <dx:MenuItem Name="editSpec">
            <Image Url="~/images/Materials/Action_Edit_32x32.png" Height="16px" Width="16px">
            </Image>
        </dx:MenuItem>
        <dx:MenuItem Name="deleteSpec">
            <Image Url="~/images/Materials/Action_Delete_32x32.png" Height="16px"
                Width="16px">
            </Image>
        </dx:MenuItem>
        <dx:MenuItem Name="assignToDiscipline">
            <Image Url="~/images/Materials/assign_spec.png" Height="16px"
                Width="16px">
            </Image>
        </dx:MenuItem>
        <dx:MenuItem Name="assignToSupplier">
            <Image Url="~/images/Materials/assign_supplier.png" Height="16px"
                Width="16px">
            </Image>
        </dx:MenuItem>
        <dx:MenuItem Name="assignToProperties">
            <Image Url="~/images/Materials/properties-icons.png" Height="16px"
                Width="16px">
            </Image>
        </dx:MenuItem>
    </Items>
    <ClientSideEvents ItemClick="function(s,e){mnuItemClick(e);}" />
</dx:ASPxPopupMenu>

<asp:SqlDataSource ID="sqlMatSpec" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_MaterialsSpecification_SelectByDiscipline" OnSelecting="sqlMatSpec_Selecting" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="lang" SessionField="lang" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>

