namespace DataLayer
{
    partial class FrameworkDataContext
    {

        public FrameworkDataContext() :
            base(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString)
        {
            OnCreated();
        }

    }
}