/* Module to import all the NG-Prime components being used in the application */

import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { CalendarModule } from 'primeng/calendar';
import { RadioButtonModule } from 'primeng/radiobutton';
import { TooltipModule } from 'primeng/tooltip';
import { TableModule } from 'primeng/table';
import { PaginatorModule } from 'primeng/paginator';
import { CheckboxModule } from 'primeng/checkbox';
import { DropdownModule } from 'primeng/dropdown';
import { FileUploadModule } from 'primeng/fileupload';


@NgModule({
    declarations: [],
    imports: [
        CommonModule,
        CalendarModule,
        RadioButtonModule,
        TooltipModule,
        TableModule,
        PaginatorModule,
        CheckboxModule,
        DropdownModule,
        FileUploadModule
    ],
    exports: [
        CalendarModule,
        RadioButtonModule,
        TooltipModule,
        TableModule,
        PaginatorModule,
        CheckboxModule,
        DropdownModule,
        FileUploadModule
    ]
})
export class NgPrimeModulesModule { }
