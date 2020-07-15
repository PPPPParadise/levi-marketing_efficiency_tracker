import { ControlCenterLayoutComponent } from './../../layouts/control-center-layout/control-center-layout.component';
import { Routes } from '@angular/router';
import { HomeLayoutComponent } from 'src/app/layouts/home-layout/home-layout.component';
import { AuthLayoutComponent } from 'src/app/layouts/auth-layout/auth-layout.component';
import { ContentLayoutComponent } from 'src/app/layouts/content-layout/content-layout.component';
import { LandingComponent } from 'src/app/modules/home/landing/landing.component';

export const FULL_ROUTES: Routes = [
    {
        path: '',
        loadChildren: './modules/home/home.module#HomeModule',
        component: HomeLayoutComponent
    },
    {
        path: 'auth',
        loadChildren: './modules/auth/auth.module#AuthModule',
        component: AuthLayoutComponent
    },
    {
        path: 'genome',
        loadChildren: './modules/genome/genome.module#GenomeModule',
        component: ContentLayoutComponent
    },
    {
        path: 'landing',
        loadChildren: './modules/landing_page/landing.module#LandingModule',
        component: ContentLayoutComponent
    }
];
