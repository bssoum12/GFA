using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataLayer; 
namespace GlobalAPI
{
    
    public enum GlobalSettings
    {
         
        MaterialsOnChildsOnly = 1,
    }

     
    public class MaterialsController
    {
         
        public static List<DataLayer.Materials_GetSuppliersByMaterialIDResult> getMaterialSuppliers(int ID)
        {
            DataLayer.MaterialsDataContext db = new DataLayer.MaterialsDataContext();
            return db.Materials_GetSuppliersByMaterialID(ID).ToList();
        }

        
        public static int deleteMaterialByID(int materialId)
        {
            // Delete material Line
            DataLayer.MaterialsDataContext db = new DataLayer.MaterialsDataContext();
            System.Data.Common.DbTransaction transaction;
            db.Connection.Open();
            transaction = db.Connection.BeginTransaction();
            db.Transaction = transaction;
            try
            {
                List<DataLayer.Materials_Attachments> attach = db.Materials_Attachments.Where(c => c.ID_Materials == materialId).ToList();
                db.Materials_Attachments.DeleteAllOnSubmit(attach);
                db.SubmitChanges();

                List<DataLayer.Materials_SoftwareMaterials> softMat = db.Materials_SoftwareMaterials.Where(c => c.ID_Materials == materialId).ToList();
                db.Materials_SoftwareMaterials.DeleteAllOnSubmit(softMat);
                db.SubmitChanges();

                List<DataLayer.Materials_KB> kb = db.Materials_KB.Where(c => c.ID_Materials == materialId).ToList();
                db.Materials_KB.DeleteAllOnSubmit(kb);
                db.SubmitChanges();

                List<DataLayer.Materials_Materials_Properties> properties = db.Materials_Materials_Properties.Where(c => c.ID_Articles == materialId).ToList();
                db.Materials_Materials_Properties.DeleteAllOnSubmit(properties);
                db.SubmitChanges();

                List<DataLayer.Materials_Materials_Norm> normes = db.Materials_Materials_Norm.Where(c => c.ID_Materials == materialId).ToList();
                db.Materials_Materials_Norm.DeleteAllOnSubmit(normes);
                db.SubmitChanges();

                List<DataLayer.Materials_MaterialsML> materialsML = db.Materials_MaterialsML.Where(c => c.MaterialsID == materialId).ToList();
                db.Materials_MaterialsML.DeleteAllOnSubmit(materialsML);
                db.SubmitChanges();

                List<DataLayer.Materials_Materials> materials = db.Materials_Materials.Where(c => c.ID == materialId).ToList();
                db.Materials_Materials.DeleteAllOnSubmit(materials);
                db.SubmitChanges();

                transaction.Commit();

                if (materials.Count > 0)
                    CommunUtility.logEvent("DELETE MATERIAL :: Code :: " + materials[0].Code + " :: Name :: " + materials[0].Nom, CommunUtility.LogTypeEnum.Information, CommunUtility.GetCurrentUserInfo().UserID, CommunUtility.LogSourceEnum.Articles );
                /*return true;*/
                return 0;
            }
            catch (System.Data.SqlClient.SqlException sqlEx)
            {
                if (sqlEx.Number == 547)
                    return 1;
            }
            catch (Exception)
            {
                transaction.Rollback();
                return 2;
            }
            finally
            {
                db.Connection.Close();
            }
            return 2;
        }

        
        public static void deleteObseleteMaterialsAttachments(int materialId, string[] linkList)
        {
            DataLayer.MaterialsDataContext db = new DataLayer.MaterialsDataContext();
            if (linkList == null)
            {
                List<DataLayer.Materials_Attachments> attach = db.Materials_Attachments.Where(c => c.ID_Materials == materialId).ToList();
                int i = 0;
                while (i < attach.Count)
                {
                    db.Materials_Attachments.DeleteOnSubmit(attach[i]);
                    db.SubmitChanges();
                    i++;
                }
            }
            else
            {
                var attachmentList = (from p in db.Materials_Attachments
                                      where p.ID_Materials == materialId
                                      select p).ToList();
                int h = 0;
                while (h < attachmentList.Count)
                {
                    if (!CommunUtility.IsInList(linkList, attachmentList[h].Link))
                    {
                        DataLayer.Materials_Attachments attach = db.Materials_Attachments.Where(c => c.Link == attachmentList[h].Link).SingleOrDefault();
                        db.Materials_Attachments.DeleteOnSubmit(attach);
                        db.SubmitChanges();
                    }
                    h++;
                }
            }
        }

         
        public static List<DataLayer.Materials_Attachments> getMaterialsAttachments(int ID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return (from p in specLayer.Materials_Attachments
                    where (int)p.ID_Materials == ID
                    select p).ToList();
        }

        
        public static void AddMaterialsAttachment(int materialId, string link, int userID)
        {
            DataLayer.MaterialsDataContext db = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_Attachments newAttach = new DataLayer.Materials_Attachments();
            try
            {
                var retMat = (from p in db.Materials_Attachments
                              where (int)p.ID_Materials == materialId
                              && p.Link == link
                              select p).SingleOrDefault();
                if (retMat == null)
                {
                    newAttach.ID_Materials = materialId;
                    newAttach.LastModifiedByUserID = userID;
                    newAttach.LastModifiedOnDate = DateTime.Now;
                    newAttach.Link = link;
                    db.Materials_Attachments.InsertOnSubmit(newAttach);
                    db.SubmitChanges();
                }
            }
            catch (Exception)
            { }
        }
 
