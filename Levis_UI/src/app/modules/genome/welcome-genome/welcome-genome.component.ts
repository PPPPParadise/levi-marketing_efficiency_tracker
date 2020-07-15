import { StoreService } from 'src/app/shared/services/store.service';
import { Component, OnInit } from '@angular/core';
import { trigger, state, style, animate, transition } from '@angular/animations';
import { Router } from '@angular/router';
import { GenomeService } from 'src/app/shared/services/genome.service';
import { first } from 'rxjs/operators';
import { any } from '@amcharts/amcharts4/.internal/core/utils/Array';
import { Footer } from 'primeng/components/common/shared';
import { array } from '@amcharts/amcharts4/core';
import { DomSanitizer } from '@angular/platform-browser';


@Component({
  selector: 'app-welcome-genome',
  templateUrl: './welcome-genome.component.html',
  styleUrls: ['./welcome-genome.component.scss'],
  animations: [
    trigger('visibilityChanged', [
      state('shown', style({ opacity: 1, })),
      state('hidden', style({ opacity: 0, display: 'none' })),
      transition('shown => hidden', animate('600ms')),
      transition('hidden => shown', animate('600ms')),
    ]),
    trigger('welcome_message', [
      state('initial_state', style({
        opacity: 1,
        transform: 'scale(1) translateY(200%)'
      })),
      state('final_state', style({
        transform: 'scale(1) translateY(0%)'
      })),
      transition('initial_state => final_state', animate('400ms ease-out'))
    ])
  ]
})
export class WelcomeGenomeComponent implements OnInit {
  

  constructor() { }

  ngOnInit() {

  }
}