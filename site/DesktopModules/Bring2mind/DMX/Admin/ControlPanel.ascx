<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ControlPanel.ascx.vb"
 Inherits="Bring2mind.DNN.Modules.DMX.Admin.ControlPanel" %>
<div style="width: 100%; text-align: center;">
 <div style="width: 500px;">
  <div style="width: 100%">
   <asp:Repeater runat="server" ID="rpButtons">
    <ItemTemplate>
     <div style="float: left; width: 100px; height: 100px; text-align: center;">
      <table style="width:100%;">
       <tr>
        <td>
<div class="<%#Container.DataItem.Icon%> link" onclick="Javascript:window.location='<%#Container.DataItem.Url%>'" />
         </a>
        </td>
       </tr>
       <tr>
        <td>
         <a href="<%#Container.DataItem.Url%>" class="link">
          <%#Container.DataItem.Title%></a>
        </td>
       </tr>
      </table>
     </div>
    </ItemTemplate>
   </asp:Repeater>
  </div>
 </div>
</div>
