import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { FULL_ROUTES } from './shared';

const routes: Routes = [
  {
    path: '',
    children: FULL_ROUTES
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
