import { Injectable, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class DocumentserviceService {

//call get api with given url endpoint
  get(url: string) {
    return `Document ${url}`;
  }


    

}
