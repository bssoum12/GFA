using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI
{
     
    public static class PropertyGroupController
    {
        
        public static Materials_Properties_GroupsML GetPropertyGroupML(int GroupId, string Locale)
        {
            DataLayer.MaterialsDataContext propertiesGroupLayer = new DataLayer.MaterialsDataContext();
            return (from g in propertiesGroupLayer.Materials_Properties_GroupsML
                    where g.ID == GroupId && g.Locale == Locale
                    select g).SingleOrDefault();
        }

        
        public static DataLayer.Materials_Properties_Groups GetPropertyGroup(int GroupId)
        {
            DataLayer.MaterialsDataContext propertiesGroupLayer = new DataLayer.MaterialsDataContext();
            return (from g in propertiesGroupLayer.Materials_Properties_Groups
                    where g.ID == GroupId
                    select g).SingleOrDefault();
        }

        
        public static int SetPropertyGroup(int parentId, string designation, int userId)
        {
            DataLayer.MaterialsDataContext propertyGroupLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Properties_Groups newPropertyGroup = new DataLayer.Materials_Properties_Groups();
            try
            {
                newPropertyGroup.Designation = designation;
                newPropertyGroup.LastModifiedByUserID = userId;
                newPropertyGroup.LastModifiedOnDate = DateTime.Now;

                if (parentId != -1)
                {
                    newPropertyGroup.ParentId = parentId;
                }
                propertyGroupLayer.Materials_Properties_Groups.InsertOnSubmit(newPropertyGroup);
                propertyGroupLayer.SubmitChanges();
                return newPropertyGroup.ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        
        public static int SetPropertyGroupML(int GroupId, string Locale, string designation)
        {
            DataLayer.MaterialsDataContext propertyGroupMLLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Properties_GroupsML newPropertyGroupML = new DataLayer.Materials_Properties_GroupsML();
            try
            {
                newPropertyGroupML.ID = GroupId;
                newPropertyGroupML.Locale = Locale;
                newPropertyGroupML.Designation = designation;

                propertyGroupMLLayer.Materials_Properties_GroupsML.InsertOnSubmit(newPropertyGroupML);
                propertyGroupMLLayer.SubmitChanges();
                return newPropertyGroupML.ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        
        public static int UpdatePropertyGroup(int GroupId, string designation, int userId)
        {
            DataLayer.MaterialsDataContext propertyGroupLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Properties_Groups propertyGroup = (from g in propertyGroupLayer.Materials_Properties_Groups
                                                                      where g.ID == GroupId
                                                                      select g).SingleOrDefault();
            if (propertyGroup != null)
            {
                try
                {

                    propertyGroup.Designation = designation;
                    propertyGroup.LastModifiedByUserID = userId;
                    propertyGroup.LastModifiedOnDate = DateTime.Now;
                    propertyGroupLayer.SubmitChanges();
                    return propertyGroup.ID;
                }
                catch (Exception)
                {
                    return -1;
                }
            }
            else
            {
                return -1;
            }
        }

        
        public static int UpdatePropertyGroupML(int GroupId, string Locale, string designation)
        {
            DataLayer.MaterialsDataContext propertyGroupLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Properties_GroupsML propertyGroupML = (from g in propertyGroupLayer.Materials_Properties_GroupsML
                                                                          where g.ID == GroupId && g.Locale == Locale
                                                                          select g).SingleOrDefault();
            if (propertyGroupML != null)
            {
                try
                {
                    propertyGroupML.Designation = designation;
                    propertyGroupLayer.SubmitChanges();
                    return propertyGroupML.ID;
                }
                catch (Exception)
                {
                    return -1;
                }
            }
            else
            {
                return -1;
            }
        }

         
        public static bool deletePropertyGroupByID(int GroupId)
        {
            DataLayer.MaterialsDataContext propertyGroupLayer = new DataLayer.MaterialsDataContext();
            try
            {
                propertyGroupLayer.Materials_DeletePropertiesGroup(GroupId);
                propertyGroupLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }

        }
    }
}
