<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_Standard.ascx.cs" Inherits="VD.Modules.Materials.Param_Standard" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>

<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />
<%@ Register TagPrefix="popupWin" TagName="popupWin" Src="~/controls/popupWin.ascx" %>
<popupWin:popupWin ID="popupWin" runat="server" />

<style>
    .btnRedLink
    {
        text-decoration: none;
        color: Red;
        font-weight: bold;
        font-family: Tahoma;
        font-size: 12px;
    }

    .btnGlassLink
    {
        text-decoration: none;
        color: #266D8D;
        font-weight: bold;
        font-family: Tahoma;
        font-size: 12px;
    }

    .header
    {
        height: 20px;
        background-color: #7EACB1;
    }

    .headerText
    {
        color: white;
        font-family: Arial;
        font-weight: bold;
        text-align: left;
    }

    .MemoText
    {
        color: black;
        font: message-box;
        font-family: Arial;
    }

    .PageBorder
    {
        border: 1px solid #7EACB1;
    }
</style>

<script type="text/javascript">

    var lbSelectUseCase = '<%= DotNetNuke.Services.Localization.Localization.GetString("lbSelectUseCase", ressFilePath) %>';
    var mSelectNorm = '<%= DotNetNuke.Services.Localization.Localization.GetString("mSelectNorm", ressFilePath) %>';

    function MenuItemClick(e) {
        //Definir les action de chaque Item des menus contextuel et toolBar  
        if (e.item == null) return;
        var name = e.item.name;
        if (name == "addNorm") addNorm();
        if (name == "editNorm") editNorm();
        if (name == "deleteNorm") deleteNorm();
        if (name == "addCase") addCase();
        if (name == "editCase") editCase();
        if (name == "deleteCase") deleteCase();
        if (name == "showStdFile") ShowStdAttachedFiles();
        if (name == "showCaseFile") ShowCaseAttachedFiles();
    }

    function RefreshNorm() {
        tlNorm.PerformCallback();
    }

    function addNorm() {
        oldPopup("LoadControl.aspx?ctrl=Materials/AddStandardDetails.ascx&IsNewNorm=true&stdId="+ tlNorm.GetFocusedNodeKey(), 630, 900, '<%= DotNetNuke.Services.Localization.Localization.GetString("mAddNewNorm", ressFilePath)%>');
    }

    function editNorm() {
        if (tlNorm.GetFocusedNodeKey() == null) {
            alert(mSelectNorm);
            return;
        }
        oldPopup("LoadControl.aspx?ctrl=Materials/AddStandardDetails.ascx&IsNewNorm=false&stdId=" + tlNorm.GetFocusedNodeKey(), 630, 900, '<%= DotNetNuke.Services.Localization.Localization.GetString("mnEdit", ressFilePath)%>');
    }

    function deleteNorm() {
        if (tlNorm.GetFocusedNodeKey() == null) {
            alert(mSelectNorm);
            return;
        }
        pupDeleteStandard.PerformCallback();
        pupDeleteStandard.Show();
    }

    function addCase() {
        if (tlNorm.GetFocusedNodeKey() == null) {
            alert(mSelectNorm);
            return;
        }
        oldPopup("LoadControl.aspx?ctrl=Materials/AddCaseDetails.ascx&IsNewCase=true&stdId=" + tlNorm.GetFocusedNodeKey(), 630, 900, '<%= DotNetNuke.Services.Localization.Localization.GetString("mnuAddCase", ressFilePath)%>');
    }

    function editCase() {
        if (grdCases.GetFocusedRowIndex() == -1) {
            alert(lbSelectUseCase);
            return;
        }
        else {
            if (grdCases.GetRowKey(grdCases.GetFocusedRowIndex()) == null) {
                alert(lbSelectUseCase);
                return;
            }
        }
        oldPopup("LoadControl.aspx?ctrl=Materials/AddCaseDetails.ascx&IsNewCase=false&stdId=" + tlNorm.GetFocusedNodeKey()
            + "&idCase=" + grdCases.GetRowKey(grdCases.GetFocusedRowIndex()), 630, 900, '<%= DotNetNuke.Services.Localization.Localization.GetString("mnuEditCase", ressFilePath)%>');
    }

    function deleteCase() {
        if (grdCases.GetFocusedRowIndex() == -1) {
            alert(lbSelectUseCase);
            return;
        }
        pupDeleteCase.PerformCallback();
        pupDeleteCase.Show();
    }

    function ShowStdAttachedFiles() {
        window.setTimeout(function () { oldPopup("LoadControl.aspx?ctrl=Materials/ShowAttachedFile.ascx&source=standard&id=" + tlNorm.GetFocusedNodeKey(), 300, 700, '<%= DotNetNuke.Services.Localization.Localization.GetString("hDocList", ressFilePath)%>'); }, 0)
    }

    function ShowCaseAttachedFiles() {
        
        if (grdCases.GetFocusedRowIndex() != -1) {
            var key = grdCases.GetRowKey(grdCases.GetFocusedRowIndex());            
            window.setTimeout(function () {
                oldPopup("LoadControl.aspx?ctrl=Materials/ShowAttachedFile.ascx&source=standardcase&id=" + key, 300, 700, '<%= DotNetNuke.Services.Localization.Localization.GetString("hDocList", ressFilePath)%>');
            }, 0);
        }
        else
        {
            alert(lbSelectUseCase);
        }
    }

    function ReloadParentData(e) {
        if (e == 'standard') {
            tlNorm.PerformCallback();
        } else if (e == 'case') {
            grdCases.PerformCallback(tlNorm.GetFocusedNodeKey());
        }
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

</script>
<div class="PageBorder" >
    <div>
    <table style="width: 100%;">
        <tr>
            <td>
                <dx:ASPxMenu ID="toolbar" ClientInstanceName="toolbar" runat="server"
                    AutoSeparators="RootOnly" Theme="Glass" ItemAutoWidth="False" Width="100%">
                    <Items>
                        <dx:MenuItem Name="normGrp">
                            <Image Url="~/images/Materials/normes.png" Width="16px" Height="16px"></Image>
                            <Items>
                                <dx:MenuItem Name="addNorm">
                                    <Image Url="~/images/add.gif" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="editNorm">
                                    <Image Url="~/images/Materials/Action_Edit_32x32.png" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="showStdFile">
                                    <Image Url="~/images/Materials/dmx_doc.gif" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="deleteNorm">
                                    <Image Url="~/images/Materials/Action_Delete_32x32.png" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                            </Items>
                        </dx:MenuItem>
                        <dx:MenuItem Name="casesGrp">
                            <Image Url="~/images/green-ok.gif" Width="16px" Height="16px"></Image>
                            <Items>
                                <dx:MenuItem Name="addCase">
                                    <Image Url="~/images/add.gif" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="editCase">
                                    <Image Url="~/images/Materials/Action_Edit_32x32.png" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="showCaseFile">
                                    <Image Url="~/images/Materials/dmx_doc.gif" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                                <dx:MenuItem Name="deleteCase">
                                    <Image Url="~/images/Materials/Action_Delete_32x32.png" Width="16px" Height="16px"></Image>
                                </dx:MenuItem>
                            </Items>
                        </dx:MenuItem>
                    </Items>
                    <ClientSideEvents ItemClick="function(s, e) {MenuItemClick(e);}" />
                </dx:ASPxMenu>
            </td>
        </tr>
    </table>
</div>
<div>
    <table style="width: 100%; border: 1px solid #7EACB1;" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <dx:ASPxSplitter ID="ASPxSplitter1" runat="server" Width="100%" Theme="Glass" Height="480">
                    <Panes>
                        <dx:SplitterPane ScrollBars="Auto" Size="25%">
                            <ContentCollection>
                                <dx:SplitterContentControl ID="SplitterContentControl1" runat="server">
                                    <dx:ASPxTreeList ID="tlNorm" ClientInstanceName="tlNorm" runat="server" Theme="Glass" Width="100%" Height="90%"
                                        DataSourceID="sqlGetNorm" ParentFieldName="ParentID" KeyFieldName="ID" OnCustomCallback="tlNorm_CustomCallback">
                                        <Columns>
                                            <dx:TreeListTextColumn FieldName="Designation">
                                            </dx:TreeListTextColumn>
                                            <dx:TreeListDataColumn Name="img1" Width="16" Caption=" ">
                                                <DataCellTemplate>
                                                    <table style="width: 100%;">
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxImage ID="img1" ImageUrl="~/images/Materials/dmx_doc.gif" runat="server" Width="16px" Height="16px" Theme="Glass"
                                                                    ToolTip="Document">
                                                                    <ClientSideEvents Click="function(s,e){ShowStdAttachedFiles();}" />
                                                                </dx:ASPxImage>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </DataCellTemplate>
                                            </dx:TreeListDataColumn>
                                        </Columns>
                                        <Settings ShowPreview="false" GridLines="Horizontal" ShowTreeLines="true" />
                                        <SettingsBehavior AllowFocusedNode="true" />
                                        <ClientSideEvents NodeClick="function(s,e){
                                            grdCases.PerformCallback(e.nodeKey);}"
                                            ContextMenu="function(s, e) {
                                            var x = ASPxClientUtils.GetEventX(e.htmlEvent);
                                            var y = ASPxClientUtils.GetEventY(e.htmlEvent);
	                                        pupMnuManageStd.ShowAtPos(x,y);}" />
                                        <Settings ShowColumnHeaders="true" />
                                    </dx:ASPxTreeList>
                                </dx:SplitterContentControl>
                            </ContentCollection>
                        </dx:SplitterPane>
                        <dx:SplitterPane ScrollBars="Auto">
                            <ContentCollection>
                                <dx:SplitterContentControl ID="SplitterContentControl2" runat="server">
                                    <dx:ASPxGridView ID="grdCases" ClientInstanceName="grdCases" runat="server" Theme="Glass" Width="98%"
                                        DataSourceID="SqlGetCases" KeyFieldName="ID" Settings-UseFixedTableLayout="true"
                                        OnCustomCallback="grdCases_CustomCallback" >
                                        <Columns>
                                            <dx:GridViewDataColumn FieldName="IDNC" Visible="false">
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="ID" Visible="false">
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataColumn FieldName="DescriptionCase" Visible="false">
                                            </dx:GridViewDataColumn>
                                            <dx:GridViewDataMemoColumn FieldName="LibCase" Visible="true">
                                            </dx:GridViewDataMemoColumn>
                                        </Columns>
                                        <Templates>
                                            <DataRow>
                                                <div class="header">
                                                        <div class="headerText">
                                                            <table style="width:100%;">
                                                                <tr>
                                                                    <td style="width:50%; vertical-align:central;">
                                                                         <%# Eval("LibCase") %>
                                                                    </td>
                                                                    <td style="width:100%;">&nbsp;
                                                                    </td>
                                                                    <td style="vertical-align:central;">
                                                                        <dx:ASPxImage ID="img" ImageUrl="~/images/Materials/dmx_doc.gif" runat="server" Width="16px" Height="16px" Theme="Glass"
                                                                            ToolTip="Document">
                                                                            <ClientSideEvents Click="function(s,e){ShowCaseAttachedFiles();}" />
                                                                        </dx:ASPxImage>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div style="overflow-y: scroll; width: 100%; height: 100px; border: 1px solid #4C90C0;">
                                                         <%# Eval("DescriptionHTML") %>
                                                    </div>
                                            </DataRow>
                                        </Templates>
                                        <Styles>
                                            <Cell>
                                                <Border BorderWidth="2" BorderStyle="Solid" BorderColor="#b5dbde" />
                                            </Cell>
                                        </Styles>
                                        <ClientSideEvents ContextMenu="function(s, e) {
                                            var x = ASPxClientUtils.GetEventX(e.htmlEvent);
                                            var y = ASPxClientUtils.GetEventY(e.htmlEvent);
	                                        pupMnuManageCase.ShowAtPos(x,y);}" />
                                        <SettingsBehavior AllowFocusedRow="true" />
                                        <SettingsDetail ShowDetailRow="false" ShowDetailButtons="true" />
                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                        <Settings ShowGroupPanel="false" ShowTitlePanel="true" VerticalScrollableHeight="420"
                                            UseFixedTableLayout="true" VerticalScrollBarMode="Auto" ShowColumnHeaders="false"  />
                                    </dx:ASPxGridView>
                                </dx:SplitterContentControl>
                            </ContentCollection>
                        </dx:SplitterPane>
                    </Panes>
                </dx:ASPxSplitter>
            </td>
        </tr>
    </table>
