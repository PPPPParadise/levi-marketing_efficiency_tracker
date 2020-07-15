import { Component, OnInit } from '@angular/core';
import { first } from 'rxjs/operators';
import { ServiceService } from 'src/app/shared/services/service.service';
import { DomSanitizer } from '@angular/platform-browser';
import { Router, ActivatedRoute, NavigationEnd } from '@angular/router';
import { StoreService } from 'src/app/shared/services/store.service';
import { YEAR, MONTH } from 'ngx-bootstrap/chronos/units/constants';
import { getFullYear } from 'ngx-bootstrap/chronos/public_api';
import { trigger, state, transition, style, animate } from '@angular/animations';

import { Renderer2, Inject } from '@angular/core';
import { DOCUMENT } from '@angular/platform-browser';
import { truncateWithEllipsis } from '@amcharts/amcharts4/.internal/core/utils/Utils';

@Component({
  selector: 'app-approvedreject',
  templateUrl: './approvedreject.component.html',
  styleUrls: ['./approvedreject.component.scss'],
  animations: [
    trigger('visibilityChanged', [
      state('shown', style({ opacity: 1, })),
      state('hidden', style({ opacity: 0, display: 'none' })),
      transition('shown => hidden', animate('600ms')),
      transition('hidden => shown', animate('600ms')),
    ])
  ],
})
export class ApprovedrejectComponent implements OnInit {
  public selected_date_approved_reject:any;
  public selected_country_approved_reject:any;
  atl_status:any;
  atl_remark:any;
  digital_status:any;
  digital_remark:any;
  pr_status:any;
  pr_remark:any;
  crm_status:any;
  crm_remark:any;
  public current_module:string[];
  public error:any;
  response:any;
  response_status:any;
  display_errors:any;
  is_display_errors:any;
  success_msg:any;
  last_updates:any;
  last_uploads:any;
  loaderVisiblity = 'hidden';
  ignore_actions:any;
  constructor(private renderer2: Renderer2, @Inject(DOCUMENT) private _document,private service : ServiceService,private sanitizer:DomSanitizer, public router:Router,public activatedRoute: ActivatedRoute, public storeservice:StoreService) { 
    this.router.events.subscribe({
      next:x=>{
        if( x instanceof NavigationEnd ){
          this.current_module = x.urlAfterRedirects.split('/');
        }
      }
    });
  }

  

  ngOnInit() {
    let a = new Date();
    a.setDate(-1)
    this.selected_date_approved_reject=a;
    this.selected_country_approved_reject = localStorage.getItem('approval_country');
    this.last_updates = JSON.parse(localStorage.last_updates);
    this.last_uploads = JSON.parse(localStorage.last_uploads);
    this.tableauload();
  }

  tableauload(){
   const s = this.renderer2.createElement('script');
   s.type = 'text/javascript';
   s.src = 'https://levis-met.cartesianconsulting.com/javascripts/api/viz_v1.js';
   s.text = ``;
   this.renderer2.appendChild(this._document.body, s);
  }

  clearForm(){
  // this.selected_date="";
  this.atl_status="";
  this.atl_remark="";
  this.digital_status="";
  this.digital_remark="";
  this.pr_status="";
  this.pr_remark="";
  this.crm_status="";
  this.crm_remark="";
  this.tableauload();
   }

  approved(){
    if(this.selected_date_approved_reject && this.selected_country_approved_reject){
    this.loaderVisiblity = 'shown';
    var param_list = [
                      {"status":this.atl_status,"type":'1',"remark":this.atl_remark},
                      {"status":this.digital_status,"type":"2","remark":this.digital_remark},
                      {"status":this.pr_status,"type":"3", "remark":this.pr_remark},
                      {"status":this.crm_status,"type":"4", "remark":this.crm_remark}
                    ];
    
    var params = {"month":this.selected_date_approved_reject.toString().split(" ",4),"template_list":param_list,"country":this.selected_country_approved_reject}
    this.service.approved(params)
    .pipe(first())
    .subscribe(res=>{
      this.loaderVisiblity = 'hidden';
      this.response = res;
      this.response_status = this.response.status;
      this.display_errors = '';
      this.is_display_errors = false;
      if(this.response.status){
        this.success_msg = this.response.message;
        // localStorage['last_updates'] = JSON.stringify(this.response.data);
        // localStorage['ignore_actions'] = JSON.stringify(this.response.ignore_actions)
        // this.ignore_actions = JSON.parse(localStorage.ignore_actions);
        // this.last_updates = JSON.parse(localStorage.last_updates);
        // alert(this.success_msg);
        this.clearForm();
        this.tableauload();
      }
      else{
        alert(this.response.message);
      }
      },
      error=> {
        this.tableauload();
        alert(this.errorList(error,event));
        // return this.errorList(error, event);
      });
  }else{
    alert("Required Field Is Empty!");
  }
  this.tableauload();
}

  errorList(err,event){
    if (err.status == 0) {
      console.log("please check your internet connection");
    } else if (err.status == 500) {
      this.error= "oops something went wrong, please try again!!";
    } else if (err.status == 400) {
      this.display_errors = err.error;
      this.is_display_errors = true;
      event.target.value = '';
      localStorage.exceldata = '';
    } else if (err.status == 403) {
      this.display_errors = "Your Session got expire. Please Re-login and try again";
      this.is_display_errors = true;
      this.router.navigate(['/logout']);  
    }
  }

  onOpenCalendar(container) {
    container.monthSelectHandler = (event: any): void => {
      container._store.dispatch(container._actions.select(event.date));
    };     
    container.setViewMode('month');
  }


}
