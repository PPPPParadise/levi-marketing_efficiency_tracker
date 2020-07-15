import { Component, OnInit, ViewChild } from '@angular/core';
import { first } from 'rxjs/operators';
import { error } from '@angular/compiler/src/util';
import { ServiceService } from 'src/app/shared/services/service.service';
import { Router } from '@angular/router';
import { trigger, state, transition, style, animate } from '@angular/animations';
// import { IgxMonthPickerComponent } from "igniteui-angular";

@Component({
  selector: 'app-landing',
  templateUrl: './landing.component.html',
  styleUrls: ['./landing.component.scss'],
  animations: [
    trigger('visibilityChanged', [
      state('shown', style({ opacity: 1, })),
      state('hidden', style({ opacity: 0, display: 'none' })),
      transition('shown => hidden', animate('600ms')),
      transition('hidden => shown', animate('600ms')),
    ]),
  ]
})


export class LandingComponent implements OnInit{
  title = 'uploadExcel';
  public selected_date:any; 
  public selected_country:any;
  public selected_currency:any;
  public isenable = true;
  public error:string = '';
  public exceluploadsuccess:any;
  public excel_status:any;
  public display_errors:any;
  public is_display_errors:any;
  selectedOwnerLevel:number = 1;
  selectedCountry:number = 0;
  textLoader = false;
  // loaderVisibility = 'shown';
  loaderVisiblity = 'hidden';
  last_uploads:any;
  public CountryList = localStorage.getItem('country').split(",") 
  

  FileTypes = [ {"id": 1,  "name": "ATL"},
                {"id": 2,  "name": "Digital"},
                {"id": 3,  "name": "PR"},
                {"id": 4,  "name": "CRM"}];
  CurrencyList = [{"id": 1, "name": "USD"},
                  {"id": 2, "name": "Local Currency"},
                ]
constructor(private service : ServiceService, private router:Router){}
ngOnInit() {
  let a = new Date();
  a.setDate(-1)
  this.selected_date=a;
  }
  
  handleInputChange(e){
    var file = e.dataTransfer ? e.dataTransfer.files[0] : e.target.files[0];
    localStorage['file_name'] = file.name;
    var pattern = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    var reader = new FileReader();
    if (!file.type.match(pattern)) {
      alert('Please choose excel file');
      return;
    }
     reader.readAsDataURL(file);
     reader.onload = function () {
       localStorage['exceldata'] = reader.result;
    };
     reader.onerror = function (error) {
     console.log('Error: ', error);
   };
   
  }


  checkExcel(event){
     if(localStorage.exceldata && this.selectedOwnerLevel && this.selected_country && this.selected_date && this.selected_currency){
       var param={};
       param["file"]= localStorage.exceldata;
       param["type"]=this.selectedOwnerLevel;
       param["country"] = this.selected_country;
       param["date"] = this.selected_date.toString().split(" ",4);
       param["currency"] = this.selected_currency;
       param['file_name'] = localStorage.file_name;
       (<HTMLInputElement> document.getElementById("submit_btn")).disabled = true;
       this.service.checkexcel(param)
       .pipe(first())
       .subscribe(res=>{
         res
         this.exceluploadsuccess = res;
         this.excel_status = this.exceluploadsuccess.status;
         this.display_errors = '';
         this.is_display_errors = false;
         localStorage['excel_rows_data'] = JSON.stringify(this.exceluploadsuccess.data);
        //  localStorage.setItem('excel_rows_data', JSON.stringify(this.exceluploadsuccess.data;));
         (<HTMLInputElement> document.getElementById("submit_btn")).disabled = false;
        },
      error=> this.errorList(error,event)
      
      );
     }else{
       alert("Required fields are empty,Please Fill");
       return false;
     }
    
  }

  submitExcel(event){
    if(localStorage.exceldata){
      this.loaderVisiblity = 'shown';
      // var selected_country = (<HTMLInputElement> document.getElementById("selected_country"));
      // var selected_date = (<HTMLInputElement> document.getElementById("selected_date"));
      // var selected_currency = (<HTMLInputElement> document.getElementById("selected_currency"));
      var param={};
      param["data"] = localStorage.getItem('excel_rows_data')
      // param["data"]=JSON.parse(localStorage.getItem('excel_rows_data'));
      param["type"]=this.selectedOwnerLevel;
      param["country"] = this.selected_country;
      param["date"] = this.selected_date.toString().split(" ",4);
      param["currency"] = this.selected_currency;
      param['file_name'] = localStorage.file_name;
      this.service.uploadexcel(param)
      .pipe(first())
      .subscribe(res=>{
        this.loaderVisiblity = 'hidden';
        res
        this.exceluploadsuccess = res;
        this.excel_status = '';
        this.excel_status = this.exceluploadsuccess.status;
        (<HTMLInputElement> document.getElementById("submit_btn")).disabled = true;
        // (<HTMLInputElement> document.getElementById("submit_btn")).disabled = false;
        localStorage['last_uploads'] = JSON.stringify(res.data);
       },
     error=> this.errorList(error,event)
     
     );
    }
   
 }



  onChangeOwnerLevel(ownerLevelId:number){
    this.selectedOwnerLevel = ownerLevelId;
  }

  errorList(err,event){
    this.excel_status = ''
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
