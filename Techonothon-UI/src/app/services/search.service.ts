import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class SearchService {

  private url: string = 'https://localhost:7002/api/DocumentService/GetAllDocuments';

  constructor(private http: HttpClient) { }

  searchResult(): Observable<any[]> {
    return this.http.get<any[]>(this.url)
  }
}
