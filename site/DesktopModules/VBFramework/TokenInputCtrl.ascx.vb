Imports DevExpress.Web

Public Class TokenInputCtrl
    Inherits System.Web.UI.UserControl
    Protected ressFilePath As String = "~/DesktopModules/VBFramework/App_LocalResources/View.ascx.resx"
    Private _datafrom As String
    Public Property datafrom() As String
        Get
            Return _datafrom
        End Get
        Set(ByVal Value As String)
            _datafrom = Value
        End Set
    End Property

    Public Function GetContact(ByVal contact As String) As String

        Return ""
    End Function

    Private Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        txtParamUrlService.Text = datafrom
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Session("NewContact") = Nothing
        For Each item As ListEditItem In lbtokeninputNewValue.Items
            Session("NewContact") = Session("NewContact") + item.Text
        Next
        Session("NewContact") = lbtokeninputNewValue.Items.Count
        Page.ClientScript.RegisterClientScriptInclude(Me.GetType(), "jquery.js", ResolveClientUrl("~/Resources/Shared/scripts/jquery/jquery.js"))
        Page.ClientScript.RegisterClientScriptInclude(Me.GetType(), "MicrosoftAjax.js", ResolveClientUrl("~/Resources/Shared/scripts/MSAJAX/MicrosoftAjax.js"))
        Page.ClientScript.RegisterClientScriptInclude(Me.GetType(), "jquery.tokeninput.js", ResolveClientUrl("~/Resources/Shared/components/Tokeninput/jquery.tokeninput.js"))
        Dim stylesLink As New HtmlLink()
        stylesLink.Attributes("rel") = "stylesheet"
        stylesLink.Attributes("type") = "text/css"
        stylesLink.Href = ResolveClientUrl("~/Resources/Shared/components/Tokeninput/token-input.css")
        Page.Header.Controls.Add(stylesLink)

        Dim stylesLink1 As New HtmlLink()
        stylesLink1.Attributes("rel") = "stylesheet"
        stylesLink1.Attributes("type") = "text/css"
        stylesLink1.Href = ResolveClientUrl("~/Resources/Shared/components/Tokeninput/Themes/token-input-facebook.css")
        Page.Header.Controls.Add(stylesLink1)
        NewContact.Controls.Clear()
        Dim tab As New Table()
        tab.ID = "tabnewcontact"
        tab.Width = New Unit("100%")
        NewContact.Controls.Add(tab)
        If lbtokeninputNewValue.Items.Count > 0 Then
            For Each item As ListEditItem In lbtokeninputNewValue.Items

                Dim rw As New TableRow()
                Dim cell As New TableCell()
                cell.Font.Name = "MS Sans Serif"
                cell.Font.Size = New FontUnit(10)
                Dim lbl As New Label()
                lbl.ID = "lbl" + item.Text
                lbl.Text = item.Text
                cell.Controls.Add(lbl)

                Dim cell2 As New TableCell()
                cell.Font.Name = "MS Sans Serif"
                cell.Font.Size = New FontUnit(10)
                Dim btn As New Button()
                btn.ID = "btn" + item.Text
                btn.Text = "Ajouter"
                btn.OnClientClick = "ShowPopupAddContact(); return false "
                cell2.Controls.Add(btn)
                rw.Cells.Add(cell)
                rw.Cells.Add(cell2)
                tab.Rows.Add(rw)
            Next

            ' popupNewContact.ShowOnPageLoad = True
        End If

        lbtokeninputNewValue.Items.Clear()
        '  lbtokeninputvalue.Items.Clear()

    End Sub


End Class