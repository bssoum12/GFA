using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace  GlobalAPI 
{
     
    public class PropertyController
    {
         
        public static string NewProperty(string libProperty, string groupId, string format, int UserID)
        {
            DataLayer.MaterialsDataContext propertyLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Properties newProperty = new DataLayer.Materials_Properties();
            try
            {
                newProperty.Designation = libProperty;
                newProperty.Format = format;
                if (groupId != null)
                {
                    newProperty.GroupId = Convert.ToInt32(groupId);
                }
                newProperty.LastModifiedByUserID = UserID;
                newProperty.LastModifiedOnDate = DateTime.Now;

                propertyLayer.Materials_Properties.InsertOnSubmit(newProperty);
                propertyLayer.SubmitChanges();
                return "ID;" + newProperty.ID;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

         
        public static bool ExistsProperty(string libProperty)
        {
            DataLayer.MaterialsDataContext db = new DataLayer.MaterialsDataContext();
            List<DataLayer.Materials_Properties> existProperty = (from p in db.Materials_Properties
                                                                     where p.Designation == libProperty
                                                                     select p).ToList();
            return (existProperty.Count > 0);
        }

         
        public static bool NewPropertyML(int Id_Property, string libPropertyML, string Locale, int userID)
        {
            DataLayer.MaterialsDataContext propertyLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_PropertiesML newPropertyML = new DataLayer.Materials_PropertiesML();
            try
            {
                newPropertyML.PropertiesID = Id_Property;
                newPropertyML.Locale = Locale;
                newPropertyML.Designation = libPropertyML;
                newPropertyML.LastModifiedByUserID = userID;
                newPropertyML.LastModifiedOnDate = DateTime.Now;
                propertyLayer.Materials_PropertiesML.InsertOnSubmit(newPropertyML);
                propertyLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

         
        public static bool UpdateProperty(int Id_Property, string libProperty, string groupId, string format, int UserID)
        {
            DataLayer.MaterialsDataContext propertyLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Properties updateProperty = (from p in propertyLayer.Materials_Properties
                                                                where p.ID == Id_Property
                                                                select p).SingleOrDefault();
            try
            {
                if (!string.IsNullOrEmpty(groupId))
                {
                    updateProperty.GroupId = Convert.ToInt32(groupId);
                }
                updateProperty.Designation = libProperty;
                updateProperty.Format = format;
                updateProperty.LastModifiedByUserID = UserID;
                updateProperty.LastModifiedOnDate = DateTime.Now;
                propertyLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

         
        public static bool UpdatePropertyML(int Id_Property, string libPropertyML, string Locale, int userID)
        {
            DataLayer.MaterialsDataContext propertyLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_PropertiesML updatePropertyML = (from p in propertyLayer.Materials_PropertiesML
                                                                    where p.PropertiesID == Id_Property && p.Locale == Locale
                                                                    select p).SingleOrDefault();
            try
            {
                updatePropertyML.Designation = libPropertyML;
                updatePropertyML.LastModifiedByUserID = userID;
                updatePropertyML.LastModifiedOnDate = DateTime.Now;
                propertyLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        public static DataLayer.Materials_Properties GetProperty(int Id_Property)
        {
            DataLayer.MaterialsDataContext propertyLayer = new DataLayer.MaterialsDataContext();
            return (from p in propertyLayer.Materials_Properties
                    where p.ID == Id_Property
                    select p).SingleOrDefault();
        }

         
        public static DataLayer.Materials_PropertiesML GetPropertyML(int Id_Property, string Locale)
        {
            DataLayer.MaterialsDataContext propertyLayer = new DataLayer.MaterialsDataContext();
            return (from p in propertyLayer.Materials_PropertiesML
                    where p.PropertiesID == Id_Property && p.Locale == Locale
                    select p).SingleOrDefault();
        }

         
        public static bool DeletePropertiesMeasureUnit(int IdProperties)
        {
            try
            {
                DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
                layer.Materials_DeletePropertiesMeasureUnit(IdProperties);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

         
        public static bool InsertProperties_MeasureUnit(int IdProperties, int IdMeasureUnit, int userID)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Properties_MeasureUnit pmu = new DataLayer.Materials_Properties_MeasureUnit();
            try
            {
                pmu.ID_Properties = IdProperties;
                pmu.ID_UniteMeasure = IdMeasureUnit;
                pmu.LastModifiedByUserID = userID;
                pmu.LastModifiedOnDate = DateTime.Now;
                layer.Materials_Properties_MeasureUnit.InsertOnSubmit(pmu);
                layer.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

         
        public static List<int> GetListIdMeasureUnitByIdPropertiy(int IdProperty)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Properties_MeasureUnit where p.ID_Properties == IdProperty select p.ID_UniteMeasure).ToList<int>();
        }
                
         
        public static string DeletePropertyByID(int ID)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                layer.Materials_DeleteProperties(ID);
                layer.SubmitChanges();
                return "ok";
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                return ex.ErrorCode.ToString();
            }
        }

         
        public static List<Materials_Properties> GetAllProperties()
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Properties select p).ToList();
        }

         
        public static List<DataLayer.Materials_GetPropertiesByGroupResult> GetPropertiesByGroup(int idGroup, string Locale)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return layer.Materials_GetPropertiesByGroup(Locale, idGroup).ToList<DataLayer.Materials_GetPropertiesByGroupResult>();
        }

        
    }

     
    public class Properties
    {
         
        public int Name { get; set; }
        
        public string Value { get; set; }

    }
}
