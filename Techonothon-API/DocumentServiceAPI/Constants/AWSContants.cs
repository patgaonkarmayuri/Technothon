using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Amazon.S3;
namespace DocumentServiceAPI.Constants
{
    public class AWSContants
    {
        public const string BucketName = "documentservice45";
        public const string AccessKey = "";
        public const string SecretKey = "";
        public static string DynamoDbTableName = "DocumentServiceData";
        public static Amazon.RegionEndpoint Region = Amazon.RegionEndpoint.USEast1;
    }
}