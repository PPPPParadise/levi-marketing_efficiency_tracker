import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BaseService} from './base.service';
@Injectable({
  providedIn: 'root'
})
export class ServiceService {

  constructor(private http: BaseService) { }

  checkexcel(obj) {
    // let url = "http://10.0.0.71:8000/api/upload/";
    let url = 'https://met-app-backend.cartesianconsulting.com/api/upload/';
    return this.http.post(url,{params:obj});
    
  }

  uploadexcel(obj) {
    // let url = "http://10.0.0.71:8000/api/upload/upload_excel/";
    let url = 'https://met-app-backend.cartesianconsulting.com/api/upload/upload_excel/';
    return this.http.post(url,{params:obj});
    
  }

  download(obj){
    // let url = "http://10.0.0.71:8000/api/upload/download_excel/";
    let url = 'https://met-app-backend.cartesianconsulting.com/api/upload/download_excel/';
    return this.http.post(url,{params:obj});
  }

  approved(obj){
    // let url = "http://10.0.0.71:8000/api/upload/approved_data/";
    let url = 'https://met-app-backend.cartesianconsulting.com/api/upload/approved_data/';
    return this.http.post(url,{params:obj});
  }

}
