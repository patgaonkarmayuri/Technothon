import {Component, OnInit, ViewChild} from '@angular/core';

import {FormControl, FormGroupDirective, NgForm, Validators} from '@angular/forms';

import {ErrorStateMatcher} from '@angular/material/core';

import { HttpClient } from '@angular/common/http';

import { SearchService } from './services/search.service';

import { MatPaginator } from '@angular/material/paginator';

import { MatSort } from '@angular/material/sort';

import { MatTableDataSource } from '@angular/material/table';




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

  displayedColumns: string[] = ['applicationId', 'clientId', 'statementDescription', 'file', 'download', 'creationDate'];




  // @ViewChild(MatPaginator) paginator: MatPaginator;

  // @ViewChild(MatSort) sort: MatSort;




  ngOnInit() {

    this.searchService.searchResult().subscribe(data => {

      this.searchList = data;

    })

// console.log('this.searchList:',this.searchList);

// if(this.searchList){

  // this.searchList= new MatTableDataSource(this.searchList );

// }




  }




  // ngAfterViewInit() {

  //   this.dataSource.paginator = this.paginator;

  //   this.dataSource.sort = this.sort;

  // }




}




// mat file upload

// https://material.angular.io/components/file-input/overview