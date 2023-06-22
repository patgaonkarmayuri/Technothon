using Amazon.S3.Model;
using Amazon.S3;
using System.Diagnostics;
using DocumentServiceAPI.Interface;
using DocumentServiceAPI.Constants;
using Amazon.DynamoDBv2.Model;
using Amazon.DynamoDBv2;
using DocumentServiceAPI.Model;

namespace DocumentServiceAPI.Service
{
    public class AWSClientService : IAWSClientService
    {
        private static readonly IAmazonS3 _s3Client = new AmazonS3Client(AWSContants.AccessKey,
            AWSContants.SecretKey,
            AWSContants.Region);

        private static readonly AmazonDynamoDBClient _dynamoDBClient = new AmazonDynamoDBClient(AWSContants.AccessKey,
            AWSContants.SecretKey,
            AWSContants.Region);

        public async Task<bool> UploadFileAsync(Stream stream, string fileName)
        {
            try
            {
                var putRequest = new PutObjectRequest
                {
                    BucketName = AWSContants.BucketName,
                    Key = fileName,
                    InputStream = stream
                };
                var response = await _s3Client.PutObjectAsync(putRequest);
                return true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw ex;
            }
        }
        //GetPreSignedUrl
        private string GetPreSignedUrl(string fileName)
        {
            var request = new GetPreSignedUrlRequest
            {
                BucketName = AWSContants.BucketName,
                Key = fileName,
                Expires = DateTime.Now.AddDays(1)
            };
            return _s3Client.GetPreSignedURL(request);
        }
        //Add item to aws dynamo db  
        public async Task<bool> AddItemToDynamoDbAsync(UploadDocumentModel uploadDocumentModel)
        {
            try
            {
                var putRequest = new PutItemRequest
                {
                    TableName = AWSContants.DynamoDbTableName,
                    Item = new Dictionary<string, AttributeValue>
                    {
                        { nameof(uploadDocumentModel.ApplicationId), new AttributeValue { S = uploadDocumentModel.ApplicationId } },
                        { nameof(uploadDocumentModel.ClientId), new AttributeValue { S = uploadDocumentModel.ClientId } },
                        { nameof(uploadDocumentModel.File), new AttributeValue { S = uploadDocumentModel.File!.FileName } },
                        { nameof(uploadDocumentModel.StatementDescription), new AttributeValue { S = uploadDocumentModel.StatementDescription } }
                    }
                };
                var response = await _dynamoDBClient.PutItemAsync(putRequest);
                return true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw ex;
            }

        }
        //Get list of items from dynamo db
        public async Task<List<GetDocumentModel>> GetItemsFromDynamoDbAsync()
        {
            var request = new ScanRequest
        {
                TableName = AWSContants.DynamoDbTableName
            };
            var response = await _dynamoDBClient.ScanAsync(request);
            var getDocumentModels = response.Items.Select(i => new GetDocumentModel
            {
                ApplicationId = i[nameof(GetDocumentModel.ApplicationId)].S,
                ClientId = i[nameof(GetDocumentModel.ClientId)].S,
                File = i[nameof(GetDocumentModel.File)].S,
                StatementDescription = i[nameof(GetDocumentModel.StatementDescription)].S
            }).ToList();
            return getDocumentModels;

        }
        //Search list of items from dynamo db
        public async Task<List<GetDocumentModel>> SearchItemsFromDynamoDbAsync(string? applicationId, string? clientId, string? file, string? statementDescription)
        {
            var request = new ScanRequest
            {
                TableName = AWSContants.DynamoDbTableName
            };
            var response = await _dynamoDBClient.ScanAsync(request);
            var getDocumentsModel = response.Items.Select(i => new GetDocumentModel
            {
                ApplicationId = i[nameof(GetDocumentModel.ApplicationId)].S,
                ClientId = i[nameof(GetDocumentModel.ClientId)].S,
                File = i[nameof(GetDocumentModel.File)].S,
                StatementDescription = i[nameof(GetDocumentModel.StatementDescription)].S,
                FileURL = GetPreSignedUrl(i[nameof(GetDocumentModel.File)].S)
            }).Where(x => (!string.IsNullOrEmpty(applicationId) ? x.ApplicationId!.Contains(applicationId) : true) &&
                          (!string.IsNullOrEmpty(clientId) ? x.ClientId!.Contains(clientId) : true) &&
                          (!string.IsNullOrEmpty(file) ? x.File!.Contains(file) : true) &&
                          (!string.IsNullOrEmpty(statementDescription) ? x.StatementDescription!.Contains(statementDescription) : true)).ToList();
            return getDocumentsModel;
        }

        //check if primary key value exist in dynamodb table
        public async Task<bool> IsItemValueExistAsync(string itemValue)
        {
            var request = new GetItemRequest
            {
                TableName = AWSContants.DynamoDbTableName,
                Key = new Dictionary<string, AttributeValue>
                {
                    { nameof(itemValue), new AttributeValue { S = itemValue } }
                }
            };
            var response = await _dynamoDBClient.GetItemAsync(request);
            return response.Item != null;

        }

        //delete file from s3 bucket
        public async Task<bool> DeleteFileAsync(string fileName)
        {
            try
            {
                var deleteRequest = new DeleteObjectRequest
                {
                    BucketName = AWSContants.BucketName,
                    Key = fileName
                };
                var response = await _s3Client.DeleteObjectAsync(deleteRequest);
                return true;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw ex;
            }
        }
    }
}