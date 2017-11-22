<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="SelectDate.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Controls.SelectDate" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<table cellspacing="1" cellpadding="4" border="0" rules="none">
 <tr>
  <td onmouseup="Button_OnMouseUp(<%= datePopup.ClientObjectId %>)">
     <ComponentArt:Calendar id="datePicker" runat="server"
     ControlType="Picker"
     ClientSideOnSelectionChanged="Picker_OnSelectionChanged" 
     PickerCssClass="Q_Value"
     PickerFormat="Short" />
   <ComponentArt:Calendar id="datePopup" runat="server"
     ImagesBaseUrl="~/DesktopModules/Bring2mind/Adapter/images/CA"
     ControlType="Calendar"
     ClientSideOnSelectionChanged="Calendar_OnSelectionChanged" 
     PopUp="Custom"
     CalendarCssClass = "DMX_calendar"
     CalendarTitleCssClass = "DMX_cal_title"
     DayCssClass = "DMX_cal_day"
     DayHeaderCssClass = "DMX_cal_dayheader"
     DayHoverCssClass = "DMX_cal_dayhover"
     MonthCssClass = "DMX_cal_month"
     NextPrevCssClass = "DMX_cal_nextprev"
     OtherMonthDayCssClass = "DMX_cal_othermonthday"
     SelectedDayCssClass = "DMX_cal_selectedday"
     SelectMonthCssClass = "DMX_cal_selector"
     SelectWeekCssClass = "DMX_cal_selector"
     DayNameFormat="FirstTwoLetters"
     SelectMonthText="¤" 
     SelectWeekText="»" 
     SwapDuration="300"
     SwapSlide="Linear"
    />
  </td>
  <td><img alt="" onmouseup="Button_OnMouseUp(<%= datePopup.ClientObjectId %>)" onclick="Button_OnClick(this, <%= datePopup.ClientObjectId %>)" class="DMX_calendar_button" src='<%= DotNetNuke.Common.ResolveUrl("~/DesktopModules/Bring2mind/DMX/images/16/calendar.gif") %>' width="16" height="16" >
  </td>
  <td runat="server" id="tcTime">
   <asp:TextBox Runat="server" ID="txtTime" Width="70" />&nbsp;
   <asp:RegularExpressionValidator Runat="server" ID="valTime" ControlToValidate="txtTime" CssClass="NormalRed" Display="Dynamic" ValidationExpression="(\d)+:\d\d" />
  </td>
  <td runat="server" id="tcClear" style="padding-left: 10px;cursor: pointer;">
   <span>
    <%=DotNetNuke.Services.Localization.Localization.GetString("lblClear", LocalResourceFile) %>
   </span>
  </td>
  <td style="padding-left:10px">
   <asp:CustomValidator runat="server" ID="reqDate" CssClass="NormalRed" />
  </td>
 </tr>
</table>
<script type="text/javascript">
// Associate the picker and the calendar:
function ComponentArt_<%= datePopup.ClientObjectId %>_Associate()
{
  if (window.<%= datePopup.ClientObjectId %>_loaded && window.<%= datePicker.ClientObjectId %>_loaded)
  {
    window.<%= datePopup.ClientObjectId %>.AssociatedPicker = <%= datePicker.ClientObjectId %>;
    window.<%= datePicker.ClientObjectId %>.AssociatedCalendar = <%= datePopup.ClientObjectId %>;
  }
  else
  {
    window.setTimeout('ComponentArt_<%= datePopup.ClientObjectId %>_Associate()', 100);
  }
}
ComponentArt_<%= datePopup.ClientObjectId %>_Associate();
function CheckDateReq_<%= datePopup.ClientObjectId %>(sender, args)
{
 if (<%= datePicker.ClientObjectId %>.GetSelectedDate()==null) {
  args.IsValid=false;
 }
}
</script>

