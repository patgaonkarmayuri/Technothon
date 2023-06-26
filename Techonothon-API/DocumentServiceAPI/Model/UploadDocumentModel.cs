using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DocumentServiceAPI.Model
{
    public class UploadDocumentModel
    {
        public string? ClientId { get; set; }
        public string? StatementDescription { get; set; }
        public IFormFile? File { get; set; }
    }
}