using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DataLayer;

namespace GlobalAPI 
{
   
    public static class StorageConditionController
    {
         
        public static Boolean DeleteStorageConditionML(int ID, string locale)
        {
            try
            {
                // DeleteStorage condition Multilanguage
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_StorageConditionsML conditionMLtoDelete = new Materials_StorageConditionsML();
                conditionMLtoDelete = GetStorageConditionML(ID, locale, materialLayer);
                materialLayer.Materials_StorageConditionsML.DeleteOnSubmit(conditionMLtoDelete);
                materialLayer.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

         
         
        public static DataLayer.Materials_StorageConditionsML GetStorageConditionML(int ID, string locale, DataLayer.MaterialsDataContext materialLayer)
        {
            try
            {
                return (from x in materialLayer.Materials_StorageConditionsML where x.ID == ID && x.Locale == locale select x).SingleOrDefault();
            }
            catch (Exception)
            { return null; }
        }
 
        public static Boolean DeleteStorageCondition(int ID)
        {
            try
            {
                int verif = 0;
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_StorageConditions conditiontoDelete = new Materials_StorageConditions();
                conditiontoDelete = GetStorageCondition(ID, materialLayer);
                List<DataLayer.Materials_StorageConditions> listCondition = new List<DataLayer.Materials_StorageConditions>();
                listCondition = GetStorageCondition();
                foreach (var item in listCondition)
                {
                    if (item.Id_Parent == conditiontoDelete.Id_Parent)
                    {
                        verif = 0;
                    }
                    else
                        verif = 1;
                }
                if (verif == 1)
                {
                    materialLayer.Materials_StorageConditions.DeleteOnSubmit(conditiontoDelete);
                    materialLayer.SubmitChanges();
                    return true;
                }
                else
                {
                    listCondition = GetStorageConditionByParentID(conditiontoDelete.ID);
                    foreach (var item in listCondition)
                    {
                        //materialLayer.Attach(item);
                        materialLayer.Materials_StorageConditions.DeleteOnSubmit(item);
                        materialLayer.SubmitChanges();
                    }
                    return false;
                }


            }
            catch (Exception)
            {
                return false;
            }
        }

        
        public static DataLayer.Materials_StorageConditions GetStorageCondition(int ID, DataLayer.MaterialsDataContext materialLayer)
        {
            try
            {
                return (from x in materialLayer.Materials_StorageConditions where x.ID == ID select x).SingleOrDefault();
            }
            catch (Exception)
            { return null; }
        }

       
        public static DataLayer.Materials_StorageConditionsML GetStorageConditionML(int ID, string locale)
        {
            try
            {

                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                return (from x in materialLayer.Materials_StorageConditionsML where x.ID == ID && x.Locale == locale select x).SingleOrDefault();
            }
            catch (Exception)
            { return null; }
        }

        
        public static DataLayer.Materials_StorageConditions GetStorageCondition(int ID)
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                return (from x in materialLayer.Materials_StorageConditions where x.ID == ID select x).SingleOrDefault();
            }
            catch (Exception)
            {
                return null;
            }
        }

         
        public static DataLayer.Materials_StorageConditions UpdateStorageCondition(DataLayer.Materials_StorageConditions NewCondition)
        {
            DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_StorageConditions storageConditionToUpdate = new DataLayer.Materials_StorageConditions();
            storageConditionToUpdate = GetStorageCondition(NewCondition.ID, materialLayer);

            if (NewCondition.Designation != null)
            {
                storageConditionToUpdate.Designation = NewCondition.Designation;
            }

            materialLayer.SubmitChanges();
            return storageConditionToUpdate;
        }

         
        public static Boolean ExistsStorageConditionML(int ID, string Locale)
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_StorageConditionsML selectedFeesML = (from c in materialLayer.Materials_StorageConditionsML
                                                                             where c.ID == ID && c.Locale == Locale
                                                                             select c).FirstOrDefault();

                if (selectedFeesML != null)
                    return true;
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        
        public static DataLayer.Materials_StorageConditionsML UpdateStorageConditionML(DataLayer.Materials_StorageConditionsML NewConditionML)
        {
            DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
            DataLayer.Materials_StorageConditionsML StorageConditionMLToUpdate = new DataLayer.Materials_StorageConditionsML();
            StorageConditionMLToUpdate = GetStorageConditionML(NewConditionML.ID, NewConditionML.Locale, materialLayer);

            if (NewConditionML.Designation != null)
            {
                StorageConditionMLToUpdate.Designation = NewConditionML.Designation;
            }
            materialLayer.SubmitChanges();
            return StorageConditionMLToUpdate;
        }

        
        public static DataLayer.Materials_StorageConditionsML InsertStorageConditionML(DataLayer.Materials_StorageConditionsML NewConditionML)
        {
            DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
            materialLayer.Materials_StorageConditionsML.InsertOnSubmit(NewConditionML);
            materialLayer.SubmitChanges();
            return NewConditionML;
        }

        
        public static Boolean ExistsStorageCondition(string designation)
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_StorageConditions selectedCondition = (from c in materialLayer.Materials_StorageConditions
                                                                              where c.Designation == designation
                                                                              select c).FirstOrDefault();

                if (selectedCondition != null)
                    return true;
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

       
        public static DataLayer.Materials_StorageConditions InsertStorageCondition(DataLayer.Materials_StorageConditions NewStorageCondition)
        {
            DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
            materialLayer.Materials_StorageConditions.InsertOnSubmit(NewStorageCondition);
            materialLayer.SubmitChanges();
            return NewStorageCondition;
        }
       
