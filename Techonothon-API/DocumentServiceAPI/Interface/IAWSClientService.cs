using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DocumentServiceAPI.Model;

namespace DocumentServiceAPI.Interface
{
    public interface IAWSClientService
    {
        Task<bool> UploadFileAsync(Stream stream, string fileName);

        Task<bool> AddItemToDynamoDbAsync(UploadDocumentModel uploadDocumentModel);

        Task<List<GetDocumentModel>> SearchItemsFromDynamoDbAsync(string? searchString);

        Task<bool> IsApplicationIDExistAsync(string applicationId);

        Task<bool> IsFileExistAsync(string file);

        Task<bool> DeleteFileAsync(string fileName);
        
    }
}