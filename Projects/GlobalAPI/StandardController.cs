using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace  GlobalAPI 
{
     
    public enum PropertyRequirementType
    {
         
        Requirement_Range = 1,
        
        Requirement_Step = 2,
        
        Requirement_Matrix = 3
    }

     
    public static class StandardController
    {
        #region Manage Norm
         
        public static DataLayer.Materials_Norm GetNormByID(int idNorm)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Norm
                    where p.ID == idNorm
                    select p).SingleOrDefault();
        }
 
        public static DataLayer.Materials_NormML GetNormML(int idNorm, string Locale)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_NormML
                    where p.NormID == idNorm && p.Locale == Locale
                    select p).SingleOrDefault();
        }

         
        public static string SetNorm(string ParentID, string libNorme, string DescriptionHTML)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm newNorm = new DataLayer.Materials_Norm();
            try
            {
                newNorm.Designation = libNorme;
                if (ParentID != "")
                {
                    newNorm.ParentID = Convert.ToInt32(ParentID);
                }
                newNorm.DescriptionHTML = DescriptionHTML;
                layer.Materials_Norm.InsertOnSubmit(newNorm);
                layer.SubmitChanges();
                return "ID_" + newNorm.ID;
            }
            catch (Exception ex)
            {
                return "err_" + ex.Message;
            }
        }

         
        public static bool SetNormML(int idNorm, string libNormML, string DescriptionHTML, string Locale)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_NormML newNormML = new DataLayer.Materials_NormML();
            try
            {
                newNormML.NormID = idNorm;
                newNormML.Locale = Locale;
                newNormML.Designation = libNormML;
                newNormML.DescriptionHTML = DescriptionHTML;
                layer.Materials_NormML.InsertOnSubmit(newNormML);
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        public static bool SetStandardKB(int idNorm, string path, int userId)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Attachement_KB newDoc = new DataLayer.Materials_Norm_Attachement_KB();
            try
            {
                newDoc.NormID = idNorm;
                newDoc.Link = path;
                newDoc.LastModifiedByUserID = userId;
                newDoc.LastModifiedOnDate = DateTime.Now;

                layer.Materials_Norm_Attachement_KB.InsertOnSubmit(newDoc);
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

               
        public static int AddNorm(string designation)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                Materials_Norm fam = new Materials_Norm() { Designation = designation };
                layer.Materials_Norm.InsertOnSubmit(fam);
                layer.SubmitChanges();
                return fam.ID;
            }
            catch
            {

                return -1;
            }
        }

                
        public static bool AddNormML(int key, string designation, string locale)
        {
            try
            {
                if (designation != string.Empty)
                {
                    MaterialsDataContext layer = new MaterialsDataContext();
                    Materials_NormML norm = new Materials_NormML() { NormID = key, Designation = designation, Locale = locale };
                    layer.Materials_NormML.InsertOnSubmit(norm);
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

                
        public static bool FindNormByLocale(int key, string locale)
        {
            var ret = false;
            MaterialsDataContext layer = new MaterialsDataContext();
            var UnitFamML = (from w in layer.Materials_NormML
                             where w.NormID == key &&
                             w.Locale == locale
                             select w).SingleOrDefault();
            if (UnitFamML != null)
                ret = true;
            return ret;
        }

        
        public static bool UpdateNorm(int idNorm, string libNorm)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_Norm norm = (from p in layer.Materials_Norm
                                                    where p.ID == idNorm
                                                    select p).SingleOrDefault();
                norm.Designation = libNorm;
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }
         
        public static bool UpdateNormML(int idNorm, string Locale, string libNorm)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_NormML normML = (from p in layer.Materials_NormML
                                                        where p.NormID == idNorm && p.Locale == Locale
                                                        select p).SingleOrDefault();
                normML.Designation = libNorm;
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        public static bool DeleteStandardML(int idStd)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {

                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

         
        public static List<DataLayer.Materials_Norm_Cases> GetMaterials_Norm_Cases(int idStd)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Norm_Cases
                    where p.IDNorm == idStd
                    select p).ToList<DataLayer.Materials_Norm_Cases>();
        }

        
        public static List<DataLayer.Materials_Norm_Cases_Properties> Get_Norm_Cases_Properties(int idNorm, int idCase)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Norm_Cases_Properties
                    join s in layer.Materials_Norm_Cases on p.IDNC equals s.ID
                    where s.IDNorm == idNorm && s.IDCase == idCase
                    select p).ToList<DataLayer.Materials_Norm_Cases_Properties>();
        }
 /*
        public static List<DataLayer.Materials_MatrixRequirement> Get_MatrixRequirement(int idNCP)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_MatrixRequirement
                    where p.IDNCP == idNCP
                    select p).ToList<DataLayer.Materials_MatrixRequirement>();
        }

         
        public static bool Delete_MatrixRequirement(int idNCP)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                List<DataLayer.Materials_MatrixRequirement> listRequirement = Get_MatrixRequirement(idNCP);
                if (listRequirement.Count > 0)
                {
                    foreach (var Requirement in listRequirement)
                    {
                        layer.Materials_MatrixRequirement.DeleteOnSubmit(Requirement);
                    }
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }

        }
        */
         /*
        public static bool Delete_Norm_Cases_Properties(int idNorm, int idStd)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                List<DataLayer.Materials_Norm_Cases_Properties> listNCP = Get_Norm_Cases_Properties(idNorm, idStd);

                if (listNCP.Count > 0)
                {
                    foreach (var ncp in listNCP)
                    {
                        if (Delete_MatrixRequirement(ncp.ID))
                        {
                            return true;
                        }
                        layer.Materials_Norm_Cases_Properties.DeleteOnSubmit(ncp);
                    }
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }*/

        /*
        public static bool Delete_Norm_Cases(int idStd, int idCase)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_Norm_Cases stdCase = (from p in layer.Materials_Norm_Cases
                                                             where p.IDCase == idCase && p.IDNorm == idStd
                                                             select p).SingleOrDefault();
                if (stdCase != null)
                {
                    if (Delete_Norm_Cases_Properties(idStd, idCase))
                    {
                        return true;
                    }
                    layer.Materials_Norm_Cases.DeleteOnSubmit(stdCase);
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }

        }
        */
         /*
        public static bool DeleteCaseByID(int idNorm, int idCase)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                //Delete from Materials_Norm_Cases
                DataLayer.Materials_Norm_Cases normCase = (from nc in layer.Materials_Norm_Cases
                                                              where nc.IDNorm == idNorm && nc.IDCase == idCase
                                                              select nc).SingleOrDefault();
                if (normCase != null)
                {
                    layer.Materials_Norm_Cases.DeleteOnSubmit(normCase);
                }

                //Delete from Materials_CasesML
                List<DataLayer.Materials_CasesML> listCaseML = (from cml in layer.Materials_CasesML
                                                                   where cml.IDCase == idCase
                                                                   select cml).ToList<DataLayer.Materials_CasesML>();
                if (listCaseML.Count > 0)
                {
                    foreach (var caseML in listCaseML)
                    {
                        layer.Materials_CasesML.DeleteOnSubmit(caseML);
                    }
                }
                //Delete case Attachement
                List<DataLayer.Materials_Case_Attachement_KB> listCaseKB = (from kb in layer.Materials_Case_Attachement_KB
                                                                               where kb.IDCase == idCase
                                                                               select kb).ToList<DataLayer.Materials_Case_Attachement_KB>();
                if (listCaseKB.Count > 0)
                {
                    foreach (var caseKB in listCaseKB)
                    {
                        layer.Materials_Case_Attachement_KB.DeleteOnSubmit(caseKB);
                    }
                }
                //Delete case
                DataLayer.Materials_Cases caseToDelete = (from p in layer.Materials_Cases
                                                             where p.ID == idCase
                                                             select p).SingleOrDefault();
                if (caseToDelete != null)
                {
                    layer.Materials_Cases.DeleteOnSubmit(caseToDelete);
                }
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }*/

         /*
        public static bool DeleteMaterials_CasesML(int idCase)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                List<DataLayer.Materials_CasesML> listCaseML = (from p in layer.Materials_CasesML
                                                                   where p.IDCase == idCase
                                                                   select p).ToList<DataLayer.Materials_CasesML>();
                if (listCaseML.Count > 0)
                {
                    //Delete casesML of the current standardCase
                    foreach (var caseML in listCaseML)
                    {
                        layer.Materials_CasesML.DeleteOnSubmit(caseML);
                    }
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }*/

         
        public static List<DataLayer.Materials_Case_Attachement_KB> Get_Case_Attachement_KB(int idCase)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Case_Attachement_KB
                    where p.IDCase == idCase
                    select p).ToList<DataLayer.Materials_Case_Attachement_KB>();
        }

         /*
        public static bool DeleteMaterials_Case_Attachement_KB(int idCase)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                //delete att kb
                List<DataLayer.Materials_Case_Attachement_KB> listCaseAttachement = Get_Case_Attachement_KB(idCase);
                if (listCaseAttachement.Count > 0)
                {
                    foreach (var caseAttachement in listCaseAttachement)
                    {
                        layer.Materials_Case_Attachement_KB.DeleteOnSubmit(caseAttachement);
                    }
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }*/
 
        public static bool DeleteNorm(int idNorm)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {

                List<DataLayer.Materials_NormML> normsML = GetAllNormML(idNorm);
                if (normsML.Count > 0)
                {
                    foreach (var normML in normsML)
                    {
                        layer.Materials_NormML.DeleteOnSubmit(normML);
                    }
                }
                List<DataLayer.Materials_Norm_Attachement_KB> listStandardAttachement = getStandardAttachement_KB(idNorm);

                if (listStandardAttachement.Count > 0)
                {
                    foreach (var standardAttachement in listStandardAttachement)
                    {
                        layer.Materials_Norm_Attachement_KB.DeleteOnSubmit(standardAttachement);
                    }
                }

                DataLayer.Materials_Norm norm = (from p in layer.Materials_Norm
                                                    where p.ID == idNorm
                                                    select p).SingleOrDefault();
                layer.Materials_Norm.DeleteOnSubmit(norm);
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        public static List<DataLayer.Materials_NormML> GetAllNormML(int idNorm)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_NormML
                    where p.NormID == idNorm
                    select p).ToList<DataLayer.Materials_NormML>();
        }

        
        public static int SetStandardCases(string libCase, string HTMLDescription)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Cases newCase = new DataLayer.Materials_Cases();
            try
            {
                newCase.LibCase = libCase;
                newCase.DescriptionHTML = HTMLDescription;
                //Insert case
                layer.Materials_Cases.InsertOnSubmit(newCase);
                layer.SubmitChanges();
                return newCase.ID;
            }
            catch (Exception)
            {
                return 1;
            }
        }

        
        public static bool UpdateCase(int idCase, string libCase, string HTMLDescription)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_Cases stdCase = (from p in layer.Materials_Cases
                                                        where p.ID == idCase
                                                        select p).SingleOrDefault();
                if (stdCase != null)
                {
                    stdCase.LibCase = libCase;
                    stdCase.DescriptionHTML = HTMLDescription;
                    layer.SubmitChanges();
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

      
        public static bool UpdateCaseML(int idCase, string libCase, string HTMLDescription, string Locale)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_CasesML stdCaseML = (from p in layer.Materials_CasesML
                                                            where p.IDCase == idCase && p.Locale == Locale
                                                            select p).SingleOrDefault();
                if (stdCaseML != null)
                {
                    stdCaseML.LibCase = libCase;
                    stdCaseML.DescriptionHTML = HTMLDescription;
                    layer.SubmitChanges();
                }
                else
                {
                    DataLayer.Materials_CasesML newStdCaseML = new DataLayer.Materials_CasesML();
                    newStdCaseML.IDCase = idCase;
                    newStdCaseML.Locale = Locale;
                    newStdCaseML.LibCase = libCase;
                    newStdCaseML.DescriptionHTML = HTMLDescription;
                    layer.Materials_CasesML.InsertOnSubmit(newStdCaseML);
                    layer.SubmitChanges();
                }
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }
        
        
        public static int SetStandardCasesML(int idCase, string Locale, string libCaseML, string HTMLDescription)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_CasesML newCaseML = new DataLayer.Materials_CasesML();
            try
            {
                newCaseML.IDCase = idCase;
                newCaseML.Locale = Locale;
                newCaseML.LibCase = libCaseML;
                newCaseML.DescriptionHTML = HTMLDescription;
                //Insert case
                layer.Materials_CasesML.InsertOnSubmit(newCaseML);
                layer.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

       
        public static DataLayer.Materials_Cases GetStantardCaseByID(int CaseID)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from c in layer.Materials_Cases
                    where c.ID == CaseID
                    select c).SingleOrDefault();
        }


        public static DataLayer.Materials_CasesML GetStantardCaseMLByLocale(int CaseID, string Locale)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from cml in layer.Materials_CasesML
                    where cml.IDCase == CaseID && cml.Locale == Locale
                    select cml).SingleOrDefault();
        }

        
        public static void DeleteCaseAttachementByIdStd(int caseId, string fPath)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Case_Attachement_KB toDelete = (from p in layer.Materials_Case_Attachement_KB
                                                                   where p.IDCase == caseId && p.Link == fPath
                                                                   select p).SingleOrDefault();

            if (toDelete != null)
            {
                layer.Materials_Case_Attachement_KB.DeleteOnSubmit(toDelete);
                layer.SubmitChanges();
            }
        }

        
        public static string deleteObseleteCaseAttachments(int caseId)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                List<DataLayer.Materials_Case_Attachement_KB> caseAttachementToDelete = (from p in layer.Materials_Case_Attachement_KB
                                                                                            where p.IDCase == caseId
                                                                                            select p).ToList<DataLayer.Materials_Case_Attachement_KB>();
                if (caseAttachementToDelete.Count > 0)
                {
                    foreach (var CaseAttachement in caseAttachementToDelete)
                    {
                        layer.Materials_Case_Attachement_KB.DeleteOnSubmit(CaseAttachement);
                        layer.SubmitChanges();
                    }
                }
                return "-1";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        
        public static int AddCaseAttachment(int caseId, string fPath, int userId)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Case_Attachement_KB newCaseAttachement = new DataLayer.Materials_Case_Attachement_KB();
            try
            {
                //Create new standard attachement
                newCaseAttachement.IDCase = caseId;
                newCaseAttachement.Link = fPath;
                newCaseAttachement.LastModifiedByUserID = userId;
                newCaseAttachement.LastModifiedOnDate = DateTime.Now;
                //Insert standard attachement
                layer.Materials_Case_Attachement_KB.InsertOnSubmit(newCaseAttachement);
                layer.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }
       
       
        public static int SetStandardCase(int idStd, int idCase)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases nc = (from p in layer.Materials_Norm_Cases
                                                    where p.IDNorm == idStd && p.IDCase == idCase
                                                    select p).SingleOrDefault();
            try
            {
                if (nc != null)
                {
                    return nc.ID;
                }
                else
                {
                    DataLayer.Materials_Norm_Cases newNC = new DataLayer.Materials_Norm_Cases();
                    newNC.IDNorm = idStd;
                    newNC.IDCase = idCase;
                    layer.Materials_Norm_Cases.InsertOnSubmit(newNC);
                    layer.SubmitChanges();
                    return newNC.ID;
                }
            }
            catch (Exception)
            {
                return -1;
            }

        }
 
        public static List<DataLayer.Materials_Norm_Attachement_KB> getStandardAttachement_KB(int stdId)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                return (from p in layer.Materials_Norm_Attachement_KB
                        where p.NormID == stdId
                        select p).ToList<DataLayer.Materials_Norm_Attachement_KB>();
            }
            catch (Exception)
            {
                return null;
            }
        }

        
        public static string deleteObseleteStandardAttachments(int stdId)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                List<DataLayer.Materials_Norm_Attachement_KB> stdAttachementToDelete = (from p in layer.Materials_Norm_Attachement_KB
                                                                                           where p.NormID == stdId
                                                                                           select p).ToList<DataLayer.Materials_Norm_Attachement_KB>();
                if (stdAttachementToDelete.Count > 0)
                {
                    foreach (var stdAttachement in stdAttachementToDelete)
                    {
                        layer.Materials_Norm_Attachement_KB.DeleteOnSubmit(stdAttachement);
                        layer.SubmitChanges();
                    }
                }
                return "-1";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }

        
        public static int AddStandardAttachment(int stdId, string fPath, int userId)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Attachement_KB newStandardAttachement = new DataLayer.Materials_Norm_Attachement_KB();
            try
            {
                //Create new standard attachement
                newStandardAttachement.NormID = stdId;
                newStandardAttachement.Link = fPath;
                newStandardAttachement.LastModifiedByUserID = userId;
                newStandardAttachement.LastModifiedOnDate = DateTime.Now;
                //Insert standard attachement
                layer.Materials_Norm_Attachement_KB.InsertOnSubmit(newStandardAttachement);
                layer.SubmitChanges();
                return 1;
            }
            catch (Exception)
            {
                return -1;
            }
        }

         
        public static int SetStandard(string parentID, string nameStd, string HTMLDescription)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                //create new standard
                DataLayer.Materials_Norm newStandard = new DataLayer.Materials_Norm();
                if (parentID != null)
                {
                    newStandard.ParentID = Convert.ToInt32(parentID);
                }
                newStandard.Designation = nameStd;
                newStandard.DescriptionHTML = HTMLDescription;
                //submit insert new standard
                layer.Materials_Norm.InsertOnSubmit(newStandard);
                layer.SubmitChanges();
                return newStandard.ID;
            }
            catch (Exception)
            {
                return -2;
            }
        }

        
        public static int UpdateStandard(int stdId, string parentID, string nameStd, string HTMLDescription)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm Standard = (from std in layer.Materials_Norm
                                                    where std.ID == stdId
                                                    select std).SingleOrDefault();
            if (Standard != null)
            {
                try
                {
                    //update standard
                    Standard.Designation = nameStd;
                    if (parentID != null)
                        Standard.ParentID = Convert.ToInt32(parentID);
                    else
                        Standard.ParentID = null;
                    Standard.DescriptionHTML = HTMLDescription;
                    //submit query
                    layer.SubmitChanges();
                    return stdId;
                }
                catch (Exception)
                {
                    return -1;
                }
            }
            else
            {
                int ret = SetStandard(parentID, nameStd, HTMLDescription);
                return ret;
            }
        }
 
        public static int SetLocalizedStandard(int stdId, string nameStd, string HTMLDescription, string Locale)
        {

            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_NormML StandardML = (from stdML in layer.Materials_NormML
                                                        where stdML.NormID == stdId && stdML.Locale == Locale
                                                        select stdML).SingleOrDefault();
            try
            {
                if (StandardML != null)
                {
                    //update standard ML
                    StandardML.Designation = nameStd;
                    StandardML.DescriptionHTML = HTMLDescription;
                    //submit update
                    layer.SubmitChanges();
                    return -1;
                }
                else
                {
                    //create new standard ML
                    DataLayer.Materials_NormML newStandardML = new DataLayer.Materials_NormML();
                    newStandardML.NormID = stdId;
                    newStandardML.Locale = Locale;
                    StandardML.Designation = nameStd;
                    StandardML.DescriptionHTML = HTMLDescription;
                    //submit insert
                    layer.Materials_NormML.InsertOnSubmit(newStandardML);
                    layer.SubmitChanges();
                    return stdId;
                }
            }
            catch (Exception)
            {
                return -2;
            }
        }

        
        public static void DeleteStandardAttachementByIdStd(int StdID, string fPath)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Attachement_KB toDelete = (from p in layer.Materials_Norm_Attachement_KB
                                                                   where p.NormID == StdID && p.Link == fPath
                                                                   select p).SingleOrDefault();

            if (toDelete != null)
            {
                layer.Materials_Norm_Attachement_KB.DeleteOnSubmit(toDelete);
                layer.SubmitChanges();
            }
        }

         
        public static DataLayer.Materials_Norm_Cases_Properties GetPropertyRef(string Locale, int id)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Norm_Cases_Properties
                    where p.ID == id
                    select p).SingleOrDefault();
        }

        /* 
        public static DataLayer.Materials_MatrixRequirement GetPropertyFct(string Locale, int id)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_MatrixRequirement
                    where p.ID == id
                    select p).SingleOrDefault();
        }
        */
        
        public static bool UpdatePropertyRange(int ID, int idProperty, string minVal, string maxVal, int idMeasure, int userID)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases_Properties propertyRange = (from p in layer.Materials_Norm_Cases_Properties
                                                                          where p.ID == ID
                                                                          select p).SingleOrDefault();
            try
            {
                if (minVal != "")
                {
                    propertyRange.ValMin = minVal;
                }
                if (maxVal != "")
                {
                    propertyRange.ValMax = maxVal;
                }
                propertyRange.ID_Properties = idProperty;
                propertyRange.ID_UniteMeasure = idMeasure;
                propertyRange.LastModifiedByUserID = userID;
                propertyRange.LastModifiedOnDate = DateTime.Now;
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        public static bool DeletePropertyRequirement(int IDNCP)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                List<DataLayer.Materials_MatrixRequirement> MXToDelete = (from p in layer.Materials_MatrixRequirement
                                                                             where p.IDNCP == IDNCP
                                                                             select p).ToList<DataLayer.Materials_MatrixRequirement>();
                foreach (var item in MXToDelete)
                {
                    layer.Materials_MatrixRequirement.DeleteOnSubmit(item);

                }
                layer.SubmitChanges();
                DataLayer.Materials_Norm_Cases_Properties toDelete = (from p in layer.Materials_Norm_Cases_Properties
                                                                         where p.ID == IDNCP
                                                                         select p).SingleOrDefault();
                layer.Materials_Norm_Cases_Properties.DeleteOnSubmit(toDelete);
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }
        
       /*
        public static int SetMatrixRequirment(int IDNCP, int idProperty, string MaxVal, string MinVal, int idMeasure)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_MatrixRequirement mx = new DataLayer.Materials_MatrixRequirement();
            try
            {
                mx.IDNCP = IDNCP;
                mx.ID_UniteMeasure = idMeasure;
                mx.IDProperty = idProperty;
                mx.ValMax = MaxVal;
                mx.ValMin = MinVal;

                layer.Materials_MatrixRequirement.InsertOnSubmit(mx);
                layer.SubmitChanges();
                return mx.ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }
        */
       /*
        public static bool UpdateMatrixRequirment(int id, int idProperty, string MaxVal, string MinVal, int idMeasure)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_MatrixRequirement mx = (from p in layer.Materials_MatrixRequirement
                                                           where p.ID == id
                                                           select p).SingleOrDefault();
            try
            {
                mx.ID_UniteMeasure = idMeasure;
                mx.IDProperty = idProperty;
                mx.ValMax = MaxVal;
                mx.ValMin = MinVal;

                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }
        */
       
        public static bool DeletePropertyMX(int id)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_MatrixRequirement mx = (from p in layer.Materials_MatrixRequirement
                                                               where p.ID == id
                                                               select p).SingleOrDefault();
                layer.Materials_MatrixRequirement.DeleteOnSubmit(mx);
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }
        
       
        public static double CalculateValue(string value)
        {
            try
            {
                string formatedValue = value.ToUpper(System.Globalization.CultureInfo.CurrentCulture);
                if (formatedValue.Contains("."))
                {
                    formatedValue = formatedValue.Replace(".", ",");
                }
                if (formatedValue.Contains("E"))
                {
                    if (formatedValue.Contains(" "))
                    {
                        double leftValue = double.Parse(formatedValue.Split(new string[] { " " }, StringSplitOptions.None)[0]);
                        int exposant = int.Parse(formatedValue.Split(new string[] { " " }, StringSplitOptions.None)[1].Split(new string[] { "E" }, StringSplitOptions.None)[1]);
                        double mul = Math.Pow(10, (double)exposant);
                        return leftValue * mul;
                    }
                    else
                    {
                        double leftValue = double.Parse(formatedValue.Split(new string[] { "E" }, StringSplitOptions.None)[0]);
                        int exposant = int.Parse(formatedValue.Split(new string[] { "E" }, StringSplitOptions.None)[1]);
                        return Math.Pow((double)leftValue, (double)exposant);
                    }
                }
                else
                {
                    return double.Parse(formatedValue);
                }
            }
            catch (Exception)
            {
                return double.NaN;
            }
        }

        
        public static List<DataLayer.Materials_Norm_Cases_Properties> GetRequirementByNC(int idnc)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Norm_Cases_Properties
                    where p.IDNC == idnc
                    select p).ToList<DataLayer.Materials_Norm_Cases_Properties>();
        }

         
        public static bool UpdateNCPropertyMatrix(int id, int idProperty, string MaxVal, string MinVal, int userID, int idMeasure, bool IsOptional)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases_Properties toUpdate = (from p in layer.Materials_Norm_Cases_Properties
                                                                     where p.ID == id
                                                                     select p).SingleOrDefault();
            try
            {
                toUpdate.ID_Properties = idProperty;
                toUpdate.ValMax = MaxVal;
                toUpdate.ValMin = MinVal;
                toUpdate.RequirementType = (int)PropertyRequirementType.Requirement_Matrix;
                toUpdate.ID_UniteMeasure = idMeasure;
                toUpdate.LastModifiedByUserID = userID;
                toUpdate.LastModifiedOnDate = DateTime.Now;
                toUpdate.IsOptional = IsOptional;

                layer.SubmitChanges();

                return false;
            }
            catch (Exception)
            { return true; }
        }

        
        public static int SetNCPropertyMatrix(int IDNC, int idProperty, string MaxVal, string MinVal, int userID, int idMeasure, bool IsOptional)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases_Properties newNCP = new DataLayer.Materials_Norm_Cases_Properties();
            try
            {
                newNCP.IDNC = IDNC;
                newNCP.ID_Properties = idProperty;
                newNCP.ValMax = MaxVal;
                newNCP.ValMin = MinVal;
                newNCP.RequirementType = (int)PropertyRequirementType.Requirement_Matrix;
                newNCP.ID_UniteMeasure = idMeasure;
                newNCP.LastModifiedByUserID = userID;
                newNCP.LastModifiedOnDate = DateTime.Now;
                newNCP.IsOptional = IsOptional;

                layer.Materials_Norm_Cases_Properties.InsertOnSubmit(newNCP);
                layer.SubmitChanges();

                return newNCP.ID;
            }
            catch (Exception)
            { return -1; }
        }

         
        public static int SetNCPropertyRange(int IDNC, int idProperty, string MaxVal, string MinVal, int userID, int idMeasure, bool IsOptional)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases_Properties newNCP = new DataLayer.Materials_Norm_Cases_Properties();
            try
            {
                newNCP.IDNC = IDNC;
                newNCP.ID_Properties = idProperty;
                newNCP.ValMax = MaxVal;
                newNCP.ValMin = MinVal;
                newNCP.RequirementType = (int)PropertyRequirementType.Requirement_Range;
                newNCP.ID_UniteMeasure = idMeasure;
                newNCP.LastModifiedByUserID = userID;
                newNCP.LastModifiedOnDate = DateTime.Now;
                newNCP.IsOptional = IsOptional;

                layer.Materials_Norm_Cases_Properties.InsertOnSubmit(newNCP);
                layer.SubmitChanges();

                return newNCP.ID;
            }
            catch (Exception)
            { return -1; }
        }

        
        public static bool UpdatePropertyRange(int ID, int idProperty, string minVal, string maxVal, int idMeasure, int userID, bool IsOptional)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases_Properties propertyRange = (from p in layer.Materials_Norm_Cases_Properties
                                                                          where p.ID == ID
                                                                          select p).SingleOrDefault();
            try
            {
                if (minVal != "")
                {
                    propertyRange.ValMin = minVal;
                }
                if (maxVal != "")
                {
                    propertyRange.ValMax = maxVal;
                }
                propertyRange.ID_Properties = idProperty;
                propertyRange.ID_UniteMeasure = idMeasure;
                propertyRange.LastModifiedByUserID = userID;
                propertyRange.LastModifiedOnDate = DateTime.Now;
                propertyRange.IsOptional = IsOptional;
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

         
        public static DataLayer.Materials_Norm_Cases_Properties GetPropertyRequirement(int ID)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Norm_Cases_Properties
                    where p.ID == ID
                    select p).SingleOrDefault();
        }

        
        public static int SetNCPropertyStep(int IDNC, int idProperty, string valueSet, int userID, int idMeasure, bool IsOptional)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases_Properties newNCPStep = new DataLayer.Materials_Norm_Cases_Properties();
            try
            {
                newNCPStep.ID_Properties = idProperty;
                newNCPStep.ID_UniteMeasure = idMeasure;
                newNCPStep.IDNC = IDNC;
                newNCPStep.LastModifiedByUserID = userID;
                newNCPStep.LastModifiedOnDate = DateTime.Now;
                newNCPStep.RequirementType = (int)PropertyRequirementType.Requirement_Step;
                newNCPStep.ValueSet = valueSet;
                newNCPStep.IsOptional = IsOptional;

                layer.Materials_Norm_Cases_Properties.InsertOnSubmit(newNCPStep);
                layer.SubmitChanges();
                return newNCPStep.ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        
        public static bool UpdateNCPropertyStep(int ID, int idProperty, string valueSet, int idMeasure, int userID, bool IsOptional)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Cases_Properties toUpdate = (from p in layer.Materials_Norm_Cases_Properties
                                                                     where p.ID == ID
                                                                     select p).SingleOrDefault();
            try
            {
                toUpdate.ValueSet = valueSet;
                toUpdate.ID_Properties = idProperty;
                toUpdate.ID_UniteMeasure = idMeasure;
                toUpdate.LastModifiedByUserID = userID;
                toUpdate.LastModifiedOnDate = DateTime.Now;
                toUpdate.IsOptional = IsOptional;

                layer.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

      
        public static List<ReqValidation> ValidateProperties(string key, int idNorm, int idCase, List<DataLayer.Materials_Materials_Properties> listMatProperties)
        {
            return null;
        }

         /*
        public static bool ValidatePropertyDependencies(int IdNCP, List<DataLayer.Materials_Materials_Properties> listMatProp)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            List<DataLayer.Materials_MatrixRequirement> listReqDependProp = (from r in layer.Materials_MatrixRequirement
                                                                                where r.IDNCP == IdNCP
                                                                                select r).ToList<DataLayer.Materials_MatrixRequirement>();
            if (listReqDependProp != null)
            {
                foreach (var property in listMatProp)
                {
                    bool isValid = true;
                    foreach (var reqDepend in listReqDependProp)
                    {
                        if (property.ID_Properties == reqDepend.IDProperty)
                        {
                            if (CalculateValue(property.Valeur.ToString()) >= CalculateValue(reqDepend.ValMin) && CalculateValue(property.Valeur.ToString()) <= CalculateValue(reqDepend.ValMax))
                            {
                                isValid = true;
                            }
                            else
                            {
                                isValid = false;
                            }
                        }
                    }
                    if (!isValid)
                        return isValid;
                }
            }
            return true;
        }*/
       /*
        public static List<ReqValidation> ValidateMaterials(int MatId)
        {
            string key = "";
            List<ReqValidation> validationLog = new List<ReqValidation>();
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Materials materials = (from m in layer.Materials_Materials
                                                          where m.ID == MatId
                                                          select m).SingleOrDefault();
            List<DataLayer.Materials_Materials_Properties> listMatProperties = (from p in layer.Materials_Materials_Properties
                                                                                   where p.ID_Articles == MatId
                                                                                   select p).ToList<DataLayer.Materials_Materials_Properties>();
            if (listMatProperties != null)
            {
                if (materials != null)
                {
                    foreach (var stdMat in materials.Materials_Materials_Norm)
                    {
                        foreach (var stdCase in stdMat.Materials_Norm.Materials_Norm_Cases)
                        {
                            key = MatId + "##" + stdMat.ID_Norm + "##" + stdCase.IDCase;
                            validationLog.AddRange(ValidateProperties(key, (int)stdMat.ID_Norm, (int)stdCase.IDCase, listMatProperties));
                        }
                    }
                }
            }
            return validationLog;
        }*/

        /*
        public static List<ReqValidation> ValidateMaterialsByAllNorm(int MatId)
        {
            string key = "";
            List<ReqValidation> validationLog = new List<ReqValidation>();
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            //Get all norm
            List<DataLayer.Materials_Norm> listNorm = (from m in layer.Materials_Norm
                                                          select m).ToList<DataLayer.Materials_Norm>();
            //Get all material properties
            List<DataLayer.Materials_Materials_Properties> listMatProperties = (from p in layer.Materials_Materials_Properties
                                                                                   where p.ID_Articles == MatId
                                                                                   select p).ToList<DataLayer.Materials_Materials_Properties>();
            if (listMatProperties != null)
            {
                if (listNorm != null)
                {
                    foreach (var std in listNorm)
                    {
                        List<DataLayer.Materials_Norm_Cases> listNC = (from n in layer.Materials_Norm_Cases
                                                                          where n.IDNorm == std.ID
                                                                          select n).ToList<DataLayer.Materials_Norm_Cases>();
                        if (listNC != null)
                        {
                            foreach (DataLayer.Materials_Norm_Cases nc in listNC)
                            {
                                //Generate validation key
                                key = MatId + "##" + std.ID + "##" + nc.IDCase;
                                validationLog.AddRange(ValidateProperties(key, (int)std.ID, (int)nc.IDCase, listMatProperties));
                            }
                        }
                    }
                }
            }
            return validationLog;
        }*/
 
        public static List<ReqValidation> ValidateMaterialsByNorm(int idMat, int idNorm, int idCase)
        {
            string key = "";
            List<ReqValidation> validationLog = new List<ReqValidation>();
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();

            List<DataLayer.Materials_Materials_Properties> listMatProperties = (from p in layer.Materials_Materials_Properties
                                                                                   where p.ID_Articles == idMat
                                                                                   select p).ToList<DataLayer.Materials_Materials_Properties>();
            if (listMatProperties != null)
            {
                if (idNorm == -1 && idCase == -1)
                {
                    List<DataLayer.Materials_Norm_Cases> reqNC = (from p in layer.Materials_Norm_Cases
                                                                     select p).ToList<DataLayer.Materials_Norm_Cases>();
                    foreach (var nc in reqNC)
                    {
                        key = idMat + "##" + nc.IDNorm + "##" + nc.IDCase;
                        validationLog.AddRange(ValidateProperties(key, (int)nc.IDNorm, (int)nc.IDCase, listMatProperties));
                    }
                }
                else if (idNorm != -1 && idCase == -1)
                {
                    List<DataLayer.Materials_Norm_Cases> reqNC = (from p in layer.Materials_Norm_Cases
                                                                     where p.IDNorm == idNorm
                                                                     select p).ToList<DataLayer.Materials_Norm_Cases>();
                    foreach (var nc in reqNC)
                    {
                        key = idMat + "##" + nc.IDNorm + "##" + nc.IDCase;
                        validationLog.AddRange(ValidateProperties(key, (int)nc.IDNorm, (int)nc.IDCase, listMatProperties));
                    }
                }
                else if (idNorm != -1 && idCase != -1)
                {
                    key = idMat + "##" + idNorm + "##" + idCase;
                    validationLog.AddRange(ValidateProperties(key, (int)idNorm, (int)idCase, listMatProperties));
                }
            }
            return validationLog;
        }
               
         
        public static DataLayer.Materials_Norm_Cases_Properties GetRequirementById(int IdReq)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Norm_Cases_Properties
                    where p.ID == IdReq
                    select p).SingleOrDefault();
        }

        
        public static Boolean setSpecNormes(int idSpec, int idNorme, int userID)
        {
            DataLayer.MaterialsDataContext specNormesLayer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_MaterialsSpecifications_Norm specProperties = new DataLayer.Materials_MaterialsSpecifications_Norm();
                specProperties.ID_Norm = idNorme;
                specProperties.ID_MaterialsSpecification = idSpec;
                specProperties.LastModifiedByUserID = userID;
                specProperties.LastModifiedOnDate = DateTime.Now;
                specNormesLayer.Materials_MaterialsSpecifications_Norm.InsertOnSubmit(specProperties);
                specNormesLayer.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        
        public static List<DataLayer.Materials_MaterialsSpecifications_Norm> getSpecNormesBySpec(int Id_Spec)
        {
            DataLayer.MaterialsDataContext specNormesLayer = new DataLayer.MaterialsDataContext();
            return (from p in specNormesLayer.Materials_MaterialsSpecifications_Norm
                    where p.ID_MaterialsSpecification == Id_Spec
                    select p).ToList<DataLayer.Materials_MaterialsSpecifications_Norm>();
        }

         
        public static List<DataLayer.Materials_Norm_Properties> GetPropertiesByNorm(int idNorm)
        {
            DataLayer.MaterialsDataContext propertiesNormesLayer = new DataLayer.MaterialsDataContext();
            return (from p in propertiesNormesLayer.Materials_Norm_Properties
                    where p.ID_Norm == idNorm
                    select p).ToList<DataLayer.Materials_Norm_Properties>();
        }

         
        public static bool DeletePropertiesNormByNorm(int idNorm)
        {
            DataLayer.MaterialsDataContext propertiesNormesLayer = new DataLayer.MaterialsDataContext();
            IQueryable<DataLayer.Materials_Norm_Properties> propertyNormToDeleteList = (from p in propertiesNormesLayer.Materials_Norm_Properties
                                                                                           where p.ID_Norm == idNorm
                                                                                           select p);
            try
            {
                foreach (var item in propertyNormToDeleteList)
                {
                    propertiesNormesLayer.Materials_Norm_Properties.DeleteOnSubmit(item);
                    propertiesNormesLayer.SubmitChanges();
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

         
        public static bool SetPropertiesNorm(int idNorm, int idProperty, int userId)
        {
            DataLayer.MaterialsDataContext propertiesNormesLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm_Properties newPropertyNorm = new DataLayer.Materials_Norm_Properties();
            try
            {
                newPropertyNorm.ID_Norm = idNorm;
                newPropertyNorm.ID_Properties = idProperty;
                newPropertyNorm.LastModifiedByUserID = userId;
                newPropertyNorm.LastModifiedOnDate = DateTime.Now;

                propertiesNormesLayer.Materials_Norm_Properties.InsertOnSubmit(newPropertyNorm);
                propertiesNormesLayer.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        
        
        public static string GetNormDescription(int IdNorm, string lang)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            var nom = string.Empty;
            nom = layer.Materials_GetNameNorm(IdNorm, lang);
            return nom;
        }

         
        public static string SetNorm(string libNorme)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Norm newNorm = new DataLayer.Materials_Norm();
            try
            {
                newNorm.Designation = libNorme;
                layer.Materials_Norm.InsertOnSubmit(newNorm);
                layer.SubmitChanges();
                return "ID_" + newNorm.ID;
            }
            catch (Exception ex)
            {
                return "err_" + ex.Message;
            }
        }

         
        public static bool SetNormML(int idNorm, string libNormML, string Locale)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_NormML newNormML = new DataLayer.Materials_NormML();
            try
            {
                newNormML.NormID = idNorm;
                newNormML.Locale = Locale;
                newNormML.Designation = libNormML;
                layer.Materials_NormML.InsertOnSubmit(newNormML);
                layer.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return true;
            }
        }

        
        #endregion
    }


     
    public class ReqValidation
    {
        string m_id;
        string m_Norm;
        string m_NCase;
        string m_PropReq;
        bool m_IsValid;
        int m_ReqType;
        int m_IdPropReq;
        int m_IdPropMat;
        int m_IdReq;

        
        public ReqValidation(string id, string norm, string ncase, int IdPropReq, int IdPropMat, string propReq, bool isValid, int IdReq, int reqType)
        {
            m_id = id;
            m_Norm = norm;
            m_NCase = ncase;
            m_IdPropReq = IdPropReq;
            m_PropReq = propReq;
            m_IsValid = isValid;
            m_ReqType = reqType;
            m_IdPropMat = IdPropMat;
            m_IdReq = IdReq;
        }

         
        public string ID { get { return m_id; } }
         
        public string Norm { get { return m_Norm; } }
         
        public string NCase { get { return m_NCase; } }
        
        public int IdPropReq { get { return m_IdPropReq; } }
         
        public string PropReq { get { return m_PropReq; } }
        
        public bool IsValid { get { return m_IsValid; } }
         
        public int IdReq { get { return m_IdReq; } }
         
        public int ReqType { get { return m_ReqType; } }
        
        public int IdPropMat { get { return m_IdPropMat; } }
        
        public void SetIsValid(bool isValid) { m_IsValid = isValid; }

    }

}
