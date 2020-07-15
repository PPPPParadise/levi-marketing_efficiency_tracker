import { Observable, Subject } from 'rxjs';
import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class StoreService {

  constructor() { }
  
  public customer_id : number;

  public historyUrl: string;

  
  private loginModal = new Subject<string>();

  public loginModalClose(close: string){
    this.loginModal.next(close);
  }
  loginModalCloseFun(): Observable<any> {
    return this.loginModal.asObservable();
  }
}
