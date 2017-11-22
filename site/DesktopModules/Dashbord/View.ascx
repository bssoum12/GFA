<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="VD.Modules.Dashbord.View" %>
<%@ Register Assembly="DevExpress.Dashboard.v17.1.Web, Version=17.1.3.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.DashboardWeb" TagPrefix="dx" %>
 
<dx:ASPxDashboard ID="ASPxDashboard1" runat="server"   WorkingMode="Designer" 
  OnConfigureDataConnection="ASPxDashboard1_ConfigureDataConnection"    DashboardStorageFolder="~/App_Data/Dashboards"></dx:ASPxDashboard>


 