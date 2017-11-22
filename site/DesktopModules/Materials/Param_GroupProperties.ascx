<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_GroupProperties.ascx.cs" Inherits="VD.Modules.Materials.Param_GroupProperties" %>
<%@ Register Assembly="DevExpress.Web.ASPxTreeList.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxTreeList" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<localizeModule:localizeModule ID="localModule" runat="server"/>

<style>
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
    function AddNewGroupProperty() {
        //Insert a parent property group
        //Set id parent to -1
        tlProtertiesGrpMgr.SetFocusedNodeKey('');
        tlProtertiesGrpMgr.StartEditNewNode();
    }

    function AddNewChildGroupProperty() {
        //insert a child property group
        tlProtertiesGrpMgr.StartEditNewNode();
    }

    function EditNode() {
        window.setTimeout(function () { tlProtertiesGrpMgr.StartEdit(tlProtertiesGrpMgr.GetFocusedNodeKey()); }, 0)
    } 

    function DeleteNode() {
        window.setTimeout(function () {
        tlProtertiesGrpMgr.PerformCustomDataCallback('delete');
        tlProtertiesGrpMgr.PerformCallback();
        }, 0)
    }

</script>

<table style="width: 100%">
    <tr>
        <td>
            <table>
                <tr>
                    <td>
                        <asp:Image ID="Image2" runat="server" ImageUrl="~/images/add.gif" Width="16px" />
                    </td>
                    <td>
                        <a class="btnRedLink" href="javascript:AddNewGroupProperty();"><%= DotNetNuke.Services.Localization.Localization.GetString("mAddNewParentPropertiesGrp", ressFilePath)%></a>
                    </td>
                    <td>&nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/add.gif" Width="16px" />
                    </td>
                    <td>
                        <a class="btnRedLink" href="javascript:AddNewChildGroupProperty();"><%= DotNetNuke.Services.Localization.Localization.GetString("mAddNewPropertiesGrp", ressFilePath)%></a>
                    </td>
                    <td>&nbsp;
                    </td>
                </tr>
            </table>
            <dx:ASPxTreeList ID="tlProtertiesGrpMgr" ClientInstanceName="tlProtertiesGrpMgr" runat="server" Theme="Glass"
                DataSourceID="sqlGetPropertiesGroup" ParentFieldName="ParentId" KeyFieldName="ID" Width="100%" Height="400" 
                OnCustomCallback="tlProtertiesGrpMgr_CustomCallback" OnHtmlRowPrepared="tlProtertiesGrpMgr_HtmlRowPrepared" 
                OnCustomErrorText="tlProtertiesGrpMgr_CustomErrorText" OnCustomDataCallback="tlProtertiesGrpMgr_CustomDataCallback">
                <Columns>
                    <dx:TreeListTextColumn FieldName="Designation" VisibleIndex="0" >
                    </dx:TreeListTextColumn>
                    <dx:TreeListTextColumn VisibleIndex="1" Width="50px" Name="action" Caption=" ">
                        <DataCellTemplate>
                            <table>
                                <tr>
                                    <td style="width:16px;" align="centre">
                                        <img src="../../../images/edit.gif" onclick="javascript:EditNode();"/>
                                    </td>
                                    <td style="width:16px;" align="centre">
                                        <img src="../../../images/delete.gif" onclick="javascript:DeleteNode();"/>
                                    </td>
                                </tr>
                            </table>
                        </DataCellTemplate>
                    </dx:TreeListTextColumn>
                </Columns>
                <Templates>
                    <EditForm>
                        <table style="width:100%;">
                            <tr>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="lblDesignation" runat="server" Text="Description"></asp:Label>
                                </td>
                                <td>
                                    <txtEifBox:txtEifBox ID="txtDesignation" runat="server" Width="200" ImageSrc="~/images/expand.gif" Theme="Glass" />            
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" align="right">
                                    <table>
                                        <tr>
                                            <td style="text-align:right">
                                                <dx:ASPxButton ID="btnUpdate"  runat="server" Text="Update" Theme="Glass" AutoPostBack="false">
                                                     <ClientSideEvents Click="function(s, e) {
                                                            tlProtertiesGrpMgr.PerformCustomDataCallback('save');
                                                            tlProtertiesGrpMgr.CancelEdit();
                                                            tlProtertiesGrpMgr.PerformCallback();
                                                         }">
                                                     </ClientSideEvents>
                                                </dx:ASPxButton>
                                            </td>
                                            <td style="text-align:left">
                                                 <dx:ASPxButton ID="btnCancel"  runat="server" Text="Cancel" Theme="Glass" AutoPostBack="false">
                                                     <ClientSideEvents Click="function(s, e) {
	                                                        tlProtertiesGrpMgr.CancelEdit();
                                                        }"></ClientSideEvents>
                                                     <ClientSideEvents/>
                                                 </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>                                   
                                </td>                                
                            </tr>                         
                        </table> 
                    </EditForm>
                </Templates>
                <ClientSideEvents
                    CustomDataCallback="function(s,e){
                    if(e.result == 'databingTree'){
                        if(window.parent.RefreshTreeGrpProperties)
                            window.parent.RefreshTreeGrpProperties();
                    }else{
                        alert(e.result);
                    }
                    }"
                    />
                <Settings VerticalScrollBarMode="Visible" ScrollableHeight="400" />
                <SettingsBehavior AllowFocusedNode="true" ExpandCollapseAction="NodeDblClick" FocusNodeOnExpandButtonClick="true"/>
                <SettingsEditing Mode="EditForm" />
            </dx:ASPxTreeList>
        </td>
    </tr>
</table>

<asp:SqlDataSource ID="sqlGetPropertiesGroup" runat="server" ConnectionString="<%$ ConnectionStrings:erpConnectionString %>" ProviderName="System.Data.SqlClient" 
    SelectCommand="Materials_GetPropertiesGroup" SelectCommandType="StoredProcedure"
    DeleteCommand="Materials_DeletePropertiesGroup" DeleteCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32"/>
    </DeleteParameters>
</asp:SqlDataSource> 
