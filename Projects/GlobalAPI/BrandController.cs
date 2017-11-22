using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI
{
   
    public static class BrandController
    {
         
        public static bool AddBrandML(int ID, string designation, string Lang)
        {
            try
            {
                if (designation != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    Materials_BrandsML matML = new Materials_BrandsML() { ID = ID, Designation = designation, Locale = Lang };
                    layer.Materials_BrandsML.InsertOnSubmit(matML);
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

       
        public static int AddBrand(string designation)
        {
            try
            {
                DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
                var ms = new Materials_Brands() { Designation = designation };
                layer.Materials_Brands.InsertOnSubmit(ms);
                layer.SubmitChanges();
                return ms.ID;
            }
            catch
            {
                return -1;
            }
        }

         
        public static Materials_Brands GetBrandByID(int Key)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            return (from p in layer.Materials_Brands where p.ID == Key select p).SingleOrDefault();
        }

         
        public static Materials_BrandsML GetBrandMLByLang(int ID, string lang)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return ((from w in layer.Materials_BrandsML
                     where w.ID == ID && w.Locale == lang
                     select w).SingleOrDefault());
        }
 
        public static bool UpdateBrand(int key, string designation)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var ret = (from p in layer.Materials_Brands where p.ID == key select p).SingleOrDefault();
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


         
        public static bool FindBrandByLocale(int key, string locale)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            var ret = false;
            if ((from p in layer.Materials_BrandsML where p.ID == key && p.Locale == locale select p).SingleOrDefault() != null)
                ret = true;
            return ret;
        }

        
        public static bool UpdateBrandByLocale(int key, string designation, string locale)
        {
            try
            {
                if (designation != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    var msML = (from p in layer.Materials_BrandsML where p.ID == key && p.Locale == locale select p).SingleOrDefault();
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
    }
}
