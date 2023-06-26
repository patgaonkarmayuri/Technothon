using System.Diagnostics;
using System.Net.Http.Headers;
using Microsoft.AspNetCore.Mvc;
using Amazon.S3;
using Amazon.S3.Model;
using DocumentServiceAPI.Interface;
using DocumentServiceAPI.Model;
using DocumentServiceAPI.Constants;

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
                if (string.IsNullOrEmpty(uploadDocumentModel.ClientId))
                {
                    return BadRequest(DocumentServiceMessages.InvalidClientId);
                }
                //Check if file exist
                bool fileExist = CheckFileNameExist(uploadDocumentModel.File.FileName);
                
                if(fileExist)
                    return BadRequest(DocumentServiceMessages.FileNameExist);
                
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
        public async Task<IActionResult> SearchItemsFromDynamoDbAsync(string? searchString)
        {
            try
            {
                var items = await _clientService.SearchItemsFromDynamoDbAsync(searchString);
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
        
        //Check if the filename exist
        private bool CheckFileNameExist(string file)
        {
            try
            {
                var fileNameExist = _clientService.IsFileExistAsync(file).Result;
                if (fileNameExist)
                    return true;
                else
                    return false;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }
        }
    }
}