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
    public class AwsClientService : IAwsClientService
    {
        private static readonly IAmazonS3 _s3Client = new AmazonS3Client(AwsContants.AccessKey,
            AwsContants.SecretKey,
            Amazon.RegionEndpoint.USEast1);

        private static readonly AmazonDynamoDBClient _dynamoDBClient = new AmazonDynamoDBClient(AwsContants.AccessKey,
            AwsContants.SecretKey,
            Amazon.RegionEndpoint.USEast1);

        public async Task<bool> UploadFileAsync(Stream stream, string fileName)
        {
            try
            {
                var putRequest = new PutObjectRequest
                {
                    BucketName = AwsContants.BucketName,
                    Key = fileName,
                    InputStream = stream
                };
                await _s3Client.PutObjectAsync(putRequest);
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        //GetPreSignedUrl
        private string GetPreSignedUrl(string fileName)
        {
            try
            {
                var request = new GetPreSignedUrlRequest
                {
                    BucketName = AwsContants.BucketName,
                    Key = fileName,
                    Expires = DateTime.Now.AddDays(1)
                };
                return _s3Client.GetPreSignedURL(request);
            }
            catch (Exception)
            {
                throw;
            }
        }

        //Add item to aws dynamo db  
        public async Task<bool> AddItemToDynamoDbAsync(UploadDocumentModel uploadDocumentModel)
        {
            try
            {
                object ApplicationId = GenerateApplicationId();
                //get current datetime
                object CreationDate = DateTime.Now.ToString("dd-MM-yyyy hh:mm tt",System.Globalization.CultureInfo.InvariantCulture);

                var putRequest = new PutItemRequest
                {
                    TableName = AwsContants.DynamoDbTableName,
                    Item = new Dictionary<string, AttributeValue>
                    {
                        { nameof(ApplicationId), new AttributeValue { S = ApplicationId.ToString() } },
                        { nameof(uploadDocumentModel.ClientId), new AttributeValue { S = uploadDocumentModel.ClientId == null? "": uploadDocumentModel.ClientId} },
                        { nameof(uploadDocumentModel.File), new AttributeValue { S = uploadDocumentModel.File!.FileName } },
                        { nameof(uploadDocumentModel.StatementDescription), new AttributeValue { S = uploadDocumentModel.StatementDescription==null? "":uploadDocumentModel.StatementDescription } },
                        { nameof(CreationDate), new AttributeValue { S = CreationDate.ToString() } }
                        
                    }
                };
                await _dynamoDBClient.PutItemAsync(putRequest);
                return true;
            }
            catch (Exception)
            {
                throw;
            }

        }

        //Get list of items from dynamo db
        public async Task<List<GetDocumentModel>> GetItemsFromDynamoDbAsync()
        {
            try
            {
                var request = new ScanRequest
                {
                    TableName = AwsContants.DynamoDbTableName
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
            catch (Exception)
            {
                throw;
            }
        }

        //Search list of items from dynamo db
        public async Task<List<GetDocumentModel>> SearchItemsFromDynamoDbAsync()
        {
            try
            {
                var request = new ScanRequest
                {
                    TableName = AwsContants.DynamoDbTableName
                };
                var response = await _dynamoDBClient.ScanAsync(request);
                var getDocumentsModel = response.Items.Select(i => new GetDocumentModel
                {
                    ApplicationId = i[nameof(GetDocumentModel.ApplicationId)].S,
                    ClientId = i[nameof(GetDocumentModel.ClientId)].S,
                    File = i[nameof(GetDocumentModel.File)].S,
                    StatementDescription = i[nameof(GetDocumentModel.StatementDescription)].S,
                    FileURL = GetPreSignedUrl(i[nameof(GetDocumentModel.File)].S),
                    CreationDate = i[nameof(GetDocumentModel.CreationDate)].S,
                    FormatedCreationDate = DateTime.ParseExact(i[nameof(GetDocumentModel.CreationDate)].S,"dd-MM-yyyy hh:mm tt",System.Globalization.CultureInfo.InvariantCulture).ToString("dd-MM-yyyy",System.Globalization.CultureInfo.InvariantCulture)
                }).OrderBy(x => DateTime.ParseExact(x.CreationDate!,"dd-MM-yyyy hh:mm tt",System.Globalization.CultureInfo.InvariantCulture))
                .ToList();
                
                return getDocumentsModel;
            }
            catch (Exception)
            {
                throw;           
            }
        }

        //check if item name exist in dynamic db database
        public async Task<bool> IsApplicationIdExistAsync(string applicationId)
        {
            try
            {
                var request = new ScanRequest
                {
                    TableName = AwsContants.DynamoDbTableName
                };
                var response = await _dynamoDBClient.ScanAsync(request);
                if(response.Items.ToList().Count  == 0)
                {
                    return false;
                }
                var getDocumentModels = response.Items.Select(i => new GetDocumentModel
                {
                    ApplicationId = i[nameof(ApplicationId)].S
                }).ToList();
                
                var checkItemExist = getDocumentModels.Any(x => x.ApplicationId == applicationId);
                return checkItemExist;
            }
            catch (Exception)
            {
                throw;
            }
        }

        //check if item name exist in dynamic db database
        public async Task<bool> IsFileExistAsync(string file)
        {
            try
            {
                var request = new ScanRequest
                {
                    TableName = AwsContants.DynamoDbTableName
                };
                var response = await _dynamoDBClient.ScanAsync(request);
                if(response.Items.ToList().Count  == 0)
                {
                    return false;
                }
                var getDocumentModels = response.Items.Select(i => new GetDocumentModel
                {
                    File = i[nameof(File)].S
                }).ToList();
                
                var checkItemExist = getDocumentModels.Any(x => x.File == file);
                return checkItemExist;
            }
            catch (Exception)
            {
                throw;
            }
        }

        //delete file from s3 bucket
        public async Task<bool> DeleteFileAsync(string fileName)
        {
            try
            {
                var deleteRequest = new DeleteObjectRequest
                {
                    BucketName = AwsContants.BucketName,
                    Key = fileName
                };
                await _s3Client.DeleteObjectAsync(deleteRequest);
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        //Generate applicationid
        private string GenerateApplicationId()
        {
            try
            {
                var applicationId = Guid.NewGuid().ToString();
                 bool applicationIdExist = IsApplicationIdExistAsync(applicationId).Result;
                
                if(applicationIdExist)
                    return GenerateApplicationId();
                else
                    return applicationId;
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex.Message);
                throw;
            }
        
        }
    }
}