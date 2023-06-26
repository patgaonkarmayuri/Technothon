import {Component, OnInit} from '@angular/core';
<<<<<<< Updated upstream
import {FormControl, FormGroupDirective, NgForm, Validators} from '@angular/forms';
import {ErrorStateMatcher} from '@angular/material/core';
import { HttpClient } from '@angular/common/http';
=======
import { SearchService } from './services/search.service';
>>>>>>> Stashed changes

export interface FileUploadTableData {
  applicationId: number;
  clientId: number;
  statementDescription: string;
  file: string;
  fileURL: string;
}

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
<<<<<<< Updated upstream
export class AppComponent implements OnInit{
=======
export class AppComponent implements OnInit {
>>>>>>> Stashed changes
  title = 'technothon-ui';
 url="https://localhost:7002/api/DocumentService/GetAllDocuments"

//api call in componet in typescript
  constructor(private http: HttpClient) {
  }

  ngOnInit(): void {
    this.http.get(`${this.url}`).subscribe(data => {
      console.log('data:',data);
      }); 
    }
  


  constructor(private searchService: SearchService) {
  }
 
  filterString: string = '';
  searchList:Array<any> = [];

  displayedColumns: string[] = ['applicationId', 'clientId', 'statementDescription', 'file', 'fileURL'];
  
  ngOnInit() {
    this.searchService.searchResult().subscribe(data => {
      this.searchList = data;
    })
  }
}

// mat file upload 
// https://material.angular.io/components/file-input/overview






