<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="EditEntry.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Edits.EditEntry" %>
<%@ Register TagPrefix="dmx" Assembly="Bring2mind.DNN.Modules.DMX.Core" Namespace="Bring2mind.DNN.Modules.DMX.UI.WebControls" %>

<p>
 <asp:Label runat="server" ID="lblErrorMsg" CssClass="NormalRed" />
</p>

<p class="Normal DMX_EditEntry_Title">
 <asp:Label runat="server" ID="lblTitle" />
</p>

<span class="Normal">
 <asp:Wizard ID="DmxEditWizard" runat="server" CssClass="DMX_Wizard" SideBarStyle-CssClass="SideBarPanel">
 <StepStyle CssClass="DMX_Wizard_Step" />
 <NavigationButtonStyle CssClass="DMX_Wizard_NavButton" />
 <SideBarButtonStyle CssClass="DMX_Wizard_SideButton" />
 <HeaderStyle CssClass="DMX_Wizard_Header"  />
 <SideBarTemplate>
  <div>
   <asp:DataList id="SideBarList" Runat="Server">
    <ItemTemplate>
     <div class="<%#IIF(DataBinder.Eval(Container, "DataItem.Name")=CurrentStepName, "SideBarButtonActive", "SideBarButton")%>" style="display:<%#IIF(DataBinder.Eval(Container, "DataItem.StepType").ToString="Complete", "none", "block")%>" onmouseover="this.className='SideBarButtonHover'" onmouseout="this.className='<%#IIF(DataBinder.Eval(Container, "DataItem.Name")=CurrentStepName, "SideBarButtonActive", "SideBarButton")%>'">
      <asp:Button id="SideBarButton" CommandName="MoveTo" Runat="Server" />
     </div>
    </ItemTemplate>
   </asp:DataList>
  </div>
 </SideBarTemplate>
 <WizardSteps>
 </WizardSteps>
 <StartNavigationTemplate>
  <div class="DMX_Wizard_NavBar">
   <asp:LinkButton CommandName="Cancel" ID="CancelButton" runat="server" Text="Cancel" CssClass="DMX_Wizard_NavButton" resourcekey="cmdCancel" CausesValidation="False" />
   <span style='display:<%=IIf(ShowNext, "inline", "none")%>'>
    <asp:LinkButton CommandName="MoveNext" ID="StartNextButton" runat="server" Text="Next" CssClass="DMX_Wizard_NavButton dmxEditNextButton" resourcekey="cmdNext" />
   </span>
   <span style='display:<%=IIf(ShowFinish, "inline", "none")%>'>
    <asp:LinkButton ID="btnIntermediateFinishButton2" runat="server" Text="Finish" CssClass="DMX_Wizard_NavButton" OnClick="IntermediateFinishButton_Click" resourcekey="cmdFinish" />
   </span>
  </div>
 </StartNavigationTemplate>
 <StepNavigationTemplate>
  <div class="DMX_Wizard_NavBar">
   <asp:LinkButton CommandName="Cancel" ID="CancelButton" runat="server" Text="Cancel" CssClass="DMX_Wizard_NavButton" resourcekey="cmdCancel" CausesValidation="False" />
   <asp:LinkButton CausesValidation="False" CommandName="MovePrevious" ID="StepPreviousButton" runat="server" Text="Previous" CssClass="DMX_Wizard_NavButton" resourcekey="cmdPrevious" />
   <span style='display:<%=IIf(ShowNext, "inline", "none")%>'>
    <asp:LinkButton CommandName="MoveNext" ID="StepNextButton" runat="server" Text="Next" CssClass="DMX_Wizard_NavButton" resourcekey="cmdNext" />
   </span>
   <span style='display:<%=IIf(ShowFinish, "inline", "none")%>'>
    <asp:LinkButton ID="btnIntermediateFinishButton1" runat="server" Text="Finish" CssClass="DMX_Wizard_NavButton" OnClick="IntermediateFinishButton_Click" resourcekey="cmdFinish" />
   </span>
  </div>
 </StepNavigationTemplate>
 <FinishNavigationTemplate>
  <div class="DMX_Wizard_NavBar">
   <asp:LinkButton CommandName="Cancel" ID="CancelButton" runat="server" Text="Cancel" CssClass="DMX_Wizard_NavButton" resourcekey="cmdCancel" CausesValidation="False" />
   <asp:LinkButton CommandName="MoveComplete" ID="FinishButton" runat="server" Text="Finish" CssClass="DMX_Wizard_NavButton" resourcekey="cmdFinish" />
  </div>
 </FinishNavigationTemplate>
 </asp:Wizard>
</span>

