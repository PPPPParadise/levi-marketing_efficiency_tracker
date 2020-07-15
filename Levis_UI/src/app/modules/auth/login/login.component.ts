import { StoreService } from 'src/app/shared/services/store.service';
import { Component, OnInit, ViewChild, ElementRef } from '@angular/core';
import { Router } from '@angular/router';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
import { AuthenticationService } from './../../../shared/services/authentication.service';
import { first } from 'rxjs/operators';
import { Subscription } from 'rxjs/internal/Subscription';
import { from } from 'rxjs';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})

export class LoginComponent implements OnInit {
  public loginForm: FormGroup;
  public ureturnUrl: string;
  public error:string = '';
  loaderVisiblity = 'shown';
  contentVisibility = 'hidden';
  is_display_errors: any;

  oldnNewpassMatch: any;
  errorOldPass: string;
  errorOldPassNotMatch: boolean;
  passmatch: any;
  passsame: boolean;
  errorPassIsSimilar: string;
  tooltipDisplayNon: boolean;
  errorPassIsSimilarUser: boolean;
  confPassMatch: any;
  confPassConfirm: boolean;
  currentUserKyte: any;
  _userProfile: any;
  successMsg: any;
  constructor(private formBuilder: FormBuilder, private router: Router,
    private authenticationService: AuthenticationService, private store: StoreService) { }

  ngOnInit() {
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });
    // reset login status
    this.authenticationService.logout();
    
  }

  // convenience getter for easy access to form fields
  get f() { return this.loginForm.controls; }

  onSubmit() {
    // stop here if form is invalid
    if (this.loginForm.invalid) {
      return;
    }

    this.authenticationService.login(this.f.username.value, this.f.password.value)
      .pipe(first())
      .subscribe(
        data => {
          this.store.loginModalClose('close');
          setTimeout(() => {
            this.loaderVisiblity = 'hidden';
            this.contentVisibility = 'shown';
          }, 3000);
          if(data.response && data.response.status){
            localStorage['country'] = data.response.uploader_for_country;
            localStorage['download_country'] = data.response.download_for_country;
            localStorage['approval_country'] = data.response.approval_for_country;
            localStorage['last_updates'] = JSON.stringify(data.response.last_updates);
            localStorage['last_uploads'] = JSON.stringify(data.response.last_uploads);
            this.router.navigate(["/landing"]);
            localStorage['is_eligible_for_approved'] = data.response.is_eligible_for_approved;
            localStorage['is_eligible_for_upload'] = data.response.is_eligible_for_upload;
            localStorage['user_details.first_name'] = data.response.user_details.first_name;
            localStorage['user_details.last_name'] = data.response.user_details.last_name;
          }
        },
        error=> this.errorList(error,event)
      );
  }

  errorList(err,event){
    if (err.status == 0) {
      console.log("please check your internet connection");
    } else if (err.status == 500) {
      this.error= "oops something went wrong, please try again!!";
    } else if (err.status == 400) {
      this.is_display_errors = true;
      this.error = "Invalid username or password"
    } else if (err.status == 403) {
      this.router.navigate(['/logout']); 
    }
  }

  
}
