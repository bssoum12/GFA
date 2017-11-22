namespace DataLayer
{
    partial class MaterialsDataContext
    {

        public MaterialsDataContext() :
            base(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["erpConnectionString"].ConnectionString)
        {
            OnCreated();
        }
    }
}