Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections
Imports System.Data
Imports System.Diagnostics
Imports System.Runtime.CompilerServices
Imports System.Web.UI.HtmlControls
Imports DevExpress.Web

Partial Public Class xTextBoxML
    Inherits System.Web.UI.UserControl

    ''' <summary>
    ''' Text Fields Width
    ''' </summary>
    ''' <remarks></remarks>
    Private _width As String
    Public Property Width() As String
        Get
            Return _width
        End Get
        Set(value As String)
            _width = value
        End Set
    End Property

    ''' <summary>
    ''' Text Fields Theme
    ''' </summary>
    ''' <remarks></remarks>
    Private _theme As String
    Public Property Theme() As String
        Get
            Return _theme
        End Get
        Set(value As String)
            _theme = value
        End Set
    End Property

    ''' <summary>
    ''' Text Fields CSS Class
    ''' </summary>
    ''' <remarks></remarks>
    Private _cssClass As String
    Public Property CssClass() As String
        Get
            Return _cssClass
        End Get
        Set(value As String)
            _cssClass = value
        End Set
    End Property

    ''' <summary>
    ''' Switch button image path
    ''' </summary>
    ''' <remarks></remarks>
    Private _imageSrc As String
    Public Property ImageSrc() As String
        Get
            Return _imageSrc
        End Get
        Set(value As String)
            _imageSrc = value
        End Set
    End Property

    ''' <summary>
    ''' Switch button image click event
    ''' </summary>
    ''' <remarks></remarks>
    Private _imageClick As String
    Public Property ImageClick() As String
        Get
            Return _imageClick
        End Get
        Set(value As String)
            _imageClick = value
        End Set
    End Property

    ''' <summary>
    ''' Text Fields MaxLength
    ''' </summary>
    ''' <history>
    '''   <para>[Ahmed.Aouina] 16/09/2014 Created</para>
    ''' </history>
    Private _maxLength As String
    Public Property MaxLength() As String
        Get
            Return _maxLength
        End Get
        Set(value As String)
            _maxLength = value
        End Set
    End Property


    Private _Validation As String
    Public Property ClientSideEvents_Validation() As String
        Get
            Return _Validation
        End Get
        Set(value As String)
            _Validation = value
        End Set
    End Property

    Private _IsRequired As Boolean
    Public Property ValidationSettings_RequiredField_IsRequired() As Boolean
        Get
            Return _IsRequired
        End Get
        Set(value As Boolean)
            _IsRequired = value
        End Set
    End Property

    Private _ErrorText As String
    Public Property ValidationSettings_RequiredField_ErrorText() As String
        Get
            Return _ErrorText
        End Get
        Set(value As String)
            _ErrorText = value
        End Set
    End Property

    Private _ValidationGroup As String
    Public Property ValidationSettings_ValidationGroup() As String
        Get
            Return _ValidationGroup
        End Get
        Set(value As String)
            _ValidationGroup = value
        End Set
    End Property

    Private _Display As DevExpress.Web.Display
    Public Property ValidationSettings_Display() As DevExpress.Web.Display
        Get
            Return _Display
        End Get
        Set(value As DevExpress.Web.Display)
            _Display = value
        End Set
    End Property

    ''' <summary>
    ''' Init
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        'Get DNN Installed Language list
        Dim languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0)

        'HTML Table for current language TextBox
        Dim tab1 As New System.Web.UI.HtmlControls.HtmlTable()
        tab1.Attributes.Add("cellpadding", "0")
        tab1.Attributes.Add("cellspacing", "0")
        tab1.Style.Add("padding-bottom", "2px")
        'HTML Table for other languages TextBoxes
        Dim tab2 As New System.Web.UI.HtmlControls.HtmlTable()
        tab2.ID = "tableML"  'Identifier used in switch button event
        tab2.Attributes.Add("style", "display:none;")
        tab2.Attributes.Add("cellpadding", "0")
        tab2.Attributes.Add("cellspacing", "0")
        Me.Controls.Add(tab1)
        Me.Controls.Add(tab2)
        'Adding TextBoxes dynamically
        For Each langObj In languages
            Dim tabRow1 As New System.Web.UI.HtmlControls.HtmlTableRow()
            Dim tabRow2 As New System.Web.UI.HtmlControls.HtmlTableRow()
            Dim tabCell1 As New System.Web.UI.HtmlControls.HtmlTableCell()
            Dim tabCell2 As New System.Web.UI.HtmlControls.HtmlTableCell()

            'Create TextBox
            Dim txtBox As New ASPxTextBox()
            txtBox.ID = "txtValue_" + langObj.Key.ToLower()
            txtBox.NullText = langObj.Value.NativeName

            'Set public properties
            If Width IsNot Nothing Then
                'If Width.Contains("%") Then
                '    Dim aze As String = Width.Split("%")(0)
                '    txtBox.Width = (Int32.Parse(tab1.Width) * Int32.Parse(aze)) / 100
                'Else
                txtBox.Width = Width
                'End If
            End If
            If Theme IsNot Nothing Then
                txtBox.Theme = Theme
            End If
            If CssClass IsNot Nothing Then
                txtBox.CssClass = CssClass
            End If

            If MaxLength IsNot Nothing Then
                txtBox.MaxLength = MaxLength
            End If

            If ClientSideEvents_Validation IsNot Nothing Then

                txtBox.ClientSideEvents.Validation = ClientSideEvents_Validation
            End If

            If ValidationSettings_RequiredField_IsRequired.ToString() IsNot Nothing Then

                txtBox.ValidationSettings.RequiredField.IsRequired = ValidationSettings_RequiredField_IsRequired
            End If

            If ValidationSettings_RequiredField_ErrorText IsNot Nothing Then

                txtBox.ValidationSettings.RequiredField.ErrorText = ValidationSettings_RequiredField_ErrorText
            End If
            If ValidationSettings_Display.ToString() IsNot Nothing Then

                txtBox.ValidationSettings.Display = ValidationSettings_Display
            End If
            If ValidationSettings_ValidationGroup IsNot Nothing Then

                txtBox.ValidationSettings.ValidationGroup = ValidationSettings_ValidationGroup
            End If

            If langObj.Key = System.Threading.Thread.CurrentThread.CurrentCulture.Name Then
                'Create switch image button
                Dim imgSwitchButton As New System.Web.UI.HtmlControls.HtmlImage()
                If ImageSrc IsNot Nothing Then
                    imgSwitchButton.Src = ImageSrc
                Else
                    imgSwitchButton.Src = "~/images/expand.gif"
                End If
                If ImageClick IsNot Nothing Then
                    imgSwitchButton.Attributes.Add("onclick", ImageClick)
                Else
                    imgSwitchButton.Attributes.Add("onclick", "if (this.src.indexOf('collapse') != -1) { this.src = '../../images/expand.gif'; } else { this.src = '../../images/collapse.gif'; };var obj = window.document.getElementById('" + tab2.ClientID + "');if (obj.style.display == '') { obj.style.display = 'none'; } else { obj.style.display = ''; };")
                End If
                imgSwitchButton.Attributes.Add("style", "cursor:hand;cursor:pointer;")
                'Add controls
                tabCell2.Style.Add("vertical-align", "top")
                tabCell2.Controls.Add(imgSwitchButton)
                tabCell1.Controls.Add(txtBox)
                tabRow1.Cells.Add(tabCell1)
                tabRow1.Cells.Add(tabCell2)
                tab1.Rows.Add(tabRow1)
            Else
                'Create language icon
                Dim imgLanguageIcon As New System.Web.UI.HtmlControls.HtmlImage()
                imgLanguageIcon.Src = "~/images/flags/" + langObj.Key + ".gif"
                'Add controls
                tabCell2.Controls.Add(imgLanguageIcon)
                tabCell1.Controls.Add(txtBox)
                tabRow1.Cells.Add(tabCell1)
                tabRow1.Cells.Add(tabCell2)
                tab2.Rows.Add(tabRow1)
            End If
        Next

    End Sub
