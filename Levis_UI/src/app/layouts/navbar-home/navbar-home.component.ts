import { first } from 'rxjs/operators';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { AuthenticationService } from './../../shared/services/authentication.service';
import { StoreService } from 'src/app/shared/services/store.service';
import { Component, OnInit, ElementRef, ViewChild } from '@angular/core';
import { trigger, state, style, transition, animate } from '@angular/animations';
import { Router, ActivatedRoute } from '@angular/router';


@Component({
  selector: 'app-navbar-home',
  templateUrl: './navbar-home.component.html',
  styleUrls: ['./navbar-home.component.scss'],
  animations: [
    trigger('slideInOut', [
      state('in', style({
        transform: 'translateX(0%)'
      })),
      state('out', style({
        transform: 'translateX(-100%)'
      })),
      transition('in => out', animate('400ms ease-in-out')),
      transition('out => in', animate('400ms ease-in-out'))
    ]),
  ]
})
export class NavbarHomeComponent implements OnInit {
  menuState: string = 'out';
  public innerWidth: number;

  public loginForm: FormGroup;
  public ureturnUrl: string;
  public error:string = '';

  
  @ViewChild("openConfirmModalContext") openConfirmModalContext: ElementRef;
  @ViewChild("closeConfirmModalContext") closeConfirmModalContext: ElementRef;
  
  constructor(private router: Router, private activatedRoute: ActivatedRoute, private store: StoreService, private formBuilder: FormBuilder,
    private authenticationService: AuthenticationService) {
    // responsive menu only for viewports less than 767.98px
    this.innerWidth = window.innerWidth;
    if (this.innerWidth > 767.98) {
      this.menuState = 'in';
    }

  }

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
          // setTimeout(() => {
          // this.closeConfirmModalContext.nativeElement.click();
          this.router.navigate(["/genome"]);
          // }, 3000);
        },
        error => {
          this.error = error.error.detail.replace(/\'/g, "");
        }
      );
  }


  toggleSideNavbar() {
    if (this.innerWidth < 767.98) {
      this.menuState = this.menuState === 'out' ? 'in' : 'out';
    }
  }

  changeRoute(section: string) {
    this.router.navigate([], {
      relativeTo: this.activatedRoute,
      queryParams: {
        section
      },
      queryParamsHandling: 'merge',
      skipLocationChange: true
    });
  }

  login(){
    this.openConfirmModalContext.nativeElement.click();
  }

}
