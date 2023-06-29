using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DocumentServiceAPI.Model;

namespace DocumentServiceAPI.Interface
{
    public interface IAwsClientService
    {
        Task<bool> UploadFileAsync(Stream stream, string fileName);

        Task<bool> AddItemToDynamoDbAsync(UploadDocumentModel uploadDocumentModel);

        Task<List<GetDocumentModel>> SearchItemsFromDynamoDbAsync();

        Task<bool> IsFileExistAsync(string file);

        Task<bool> DeleteFileAsync(string fileName);
        
    }
}