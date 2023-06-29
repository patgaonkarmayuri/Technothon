using System.Diagnostics;
using System.Net.Http.Headers;
using Microsoft.AspNetCore.Mvc;
using Amazon.S3;
using Amazon.S3.Model;
using DocumentServiceAPI.Interface;
using DocumentServiceAPI.Model;
using DocumentServiceAPI.Constants;
using nClam;
using Newtonsoft.Json;

namespace DocumentServiceAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DocumentServiceController : ControllerBase
    {
        private readonly IAwsClientService _clientService;
        private object objResponseJson = new object();

        public DocumentServiceController(IAwsClientService clientService,IConfiguration config)
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
                    objResponseJson = JsonConvert.SerializeObject(new { Message=DocumentServiceMessages.InvalidFile,Status = false});
                }
                if (string.IsNullOrEmpty(uploadDocumentModel.ClientId))
                {
                    objResponseJson = JsonConvert.SerializeObject(new { Message=DocumentServiceMessages.InvalidClientId,Status = false});
                }
                //Check if file exist
                bool fileExist = CheckFileNameExist(uploadDocumentModel.File!.FileName);
                
                if(fileExist){
                    objResponseJson = JsonConvert.SerializeObject(new { Message=DocumentServiceMessages.FileNameExist,Status = false});
                    return Ok(objResponseJson);
                }

                var updateResponse = await UploadFileToS3(uploadDocumentModel.File);
                
                if (Convert.ToBoolean(updateResponse)){  

                    var addMetadataResponse = await _clientService.AddItemToDynamoDbAsync(uploadDocumentModel);
                    if (addMetadataResponse){ 
                        objResponseJson = JsonConvert.SerializeObject(new { Message=DocumentServiceMessages.UploadSuccess,Status = true});
                    }
                    else{
                        //delete file if insert to dynamo db failed.
                        await _clientService.DeleteFileAsync(uploadDocumentModel.File.FileName);
                        objResponseJson = JsonConvert.SerializeObject(new { Message=DocumentServiceMessages.UploadFailed,Status = false});
                    }
                }
                else{
                    objResponseJson = JsonConvert.SerializeObject(new { Message=DocumentServiceMessages.UploadFailed,Status = false});
                    return Ok(objResponseJson);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                objResponseJson = JsonConvert.SerializeObject(new { Message = DocumentServiceMessages.ExceptionOccured,Status = false});
            }
            return Ok(objResponseJson);
        }
        
        //Search list of items from dynamo db
        [HttpGet]
        [Route("GetAllDocuments")]
        public async Task<IActionResult> SearchItemsFromDynamoDbAsync()
        {
            try
            {
                var items = await _clientService.SearchItemsFromDynamoDbAsync();
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
            catch (Exception)
            {
                throw;
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