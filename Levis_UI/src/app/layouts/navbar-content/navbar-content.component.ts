import { Component, OnInit } from '@angular/core';
import { Router, NavigationEnd } from '@angular/router';
import { trigger, state, style, transition, animate } from '@angular/animations';
import { TextAnimation } from 'ngx-teximate';
import { fadeIn } from 'ng-animate';

@Component({
  selector: 'app-navbar-content',
  templateUrl: './navbar-content.component.html',
  styleUrls: ['./navbar-content.component.scss'],
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
    trigger('fadeInOut', [
      state('void', style({
        opacity: 0
      })),
      transition('void <=> *', animate('1000ms ease-in'))
    ])
  ]
})
export class NavbarContentComponent implements OnInit {
  current_route: boolean;
  menuState: string = 'out';
  public innerWidth: number;
  logoState: string = 'out';
  text = 'GENOME';
  first_name : any;
  last_name : any;

  constructor(private router: Router) {
    this.router.events.subscribe({
      next: x => {
        if (x instanceof NavigationEnd) {
          // check url after redirection completes
          if (x.urlAfterRedirects.split('/')[2] != 'welcome') {
            this.current_route = true;
          } else {
            this.current_route = false;
          }
        }
      }
    });

    // responsive menu only for viewports less than 767.98px
    this.innerWidth = window.innerWidth;
    if (this.innerWidth > 767.98) {
      this.menuState = 'in';
    }
  }

  ngOnInit() {
    this.logoState = 'in';
    this.text = this.router.url.substr(1).split("/")[0].toUpperCase();
    this.first_name=  localStorage['user_details.first_name'];
    this.last_name=  localStorage['user_details.last_name'];
  //   console.log("asdfg:",localStorage['user_details.first_name'])
  //   console.log(localStorage['user_details.first_name']);
  //   console.log(this.first_name); 
  }
  

  toggleSideNavbar() {
    if (this.innerWidth < 767.98) {
      this.menuState = this.menuState === 'out' ? 'in' : 'out';
    }
  }

  enterAnimation: TextAnimation = {
    animation: fadeIn,
    delay: 80,
    type: 'letter'
  };

}
