import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class FileUploadService {  

  private baseUrl = 'assets/json/fileupload.json';
  constructor(private http: HttpClient) {}

  // Returns an observable
  upload1(file: any): Observable<any> {
    // Create form data
    const formData = new FormData();

    // Store form name as "file" with file data
    formData.append('file', file);
    // Make http post request over api
    // with formData as req
    return this.http.post(this.baseUrl, formData);
  }
}
