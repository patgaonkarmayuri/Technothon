using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Amazon.S3;
namespace DocumentServiceAPI.Constants
{
    public class AWSContants
    {
        public const string BucketName = "technothondocumentservice";
        public const string AccessKey = "AKIA4KPXMHOH4R4CD4Y6";
        public const string SecretKey = "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";
        public static string DynamoDbTableName = "DocumentServiceData";
        public static Amazon.RegionEndpoint Region = Amazon.RegionEndpoint.USEast1;
    }
}