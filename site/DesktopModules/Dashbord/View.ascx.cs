/*
' Copyright (c) 2017  Virtualdev.tn
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using DevExpress.DashboardWeb;
using DevExpress.DashboardCommon;
using DevExpress.DataAccess.Sql;
using DotNetNuke.Entities.Users;
using GlobalAPI; 

namespace VD.Modules.Dashbord
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from DashbordModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : DashbordModuleBase, IActionable
    {

        public UserInfo CurrentUser = GlobalAPI.CommunUtility.GetCurrentUserInfo();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (CurrentUser.IsSuperUser)
                    ASPxDashboard1.WorkingMode = WorkingMode.Designer; 
                else
                    ASPxDashboard1.WorkingMode = WorkingMode.ViewerOnly ; 
                  
                DashboardSqlDataSource sqlDataSource = new DashboardSqlDataSource("sqlDataSource", "erpConnectionString");                 
                DevExpress.DataAccess.Sql.StoredProcQuery selec = new StoredProcQuery("GetMaterialsCount", "Materials_GetMaterialsCount");
                selec.Validate();
                sqlDataSource.Queries.Add(selec);

                DevExpress.DataAccess.Sql.StoredProcQuery selec2 = new StoredProcQuery("GetPropertiesCount", "Materials_GetPropertiesCount");
                selec2.Validate();
                sqlDataSource.Queries.Add(selec2);

                DevExpress.DataAccess.Sql.StoredProcQuery selec3 = new StoredProcQuery("GetMaterialsSpecificationsCount", "Materials_GetMaterialsSpecificationsCount");
                selec3.Validate();
                sqlDataSource.Queries.Add(selec3);


                



                DataSourceInMemoryStorage dataSourceStorage = new DataSourceInMemoryStorage();
                dataSourceStorage.RegisterDataSource("sqlDataSource", sqlDataSource.SaveToXml());
                ASPxDashboard1.SetDataSourceStorage(dataSourceStorage);
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        public ModuleActionCollection ModuleActions
        {
            get
            {
                var actions = new ModuleActionCollection
                    {
                        {
                            GetNextActionID(), Localization.GetString("EditModule", LocalResourceFile), "", "", "",
                            EditUrl(), false, SecurityAccessLevel.Edit, true, false
                        }
                    };
                return actions;
            }
        }

        protected void ASPxDashboard1_ConfigureDataConnection(object sender, DevExpress.DashboardWeb.ConfigureDataConnectionWebEventArgs e)
        {
            if(e.ConnectionName == "erpConnectionString")
            {
                DevExpress.DataAccess.ConnectionParameters.MsSqlConnectionParameters sqlParam = new DevExpress.DataAccess.ConnectionParameters.MsSqlConnectionParameters();
                sqlParam.AuthorizationType = DevExpress.DataAccess.ConnectionParameters.MsSqlAuthorizationType.SqlServer;
                sqlParam.DatabaseName = "ERP";
                sqlParam.Password = "Sm@dmin2017";
                sqlParam.ServerName = "localhost";
                sqlParam.UserName = "smadmin";
                
                e.ConnectionParameters = sqlParam;
            }
        }

        protected void ASPxDashboard1_ConnectionError(object sender, ConnectionErrorWebEventArgs e)
        {
            e.Cancel = true;
            e.Handled = true;
            Console.Write(e.Exception.Message); 
        }
    }
}