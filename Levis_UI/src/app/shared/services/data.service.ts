import { Injectable } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
@Injectable()
export class DataService {
  chart_data: any = {};
  data: BehaviorSubject<any> = new BehaviorSubject<any>(this.chart_data);
  constructor() { }
}
