<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Param_Norm.ascx.cs" Inherits="VD.Modules.Materials.Param_Norm" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>
<%@ Register assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dxe" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<%@ Register TagPrefix="accessModule" TagName="accessModule" Src="~/controls/accessControl_module.ascx" %>
<%@ Register TagPrefix="txtEifBox" TagName="txtEifBox" Src="~/controls/xTextBoxML.ascx" %>

<localizeModule:localizeModule ID="localModule" runat="server"/>
<accessModule:accessModule ID="AccModule" runat="server"/>
<script type="text/javascript">
    function AddItemToGrid() {
        window.setTimeout(function () { grdParam.AddNewRow(); }, 0)
    }
</script>
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
<table style="width:100%">
    <tr>
        <td>
            <table>
                    <tr>
                        <td>
                            <asp:Image ID="Image2" runat="server" ImageUrl="~/images/add.gif" Width="16px" />
                        </td>
                        <td>
                            <a class="btnRedLink" href="javascript:AddItemToGrid();"> <%= DotNetNuke.Services.Localization.Localization.GetString("mAddNewNorm", ressFilePath)%></a>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>

            <dx:ASPxGridView ID="grdParam" runat="server" Width="100%" ClientInstanceName="grdParam" OnCustomCallback="grdParam_CustomCallback"
                ClientIDMode="AutoID" Theme="Glass"  OnHtmlEditFormCreated="grdParam_HtmlEditFormCreated"
                AutoGenerateColumns="False" DataSourceID="SqlParamDS" EnableTheming="True" KeyFieldName="ID">
                <SettingsBehavior AllowFocusedRow="true" />
                <Templates >
                    <EditForm >
                        <table style="width:100%;">
                            <tr>
                                <td style="vertical-align:top;">
                                    <asp:Label ID="lblDesignation" runat="server" Text="Description"></asp:Label>
                                </td>
                                <td>
                                    <txtEifBox:txtEifBox ID="txtDesignation" runat="server" Width="400" ImageSrc="~/images/expand.gif" Theme="Glass" />            
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"  align="right">
                                    <table >
                                        <tr>
                                            <td style="text-align:right">
                                                <dxe:ASPxButton ID="btnUpdate"  runat="server" Text="Update" Theme="Glass" AutoPostBack="false">
                                                     <ClientSideEvents Click="function(s, e) {grdParam.PerformCallback('save');}"></ClientSideEvents>
                                                     <ClientSideEvents />
                                                </dxe:ASPxButton>
                                            </td>
                                            <td style="text-align:left">
                                                 <dxe:ASPxButton ID="btnCancel"  runat="server" Text="Cancel" Theme="Glass" AutoPostBack="false">
                                                     <ClientSideEvents Click="function(s, e) {
	grdParam.CancelEdit();
}"></ClientSideEvents>
                                                     <ClientSideEvents />
                                                  </dxe:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>                                   
                                </td>                                
                            </tr>
                                                        
                        </table>                       

                    </EditForm>
                </Templates>
                <Columns>
                    <dx:GridViewCommandColumn ButtonType="Image" Width="40px" Caption=" " VisibleIndex="0" ShowEditButton="True" ShowDeleteButton="True"/>
                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="0" Visible="false">
                        <EditFormSettings Visible="False" />
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="Designation" VisibleIndex="1">
                    </dx:GridViewDataTextColumn>                     
                </Columns>
                <SettingsEditing Mode="EditForm"></SettingsEditing>
                <SettingsLoadingPanel Mode="ShowOnStatusBar" />
                <SettingsPager  PageSize="10">
                    <PageSizeItemSettings Visible="true" Position="Right" ShowAllItem="true"></PageSizeItemSettings>
                    <Summary AllPagesText="Pages: {0} - {1} ({2}éléments)" Text="Page {0} sur {1} ({2} éléments)" />
                </SettingsPager>
                <Settings ShowFilterRow="True" ShowFooter="true" />
                <Images>
                    <LoadingPanelOnStatusBar Url="~/App_Themes/Glass/GridView/gvLoadingOnStatusBar.gif">
                    </LoadingPanelOnStatusBar>
                    <LoadingPanel Url="~/App_Themes/Glass/GridView/Loading.gif">
                    </LoadingPanel>
                </Images>
                <ImagesFilterControl>
                    <LoadingPanel Url="~/App_Themes/Glass/Editors/Loading.gif">
                    </LoadingPanel>
                </ImagesFilterControl>
                <Styles>
                    <Header ImageSpacing="5px" SortingImageSpacing="5px">
                    </Header>
                </Styles>
                <StylesEditors>
                    <CalendarHeader Spacing="1px">
                    </CalendarHeader>
                    <ProgressBar Height="25px">
                    </ProgressBar>
                </StylesEditors>
                <SettingsCommandButton>
                    <EditButton>
                        <Image Url="../../../images/edit.gif">
                        </Image>
                    </EditButton>
                    <DeleteButton>
                        <Image Url="../../../images/delete.gif">
                        </Image>
                    </DeleteButton>
                </SettingsCommandButton>
            </dx:ASPxGridView>


        </td>
    </tr>
</table>


<asp:SqlDataSource ID="SqlParamDS" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Materials_GetAllNorm" SelectCommandType="StoredProcedure"
     DeleteCommand="Materials_DeleteNorm" DeleteCommandType="StoredProcedure"
     InsertCommand="Materials_InsertNorm" InsertCommandType="StoredProcedure" 
    UpdateCommand="Materials_UpdateNorm" UpdateCommandType="StoredProcedure">
    <SelectParameters>
        <asp:SessionParameter Name="Locale" SessionField="Locale" Type="String" />
    </SelectParameters>
    <DeleteParameters>
        <asp:Parameter Name="ID" Type="Int32" />
    </DeleteParameters>    
</asp:SqlDataSource>
