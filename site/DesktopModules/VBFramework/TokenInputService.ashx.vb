Imports System.Web
Imports System.Web.Services
Imports System.Collections.Generic
Imports System.Linq
Imports GlobalAPI
Imports DataLayer

Public Class TokenInputService
    Implements System.Web.IHttpHandler

    ' 
    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest


        context.Response.ContentType = "text/plain"
        Dim req As String = String.Empty
        Dim type As String = String.Empty
        If context.Request.QueryString("datafrom") IsNot Nothing Then
            type = context.Request.QueryString("datafrom").ToString().ToLower()
        End If
        If context.Request.QueryString("q") IsNot Nothing Then
            req = context.Request.QueryString("q").ToString()
        End If
        Dim layer As New FrameworkDataContext()
        Dim list = New Object()




        Select Case type
            Case "materials"
                list = (From p In MaterialsController.getMaterials() Where p.Code.Contains(req) Or p.Nom.Contains(req) Select New With {
                   Key .id = "token-" & "ma-" & p.ID.ToString(),
                   Key .name = p.Code.ToString() & " : " & p.Nom
                   })

            Case "spec"
                list = (From p In layer.Framework_SuggestMatSpec Where p.ContactName.Contains(req) Select New With {
                   Key .id = "token-" & p.ContactID.ToString(),
                   Key .name = p.ContactName.ToString()
                   })
            Case "searchmaterials"
                list = (From x In layer.Framework_SuggestMaterials Where x.SearchText.Contains(req) Select New With {
                   Key .id = "token-" & x.SearchID,
                   Key .name = x.SearchText.ToString()})
            Case Else

                list = (From p In layer.Framework_SuggestAll Where p.ContactName.Contains(req) Select New With {
                Key .id = "token-" & p.ContactID.ToString(),
                Key .name = p.ContactName.ToString()
                })
        End Select

        Dim oSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim sJSON As String = oSerializer.Serialize(list)
        context.Response.Write(sJSON)

    End Sub


    Private Function StripHtml(source As String) As String
        Dim output As String

        If source IsNot Nothing Then
            'get rid of HTML tags
            output = Regex.Replace(source, "<[^>]*>", String.Empty)

            'get rid of multiple blank lines
            output = Regex.Replace(output, "^\s*$\n", String.Empty, RegexOptions.Multiline)

            Return output
        Else
            Return ""
        End If

    End Function

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class