End Class

''' <summary>
''' Module Hosting Extension methods for EIFxTextBoxML Control
''' </summary>
''' <remarks></remarks>
Public Module EIFxTextBoxExtensions

    ''' <summary>
    ''' Get Text Field Value By Locale
    ''' </summary>
    ''' <param name="Control">Current EifTextBoxML instance</param>
    ''' <param name="Locale">Locale code</param>
    ''' <returns>Text value</returns>
    ''' <remarks></remarks>
    <Extension()> _
    Public Function GetTextFieldValueByLocale(Control As UserControl, Locale As String) As String
        Try
            Dim txtBox As Control = GlobalAPI.CommunUtility.FindControlRecursive(Control, "txtValue_" & Locale.ToLower())
            If (txtBox IsNot Nothing) Then
                Dim curTextBox = DirectCast(txtBox, ASPxTextBox)
                Return curTextBox.Text
            End If
            Return ""
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function

    ''' <summary>
    ''' Set Text Field Value By Locale
    ''' </summary>
    ''' <param name="Control">Current EifTextBoxML instance</param>
    ''' <param name="Locale">Locale code</param>
    ''' <param name="value">Text value</param>
    ''' <remarks></remarks>
    <Extension()> _
    Public Sub SetTextFieldValueByLocale(Control As UserControl, Locale As String, Value As String)
        Try
            Dim txtBox As Control = GlobalAPI.CommunUtility.FindControlRecursive(Control, "txtValue_" & Locale.ToLower())
            If (txtBox IsNot Nothing) Then
                Dim curTextBox = DirectCast(txtBox, ASPxTextBox)
                curTextBox.Text = Value
            End If
        Catch generatedExceptionName As Exception
        End Try
    End Sub

    ''' <summary>
    ''' Set Enabled
    ''' </summary>
    ''' <param name="Control">Current EifTextBoxML instance</param>
    ''' <remarks></remarks>
    <Extension()> _
    Public Sub SetEnabled(Control As UserControl, Enabled As Boolean)
        Try
            'Get DNN Installed Language list
            Dim languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0)
            'Set TextBoxes Enabled
            For Each langObj In languages
                Dim txtBox As Control = GlobalAPI.CommunUtility.FindControlRecursive(Control, "txtValue_" & langObj.Key.ToLower())
                If (txtBox IsNot Nothing) Then
                    Dim curTextBox = DirectCast(txtBox, ASPxTextBox)
                    curTextBox.Enabled = Enabled
                End If
            Next
        Catch ex As Exception
        End Try
    End Sub

    ''' <summary>
    ''' Get Enabled
    ''' </summary>
    ''' <param name="Control">Current EifTextBoxML instance</param>
    ''' <remarks></remarks>
    <Extension()> _
    Public Function GetEnabled(Control As UserControl) As Boolean
        Try
            'Get TextBoxes Enabled
            Dim langCode = System.Threading.Thread.CurrentThread.CurrentCulture.Name
            Dim txtBox As Control = GlobalAPI.CommunUtility.FindControlRecursive(Control, "txtValue_" & langCode.ToLower())
            If (txtBox IsNot Nothing) Then
                Dim curTextBox = DirectCast(txtBox, ASPxTextBox)
                Return curTextBox.Enabled
            End If
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
End Module



