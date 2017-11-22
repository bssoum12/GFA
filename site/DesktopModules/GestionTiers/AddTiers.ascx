<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AddTiers.ascx.cs" Inherits="VD.Modules.GestionTiers.AddTiers" %>
<%@ Register Assembly="DevExpress.Web.v17.1, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="localizeModule" TagName="localizeModule" Src="~/controls/localize_module.ascx" %>


<localizeModule:localizeModule ID="localModule" runat="server" />

<dx:ASPxPageControl ID="pageControl" ClientInstanceName="pageControl" runat="server" Width="100%"
    EnableHierarchyRecreation="true" Theme="Glass" Height="375px">

    <TabPages>
        <dx:TabPage Name="TabGeneral" Text="Information Générale">
            <ContentCollection>
                <dx:ContentControl ID="ContentControl1" runat="server">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblNom" runat="server" Theme="Glass" Width="100%" Text="Nom du tier :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtNom" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblNomAlter" runat="server" Theme="Glass" Width="100%" Text="Nom alternatif :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtNomAlter" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblClient" runat="server" Theme="Glass" Width="100%" Text="Client :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbclient" Theme="Glass" Width="100%">
                                    <Items>
                                        <dx:ListEditItem Text="Oui" Value="1" />
                                        <dx:ListEditItem Text="Non" Value="0" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblCodeClient" runat="server" Theme="Glass" Width="100%" Text="Code client :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtCodeClient" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblFournisseur" runat="server" Theme="Glass" Width="100%" Text="Fournisseur :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbFournisseur" Theme="Glass" Width="100%">
                                    <Items>
                                        <dx:ListEditItem Text="Oui" Value="1" />
                                        <dx:ListEditItem Text="Non" Value="0" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblCodeFournisseur" runat="server" Theme="Glass" Width="100%" Text="Code fournisseur :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtCodeFournisseur" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblEtat" runat="server" Theme="Glass" Width="100%" Text="Etat :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbEtat" Theme="Glass" Width="100%">
                                    <Items>
                                        <dx:ListEditItem Text="En activité" Value="1" />
                                        <dx:ListEditItem Text="Clos" Value="0" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblCodebarre" runat="server" Theme="Glass" Width="100%" Text="Code à barres :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtCodeBarres" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblAdresse" runat="server" Theme="Glass" Width="100%" Text="Adresse :"></dx:ASPxLabel>
                            </td>
                            <td colspan="3">
                                <dx:ASPxTextBox runat="server" ID="txtAdresse" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblCodePostal" runat="server" Theme="Glass" Width="100%" Text="Code Postal :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtCodePostal" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblVille" runat="server" Theme="Glass" Width="100%" Text="Ville :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtVille" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblPays" runat="server" Theme="Glass" Width="100%" Text="Pays :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbPays" Theme="Glass" Width="100%"></dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblDepartement" runat="server" Theme="Glass" Width="100%" Text="Département :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbDepartement" Theme="Glass" Width="100%"></dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblEmail" runat="server" Theme="Glass" Width="100%" Text="E-Mail :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtEmail" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblSiteWeb" runat="server" Theme="Glass" Width="100%" Text="Web :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtsiteweb" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblTelephone" runat="server" Theme="Glass" Width="100%" Text="Téléphone :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtTelephone" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblFax" runat="server" Theme="Glass" Width="100%" Text="Fax :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtFax" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblMatricuelFiscal" runat="server" Theme="Glass" Width="100%" Text="Matricule fiscal :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtMatriculeFiscal" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblRC" runat="server" Theme="Glass" Width="100%" Text="RC :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtRCs" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblCodeDouane" runat="server" Theme="Glass" Width="100%" Text="Code en douane :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtCodeDouane" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblBan" runat="server" Theme="Glass" Width="100%" Text="BAN :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtBAN" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblAsujetti" runat="server" Theme="Glass" Width="100%" Text="Assujetti à la TVA :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbAsujetti" Theme="Glass" Width="100%">
                                    <Items>
                                        <dx:ListEditItem Text="Oui" Value="1" />
                                        <dx:ListEditItem Text="Non" Value="0" />
                                    </Items>
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblNumTVA" runat="server" Theme="Glass" Width="100%" Text="Numéro de TVA :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtNumTVA" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblTypeTiers" runat="server" Theme="Glass" Width="100%" Text="Type du tiers :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbtypetiers" Theme="Glass" Width="100%">
                                    
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblEffectif" runat="server" Theme="Glass" Width="100%" Text="Effectif :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtEffectif" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                         <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblFormeJuridique" runat="server" Theme="Glass" Width="100%" Text="Forme juridique :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbFormeJuridique" Theme="Glass" Width="100%">
                                    
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblCapital" runat="server" Theme="Glass" Width="100%" Text="Capital :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox runat="server" ID="txtCapital" Theme="Glass" Width="100%"></dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lblDevise" runat="server" Theme="Glass" Width="100%" Text="Devise :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox runat="server" ID="cmbDevise" Theme="Glass" Width="100%">
                                    
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 100px;">
                                <dx:ASPxLabel ID="lbllogo" runat="server" Theme="Glass" Width="100%" Text="Logo :"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxUploadControl ID="ASPxUploadControl1" runat="server" Theme="Glass" UploadMode="Auto" Width="280px"></dx:ASPxUploadControl>
                            </td>
                        </tr>
                    </table>
 
                   

                   
                </dx:ContentControl>
            </ContentCollection>
        </dx:TabPage>
    </TabPages>
</dx:ASPxPageControl>

 <div style="">
                            <hr />
                            <div align="right">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxButton ID="btnEnregistrer" runat="server" Text="Engistrer et Fermer" ClientInstanceName="btnEnregistrer"
                                                AutoPostBack="false" ValidationGroup="groupTabGeneral" Theme="Glass">
                                                
                                            </dx:ASPxButton>
                                        </td>
                                        <td style="width: 100px;" align="right">

                                            <dx:ASPxButton ID="btnAnnuler" runat="server" Text="Annuler" ClientInstanceName="btnAnnuler"
                                                AutoPostBack="false" Theme="Glass">
                                                
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>

                            </div>
                        </div>