using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI 
{
 
    public static class UnitFamilyController
    {
         
        public static int AddUnitFamilies(string designation)
        {
            try
            {
               MaterialsDataContext layer = new MaterialsDataContext();
                var uf = new Materials_UnitFamilies() { Designation = designation };
                layer.Materials_UnitFamilies.InsertOnSubmit(uf);
                layer.SubmitChanges();
                return uf.ID;
            }
            catch
            {
                return -1;
            }

        }

         
        public static bool AddUnitFamiliesML(int ID, string designation, string Lang)
        {
            try
            {
                if (designation != string.Empty)
                {
                   MaterialsDataContext layer = new MaterialsDataContext();
                   Materials_UnitFamiliesML matML = new Materials_UnitFamiliesML() { UnitFamiliesID = ID, Description = designation, Locale = Lang };
                    layer.Materials_UnitFamiliesML.InsertOnSubmit(matML);
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

       
        public static Materials_UnitFamilies GetUnitFamiliesByID(int key)
        {
           MaterialsDataContext layer = new MaterialsDataContext();
            return ((from p in layer.Materials_UnitFamilies where p.ID == key select p).SingleOrDefault());
        }

         
        public static Materials_UnitFamiliesML GetUnitFamiliesByLocale(int key, string locale)
        {
           MaterialsDataContext layer = new MaterialsDataContext();
            return ((from p in layer.Materials_UnitFamiliesML where p.UnitFamiliesID == key && p.Locale == locale select p).SingleOrDefault());
        }

         
        public static bool UpdateUnitFamilies(int key, string designation)
        {
            try
            {
               MaterialsDataContext layer = new MaterialsDataContext();
                var uf = (from p in layer.Materials_UnitFamilies where p.ID == key select p).SingleOrDefault();
                if (uf != null)
                {
                    uf.Designation = designation;
                    layer.SubmitChanges();
                }
                return true;
            }
            catch
            {
                return false;
            }

        }

         
        public static bool FindUnitFamiliesByLocale(int key, string local)
        {
            var ret = false;
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            if ((from w in layer.Materials_UnitFamiliesML
                 where w.UnitFamiliesID == key && w.Locale == local
                 select w).SingleOrDefault() != null)
                ret = true;
            return ret;
        }

        
        public static bool UpdateUnitFamiliesML(int key, string designation, string local)
        {
            try
            {
                if (designation != string.Empty)
                {
                    DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
                    var ret = (from w in layer.Materials_UnitFamiliesML
                               where w.UnitFamiliesID == key && w.Locale == local
                               select w).SingleOrDefault();
                    if (ret != null)
                    {
                        ret.Description = designation;
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
    }
}
