import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class BaseService {
  constructor(private http: HttpClient) { }


  get(url): Observable<any> {
    let user = JSON.parse(localStorage.getItem('currentUser'));
    const token = user && user.response.access_token;
    return this.http.get<any>(url, {
        headers: new HttpHeaders().set('Authorization', 'Bearer ' + token),
    });
  }

  post(url, data): Observable<any> {
      let user = JSON.parse(localStorage.getItem('currentUser'));
      const token = user && user.response.access_token;
      const headers = {
          headers: new HttpHeaders().set('Authorization', 'Bearer ' + token),
      };
      return this.http.post<any>(url, data, headers);
  }

  getJourney(url, journey, segment_type, customerid): Observable<any> {
    let user = JSON.parse(localStorage.getItem('currentUser'));
    const token = user && user.response.access_token;
    if(customerid){
      const headers = {
        headers: new HttpHeaders().set('Authorization', 'Bearer ' + token),
        params : new HttpParams().set('journey_type', journey).set('segment_type', segment_type).set('customer_id', customerid)
      };
      return this.http.get<any>(url, headers);
    } else{
      const headers = {
        headers: new HttpHeaders().set('Authorization', 'Bearer ' + token),
        params : new HttpParams().set('journey_type', journey).set('segment_type', segment_type)
      };
      return this.http.get<any>(url, headers);
    }
  }

  getfilterdata(url,port): Observable<any> {
    let user = JSON.parse(localStorage.getItem('currentUser'));
    const token = user && user.response.access_token;
    const headers = {
        headers: new HttpHeaders().set('Authorization', 'Bearer ' + token),
        params : new HttpParams().set('port', port)
      };
      return this.http.get<any>(url, headers);
    }
}
