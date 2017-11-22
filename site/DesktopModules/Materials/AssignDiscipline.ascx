<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AssignDiscipline.ascx.cs" Inherits="VD.Modules.Materials.AssignDisciplineToSpec" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>
<localizeModule:localizeModule ID="localModule" runat="server" />

<script type="text/javascript" lang="javascript">

    function hidePup() {
        if (window.parent.popupWind) {
            window.parent.popupWind.Hide();
        }
        if (window.parent.dnnModal)
            window.parent.dnnModal.load();
    }

</script>

<div>
    <dx:ASPxLabel ID="lblSpecUI" runat="server" Theme="Glass">
    </dx:ASPxLabel>
</div>
<div>
    <table>
        <tr>
            <td>
                <dx:ASPxLabel ID="lblDisciplineUI" runat="server" Theme="Glass">
                </dx:ASPxLabel>
            </td>
            <td>
                <dx:ASPxComboBox ID="cmbDiscipline" ClientInstanceName="cmbDiscipline" runat="server" Theme="Glass" IncrementalFilteringMode="Contains" 
                    DataSourceID="sqlDiscipline" ValueField="Abreviation" TextField="Designation" ValueType="System.String">
                </dx:ASPxComboBox>
            </td>
        </tr>
        <tr align="right">
            <td colspan="2">
                <table>
                    <tr>
                        <td>
                            <dx:ASPxButton ID="btnApply" runat="server" Theme="Glass" OnClick="btnApply_Click">
                            </dx:ASPxButton>
                        </td>
                        <td>
                            <dx:ASPxButton ID="btnClose" runat="server" Theme="Glass">
                                <ClientSideEvents Click="function(s,e){hidePup();}" />
                            </dx:ASPxButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

<asp:SqlDataSource ID="sqlDiscipline" runat="server" ConnectionString="<%$ ConnectionStrings:ERPConnectionString %>"
    SelectCommand="Framework_GetAllDisciplines" SelectCommandType="StoredProcedure">
        <SelectParameters>
        <asp:SessionParameter Name ="Locale" SessionField="lang" Type ="String" />
    </SelectParameters>
</asp:SqlDataSource>