        public static Boolean IsUsedStorageCondition(int ID)
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_Specifications_StorageConditions selectedFees = (from c in materialLayer.Materials_Specifications_StorageConditions
                                                                                        where c.ID_StorageCondition == ID
                                                                                        select c).FirstOrDefault();
                if (selectedFees != null)
                {
                    return true;
                }
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }
       
        
        public static List<DataLayer.Materials_StorageConditions> GetStorageCondition()
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                return (from x in materialLayer.Materials_StorageConditions select x).ToList<DataLayer.Materials_StorageConditions>();
            }
            catch (Exception)
            { return null; }
        }
        
        public static List<DataLayer.Materials_StorageConditions> GetStorageConditionByParentID(int id)
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                return (from x in materialLayer.Materials_StorageConditions where x.Id_Parent == id select x).ToList<DataLayer.Materials_StorageConditions>();
            }
            catch (Exception)
            { return null; }
        }

         
        public static Boolean ExistsCondtionSpec(int spec, int cond)
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_Specifications_StorageConditions selectedCondSpec = (from c in materialLayer.Materials_Specifications_StorageConditions
                                                                                            where c.ID_StorageCondition == cond && c.ID_MaterialsSpecification.Equals(spec)
                                                                                            select c).FirstOrDefault();

                if (selectedCondSpec != null)
                    return true;
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        
        public static Boolean InsertStorageConditionToSpec(List<DataLayer.Materials_Specifications_StorageConditions> NewStorageConditionSpecList)
        {

            DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
            System.Data.Common.DbTransaction transaction;
            materialLayer.Connection.Open();
            transaction = materialLayer.Connection.BeginTransaction();
            materialLayer.Transaction = transaction;
            try
            {
                foreach (var item in NewStorageConditionSpecList)
                {
                    materialLayer.Materials_Specifications_StorageConditions.InsertOnSubmit(item);
                }

                materialLayer.SubmitChanges();
                transaction.Commit();
                return true;
            }
            catch (Exception)
            {
                transaction.Rollback();
                return false;
            }
            finally
            {
                materialLayer.Connection.Close();
            }
        }

      
        public static void deleteConditionSpecification(int ID_StorageCondition, int ID_MaterialsSpecification)
        {
            DataLayer.MaterialsDataContext Layer = new DataLayer.MaterialsDataContext();
            try
            {
                DataLayer.Materials_Specifications_StorageConditions CondspecToDelete = (from p in Layer.Materials_Specifications_StorageConditions
                                                                                            where p.ID_StorageCondition == ID_StorageCondition && p.ID_MaterialsSpecification == ID_MaterialsSpecification
                                                                                            select p).SingleOrDefault();
                Layer.Materials_Specifications_StorageConditions.DeleteOnSubmit(CondspecToDelete);
                Layer.SubmitChanges();

            }
            catch (Exception)
            {
                return;
            }
        }

      
        public static List<DataLayer.Materials_GetAllAssignedConditionToSpecResult> GetAssignedCndSpecList(string Locale, int idSpec)
        {
            try
            {
                DataLayer.MaterialsDataContext Layer = new DataLayer.MaterialsDataContext();
                return (from c in Layer.Materials_GetAllAssignedConditionToSpec(Locale, idSpec)
                        select c).ToList<DataLayer.Materials_GetAllAssignedConditionToSpecResult>();
            }
            catch (Exception)
            {
                return null;
            }
        }

       
        public static Boolean GetSpecification(int spec, int cond)
        {
            try
            {
                DataLayer.MaterialsDataContext materialLayer = new DataLayer.MaterialsDataContext();
                DataLayer.Materials_MaterialsSpecifications selectedCondSpec = (from c in materialLayer.Materials_MaterialsSpecifications
                                                                                   where c.ID == spec
                                                                                   select c).FirstOrDefault();
                int idParent = int.Parse(selectedCondSpec.Id_Parent.ToString());

                if (idParent != -1)
                {
                    if (ExistsCondtionSpec(idParent, cond))
                    {
                        return true;
                    }
                    else
                        return false;
                }
                else
                {
                    return false;
                }

            }
            catch (Exception)
            {
                return false;
            }
        }

 
        public static List<DataLayer.Materials_StorageConditions> GetStorageConditionByIdParent(int? IdParent)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                return (from x in layer.Materials_StorageConditions where x.Id_Parent == IdParent select x).ToList<DataLayer.Materials_StorageConditions>();
            }
            catch (Exception)
            { return null; }
        }

        
        public static DataLayer.Materials_StorageConditions GetStorageConditions(int ID, string locale)
        {
            try
            {
                MaterialsDataContext layer = new MaterialsDataContext();
                var query = (from x in layer.Materials_StorageConditions.Where(j => j.ID == ID)
                             join ml in layer.Materials_StorageConditionsML.Where(j => j.Locale == locale) on x.ID equals ml.ID into tl_j
                             from ml in tl_j.DefaultIfEmpty()
                             select new
                             {
                                 ID = x.ID,
                                 Id_Parent = x.Id_Parent,
                                 Designation = ml.Designation == null ? x.Designation : ml.Designation,

                             });
                var matches =
                 from result in query.AsEnumerable()
                 select new DataLayer.Materials_StorageConditions()
                 {
                     ID = result.ID,
                     Id_Parent = result.Id_Parent,
                     Designation = result.Designation
                 };
                return matches.SingleOrDefault();
            }
            catch (Exception)
            { return null; }
        }
        
    }
}
