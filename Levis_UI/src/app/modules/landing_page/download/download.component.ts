import { Component, OnInit } from '@angular/core';
import { first } from 'rxjs/operators';
import { ServiceService } from 'src/app/shared/services/service.service';
import { DomSanitizer } from '@angular/platform-browser';
import { Router, ActivatedRoute, NavigationEnd } from '@angular/router';
import { StoreService } from 'src/app/shared/services/store.service';

@Component({
  selector: 'app-download',
  templateUrl: './download.component.html',
  styleUrls: ['./download.component.scss']
})
export class DownloadComponent implements OnInit {
  public CountryList = localStorage.getItem('download_country').split(",") 
  FileTypes = [ {"id": 1,  "name": "ATL"},
                {"id": 2,  "name": "Digital"},
                {"id": 3,  "name": "PR"},
                {"id": 4,  "name": "CRM"}];
  
  public selected_date_download:any;
  public selected_country_download:any;
  public selected_template_download : any;
  public isenable = true;
  public response:any;
  public excel_status:any;
  public display_errors:any;
  public is_display_errors:any;
  public error:any;
  public current_module:string[];
  public fileUrl:any;
  downloaded_file_name

  constructor(private service : ServiceService,private sanitizer:DomSanitizer, public router:Router,public activatedRoute: ActivatedRoute, public storeservice:StoreService) { 
    this.router.events.subscribe({
      next:x=>{
        if( x instanceof NavigationEnd ){
          this.current_module = x.urlAfterRedirects.split('/');
        }
      }
    });
  }

  ngOnInit() {
  }

  onOpenCalendar(container) {
    container.monthSelectHandler = (event: any): void => {
      container._store.dispatch(container._actions.select(event.date));
    };     
    container.setViewMode('month');
  }


  DownloadExcel(){
    if(this.selected_country_download && this.selected_date_download && this.selected_template_download){
      var param={};
      param["Country"] = this.selected_country_download;
      param["Month"] = this.selected_date_download.toString().split(" ",4);
      param["Template_Type"] = this.selected_template_download;
      this.service.download(param)
      .pipe(first())
      .subscribe(res=>{
        res
        this.response = res;
        this.excel_status = this.response.status;
        this.display_errors = '';
        this.is_display_errors = false;
        if(this.response.status){
        this.downloaded_file_name = this.response.template_name;
        this.get_excel(this.response.data);}
        else{
          alert(this.response.message)
        }
       },
     error=> this.errorList(error,event)
     
     );
    }else{
      alert("Required fields are empty,Please Fill");
      return false;
    }

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

  get_excel(data){
    let bytechar = atob(data);
    let bytenumber = new Array(bytechar.length);
    for(let i=0; i< bytechar.length; i++){
      bytenumber[i] = bytechar.charCodeAt(i);
    }
    let bytearray = new Uint8Array(bytenumber);
    var a = document.createElement("a");
    let blob = new Blob([bytearray],{type:'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'});
    a.href = URL.createObjectURL(blob);
    a.download = this.downloaded_file_name;
    a.click();
  }
  
}
