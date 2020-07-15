import { FormControl, FormGroup } from '@angular/forms';
import { Component, OnInit, ViewChild, ElementRef, Inject, HostListener } from '@angular/core';
import { DOCUMENT } from "@angular/platform-browser";
import { ActivatedRoute, Router } from '@angular/router';
import { trigger, transition, useAnimation } from '@angular/animations';
import { bounce } from 'ng-animate';
import { LandingPageService } from 'src/app/shared/services/landing-page.service';
declare var $: any;
@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.scss'],
  animations: [
    trigger('bounce', [transition('* => *', useAnimation(bounce, {
      // Set the duration to 5seconds and delay to 2seconds
      params: { timing: 5, delay: 2 }
    }))])
  ],
})
export class LandingComponent implements OnInit {
  

  ngOnInit() {
    
    };
    
}
