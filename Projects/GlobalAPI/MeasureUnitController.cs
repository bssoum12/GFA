using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI 
{
    
    public static class MeasureUnitController
    {
 
        public static int AddMeasureUnit(string designation, string abbreviation, int IdMeasureSystem, int IdUnitFamilies, int IdUser)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                Materials_MeasureUnit mu = new Materials_MeasureUnit()
                {
                    Designation = designation,
                    Abreviation = abbreviation
                    ,
                    ID_SystemMeasure = IdMeasureSystem,
                    ID_FamilyUnites = IdUnitFamilies,
                    LastModifiedByUserID = IdUser,
                    LastModifiedOnDate = DateTime.Now
                };
                layer.Materials_MeasureUnit.InsertOnSubmit(mu);
                layer.SubmitChanges();
                return mu.ID;
            }
            catch
            {
                return -1;
            }
        }

      
        public static bool AddMeasureUnitML(int key, string designation, string locale)
        {
            try
            {
                if (designation != "")
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    Materials_MeasureUnitML muML = new Materials_MeasureUnitML() { Designation = designation, Locale = locale, MeasureUnitID = key };
                    layer.Materials_MeasureUnitML.InsertOnSubmit(muML);
                    layer.SubmitChanges();
                    return true;
                }
                else
                    return false;
            }
            catch
            {
                return false;
            }

        }

         
        public static bool UpdateMeasureUnit(int key, string designation, string abbreviation, int MeasureSystemId, int UnitFamiliesId, int UserId)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var mu = (from p in layer.Materials_MeasureUnit where p.ID == key select p).SingleOrDefault();
                if (mu != null)
                {
                    mu.Designation = designation;
                    mu.Abreviation = abbreviation;
                    mu.ID_FamilyUnites = UnitFamiliesId;
                    mu.ID_SystemMeasure = MeasureSystemId;
                    mu.LastModifiedByUserID = UserId;
                    mu.LastModifiedOnDate = DateTime.Now;
                    layer.SubmitChanges();
                    return true;
                }
                else
                    return false;
            }
            catch
            {
                return false;
            }
        }

         
        public static bool FindMeasureUnitByLocale(int key, string locale)
        {
            var ret = false;
            MaterialsDataContext layer = new MaterialsDataContext();
            if ((from p in layer.Materials_MeasureUnitML where p.MeasureUnitID == key && p.Locale == locale select p).SingleOrDefault() != null)
                ret = true;
            return ret;
        }
 
        public static bool UpdateMeasureUnitML(int key, string designation, string locale)
        {
            try
            {
                if (designation != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    var muML = (from p in layer.Materials_MeasureUnitML where p.MeasureUnitID == key && p.Locale == locale select p).SingleOrDefault();
                    if (muML != null)
                    {
                        muML.Designation = designation;
                        layer.SubmitChanges();
                        return true;
                    }
                    else
                        return false;

                }
                else
                    return false;
            }
            catch
            {
                return false;
            }

        }

         
        public static Materials_MeasureUnit GetMeasureUnitById(int key)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            return ((from p in layer.Materials_MeasureUnit where p.ID == key select p).SingleOrDefault());
        }

        
        public static Materials_MeasureUnitML GetMeasureUnitByLocale(int key, string locale)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            return ((from p in layer.Materials_MeasureUnitML where p.MeasureUnitID == key && p.Locale == locale select p).SingleOrDefault());

        }
    }
}