</div>
</div>


<dx:ASPxPopupControl ID="pupDeleteStandard" ClientInstanceName="pupDeleteStandard" Theme="Glass" runat="server" 
    Width="300" Height="150" OnWindowCallback="pupDeleteStandard_WindowCallback" 
    Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True">
    <ContentCollection>
        <dx:PopupControlContentControl ID="ContentControlDeleteStandard" runat="server" >
            <table style="width:100%">
                <tr valign="bottom">
                    <td style="width:100%">&nbsp;
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnDeleteStd" runat="server" Theme="Glass" OnClick="btnDeleteStd_Click" >
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnCancelDeleteStd" runat="server" Theme="Glass" >
                            <ClientSideEvents Click="function(s,e){
                                    pupDeleteStandard.Hide();
                                }" />
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

<dx:ASPxPopupControl ID="pupDeleteCase" ClientInstanceName="pupDeleteCase" Theme="Glass" runat="server" 
    Width="300" Height="150" OnWindowCallback="pupDeleteCase_WindowCallback" 
    Modal="true" PopupHorizontalAlign="WindowCenter" PopupVerticalAlign="WindowCenter" AllowDragging="True">
    <ContentCollection>
        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server" >
            <table style="width:100%">
                <tr valign="bottom">
                    <td style="width:100%">&nbsp;
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnDeleteCase" runat="server" Theme="Glass" OnClick="btnDeleteCase_Click">
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnCancelDeleteCase" runat="server" Theme="Glass" >
                            <ClientSideEvents Click="function(s,e){
                                    pupDeleteCase.Hide();
                                }" />
                        </dx:ASPxButton>
                    </td>
                </tr>
            </table>
        </dx:PopupControlContentControl>
    </ContentCollection>
