import { StoreService } from 'src/app/shared/services/store.service';
import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AuthenticationService } from './../../../shared/services/authentication.service';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.scss']
})
export class LogoutComponent implements OnInit {

  constructor(private router: Router, private storeService: StoreService,private authenticationService: AuthenticationService) { }

  ngOnInit() {
    debugger;
    this.authenticationService.logout();
    sessionStorage.removeItem("currentUser");
    sessionStorage.clear();
    this.storeService.historyUrl = '';
    localStorage.removeItem("is_eligible_for_upload");
    localStorage['is_eligible_for_upload']='';
    this.router.navigate(["login"]);
  }

}
