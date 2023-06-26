import { Component, Input, OnInit } from '@angular/core';
import { HttpClient, HttpEventType, HttpParams, HttpResponse } from '@angular/common/http';
import { Observable } from 'rxjs';
import { FileUploadService } from '../file-upload.service';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';

@Component({
  selector: 'app-file-upload',
  templateUrl: './file-upload.component.html',
  styleUrls: ['./file-upload.component.css']
})
export class FileUploadComponent implements OnInit {

  shortLink: string = ''; // Variable to store shortLink from api response
  loading: boolean = false; // Flag variable
  file: File | null = null; // Variable to store file to Upload

  constructor(private fb: FormBuilder, private fileUploadService: FileUploadService,
    private http: HttpClient) { }

  uploadFileForm: FormGroup = new FormGroup({
    clientId: new FormControl(''),
    statementDescription: new FormControl(''),
    file: new FormControl('')
  });


  ngOnInit(): void {
    this.uploadFileForm = this.fb.group(
      {
        clientId: ['', Validators.required],
        statementDescription: ['', Validators.required],
        file: ['', Validators.required],
      }
    );
  }
  
  // On file Select
  onChange(event: any) {
    this.file = event.target.files[0];
  }

  onSubmit(): void {
    console.log('Submitted form', this.uploadFileForm.value);

    if (this.file) {
      this.loading = !this.loading;
      console.log(this.file);
      this.upload(this.file).subscribe((event: any) => {
        if (typeof event === 'object') {
          // Short link via api response
          this.shortLink = event.link;
          this.loading = false; // Flag variable
        }
      });
    }
  }

  private baseUrl = 'assets/json/fileupload.json';

  upload(file: any): Observable<any> {
    // Create form data
    const formData = new FormData();

    // Store form name as "file" with file data
    formData.append('file', file)
    formData.append('ClientId', this.uploadFileForm.value.clientId)
    formData.append('StatementDescription', this.uploadFileForm.value.statementDescription)

    const params = new URLSearchParams();
    const formValue = this.uploadFileForm.value; // this.form should be a FormGroup

    // Make http post request over api
    // with formData as req
    return this.http.post(this.baseUrl, formData);
  }

}