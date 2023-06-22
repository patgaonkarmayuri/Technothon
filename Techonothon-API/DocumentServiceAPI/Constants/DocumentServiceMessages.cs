using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DocumentServiceAPI.Constants
{
    public class DocumentServiceMessages
    {
         public const string EmptyFile = "Empty file"; 
         public const string InvalidFile = "Invalid file";
         public const string ExceptionOccured = "Exception Occured";
        public const string UploadSuccess = "Document Uploaded Successfully";
        public const string UploadFailed = "Document Upload Failed";
        public const string ApplicationIdExist = "ApplicationId already exists";
        public const string FileNameExist = "Document already exists";
        public const string BothExist = "Both ApplicationId and Document already exists";
        public const string InvalidApplicationId = "Invalid ApplicationId";

    }
}