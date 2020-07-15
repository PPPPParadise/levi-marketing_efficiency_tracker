import { CountoModule } from 'angular2-counto';
import { StoreService } from 'src/app/shared/services/store.service';
import { BaseService } from './shared/services/base.service';
import { GenomeService } from 'src/app/shared/services/genome.service';
import { AuthenticationService } from './shared/services/authentication.service';
import { AuthGuard } from './shared/services/auth-guard.service';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { ContentLayoutComponent } from './layouts/content-layout/content-layout.component';
import { SharedModule } from './shared';
import { HomeLayoutComponent } from './layouts/home-layout/home-layout.component';
import { NavbarHomeComponent } from './layouts/navbar-home/navbar-home.component';
import { AuthLayoutComponent } from './layouts/auth-layout/auth-layout.component';
import { NavbarContentComponent } from './layouts/navbar-content/navbar-content.component';
import { NavigationGenomeComponent } from './layouts/navigation-genome/navigation-genome.component';
import { DataService } from './shared/services/data.service';
import { LandingPageService } from './shared/services/landing-page.service';
import { CarouselModule } from 'ngx-owl-carousel-o';
import { ControlCenterLayoutComponent } from './layouts/control-center-layout/control-center-layout.component';
import { DragDropModule } from '@angular/cdk/drag-drop';
import { TeximateModule } from 'ngx-teximate';
import { MatCardModule, MatDatepickerModule, MatInputModule, MatNativeDateModule } from '@angular/material';
import { GaugeChartModule } from 'angular-gauge-chart';
// import { IgxCalendarModule } from 'igniteui-angular';
// import { MonthpickerComponent } from './monthpicker/monthpicker.component'

// import { ApprovedrejectComponent } from './modules/landing_page/approvedreject/approvedreject.component';
//import { BsDatepickerModule, BsDatepickerConfig } from 'ngx-bootstrap/datepicker';
@NgModule({
  declarations: [
    AppComponent,
    ContentLayoutComponent,
    HomeLayoutComponent,
    NavbarHomeComponent,
    AuthLayoutComponent,
    NavbarContentComponent,
    NavigationGenomeComponent,
    ControlCenterLayoutComponent,
    // ApprovedrejectComponent,
  ],
  imports: [
    BrowserModule,
    //BsDatepickerModule.forRoot(),
    ReactiveFormsModule,
    AppRoutingModule,
    HttpClientModule,
    SharedModule,
    BrowserAnimationsModule,
    CarouselModule,
    CountoModule,
    TeximateModule,
    DragDropModule,
    MatCardModule,
    GaugeChartModule,
    MatDatepickerModule,
    MatInputModule,
    MatNativeDateModule,
    // IgxCalendarModule
    // MonthpickerComponent
  ],
  providers: [
    DataService,
    AuthGuard,
    AuthenticationService,
    BaseService,
    GenomeService,
    StoreService,
    LandingPageService
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
