using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DocumentServiceAPI.Model
{
    public class GetDocumentModel
    {
        public string? ApplicationId { get; set; }
        public string? ClientId { get; set; }
        public string? StatementDescription { get; set; }
        public string? File { get; set; }
         public string? FileURL { get; set; }
    }
}