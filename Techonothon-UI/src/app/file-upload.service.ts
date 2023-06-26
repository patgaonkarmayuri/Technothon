import { Injectable } from '@angular/core';
import { HttpClient, HttpRequest, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';
import { HttpParams } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class FileUploadService {
  private baseUrl = 'https://localhost:7002/api/DocumentService/UploadDocument';

  constructor(private http: HttpClient) { }

  upload(file: File): Observable<HttpEvent<any>> {
    const formData: FormData = new FormData();
    formData.append('file', file);
    formData.append('ApplicationId', '');
    formData.append('ClientId', '');
    formData.append('StatementDescription', '');

    const req = new HttpRequest('POST', `${this.baseUrl}`, formData, {
      reportProgress: true,
      responseType: 'json'
    });
    this.http.request(req).subscribe(event => {
      console.log("event Data :",event);
    });
    return this.http.request(req);
  }

  getFiles(): Observable<any[]> {
    return this.http.get<any[]>(`${this.baseUrl}`);
  }
}
