import { Component, OnInit } from '@angular/core';
import { trigger, state, style, transition, animate } from '@angular/animations';
@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
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
export class HomeComponent implements OnInit {
  menuState: string = 'out';
  public innerWidth: number;
  constructor() {

    this.innerWidth = window.innerWidth;
    if (this.innerWidth > 767.98) {
      this.menuState = 'in';
    }
  }

  ngOnInit() {

  }

  toggleSideNavbar() {
    if (this.innerWidth < 767.98) {
      this.menuState = this.menuState === 'out' ? 'in' : 'out';
    }
  }

}
