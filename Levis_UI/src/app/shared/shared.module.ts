import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { NgPrimeModulesModule } from './modules/ng-prime-modules.module';
import { LoaderComponent } from './components/loader/loader.component';
import { NoDataFoundComponent } from './components/no-data-found/no-data-found.component';
import { TeximateModule } from 'ngx-teximate';


@NgModule({
    imports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,
        RouterModule,
        NgPrimeModulesModule,
        TeximateModule
    ],
    declarations: [
        LoaderComponent,
        NoDataFoundComponent
    ],
    exports: [
        CommonModule,
        FormsModule,
        ReactiveFormsModule,
        RouterModule,
        NgPrimeModulesModule,
        TeximateModule,
        LoaderComponent,
        NoDataFoundComponent
    ]
})
export class SharedModule { }