</dx:ASPxPopupControl>

<dx:ASPxPopupMenu ID="pupMnuManageStd" ClientInstanceName="pupMnuManageStd" runat="server" Theme="Glass">
    <Items>
        <dx:MenuItem Name="addNorm">
            <Image Url="~/images/add.gif" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="editNorm">
            <Image Url="~/images/Materials/Action_Edit_32x32.png" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="showStdFile">
            <Image Url="~/images/Materials/dmx_doc.gif" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="deleteNorm">
            <Image Url="~/images/Materials/Action_Delete_32x32.png" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="addCase">
            <Image Url="~/images/add.gif" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
    </Items>
    <ClientSideEvents ItemClick="function(s,e){MenuItemClick(e);}" />
</dx:ASPxPopupMenu>

<dx:ASPxPopupMenu ID="pupMnuManageCase" ClientInstanceName="pupMnuManageCase" runat="server" Theme="Glass">
    <Items>
        <dx:MenuItem Name="addCase">
            <Image Url="~/images/add.gif" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="editCase">
            <Image Url="~/images/Materials/Action_Edit_32x32.png" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="showCaseFile">
            <Image Url="~/images/Materials/dmx_doc.gif" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
        <dx:MenuItem Name="deleteCase">
            <Image Url="~/images/Materials/Action_Delete_32x32.png" Width="16px" Height="16px"></Image>
        </dx:MenuItem>
    </Items>
    <ClientSideEvents ItemClick="function(s,e){MenuItemClick(e);}" />
</dx:ASPxPopupMenu>

<asp:SqlDataSource ID="sqlGetNorm" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetAllNorm"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" DefaultValue="fr-FR" />
    </SelectParameters>
</asp:SqlDataSource>

<asp:SqlDataSource ID="SqlGetCases" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>"
    ProviderName="System.Data.SqlClient" SelectCommand="Materials_GetStdCasesByIDStd"
    SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="IDNorme" SessionField="IDNorme" Type="Int32" />
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" DefaultValue="fr-FR" />
    </SelectParameters>
</asp:SqlDataSource>
