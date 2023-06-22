using System.Diagnostics;
using System.Net.Http.Headers;
using Microsoft.AspNetCore.Mvc;
using Amazon.S3;
using Amazon.S3.Model;
using DocumentServiceAPI.Interface;
using DocumentServiceAPI.Model;
using DocumentServiceAPI.Constants;
using static DocumentServiceAPI.Constants.DocumentServiceEnum;

namespace DocumentServiceAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DocumentServiceController : ControllerBase
    {
        private readonly IAWSClientService _clientService;
        public DocumentServiceController(IAWSClientService clientService)
        {
            _clientService = clientService;            
        }

        //Upload Document to S3 Bucket
        [HttpPost]
        [Route("UploadDocument")]
        public async Task<IActionResult> UploadDocument([FromForm]UploadDocumentModel uploadDocumentModel)
        {
            try
            {
                if (uploadDocumentModel.File == null || uploadDocumentModel.File.Length == 0)
                {
                    return BadRequest(DocumentServiceMessages.InvalidFile);
                }
                if (string.IsNullOrEmpty(uploadDocumentModel.ApplicationId))
                {
                    return BadRequest(DocumentServiceMessages.InvalidApplicationId);
                }
                //Check if applicationid or file exist
                ItemCheckEnum itemCheckResponse= CheckApplicationIdAndFileNameExist(uploadDocumentModel.ApplicationId,uploadDocumentModel.File.FileName);
                
                switch(itemCheckResponse){
                    case ItemCheckEnum.ApplicationIdExist:
                        return BadRequest(DocumentServiceMessages.ApplicationIdExist);
                    case ItemCheckEnum.FileNameExist:
                        return BadRequest(DocumentServiceMessages.FileNameExist);
                    case ItemCheckEnum.BothExist:
                        return BadRequest(DocumentServiceMessages.BothExist);
                }
                
                var updateResponse = await UploadFileToS3(uploadDocumentModel.File);
                
                if (Convert.ToBoolean(updateResponse)){  

                    var addMetadataResponse = await _clientService.AddItemToDynamoDbAsync(uploadDocumentModel);
                    if (addMetadataResponse){ 
                        return Ok(DocumentServiceMessages.UploadSuccess);
                    }
                    else{
                        //delete file if insert to dynamo db failed.
                        var deleteFileResponse = await _clientService.DeleteFileAsync(uploadDocumentModel.File.FileName);
                        return BadRequest(DocumentServiceMessages.UploadFailed);
                    }
                }
                else{
                    return BadRequest(DocumentServiceMessages.UploadFailed);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return BadRequest(DocumentServiceMessages.ExceptionOccured);
            }
        }

        //Search list of items from dynamo db
        [HttpGet]
        [Route("GetAllDocuments")]
        public async Task<IActionResult> SearchItemsFromDynamoDbAsync(string? applicationId, string? clientId, string? file,string? statementDescription)
        {
            try
            {
                var items = await _clientService.SearchItemsFromDynamoDbAsync(applicationId, clientId, file, statementDescription);
                return Ok(items);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return BadRequest();
            }
        
        }
        
        //UploadFileToS3
        private async Task<bool> UploadFileToS3(IFormFile file)
        {
            try
            {
                    var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName!.Trim('"');

                    var stream = file.OpenReadStream();
                    var uploadResponse = await _clientService.UploadFileAsync(stream, fileName);
                    return uploadResponse;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw ex;
            }
        }
        //Check if the application id and filename exist
        private ItemCheckEnum CheckApplicationIdAndFileNameExist(string applicationId, string fileName)
        {
            try
            {
                var applicationIdExist = _clientService.IsItemValueExistAsync(applicationId).Result;
                var fileNameExist = _clientService.IsItemValueExistAsync(fileName).Result;
                if (applicationIdExist && fileNameExist)
                    return ItemCheckEnum.BothExist;
                else if (applicationIdExist)
                    return ItemCheckEnum.ApplicationIdExist;
                else if (fileNameExist)
                    return ItemCheckEnum.FileNameExist;
                else
                    return ItemCheckEnum.None;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }
        }
        

    }
    
}