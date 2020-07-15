import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { LandingRoutingModule } from './landing-routing.module'
import { LandingComponent } from "./landing/landing.component";
import { SharedModule } from 'src/app/shared';
import { BsDatepickerModule, BsDatepickerConfig } from 'ngx-bootstrap/datepicker';
import { setTheme } from 'ngx-bootstrap/utils';
import { DownloadComponent } from './download/download.component';
import { ApprovedrejectComponent } from './approvedreject/approvedreject.component';
// import { IgxCalendarModule } from 'igniteui-angular';

setTheme('bs4');
@NgModule({
  declarations: [LandingComponent,DownloadComponent,ApprovedrejectComponent,],
  imports: [
    CommonModule,
    BsDatepickerModule.forRoot(),
    LandingRoutingModule,
    SharedModule,
    // IgxCalendarModule
  ]
})
export class LandingModule {}
