using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI 
{
    
    public enum Softwares
    {
        
        GFA = 1,         
        SAGE = 2 

    }

   
    public class SoftwareController
    {
        
        public static bool ExistsSoftwareMaterial(int IdMaterial, int IdSpecSoftware)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            if ((from p in layer.Materials_SoftwareMaterials where p.ID_TechnicalSoftwares == IdSpecSoftware && p.ID_Materials == IdMaterial && p.IsDeleted == false select p).ToList().Count > 0)
                return true;
            else
                return false;
        }

         
        public static string AddSoftwareMaterial(int IdMaterial, int IdSpecSoftware, string SoftwareCode, int UserID)
        {
            try
            {
                DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_SoftwareMaterials mappingMat = new Materials_SoftwareMaterials();
                mappingMat.SoftwareCode = SoftwareCode;
                mappingMat.ID_Materials = IdMaterial;
                mappingMat.ID_TechnicalSoftwares = IdSpecSoftware;
                mappingMat.IsDeleted = false;
                mappingMat.CreatedByUserID = UserID;
                mappingMat.CreatedOnDate = DateTime.Now;
                layer.Materials_SoftwareMaterials.InsertOnSubmit(mappingMat);
                layer.SubmitChanges();
                return "ok";

            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        
        public static Materials_TechnicalSoftwares_ML GetTechnicalSoftwareByLang(int ID, string lang)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return ((from w in layer.Materials_TechnicalSoftwares_ML
                     where w.ID_TechnicalSoftwares == ID && w.Locale == lang
                     select w).SingleOrDefault());
        }

         
        public static Materials_TechnicalSoftwares GetTechnicalSoftwareByID(int Key)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            return (from p in layer.Materials_TechnicalSoftwares where p.ID == Key select p).SingleOrDefault();
        }

         
        public static int AddTechnicalSoftware(string Name, string Editor, string Version)
        {
            try
            {
                DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
                var ms = new Materials_TechnicalSoftwares() { Name = Name, Editor = Editor, Version = Version };
                layer.Materials_TechnicalSoftwares.InsertOnSubmit(ms);
                layer.SubmitChanges();
                return ms.ID;
            }
            catch
            {
                return -1;
            }
        }

        
        public static bool AddTechnicalSoftwareML(int ID, string name, string editor, string Lang)
        {
            try
            {
                if (name != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    Materials_TechnicalSoftwares_ML matML = new Materials_TechnicalSoftwares_ML() { Name = name, Editor = editor, ID_TechnicalSoftwares = ID, Locale = Lang };
                    layer.Materials_TechnicalSoftwares_ML.InsertOnSubmit(matML);
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

         
        public static bool UpdateTechnicalSoftware(int key, string name, string editor, string version)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var ret = (from p in layer.Materials_TechnicalSoftwares where p.ID == key select p).SingleOrDefault();
                if (ret != null)
                {
                    ret.Name = name;
                    ret.Editor = editor;
                    ret.Version = version;
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

         
        public static bool UpdateTechnicalSoftwareByLocale(int key, string name, string editor, string locale)
        {
            try
            {
                if (name != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    var msML = (from p in layer.Materials_TechnicalSoftwares_ML where p.ID_TechnicalSoftwares == key && p.Locale == locale select p).SingleOrDefault();
                    if (msML != null)
                    {
                        msML.Name = name;
                        msML.Editor = editor;
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

       
        public static bool FindTechnicalSoftwareByLocale(int key, string locale)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            var ret = false;
            if ((from p in layer.Materials_TechnicalSoftwares_ML where p.ID_TechnicalSoftwares == key && p.Locale == locale select p).SingleOrDefault() != null)
                ret = true;
            return ret;
        }

        
        public static List<DotNetNuke.Entities.Users.UserInfo> GetTechnicalSoftwareDsciplineResponsable(string disciplineID, int technicalID , int _portalId)
        {
            try
            {
                MaterialsDataContext db = new MaterialsDataContext();
                List<Materials_TechnicalSoftware_Discipline_Responsable> lsRespo = new List<Materials_TechnicalSoftware_Discipline_Responsable>();
                if (disciplineID == "")
                    lsRespo = (from w in db.Materials_TechnicalSoftware_Discipline_Responsable where w.ID_TechnicalSoftwares == technicalID select w).ToList();
                else
                    lsRespo = (from w in db.Materials_TechnicalSoftware_Discipline_Responsable where w.ID_Discipline == disciplineID && w.ID_TechnicalSoftwares == technicalID select w).ToList();

                List<DotNetNuke.Entities.Users.UserInfo> lsEmp = new List<DotNetNuke.Entities.Users.UserInfo>();
                foreach (Materials_TechnicalSoftware_Discipline_Responsable act in lsRespo)
                {

                    if (act.ID_User.HasValue)
                    {
                        DotNetNuke.Entities.Users.UserInfo empTemp = DotNetNuke.Entities.Users.UserController.GetUserById(_portalId , (int) act.ID_User); 
                        lsEmp.Add(empTemp);
                    }
                }
                return lsEmp;
            }
            catch
            {
                return null;
            }
        }

        
        public static bool AddTechnicalSoftwareDsciplineResponsable(string disciplineID, int technicalID, int? roelID , int? empID, int userID)
        {
            try
            {
                MaterialsDataContext db = new MaterialsDataContext();
                Materials_TechnicalSoftware_Discipline_Responsable doc = new Materials_TechnicalSoftware_Discipline_Responsable()
                {
                    ID_Discipline = disciplineID == "ALL" ? null : disciplineID,
                    ID_TechnicalSoftwares = technicalID,    
                    ID_Role = roelID, 
                     ID_User  = empID,
                    LastModifiedByUserID = userID,
                    LastModifiedOnDate = DateTime.Now
                };
                db.Materials_TechnicalSoftware_Discipline_Responsable.InsertOnSubmit(doc);
                db.SubmitChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
