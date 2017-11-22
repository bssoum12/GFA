<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Search.ascx.vb" Inherits="Bring2mind.DNN.Modules.DMX.Views.Search" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<asp:Panel runat="server" ID="pnlAdvancedSearch" CssClass="advancedSearch">
<div class="row">
 <div class="col-md-3 col-xs-12">
  <div class="form-group">
    <label for="<%=dd1Field.ClientID %>"><%= LocalizeString("plField") %></label>
    <asp:DropDownList ID="dd1Field" runat="server" DataTextField="Text" DataValueField="Value" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=dd1Selection.ClientID %>"><%= LocalizeString("plSelection") %></label>
    <asp:DropDownList ID="dd1Selection" runat="server" CssClass="form-control">
    <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
    <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
    <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
    <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
    <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
   </asp:DropDownList>
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=txt1Search.ClientID %>"><%= LocalizeString("plSearchString") %></label>
    <asp:TextBox runat="server" ID="txt1Search" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-1 col-xs-12">
  <div class="form-group">
    <label for="<%=chk1Exact.ClientID %>"><%= LocalizeString("plExact") %></label>
    <asp:CheckBox runat="server" ID="chk1Exact" CssClass="form-control" />
  </div>
 </div>
</div>
<div class="row">
 <div class="col-md-3 col-xs-12">
  <div class="form-group">
    <label for="<%=dd2Field.ClientID %>"><%= LocalizeString("plField") %></label>
    <asp:DropDownList ID="dd2Field" runat="server" DataTextField="Text" DataValueField="Value" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=dd2Selection.ClientID %>"><%= LocalizeString("plSelection") %></label>
    <asp:DropDownList ID="dd2Selection" runat="server" CssClass="form-control">
    <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
    <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
    <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
    <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
    <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
   </asp:DropDownList>
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=txt2Search.ClientID %>"><%= LocalizeString("plSearchString") %></label>
    <asp:TextBox runat="server" ID="txt2Search" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-1 col-xs-12">
  <div class="form-group">
    <label for="<%=chk2Exact.ClientID %>"><%= LocalizeString("plExact") %></label>
    <asp:CheckBox runat="server" ID="chk2Exact" CssClass="form-control" />
  </div>
 </div>
</div>
<div class="row">
 <div class="col-md-3 col-xs-12">
  <div class="form-group">
    <label for="<%=dd3Field.ClientID %>"><%= LocalizeString("plField") %></label>
    <asp:DropDownList ID="dd3Field" runat="server" DataTextField="Text" DataValueField="Value" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=dd3Selection.ClientID %>"><%= LocalizeString("plSelection") %></label>
    <asp:DropDownList ID="dd3Selection" runat="server" CssClass="form-control">
    <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
    <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
    <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
    <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
    <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
   </asp:DropDownList>
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=txt3Search.ClientID %>"><%= LocalizeString("plSearchString") %></label>
    <asp:TextBox runat="server" ID="txt3Search" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-1 col-xs-12">
  <div class="form-group">
    <label for="<%=chk3Exact.ClientID %>"><%= LocalizeString("plExact") %></label>
    <asp:CheckBox runat="server" ID="chk3Exact" CssClass="form-control" />
  </div>
 </div>
</div>
<div class="row">
 <div class="col-md-3 col-xs-12">
  <div class="form-group">
    <label for="<%=dd4Field.ClientID %>"><%= LocalizeString("plField") %></label>
    <asp:DropDownList ID="dd4Field" runat="server" DataTextField="Text" DataValueField="Value" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=dd4Selection.ClientID %>"><%= LocalizeString("plSelection") %></label>
    <asp:DropDownList ID="dd4Selection" runat="server" CssClass="form-control">
    <asp:ListItem Value="All" Text="All" resourcekey="optSelectionAll" />
    <asp:ListItem Value="Any" Text="Any" resourcekey="optSelectionAny" />
    <asp:ListItem Value="Exact" Text="Exact" resourcekey="optSelectionExact" />
    <asp:ListItem Value="Without" Text="Without" resourcekey="optSelectionWithout" />
    <asp:ListItem Value="Phrase" Text="Phrase" resourcekey="optSelectionPhrase" />
   </asp:DropDownList>
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=txt4Search.ClientID %>"><%= LocalizeString("plSearchString") %></label>
    <asp:TextBox runat="server" ID="txt4Search" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-1 col-xs-12">
  <div class="form-group">
    <label for="<%=chk4Exact.ClientID %>"><%= LocalizeString("plExact") %></label>
    <asp:CheckBox runat="server" ID="chk4Exact" CssClass="form-control" />
  </div>
 </div>
</div>
<div class="row">
 <div class="col-md-3 col-xs-12">
  <div class="form-group">
    <label for="<%=ddCombination.ClientID %>"><%= LocalizeString("plCombination") %></label>
    <asp:DropDownList ID="ddCombination" runat="server" CssClass="form-control">
     <asp:ListItem Value="AND" resourcekey="optAnd" />
     <asp:ListItem Value="OR" resourcekey="optOr" />
   </asp:DropDownList>
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
  <div class="form-group">
    <label for="<%=chkAllVersions.ClientID %>"><%= LocalizeString("chkAllVersions") %></label>
    <asp:CheckBox runat="server" ID="chkAllVersions" CssClass="form-control" />
  </div>
 </div>
 <div class="col-md-4 col-xs-12">
 </div>
 <div class="col-md-1 col-xs-12">
 </div>
</div>

<asp:LinkButton ID="cmdSearch" runat="server" resourceKey="cmdSearch" CssClass="dnnPrimaryAction" />
</asp:Panel>

