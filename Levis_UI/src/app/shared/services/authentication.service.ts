import { Injectable } from '@angular/core';
import { Observable, BehaviorSubject } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { map, catchError } from 'rxjs/operators';
import { Constants } from './constants';
import { UserModel } from '../models/user-model';
import { any } from '@amcharts/amcharts4/.internal/core/utils/Array';
import { Response } from 'selenium-webdriver/http';

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {
  private currentUserSubject: BehaviorSubject<UserModel>;
  public currentUser: Observable<UserModel>;
  
  constructor(private http: HttpClient) { 
    this.currentUserSubject = new BehaviorSubject<UserModel>(JSON.parse(localStorage.getItem('currentUser')));
    this.currentUser = this.currentUserSubject.asObservable();
  }

  public get currentUserValue(): UserModel {
    return this.currentUserSubject.value;
  }

  login(username: string, password: string) {
    return this.http.post<any>(`${Constants.LOGIN_URL}`, { username, password })
      .pipe(map(user => {
        // login successful if there's a jwt token in the response
        if (user && user.response.access_token) {
            // store user details and jwt token in local storage to keep user logged in between page refreshes
            localStorage.setItem('currentUser', JSON.stringify(user));
            this.currentUserSubject.next(user);
        }
        return user;
      }));
  }

  logout() {
    // remove user from local storage to log user out
    localStorage.clear();
    localStorage.removeItem('currentUser');
    this.currentUserSubject.next(null);
  }

  // logout() {
  //   debugger;
  //   let response =  this.http.post<any>(`${Constants.LOGOUT_URL}`, {user: JSON.parse(localStorage.currentUser).response.access_token});
  //   return 
    // return this.http.post<any>(`${Constants.LOGOUT_URL}`, {user: JSON.parse(localStorage.currentUser).response.access_token});
  // }
    // this.currentUserSubject.next(null)
}