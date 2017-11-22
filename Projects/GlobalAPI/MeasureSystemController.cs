using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI 
{
    
    public class MeasureSystemController
    {
        
        public static Materials_MeasureSystemML GetMeasureSystemMLByLang(int ID, string lang)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return ((from w in layer.Materials_MeasureSystemML
                     where w.MeasureSystemID == ID && w.Locale == lang
                     select w).SingleOrDefault());
        }

        
        public static int AddMeasureSystem(string designation)
        {
            try
            {
                DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
                var ms = new Materials_MeasureSystem() { Designation = designation };
                layer.Materials_MeasureSystem.InsertOnSubmit(ms);
                layer.SubmitChanges();
                return ms.ID;
            }
            catch
            {
                return -1;
            }
        }

        
        public static Materials_MeasureSystem GetMeasureSystemByID(int Key)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            return (from p in layer.Materials_MeasureSystem where p.ID == Key select p).SingleOrDefault();
        }

        
        public static bool UpdateMeasureSystem(int key, string designation)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var ret = (from p in layer.Materials_MeasureSystem where p.ID == key select p).SingleOrDefault();
                if (ret != null)
                {
                    ret.Designation = designation;
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

         
        public static bool FindMeasureSystemByLocale(int key, string locale)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            var ret = false;
            if ((from p in layer.Materials_MeasureSystemML where p.MeasureSystemID == key && p.Locale == locale select p).SingleOrDefault() != null)
                ret = true;
            return ret;
        }

        
        public static bool UpdateMeasureSystemByLocale(int key, string designation, string locale)
        {
            try
            {
                if (designation != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    var msML = (from p in layer.Materials_MeasureSystemML where p.MeasureSystemID == key && p.Locale == locale select p).SingleOrDefault();
                    if (msML != null)
                    {
                        msML.Designation = designation;
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

         
        public static bool AddMeasureSystemML(int ID, string designation, string Lang)
        {
            try
            {
                if (designation != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    Materials_MeasureSystemML matML = new Materials_MeasureSystemML() { MeasureSystemID = ID, Designation = designation, Locale = Lang };
                    layer.Materials_MeasureSystemML.InsertOnSubmit(matML);
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
    }
}
