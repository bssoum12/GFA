using System.Configuration; 
namespace DataLayer
{
    partial class GestionTiersDataContext
    {
        public GestionTiersDataContext() :
            base(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString)
        {
            OnCreated();
        }
    }
}