<asp:Panel runat="server" ID="pnlQuickSearch">
 <div class="row">
  <div class="col-xs-12">
   <div class="input-group">
    <asp:TextBox runat="server" ID="txtQuickSearch" CssClass="form-control" />
    <span class="input-group-addon"><asp:LinkButton ID="cmdQuickSearch" runat="server" resourceKey="cmdSearch" /></span>
   </div>
  </div>
 </div>
</asp:Panel>

<div class="dmx_search_categories" runat="server" id="divSearchResultsCategoryTree">
 <div class="dmx_search_categories_clear"><a href="<%= DotNetNuke.Common.NavigateUrl(TabID) %>"><%= LocalizeString("AllCategories")%></a></div>
 <%= GetCategoryTree %>
</div>

<div class="dmx_search_results">
<asp:GridView ID="gvResults" runat="server" AllowSorting="True" DataSourceID="odsResults" CssClass="dmxSearchResults" ShowHeader="true"
 GridLines="None" Width="100%" AutoGenerateColumns="false" PagerStyle-CssClass="dmxSearchResultsPager">
 <PagerSettings Mode="NumericFirstLast" />
 <SortedAscendingHeaderStyle CssClass="sortasc" />
 <SortedDescendingHeaderStyle CssClass="sortdesc" />
 <Columns>
  <asp:TemplateField ItemStyle-VerticalAlign="Top">
   <ItemTemplate>
    <%#Bring2mind.DNN.Modules.DMX.UI.Utilities.GetImageHtmlBlock(Eval("Icon32"), Bring2mind.DNN.Modules.DMX.Common.Globals.GetAString(Eval("Remarks")), "<p class=""dmxicon-32-{0}"" title=""{1}"" style=""padding:0"" />", "<img src=""{0}"" border=""0"" width=""32"" height=""32"" title=""{1}"" />")%>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField SortExpression="e.Title" HeaderText="Title">
   <ItemTemplate>
    <div>
     <a href='<%#IIF(CStr(Eval("EntryType")).StartsWith("File"), DownloadUrl(Eval("EntryId")), BaseUrl+CStr(Eval("EntryId")))%>' class="SubHead"
      title='<%#Eval("Remarks")%>' style='display: <%#IIF(Eval("EntryType")="Hyperlink", "none", "block")%>'>
      <%# Eval("Title")%>
     </a>
     <a href='<%#Eval("Entry")%>' class="SubHead" title='<%#Eval("Remarks")%>'
      style='display: <%#IIF(Eval("EntryType")="Hyperlink", "block", "none")%>'>
      <%# Eval("Title")%>
     </a>
    </div>
    <div>
     <%# FormatFolder(Eval("CollectionId"), Bring2mind.DNN.Modules.DMX.Common.Globals.GetAString(Eval("FolderTitle")))%>
    </div>
    <div>
     <asp:Label ID="lblSummary" runat="server" CssClass="Normal" Text='<%# Server.HtmlDecode(Server.HtmlDecode(Eval("Extract"))) + "<br>" %>'
      />
    </div>
    <div>
     <a href='<%= BaseUrl %><%#Eval("EntryId")%>' class="SubHead">
      <%= BaseUrl %><%#Eval("EntryId")%></a>&nbsp;-
     <asp:Label ID="lblPubDate" runat="server" CssClass="Normal" Text='<%# FormatDate(Eval("LastModified")) %>' />
    </div>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-Width="16" ItemStyle-VerticalAlign="Top">
   <ItemTemplate>
    <a href='<%# DownloadUrl(Eval("EntryId"))%>' class="dmxicon-16-disk_blue-png link"
     style="display: <%#IIF(CStr(Eval("EntryType")).StartsWith("File"), "block", "none")%>"
     title='<%=DotNetNuke.Services.Localization.Localization.GetString("Download.Button", Bring2mind.DNN.Modules.DMX.Common.Globals.glbDMXSharedResourceFile)%>'>
     &nbsp;</a>
   </ItemTemplate>
  </asp:TemplateField>
  <asp:TemplateField ItemStyle-Width="70" ItemStyle-VerticalAlign="Top" SortExpression="e.FileSize" HeaderText="Size">
   <ItemTemplate>
    <asp:Label ID="lblSize" runat="server" CssClass="Normal" Text='<%# IIF(Eval("EntryType").StartsWith("File"), Bring2mind.DNN.Modules.DMX.Common.Globals.FormatSize(Eval("FileSize")), "") %>' />
   </ItemTemplate>
  </asp:TemplateField>
 </Columns>
</asp:GridView>
<asp:ObjectDataSource ID="odsResults" runat="server" SelectMethod="GetSearchResults" TypeName="Bring2mind.DNN.Modules.DMX.Views.Search"
 EnablePaging="True" MaximumRowsParameterName="PageSize" SelectCountMethod="GetRowCount" SortParameterName="Sort"
 StartRowIndexParameterName="StartRow">
 <SelectParameters>
  <asp:ControlParameter Name="ModuleId" ControlID="hidModuleId" Type="Int32" PropertyName="Value" />
 </SelectParameters>
</asp:ObjectDataSource>
</div>
<asp:HiddenField ID="hidModuleId" runat="server" />

<script type="text/javascript">
 $(function () {
  $('.DnnModule-<%=ModuleContext.ModuleId%> input[type="text"]').on('keypress', function (e) {
   if (e.which == 13) {
    e.preventDefault();
    var btn = document.getElementById('<%=cmdSearch.ClientID%>');
    if (btn == null) { btn = document.getElementById('<%=cmdQuickSearch.ClientID%>'); }
    btn.click();
   }
  });
 });
</script>