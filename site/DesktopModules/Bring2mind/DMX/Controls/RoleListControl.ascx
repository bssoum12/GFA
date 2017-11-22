<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="RoleListControl.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.UI.WebControls.RoleListControl" %>
<table cellspacing="0" cellpadding="2" border="0">
 <tr>
  <td align="center" class="NormalBold">Available</td>
  <td align="center">&nbsp;</td>
  <td align="center" class="NormalBold">Assigned</td>
 </tr>
 <tr>
  <td align="center" valign="top">
   <asp:listbox id="lstAvailable" runat="server" class="NormalTextBox" selectionmode="Multiple"></asp:listbox>
  </td>
  <td align="center" valign="middle">
   <table cellpadding="0" cellspacing="0" border="0">
    <tr>
     <td align="center" valign="top"><asp:linkbutton id="cmdAdd" runat="server" CssClass="dnnPrimaryAction" text="&nbsp;>&nbsp;" causesvalidation="False" /></td>
    </tr>
    <tr>
     <td align="center" valign="top"><asp:linkbutton id="cmdRemove" runat="server" CssClass="dnnSecondaryAction" text="&nbsp;<&nbsp;" causesvalidation="False" /></td>
    </tr>
    <tr>
     <td>&nbsp;</td>
    </tr>
    <tr>
     <td align="center" valign="bottom"><asp:linkbutton id="cmdAddAll" runat="server" CssClass="dnnSecondaryAction" text="&nbsp;>>&nbsp;" causesvalidation="False" /></td>
    </tr>
    <tr>
     <td align="center" valign="bottom"><asp:linkbutton id="cmdRemoveAll" runat="server" CssClass="dnnSecondaryAction" text="&nbsp;<<&nbsp;" causesvalidation="False" /></td>
    </tr>
   </table>
  </td>
  <td align="center" valign="top">
   <asp:listbox runat="server" id="lstAssigned" class="NormalTextBox" selectionmode="Multiple"></asp:listbox>
  </td>
 </tr>
</table>
