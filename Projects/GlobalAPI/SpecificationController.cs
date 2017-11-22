using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI
{
    
    public static class SpecificationController
    {
         
        public static void AddMateriaslSpecProperties(int IdProperties, int userid, int IdSpec)
        {

            MaterialsDataContext layer = new MaterialsDataContext();
            var ret = (from p in layer.Materials_Specification_Properties where p.Id_Properties == IdProperties && p.Id_Specification == IdSpec select p).SingleOrDefault();
            if (ret == null)
            {
                Materials_Specification_Properties spec = new Materials_Specification_Properties();
                spec.Id_Specification = IdSpec;
                spec.Id_Properties = IdProperties;
                spec.LastModifiedByUserID = userid;
                spec.LastModifiedOnDate = DateTime.Now;
                layer.Materials_Specification_Properties.InsertOnSubmit(spec);
                layer.SubmitChanges();
            }
        }
 
        public static void AddMaterialsSpecProperties(int IdProperties, int userid, int IdSpec)
        {

            MaterialsDataContext layer = new MaterialsDataContext();
            var ret = (from p in layer.Materials_Specification_Properties where p.Id_Properties == IdProperties && p.Id_Specification == IdSpec select p).SingleOrDefault();
            if (ret == null)
            {
                Materials_Specification_Properties spec = new Materials_Specification_Properties();
                spec.Id_Specification = IdSpec;
                spec.Id_Properties = IdProperties;
                spec.LastModifiedByUserID = userid;
                spec.LastModifiedOnDate = DateTime.Now;
                layer.Materials_Specification_Properties.InsertOnSubmit(spec);
                layer.SubmitChanges();
            }
        }

        
        public static List<DataLayer.Materials_MaterialsSpecification_SelectResult> getMaterialsSpecification(string lang)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return specLayer.Materials_MaterialsSpecification_Select(lang).ToList<DataLayer.Materials_MaterialsSpecification_SelectResult>();
        }

       
        public static IEnumerable<DataLayer.Materials_MaterialsSpecifications> getMaterialsSpecification(string discipline, string locale)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            if (discipline.ToLower() != "all")
            {
                var query = (from ms in specLayer.Materials_MaterialsSpecifications
                             join msd in specLayer.Materials_MaterialsSpecifications_Discipline.Where(j => j.ID_Discipline == discipline) on ms.ID equals msd.ID_MaterialsSpecifications
                             join msML in specLayer.Materials_MaterialsSpecificationsML.Where(j => j.Lang == locale) on ms.ID equals msML.ID into tl_j
                             from msML in tl_j.DefaultIfEmpty()
                             select new
                             {
                                 ID = ms.ID,
                                 Id_Parent = ms.Id_Parent,
                                 Designation = msML.Designation == null ? ms.Designation : msML.Designation,
                                 LastModifiedByUserID = ms.LastModifiedByUserID,
                                 LastModifiedOnDate = ms.LastModifiedOnDate,
                                 CreatedByUserID = ms.CreatedByUserID,
                                 CreatedOnDate = ms.CreatedOnDate,
                                 Materials_Materials = ms.Materials_Materials
                             });
                var matches =
                from result in query.AsEnumerable()
                select new DataLayer.Materials_MaterialsSpecifications()
                {
                    ID = result.ID,
                    Id_Parent = result.Id_Parent,
                    Designation = result.Designation,
                    LastModifiedByUserID = result.LastModifiedByUserID,
                    LastModifiedOnDate = result.LastModifiedOnDate,
                    CreatedByUserID = result.CreatedByUserID,
                    CreatedOnDate = result.CreatedOnDate,
                    Materials_Materials = result.Materials_Materials
                };
                return matches;
            }
            else
            {
                var query = (from kb in specLayer.Materials_MaterialsSpecifications
                             join kbml in specLayer.Materials_MaterialsSpecificationsML.Where(j => j.Lang == locale) on kb.ID equals kbml.ID into tl_j
                             from kbml in tl_j.DefaultIfEmpty()
                             select new
                             {
                                 ID = kb.ID,
                                 Id_Parent = kb.Id_Parent,
                                 Designation = kbml.Designation == null ? kb.Designation : kbml.Designation,
                                 LastModifiedByUserID = kb.LastModifiedByUserID,
                                 LastModifiedOnDate = kb.LastModifiedOnDate,
                                 CreatedByUserID = kb.CreatedByUserID,
                                 CreatedOnDate = kb.CreatedOnDate,
                                 Materials_Materials = kb.Materials_Materials
                             });
                var matches =
                from result in query.AsEnumerable()
                select new DataLayer.Materials_MaterialsSpecifications()
                {
                    ID = result.ID,
                    Id_Parent = result.Id_Parent,
                    Designation = result.Designation,
                    LastModifiedByUserID = result.LastModifiedByUserID,
                    LastModifiedOnDate = result.LastModifiedOnDate,
                    CreatedByUserID = result.CreatedByUserID,
                    CreatedOnDate = result.CreatedOnDate,
                    Materials_Materials = result.Materials_Materials
                };
                return matches;
            }

        }

      
        public static string AddNewSpec(string Id_Parent, string designation, int userID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_MaterialsSpecifications newSpec = new DataLayer.Materials_MaterialsSpecifications();
            try
            {
                if (Id_Parent == "")
                {
                    newSpec.Id_Parent = null;
                }
                else
                {
                    newSpec.Id_Parent = int.Parse(Id_Parent);
                }
                newSpec.Designation = designation;
                newSpec.CreatedByUserID = userID;
                newSpec.CreatedOnDate = DateTime.Now;
                newSpec.LastModifiedByUserID = userID;
                newSpec.LastModifiedOnDate = DateTime.Now;

                specLayer.Materials_MaterialsSpecifications.InsertOnSubmit(newSpec);
                specLayer.SubmitChanges();
                return "ID;" + newSpec.ID;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

         
        public static string EditSpec(string id, string Id_Parent, string designation, int userID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_MaterialsSpecifications Spec = (from s in specLayer.Materials_MaterialsSpecifications
                                                                       where s.ID == int.Parse(id)
                                                                       select s).SingleOrDefault();
                if (Id_Parent == "")
                {
                    Spec.Id_Parent = null;
                }
                else
                {
                    Spec.Id_Parent = int.Parse(Id_Parent);
                }
                Spec.Designation = designation;
                Spec.LastModifiedByUserID = userID;
                Spec.LastModifiedOnDate = DateTime.Now;

                specLayer.SubmitChanges();
                return "ok";
            }
            catch (Exception ex)
            {

                return ex.Message;
            }
        }

         
        public static bool deleteMaterialsSpecification(int ID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_MaterialsSpecifications specToDelete = (from p in specLayer.Materials_MaterialsSpecifications
                                                                               where p.ID == ID
                                                                               select p).SingleOrDefault();
                bool isNewCreated = (specToDelete.Materials_MaterialsSpecifications_Norm.Count == 0)                    
                    && (specToDelete.Materials_Materials.Count == 0)
                    && (specToDelete.Materials_Specification_Properties.Count == 0)
                    && (specToDelete.Materials_Specification_SoftwareSpecifcation.Count == 0)
                    && (specToDelete.Materials_Specifications_StorageConditions.Count == 0)
                    && (specToDelete.Materials_Supplier_MaterialsSpecifications.Count == 0);
                if (isNewCreated)
                {
                    if (specToDelete.Materials_MaterialsSpecifications_Discipline.Count > 0)
                    {
                        var specDispToDelete = (from p in specLayer.Materials_MaterialsSpecifications_Discipline
                                                where p.ID_MaterialsSpecifications == ID
                                                select p);
                        specLayer.Materials_MaterialsSpecifications_Discipline.DeleteAllOnSubmit(specDispToDelete);
                    }
                    if (specToDelete.Materials_MaterialsSpecificationsML.Count > 0)
                    {
                        var specMlToDelete = (from p in specLayer.Materials_MaterialsSpecificationsML
                                              where p.ID == ID
                                              select p);
                        specLayer.Materials_MaterialsSpecificationsML.DeleteAllOnSubmit(specMlToDelete);
                    }
                }
                specLayer.Materials_MaterialsSpecifications.DeleteOnSubmit(specToDelete);
                specLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        public static string AssignMatSpecToDiscipline(string ID_Discipline, int ID_MaterialsSpecification, int userID)
        {
            DataLayer.MaterialsDataContext specDisciplineLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_MaterialsSpecifications_Discipline newSpecDiscipline = new DataLayer.Materials_MaterialsSpecifications_Discipline();
            try
            {
                newSpecDiscipline.ID_Discipline = ID_Discipline;
                newSpecDiscipline.ID_MaterialsSpecifications = ID_MaterialsSpecification;
                newSpecDiscipline.CreatedByUserID = userID;
                newSpecDiscipline.CreatedOnDate = DateTime.Now;
                newSpecDiscipline.LastModifiedByUserID = userID;
                newSpecDiscipline.LastModifiedOnDate = DateTime.Now;
                specDisciplineLayer.Materials_MaterialsSpecifications_Discipline.InsertOnSubmit(newSpecDiscipline);
                specDisciplineLayer.SubmitChanges();
                return "ok";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
         
         
        public static string AssignMatSpecToSupplier(int ID_Supplier, int ID_MaterialsSpecification, int userID)
        {
            try
            {
                DataLayer.MaterialsDataContext specSupplierLayer = new DataLayer.MaterialsDataContext();
                if (specSupplierLayer.Materials_Supplier_MaterialsSpecifications.Where(x => x.IDContact == ID_Supplier && x.IDMatSpec == ID_MaterialsSpecification).ToList().Count == 0)
                {
                    DataLayer.Materials_Supplier_MaterialsSpecifications newSpecSupplier = new DataLayer.Materials_Supplier_MaterialsSpecifications();

                    newSpecSupplier.IDContact = ID_Supplier;
                    newSpecSupplier.IDMatSpec = ID_MaterialsSpecification;
                    newSpecSupplier.CreatedByUserID = userID;
                    newSpecSupplier.CreatedOnDate = DateTime.Now;
                    newSpecSupplier.LastModifiedByUserID = userID;
                    newSpecSupplier.LastModifiedOnDate = DateTime.Now;
                    specSupplierLayer.Materials_Supplier_MaterialsSpecifications.InsertOnSubmit(newSpecSupplier);
                    specSupplierLayer.SubmitChanges();
                    return "ok";
                }
                else
                {
                    return "Affectation existe.";
                }

            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
 
        public static List<int> GetIDMatSpecByDiscipline(string ID_Discipline)
        {
            DataLayer.MaterialsDataContext specDisciplineLayer = new DataLayer.MaterialsDataContext();
            return (from p in specDisciplineLayer.Materials_MaterialsSpecifications_Discipline
                    where p.ID_Discipline == ID_Discipline
                    select p.ID_MaterialsSpecifications).ToList<int>();
        }

        
        public static string DeleteMatSpec_Discipline(string ID_Discipline, int ID_MaterialsSpecifications)
        {
            try
            {
                DataLayer.MaterialsDataContext specDisciplineLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_MaterialsSpecifications_Discipline MatSpecToDelete = (from p in specDisciplineLayer.Materials_MaterialsSpecifications_Discipline
                                                                                             where p.ID_Discipline == ID_Discipline && p.ID_MaterialsSpecifications == ID_MaterialsSpecifications
                                                                                             select p).SingleOrDefault();
                specDisciplineLayer.Materials_MaterialsSpecifications_Discipline.DeleteOnSubmit(MatSpecToDelete);
                specDisciplineLayer.SubmitChanges();
                return "ok";
            }
            catch (Exception ex)
            {

                return ex.Message;
            }

        }

        
        public static bool deleteMaterialsSpecificationSupplierBySpec(int Id_Spec)
        {
            DataLayer.MaterialsDataContext specSupplierLayer = new DataLayer.MaterialsDataContext();
            IQueryable<DataLayer.Materials_Supplier_MaterialsSpecifications> specSupplierToDelete = (from p in specSupplierLayer.Materials_Supplier_MaterialsSpecifications
                                                                                                        where p.IDMatSpec == Id_Spec
                                                                                                        select p);
            try
            {
                foreach (var item in specSupplierToDelete)
                {
                    specSupplierLayer.Materials_Supplier_MaterialsSpecifications.DeleteOnSubmit(item);
                    specSupplierLayer.SubmitChanges();
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        public static IQueryable<DataLayer.Materials_Supplier_MaterialsSpecifications> getSpecSupplierbyDiscipline(string Id_Discipline)
        {
            DataLayer.MaterialsDataContext specSupplierLayer = new DataLayer.MaterialsDataContext();
            return (from p in specSupplierLayer.Materials_Supplier_MaterialsSpecifications
                    join s in specSupplierLayer.Materials_MaterialsSpecifications_Discipline on p.IDMatSpec equals s.ID_MaterialsSpecifications
                    where s.ID_Discipline == Id_Discipline
                    select p);
        }
        
        
        public static IQueryable<DataLayer.Materials_Supplier_MaterialsSpecifications> getSpecSupplierbySpec(int Id_Spec)
        {
            DataLayer.MaterialsDataContext specSupplierLayer = new DataLayer.MaterialsDataContext();
            return (from p in specSupplierLayer.Materials_Supplier_MaterialsSpecifications
                    where p.IDMatSpec == Id_Spec
                    select p);
        }

        
        public static List<DataLayer.Materials_SelectMaterialsSpecificationByIDResult> GetMatSpecByID(int specID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return specLayer.Materials_SelectMaterialsSpecificationByID(specID).ToList<DataLayer.Materials_SelectMaterialsSpecificationByIDResult>();
        }
        
         
        public static bool SetSpecML(int IDSpec, string specML, string lang, int userID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_MaterialsSpecificationsML newSpecML = new DataLayer.Materials_MaterialsSpecificationsML();
            try
            {
                newSpecML.ID = IDSpec;
                newSpecML.Lang = lang;
                newSpecML.Designation = specML;
                newSpecML.LastModifiedByUserID = userID;
                newSpecML.LastModifiedOnDate = DateTime.Now;
                //Insert specML
                specLayer.Materials_MaterialsSpecificationsML.InsertOnSubmit(newSpecML);
                specLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

         
        public static bool UpdateSpecML(int IdSpec, string libSpecML, string lang, int userID)
        {
            DataLayer.MaterialsDataContext MLSpecLayer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_MaterialsSpecificationsML specML = (from p in MLSpecLayer.Materials_MaterialsSpecificationsML
                                                                           where p.ID == IdSpec && p.Lang == lang
                                                                           select p).SingleOrDefault();
                specML.Designation = libSpecML;
                specML.LastModifiedByUserID = userID;
                specML.LastModifiedOnDate = DateTime.Now;
                MLSpecLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }

        }

         
        public static DataLayer.Materials_MaterialsSpecificationsML GetMLSpec(int IdSpec, string lang)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return (from p in specLayer.Materials_MaterialsSpecificationsML
                    where p.ID == IdSpec && p.Lang == lang
                    select p).SingleOrDefault();
        }

       
        public static bool DeleteSpecML(int IdSpec, string lang)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_MaterialsSpecificationsML specML = (from p in specLayer.Materials_MaterialsSpecificationsML
                                                                           where p.ID == IdSpec && p.Lang == lang
                                                                           select p).SingleOrDefault();
                specLayer.Materials_MaterialsSpecificationsML.DeleteOnSubmit(specML);
                specLayer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }

        }

         
        public static List<DataLayer.Materials_Specification_Properties> getSpecPropertiesBySpec(int Id_Spec)
        {
            DataLayer.MaterialsDataContext specPropertiesLayer = new DataLayer.MaterialsDataContext();
            return (from p in specPropertiesLayer.Materials_Specification_Properties
                    where p.Id_Specification == Id_Spec
                    select p).ToList<DataLayer.Materials_Specification_Properties>();
        }
 
        public static Boolean setSpecProperties(int idSpec, int idProperty, int userID)
        {
            DataLayer.MaterialsDataContext specPropertiesLayer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_Specification_Properties specProperties = new DataLayer.Materials_Specification_Properties();
                specProperties.Id_Properties = idProperty;
                specProperties.Id_Specification = idSpec;
                specProperties.LastModifiedByUserID = userID;
                specProperties.LastModifiedOnDate = DateTime.Now;
                specPropertiesLayer.Materials_Specification_Properties.InsertOnSubmit(specProperties);
                specPropertiesLayer.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        
        public static bool deleteMaterialsSpecificationPropertiesBySpec(int IdSpec)
        {
            DataLayer.MaterialsDataContext specPropertiesLayer = new DataLayer.MaterialsDataContext();
            IQueryable<DataLayer.Materials_Specification_Properties> toDeleteSpecProperties = (from p in specPropertiesLayer.Materials_Specification_Properties
                                                                                                  where p.Id_Specification == IdSpec
                                                                                                  select p);
            try
            {
                foreach (var item in toDeleteSpecProperties)
                {
                    specPropertiesLayer.Materials_Specification_Properties.DeleteOnSubmit(item);
                    specPropertiesLayer.SubmitChanges();
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        
        public static bool deleteMaterialsSpecificationNormesBySpec(int IdSpec)
        {
            DataLayer.MaterialsDataContext specNormesLayer = new DataLayer.MaterialsDataContext();
            IQueryable<DataLayer.Materials_MaterialsSpecifications_Norm> toDeleteSpecProperties = (from p in specNormesLayer.Materials_MaterialsSpecifications_Norm
                                                                                                      where p.ID_MaterialsSpecification == IdSpec
                                                                                                      select p);
            try
            {
                foreach (var item in toDeleteSpecProperties)
                {
                    specNormesLayer.Materials_MaterialsSpecifications_Norm.DeleteOnSubmit(item);
                    specNormesLayer.SubmitChanges();
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        
        public static string AddMatchingSpecification(int IdSpecification, int IdSpecSoftware)
        {
            try
            {
                DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_Specification_SoftwareSpecifcation correspspec = new Materials_Specification_SoftwareSpecifcation();
                correspspec.ID_MaterialsSpecifications = IdSpecification;
                correspspec.ID_SoftwaresSpecifications = IdSpecSoftware;
                layer.Materials_Specification_SoftwareSpecifcation.InsertOnSubmit(correspspec);
                layer.SubmitChanges();
                return "ok";

            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
 
        public static bool HasCorrespondenceSpec(int IdSpecSoftware)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            if ((from p in layer.Materials_Specification_SoftwareSpecifcation where p.ID_SoftwaresSpecifications == IdSpecSoftware select p).ToList().Count > 0)
                return true;
            else
                return false;
        }

        
        public static DataLayer.Materials_MaterialsSpecifications GetSpecificationById(int id, string Locale)
        {
            try
            {
                DataLayer.MaterialsDataContext StockLayer = new DataLayer.MaterialsDataContext();
                var query = (from x in StockLayer.Materials_MaterialsSpecifications.Where(j => j.ID == id)
                             join ml in StockLayer.Materials_MaterialsSpecificationsML.Where(j => j.Lang == Locale) on x.ID equals ml.ID into tl_j
                             from ml in tl_j.DefaultIfEmpty()
                             select new
                             {
                                 ID = x.ID,
                                 Designation = ml.Designation == null ? x.Designation : ml.Designation
                             });
                var matches =
                 from result in query.AsEnumerable()
                 select new DataLayer.Materials_MaterialsSpecifications()
                 {
                     ID = result.ID,
                     Designation = result.Designation
                 };
                return matches.SingleOrDefault();
            }
            catch (Exception)
            { return null; }
        }

         
        public static List<Materials_MaterialsSpecifications> GetAllFamilies()
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_MaterialsSpecifications select p).ToList();
        }
  

        
        public static string GetMaterialsSpecDescriptionById(int key)
        {
            try
            {
                var ret = string.Empty;
                MaterialsDataContext layer = new MaterialsDataContext();
                var matspec = (from d in layer.Materials_MaterialsSpecifications where d.ID == key select d).SingleOrDefault();
                if (matspec != null)
                    ret = matspec.Designation;
                return ret;
            }
            catch
            {
                return string.Empty;
            }
        }
    }
}
