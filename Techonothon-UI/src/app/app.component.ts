import { Component, OnInit, ViewChild } from '@angular/core';

import { FormControl, FormGroupDirective, NgForm, Validators } from '@angular/forms';

import { ErrorStateMatcher } from '@angular/material/core';

import { HttpClient } from '@angular/common/http';

import { SearchService } from './services/search.service';

import { MatPaginator } from '@angular/material/paginator';

import { MatSort } from '@angular/material/sort';

import { MatTableDataSource } from '@angular/material/table';

import { MatTableExporterModule } from 'mat-table-exporter';
import { ActivatedRoute, NavigationEnd, Router } from '@angular/router';





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

export class AppComponent implements OnInit {

  title = 'technothon-ui';
  downloads: any;
  url = "https://localhost:7002/api/DocumentService/GetAllDocuments"
  myValue: any;
  mySubscription: any;




  //api call in componet in typescript

  constructor(private http: HttpClient, private searchService: SearchService, private router: Router, private activatedRoute: ActivatedRoute) {
    this.myValue = this.searchService.getValue();
    this.searchList = this.myValue;
    console.log('this.searchList:', this.searchList);
   
  }




  filterString: string = '';

  searchList: Array<any> = [];

  displayedColumns: string[] = ['applicationId', 'clientId', 'statementDescription', 'file', 'formatedCreationDate', 'download'];




  ngOnInit() {

    this.searchService.searchResult().subscribe(data => {

      this.searchList = data;

    })

    // console.log('this.searchList:',this.searchList);

    // if(this.searchList){

    // this.searchList= new MatTableDataSource(this.searchList );

    // }




  }
  downloadFile(search: any): void {

    this.searchService.downloadFile(search.fileURL)

      .subscribe((blob: any) => {

        const a = document.createElement('a')

        const objectUrl = URL.createObjectURL(blob)

        a.href = objectUrl

        a.download = search.file;

        a.click();

        URL.revokeObjectURL(objectUrl);

      })

  }






}