        public static DataLayer.Materials_Materials GetMaterial(int idMat)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Materials
                    where p.ID == idMat
                    select p).SingleOrDefault();
        }

         
        public static bool IsExisteMaterials(int key)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            var list = (from p in layer.Materials_Materials_Properties where p.ID_Articles == key select p).ToList();
            if (list.Count > 0)
            {
                var prop = list[0].ID_Properties;
                var propVal = list[0].Valeur;
                var brand = list[0].Materials_Materials.ID_Brand;
                List<Materials_GetallmaterialshavingsamepropertyandvalueResult> materialsCodes = null;
                if (brand == null)
                    materialsCodes = layer.Materials_Getallmaterialshavingsamepropertyandvalue(prop, propVal, key, null, list.Count).ToList();
                else
                    materialsCodes = layer.Materials_Getallmaterialshavingsamepropertyandvalue(prop, propVal, key, brand, list.Count).ToList();

                var k = 0;
                while (k < materialsCodes.Count)
                {
                    //Get materials properties
                    var allMaterialsProp = (from p in layer.Materials_Materials_Properties where p.ID_Articles == materialsCodes[k].ID_Articles select p).ToList();
                    //Check properties count
                    if (list.Count == allMaterialsProp.Count)
                    {
                        int h = 0;
                        bool IsDifferentMaterial = false;
                        while ((h < list.Count) && (!IsDifferentMaterial))
                        {
                            //Check if the property exists
                            if (IsPropertyInList(allMaterialsProp, list[h]) == false)
                            {
                                IsDifferentMaterial = true;
                                //found = false;
                            }
                            h++;
                        }
                        if (IsDifferentMaterial == false)
                            return true;
                    }
                    k++;
                }
            }
            return false;
        }

        
        private static bool IsPropertyInList(List<Materials_Materials_Properties> propertiesList, Materials_Materials_Properties property)
        {
            var list = (from pr in propertiesList where pr.ID_Properties == property.ID_Properties && pr.Valeur == property.Valeur select pr).ToList();
            return list.Count > 0;
        }
 
        public static DataLayer.Materials_Materials_Properties GetPropertyMaterials(int idMat, int idProp)
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Materials_Properties
                    where p.ID_Articles == idMat && p.ID_Properties == idProp
                    select p).SingleOrDefault();
        }

         
        public static int AddMaterialsKB(int materialId, string data, int userID)
        {
            int retId = -1;
            DataLayer.MaterialsDataContext db = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_KB newKB = new DataLayer.Materials_KB();
            try
            {
                var retKB = (from p in db.Materials_KB
                             where (int)p.ID_Materials == materialId
                             select p).SingleOrDefault();
                if (retKB == null)
                {
                    newKB.ID_Materials = materialId;
                    newKB.LastModifiedByUserID = userID;
                    newKB.LastModifiedOnDate = DateTime.Now;
                    newKB.Article = data;
                    db.Materials_KB.InsertOnSubmit(newKB);
                    db.SubmitChanges();
                    retId = newKB.ID;
                }
                else
                {
                    retKB.Article = data;
                    db.SubmitChanges();
                    retId = retKB.ID;
                }
            }
            catch (Exception)
            { }
            return retId;
        }

         
        public static void AddLocalizedMaterialsKB(int Id, string data, string locale)
        {
            DataLayer.MaterialsDataContext db = new DataLayer.MaterialsDataContext();
            try
            {
                var retKB_ML = (from p in db.Materials_KB_ML
                                where p.ID == Id && p.Locale == locale
                                select p).SingleOrDefault();
                if (retKB_ML == null)
                {
                    if (data != "")
                    {
                        DataLayer.Materials_KB_ML newKB_ML = new DataLayer.Materials_KB_ML();
                        newKB_ML.ID = Id;
                        newKB_ML.Locale = locale;
                        newKB_ML.Article = data;
                        //newKB_ML.Title = data;
                        db.Materials_KB_ML.InsertOnSubmit(newKB_ML);
                        db.SubmitChanges();
                    }
                }
                else
                {
                    retKB_ML.Article = data;
                    //retKB.Title = data;
                    db.SubmitChanges();
                }
            }
            catch (Exception)
            { }
        }

        
        public static DataLayer.Materials_KB getMaterialsDetails(int ID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return (from p in specLayer.Materials_KB
                    where (int)p.ID_Materials == ID
                    select p).SingleOrDefault();
        }
 
        public static DataLayer.Materials_KB_ML getLocalizedMaterialsDetails(string Locale, int ID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return (from p in specLayer.Materials_KB_ML
                    where (int)p.ID == ID && p.Locale == Locale
                    select p).SingleOrDefault();
        }

         
        public static DataLayer.Materials_Materials getMaterialByID(int ID)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return (from p in specLayer.Materials_Materials where p.ID == ID select p).SingleOrDefault();
        }

         
        public static List<DataLayer.Materials_GetMaterialPropertiesResult> getMaterialPropertiesByID(int ID, string Locale)
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return specLayer.Materials_GetMaterialProperties(ID, Locale).ToList();
        }

       
        public static IQueryable<DataLayer.Materials_Materials> SearchMaterialsByDisciplineSpecNorm(string discipline, string spec, string norme)
        {
            DataLayer.MaterialsDataContext Layer = new DataLayer.MaterialsDataContext();
            if ((discipline == "") && (spec == "") && (norme == ""))
            {
                return (from p in Layer.Materials_Materials where p.ID == -1 select p);
            }
            var allMat = (from p in Layer.Materials_Materials select p);
            if (discipline != "")
            {
                allMat = (from x in allMat
                          join y in Layer.Materials_MaterialsSpecifications_Discipline on x.ID_MaterialsSpecifications equals y.ID_MaterialsSpecifications
                          where y.ID_Discipline == discipline.ToString()
                          select x);
            }
            if (spec != "")
            {
                allMat = (from x in allMat
                          where x.ID_MaterialsSpecifications == int.Parse(spec)
                          select x);
            }
            if (norme != "")
            {
                allMat = (from x in allMat
                          join n in Layer.Materials_Materials_Norm on x.ID equals n.ID_Materials
                          where n.ID_Norm == int.Parse(norme)
                          select x);
            }
            return allMat;
        }

      
        public static IQueryable<DataLayer.Materials_Materials> SearchMaterialsBySuppliersAndBrands(int? ContactID, int? BrandID)
        {
            DataLayer.MaterialsDataContext Layer = new DataLayer.MaterialsDataContext();
            if (BrandID.HasValue)
            {
                if (ContactID.HasValue)
                {
                    return (from p in Layer.Materials_Supplier_MaterialsSpecifications
                            join x in Layer.Materials_Materials on p.IDMatSpec equals x.ID_MaterialsSpecifications
                            where p.IDContact == ContactID && x.ID_Brand == BrandID
                            select x).Distinct();
                }
                else
                {
                    return (from x in Layer.Materials_Materials
                            where x.ID_Brand == BrandID
                            select x).Distinct();
                }
            }
            else
            {
                if (ContactID.HasValue)
                {
                    return (from p in Layer.Materials_Supplier_MaterialsSpecifications
                            join x in Layer.Materials_Materials on p.IDMatSpec equals x.ID_MaterialsSpecifications
                            where p.IDContact == ContactID
                            select x).Distinct();
                }
                else
                {
                    return (from x in Layer.Materials_Materials
                            where x.ID == -1
                            select x).Distinct();
                }
            }
        }

        
        public static IQueryable<DataLayer.Materials_Materials> SearchMaterialsFullText(string searchtext, int PropertiesID, double ValueInit, double ValueEnd)
        {
            DataLayer.MaterialsDataContext Layer = new DataLayer.MaterialsDataContext();
            if (searchtext != "")
            {
                if (PropertiesID == -1)
                {
                    return (from p in Layer.Materials_SeachViewFullText
                            join x in Layer.Materials_Materials on p.ID equals x.ID
                            where p.SearchText.Contains(searchtext)
                            select x).Distinct();
                }
                else
                {
                    return (from p in Layer.Materials_SeachViewFullText
                            join x in Layer.Materials_Materials on p.ID equals x.ID
                            where p.SearchText.Contains(searchtext) && (p.ID_Properties == PropertiesID) &&  ( double.Parse(p.Valeur) > ValueInit) && (double.Parse(p.Valeur) < ValueEnd)
                            select x).Distinct();
                }
            }
            else
                return (from p in Layer.Materials_Materials where p.ID == -1 select p);
        }

        
        public static IQueryable<DataLayer.Materials_Materials> getMaterials()
        {
            DataLayer.MaterialsDataContext specLayer = new DataLayer.MaterialsDataContext();
            return (from p in specLayer.Materials_Materials select p);
        }

         
        public static void AddMaterialsProperties(int IdArticle, int IdProperties, int IdMeasureUnit, string Valeur, int UserID)
        {
            MaterialsDataContext layer = new MaterialsDataContext();
            var ret = (from p in layer.Materials_Materials_Properties where p.ID_Articles == IdArticle && p.ID_Properties == IdProperties select p).SingleOrDefault();
            if (ret == null)
            {
                Materials_Materials_Properties prop = new Materials_Materials_Properties();
                prop.ID_Articles = IdArticle;
                prop.ID_Properties = IdProperties;
                if (IdMeasureUnit > -1)
                    prop.ID_UniteMeasure = IdMeasureUnit;
                prop.Valeur = Valeur;
                prop.LastModifiedByUserID = UserID;
                prop.LastModifiedOnDate = DateTime.Now;
                layer.Materials_Materials_Properties.InsertOnSubmit(prop);
                layer.SubmitChanges();
            }
            else
            {
                if (IdMeasureUnit > -1)
                    ret.ID_UniteMeasure = IdMeasureUnit;
                ret.Valeur = Valeur;
                layer.SubmitChanges();
            }
        }

        
        public static bool IsCodeExiste(string code)
        {
            var ret = false;
            MaterialsDataContext layer = new MaterialsDataContext();
            if ((from p in layer.Materials_Materials where p.Code == code select p).ToList().Count > 0)
                ret = true;
            return ret;
        }

         
        public static bool UpdateMaterialsCode(int key, string code)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var ret = (from p in layer.Materials_Materials where p.ID == key select p).SingleOrDefault();
                if (ret != null)
                {
                    ret.Code = code;
                    layer.SubmitChanges();
                    return true;
                }
                else
                {
                    return false;
                }

            }
            catch
            {
                return false;
            }

        }

        
        public static int AddMaterials(string code, int typecode, string description, string nom, int MaetriaslSpecId, int UserId, int? brandId , double? _alertstock , double? _stockoptimal , string _codedouane , bool? _etatAchat , bool? _etatVente , int? _paysorigine  )
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                Materials_Materials article = new Materials_Materials()
                {
                    Code = code,
                    ID_MaterialsSpecifications = MaetriaslSpecId,
                    TypeCode = typecode,
                    Nom = nom,
                    Description = description,
                    CreatedByUserID = UserId,
                    CreatedOnDate = DateTime.Now,
                    ID_Brand = (brandId == -1) ? null : brandId,
                    AlerteStock = _alertstock,
                    Codedouane = _codedouane,
                    EtatAchat = _etatAchat,
                    EtatVente = _etatVente,
                    StockOptimal = _stockoptimal , ID_PaysOrigne = _paysorigine 

                }; 
                layer.Materials_Materials.InsertOnSubmit(article);
                layer.SubmitChanges();
                return article.ID;
            }
            catch
            {
                return -1;
            }
        }

        
        public static bool CopyMaterialsProperties(int Sourcekey, int DestKey, int userID)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var listProp = layer.Materials_Materials_Properties.Where(c => c.ID_Articles == Sourcekey).ToList();
                foreach (var prop in listProp)
                {
                    Materials_Materials_Properties p = new Materials_Materials_Properties()
                    {
                        ID_Articles = DestKey,
                        ID_Properties = prop.ID_Properties,
                        ID_UniteMeasure = prop.ID_UniteMeasure
                        ,
                        Valeur = prop.Valeur,
                        LastModifiedByUserID = userID,
                        LastModifiedOnDate = DateTime.Now
                    };
                    layer.Materials_Materials_Properties.InsertOnSubmit(p);
                    layer.SubmitChanges();
                }
                return true;
            }
            catch
            {
                return false;
            }
        }
 
        public static bool AddMaterialsNorm(int MaterialsId, int NormId)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                Materials_Materials_Norm MatNorm = new Materials_Materials_Norm() { ID_Materials = MaterialsId, ID_Norm = NormId };
                layer.Materials_Materials_Norm.InsertOnSubmit(MatNorm);
                layer.SubmitChanges();
                return true;
            }
            catch
            {
                return false;
            }

        }

      
        public static bool UpdateMaterialsML(int key, string name, string designation, string Locale, int userID)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var ret = (from p in layer.Materials_MaterialsML where p.MaterialsID == key && p.Locale == Locale select p).SingleOrDefault();
                if (ret == null)
                {
                    if (name != string.Empty || designation != string.Empty)
                    {
                        Materials_MaterialsML matML = new Materials_MaterialsML()
                        {
                            MaterialsID = key,
                            Designation = designation,
                            Name = name,
                            Locale = Locale,
                            LastModifiedByUserID = userID,
                            LastModifiedOnDate = DateTime.Now
                        };
                        layer.Materials_MaterialsML.InsertOnSubmit(matML);
                        layer.SubmitChanges();
                        return true;
                    }
                    else
                        return false;
                }
                else
                {
                    ret.Designation = designation;
                    ret.Name = name;
                    layer.SubmitChanges();
                    return true;
                }
            }
            catch
            {
                return false;
            }
        }

      
        public static bool DeleteMaterialsNormByMaterialsId(int key)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                layer.Materials_DeleteMaterialsNormByMaterials(key);
                return true;
            }
            catch
            {
                return false;
            }
        }

         
        public static List<int> GetMaterialNormsByID(int MaterialID)
        {
            List<int> lstID = new List<int>();
            MaterialsDataContext layer = new MaterialsDataContext();
            var lstMatNorm = (from p in layer.Materials_Materials_Norm where p.ID_Materials == MaterialID select p).ToList();
            if (lstMatNorm.Count > 0)
            {
                foreach (Materials_Materials_Norm matNorm in lstMatNorm)
                {
                    lstID.Add(matNorm.ID_Norm);
                }
            }
            return lstID;
        }

         
        public static bool UpdateMaterials(int key, string nom, string description, int MaterialsSpecId, int UserID, int? brandId , double? _alertstock, double? _stockoptimal, string _codedouane, bool? _etatAchat, bool? _etatVente , int? _paysorigine)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var mat = (from p in layer.Materials_Materials where p.ID == key select p).SingleOrDefault();
                if (mat != null)
                {
                    //mat.Code = code;
                    mat.Nom = nom;
                    mat.Description = description;
                    //mat.TypeCode = typecode;
                    mat.LastModifiedByUserID = UserID;
                    mat.LastModifiedOnDate = DateTime.Now;
                    mat.ID_MaterialsSpecifications = MaterialsSpecId;
                    mat.ID_Brand = (brandId == -1) ? null : brandId;
                    mat.AlerteStock = _alertstock;
                    mat.Codedouane = _codedouane;
                    mat.EtatAchat = _etatAchat;
                    mat.EtatVente = _etatVente;
                    mat.StockOptimal = _stockoptimal;
                    mat.ID_PaysOrigne = _paysorigine; 
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

            
        public static List<Materials_Materials_Norm> GetNormsByMaterialsId(int key)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var ret = (from p in layer.Materials_Materials_Norm where p.ID_Materials == key select p).ToList();
                return ret;
            }
            catch
            {
                return null;
            }

        }
 
        public static Materials_MaterialsML GetMaterialsByLocale(int key, string Locale)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var retLang = (from x in layer.Materials_MaterialsML where x.MaterialsID == key && x.Locale == Locale select x).SingleOrDefault();
                return retLang;
            }
            catch
            {
                return null;
            }
        }

         
        public static int GetNbMaterials()
        {
            DataLayer.MaterialsDataContext layer = new DataLayer.MaterialsDataContext();
            return (from p in layer.Materials_Materials select p.ID).Count();
        }

        
        public static string GetGlobalSetting(string key)
        {
            try
            {
                MaterialsDataContext db = new MaterialsDataContext();
                var retStetting = (from p in db.Materials_Settings where p.SettingName == key select p.SettingValue).SingleOrDefault();
                return retStetting == null ? "" : retStetting;
            }
            catch (Exception)
            {
                return null;
            }
        }

    }
}
