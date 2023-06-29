import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';
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

  downloadFile(url: string): Observable<Blob> {

    return this.http.get(url, { responseType: 'blob' });

  }
  private myBehaviorSubject = new BehaviorSubject<string>('');




  // reLoad(){
  //   this.router.navigate([this.router.url])
  // }

  setValue(value: string) {

    this.myBehaviorSubject.next(value);

  }




  getValue() {

    return this.myBehaviorSubject.asObservable();

  }
}
