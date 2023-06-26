import {Component, OnInit} from '@angular/core';
import {FormControl, FormGroupDirective, NgForm, Validators} from '@angular/forms';
import {ErrorStateMatcher} from '@angular/material/core';
import { HttpClient } from '@angular/common/http';
import { SearchService } from './services/search.service';

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
export class AppComponent implements OnInit{
  title = 'technothon-ui';
 url="https://localhost:7002/api/DocumentService/GetAllDocuments"

//api call in componet in typescript
  constructor(private http: HttpClient, private searchService: SearchService) {
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






