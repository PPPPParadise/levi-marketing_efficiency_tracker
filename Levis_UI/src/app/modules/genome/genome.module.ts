import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { GenomeRoutingModule } from './genome-routing.module';
import { WelcomeGenomeComponent } from './welcome-genome/welcome-genome.component';
import { SharedModule } from 'src/app/shared';

@NgModule({
  declarations: [WelcomeGenomeComponent],
  imports: [
    CommonModule,
    GenomeRoutingModule,
    SharedModule
  ]
})
export class GenomeModule { }
