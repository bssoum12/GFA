using DotNetNuke.Entities.Users;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI;

namespace GlobalAPI
{
    public class CommunUtility
    {
        public enum LogSourceEnum
        {            

            Articles = 1,                        
            GestionTiers = 2,
            Framework = 3,

        }

        public enum LogTypeEnum
        {            
            Information = 0,            
            Warning = 1,            
            Error = 2
        }

        public static string getRessourceEntry(string Name, string ResourceFile)
        {
            return DotNetNuke.Services.Localization.Localization.GetString(Name, ResourceFile);
        }
        public static UserInfo GetCurrentUserInfo()
        {
            return UserController.Instance.GetCurrentUserInfo();
        }
        public static bool IsInList(string[] linkList, string link)
        {
            bool found = false;
            int k = 0;
            while ((k < linkList.Length) && (!found))
            {
                if (link == linkList[k])
                {
                    found = true;
                }
                k++;
            }
            return found;
        }


        public static Control FindControlRecursive(Control control, string id)
        {
            if ((control == null))
            {
                return null;
            }

            // try to find the control at the current level
            Control ctrl = control.FindControl(id);
            if ((ctrl == null))
            {
                // search the children
                foreach (Control child in control.Controls)
                {
                    ctrl = FindControlRecursive(child, id);
                    if (ctrl != null)
                    {                        
                        break;
                    }

                }

            }

            return ctrl;
        }


        public static string GetPortalAlias()
        {
            return "aquafish.virtualdev.tn"; 
        }

        public static void logEvent(string message, LogTypeEnum type, int userId, LogSourceEnum source)
        {
            try
            {
                DataLayer.FrameworkDataContext db = new DataLayer.FrameworkDataContext();
                DataLayer.Framework_Log  logEntry = new DataLayer.Framework_Log();
                logEntry.Created = DateTime.Now;
                logEntry.Message = message;
                logEntry.Type = type.ToString();
                logEntry.UserId = userId;
                logEntry.Source = source.ToString();
                db.Framework_Log.InsertOnSubmit(logEntry);
                db.SubmitChanges();
            }
            catch (Exception) { }
        }

    }
}
