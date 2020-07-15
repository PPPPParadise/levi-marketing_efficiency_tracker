import { Constants } from './constants';
import { BaseService } from './base.service';
import { Injectable } from '@angular/core';
import { HttpParams,HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class GenomeService {

  constructor(private http: BaseService) { }

  getgenome(){
    let url = `${Constants.GENOME}`;
    return this.http.get(url);
  }

  explore_genome(data){
    let url = `${Constants.GENOME}`;
    return this.http.post(url, data);
  }

  getportdata(port){
    let url = `${Constants.GENOME}`;
    return this.http.getfilterdata(url,port);
    }

  clusters(){
    let url = `${Constants.CLUSTER}`;
    return this.http.get(url);
  }

  dimensions(){
    let url = `${Constants.DIMENSION}`;
    return this.http.get(url);
  }

  clusterDimensionMapping(){
    let url = `${Constants.CLISTER_DIMENSION_MAPPING}`;
    return this.http.get(url);
  }

  customerJourney(journey_type, segment_type, customerid){
    let url = `${Constants.CUSTOMER_SEGMENT_JOURNEY}`;
    return this.http.getJourney(url, journey_type, segment_type, customerid);
  }

  dimension(){
    let url = `${Constants.DIMENSION}`;
    return this.http.get(url);
  }
  
}
