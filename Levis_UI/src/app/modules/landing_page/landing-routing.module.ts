import { AuthGuard } from './../../shared/services/auth-guard.service';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { LandingComponent } from "./landing/landing.component";
import { DownloadComponent } from './download/download.component';
import { ApprovedrejectComponent } from './approvedreject/approvedreject.component';

const routes: Routes = [
  {
    path: '',
    children: [
      // {
      //   path: '',
      //   redirectTo: 'welcome',
      //   pathMatch: 'full'
      // },
      {
        path: 'upload',
        component: LandingComponent
      },
      {
        path: 'download',
        component: DownloadComponent
      },
      {
        path: 'approve',
        component: ApprovedrejectComponent,
      }
    ]
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class LandingRoutingModule { }
