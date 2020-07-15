import { BaseService } from './base.service';
import { Constants } from './constants';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class LandingPageService {

  constructor(private http: BaseService) { }

  requestDemo(data){
    // let url = 'http://192.168.111.73:9898/cartorp_project/send_email/';
    let url = 'https://thekyte.ai/api/cartorp_project/request_demo/';
    return this.http.post(url, data);
  }

}
