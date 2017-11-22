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
Imports DevExpress.Web.ASPxHtmlEditor

Partial Public Class xHTMLEditorML
    Inherits System.Web.UI.UserControl

    ''' <summary>
    ''' HtmlEditor Fields Width
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
    ''' HtmlEditor Fields Height
    ''' </summary>
    ''' <remarks></remarks>
    Private _height As String
    Public Property Height() As String
        Get
            Return _height
        End Get
        Set(value As String)
            _height = value
        End Set
    End Property

    ''' <summary>
    ''' HtmlEditor Fields Theme
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
    ''' HtmlEditor Fields CSS Class
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
    ''' Init
    ''' </summary>
    ''' <param name="sender"></param>
    ''' <param name="e"></param>
    ''' <remarks></remarks>
    Protected Sub Page_Init(sender As Object, e As System.EventArgs) Handles Me.Init
        'Get DNN Installed Language list
        Dim languages = DotNetNuke.Services.Localization.LocaleController.Instance.GetLocales(0)

        'HTML Table for current language HtmlEditor
        Dim tab1 As New System.Web.UI.HtmlControls.HtmlTable()
        tab1.Attributes.Add("cellpadding", "0")
        tab1.Attributes.Add("cellspacing", "0")
        tab1.Style.Add("padding-bottom", "2px")

        'HTML Table for other languages HtmlEditors
        Dim tab2 As New System.Web.UI.HtmlControls.HtmlTable()
        tab2.ID = "tableML" 'Identifier used in switch button event
        tab2.Attributes.Add("style", "display:none;")
        tab2.Attributes.Add("cellpadding", "0")
        tab2.Attributes.Add("cellspacing", "0")
        Me.Controls.Add(tab1)
        Me.Controls.Add(tab2)

        'Adding HtmlEditors dynamically
        For Each langObj In languages
            Dim tabRow1 As New System.Web.UI.HtmlControls.HtmlTableRow()
            Dim tabRow2 As New System.Web.UI.HtmlControls.HtmlTableRow()
            Dim tabCell1 As New System.Web.UI.HtmlControls.HtmlTableCell()
            Dim tabCell2 As New System.Web.UI.HtmlControls.HtmlTableCell()

            'Create HtmlEditor
            Dim hteField As New ASPxHtmlEditor() ' ASPxHtmlEditor()
            hteField.ID = "hteValue_" + langObj.Key.ToLower()
            hteField.ClientSideEvents.Init = "function(s, e) {s.AdjustControl();}"
            'Set public properties
            If Height IsNot Nothing Then
                hteField.Height = Height
            End If
            If Width IsNot Nothing Then
                hteField.Width = Width
            End If
            If CssClass IsNot Nothing Then
                hteField.CssClass = CssClass
            End If
            If Theme IsNot Nothing Then
                hteField.Theme = Theme
            End If



            If langObj.Key = System.Threading.Thread.CurrentThread.CurrentCulture.Name Then
                'Create switch image button
                Dim imgSwitchButton As New System.Web.UI.HtmlControls.HtmlImage()
                If ImageSrc IsNot Nothing Then
                    imgSwitchButton.Src = ImageSrc
                Else
                    imgSwitchButton.Src = "~/images/add.gif"
                End If
                If ImageClick IsNot Nothing Then
                    imgSwitchButton.Attributes.Add("onclick", ImageClick)
                Else
                    'imgSwitchButton.Attributes.Add("onclick", "SwitchButtonClick(this);")
                    imgSwitchButton.Attributes.Add("onclick", "if (this.src.indexOf('collapse') != -1) { this.src = '../../images/expand.gif'; } else { this.src = '../../images/collapse.gif'; };var obj = window.document.getElementById('" + tab2.ClientID + "');if (obj.style.display == '') { obj.style.display = 'none'; } else { obj.style.display = ''; };")
                End If
                imgSwitchButton.Attributes.Add("style", "cursor:hand;cursor:pointer;")
                'Add controls
                tabCell2.Style.Add("vertical-align", "top")
                tabCell2.Controls.Add(imgSwitchButton)
                tabCell1.Controls.Add(hteField)
                tabRow1.Cells.Add(tabCell1)
                tabRow1.Cells.Add(tabCell2)
                tab1.Rows.Add(tabRow1)
            Else
                'Create language icon
                Dim imgLanguageIcon As New System.Web.UI.HtmlControls.HtmlImage()
                imgLanguageIcon.Src = "~/images/flags/" + langObj.Key + ".gif"
                'Add controls
                tabCell2.Style.Add("vertical-align", "top")
                tabCell2.Controls.Add(imgLanguageIcon)
                tabCell1.Controls.Add(hteField)
                tabRow1.Cells.Add(tabCell1)
                tabRow1.Cells.Add(tabCell2)
                tab2.Rows.Add(tabRow1)
            End If
        Next
    End Sub
End Class

''' <summary>
''' Module Hosting Extension methods for EIFxHTMLEditorML Control
''' </summary>
''' <remarks></remarks>
Public Module EIFxHTMLEditorExtensions

    ''' <summary>
    ''' Get Html Field Value By Locale
    ''' </summary>
    ''' <param name="Control">Current EIFxHTMLEditorML instance</param>
    ''' <param name="Locale">Locale code</param>
    ''' <returns>HTML value</returns>
    ''' <remarks></remarks>
    <Extension()> _
    Public Function GetHtmlFieldValueByLocale(Control As UserControl, Locale As String) As String
        Try
            Dim hteField As Control = GlobalAPI.CommunUtility.FindControlRecursive(Control, "hteValue_" & Locale.ToLower())
            If (hteField IsNot Nothing) Then
                Dim curHtmlEditor = DirectCast(hteField, ASPxHtmlEditor)
                Return curHtmlEditor.Html
            End If
            Return ""
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function

    ''' <summary>
    ''' Set Html Field Value By Locale
    ''' </summary>
    ''' <param name="Control">Current EIFxHTMLEditorML instance</param>
    ''' <param name="Locale">Locale code</param>
    ''' <param name="value">HTML value</param>
    ''' <remarks></remarks>
    <Extension()> _
    Public Sub SetHtmlFieldValueByLocale(Control As UserControl, Locale As String, Value As String)
        Try
            Dim hteField As Control = GlobalAPI.CommunUtility.FindControlRecursive(Control, "hteValue_" & Locale.ToLower())
            If (hteField IsNot Nothing) Then
                Dim curHtmlEditor = DirectCast(hteField, ASPxHtmlEditor)
                curHtmlEditor.Html = Value
            End If
        Catch generatedExceptionName As Exception
        End Try
    End Sub
End Module

