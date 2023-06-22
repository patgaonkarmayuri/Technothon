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
        public async Task<IActionResult> UpdateDocument([FromForm]UploadDocumentModel uploadDocumentModel)
        {
            if (uploadDocumentModel.File == null)
            {
                return BadRequest(ErrorMessages.InvalidFile);
            }
            try
            {
                var updateResponse = await UploadFileToS3(uploadDocumentModel.File);
                if (updateResponse.ToUpper() == "TRUE"){  

                    var addMetadataResponse = await _clientService.AddItemToDynamoDbAsync(uploadDocumentModel);
                    if (addMetadataResponse){ 
                        return Ok(ErrorMessages.UploadSuccess);
                    }
                    else{
                        return BadRequest(ErrorMessages.ExceptionOccured);
                    }
                }
                else{
                    return BadRequest(ErrorMessages.ExceptionOccured);
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return BadRequest(ErrorMessages.ExceptionOccured);
            }
        }

        //UploadFileToS3
        private async Task<string> UploadFileToS3(IFormFile file)
        {
            try
            {
                if (file.Length > 0)
                {
                    var fileName = ContentDispositionHeaderValue.Parse(file.ContentDisposition).FileName.Trim('"');

                    var stream = file.OpenReadStream();
                    var uploadResponse = await _clientService.UploadFileAsync(stream, fileName);
                    return uploadResponse.ToString();
                }
                else
                {
                    return ErrorMessages.EmptyFile;
                }
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                return ErrorMessages.ExceptionOccured;
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
    }
    
}