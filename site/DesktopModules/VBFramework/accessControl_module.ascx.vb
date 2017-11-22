Imports System.Data.SqlClient
Imports System.Threading
Imports System.Globalization
Imports DotNetNuke

Partial Class accessControl_module
    Inherits Entities.Modules.PortalModuleBase

    Private Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Try
            If Request.UrlReferrer.Segments(1).Equals("DesktopModules/") Or Request.UrlReferrer.Authority.Equals(PortalAlias.HTTPAlias) Then
                If Not Request.IsAuthenticated Then
                    Response.Redirect("~/Default.aspx", True)
                End If
            Else
                Response.Redirect("~/ErrorPage.aspx", True)
            End If
        Catch ex As Exception
            Response.Redirect("~/ErrorPage.aspx", True)
        End Try
    End Sub
End Class
