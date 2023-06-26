import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class SearchService {

  private url: string = 'assets/json/search.json';

  constructor(private http: HttpClient) { }

  searchResult(): Observable<any[]> {
    return this.http.get<any[]>(this.url)
  }
}
