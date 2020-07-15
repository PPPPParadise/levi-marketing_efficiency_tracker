import { Component, OnInit } from '@angular/core';
import { Router, NavigationEnd, ActivatedRoute } from '@angular/router';
import { FormControl } from '@angular/forms';

@Component({
  selector: 'app-navigation-genome',
  templateUrl: './navigation-genome.component.html',
  styleUrls: ['./navigation-genome.component.scss']
})
export class NavigationGenomeComponent implements OnInit {

  current_route: boolean;
  show_tableau: boolean;
  current_module: string[];
  journey_type: string;
  clickRoute: string;
  permissions:any;
  is_eligible_upload:boolean;
  is_eligible_approve:boolean;
  selected_customer_type: string;
  // genome analysis active module
  ga_active: string;
  type_of_customer: string;
  authenticationService: any;

  constructor(private router: Router, private activatedRoute: ActivatedRoute) {
    this.router.events.subscribe({
      next: x => {
        if (x instanceof NavigationEnd) {
          // check url after redirection completes
          if (x.urlAfterRedirects.split('/')[2] !== 'welcome') {
            this.current_route = true;
            // this.show_tableau = false;
            // getting an array of all the route segments and using it to show/hide the nav items
            this.current_module = x.urlAfterRedirects.split('/');
            // if(this.clickRoute === 'journeys'){
              // if (this.current_module[3] === 'journeys') {
              //   this.journey_type = this.current_module[4].split('?')[0];
              // }
            // } else{
            //   this.router.navigate(['./genome/analysis/'+this.clickRoute]);
            // }

          } else {
            this.current_route = false;
          }
        }
      }
    });
  }

  ngOnInit() {
    // this.permissions = JSON.parse(localStorage.getItem('currentUser'));
    // if(this.permissions.getItem("response").getItem("is_eligible_for_approved")){
    //   this.is_eligible_approve = "active";
    // }
    // if(this.permissions.getItem("response").getItem("is_eligible_for_upload")){
    //   this.is_eligible_upload = 
    // }

    // localStorage.getItem("")
    // load on HVHF when first initialised
    // this.authenticationService.LoginComponent()
    this.is_eligible_upload = localStorage['is_eligible_for_upload'];
    console.log(localStorage['is_eligible_for_upload']);
    // console.log(this.is_eligible_upload); 
    this.is_eligible_approve =localStorage['is_eligible_for_approved'];
    console.log(localStorage['is_eligible_for_approved']);


    this.activatedRoute.queryParams.subscribe(
      {
        next: x => {
          this.selected_customer_type = x.type;
        }
      }
    );
  }

  // dataChanged(value) {
  //   this.router.navigate([], {
  //     relativeTo: this.activatedRoute,
  //     queryParams: {
  //       type: value
  //     }
  //   });
  // }

  // goToCluster() {
  //   this.clickRoute = 'clusters';
  //   this.router.navigate(['./genome/analysis/clusters']);
  // }
  // goToDimensions() {
  //   this.clickRoute = 'dimensions';
  //   this.router.navigate(['./genome/analysis/dimensions']);
  // }
  // goToJourney() {
  //   this.clickRoute = 'journeys';
  //   this.router.navigate(['./analysis/journeys'], {
  //     relativeTo: this.activatedRoute,
  //     queryParams: {
  //       type: 'HVHF'
  //     }
  //   });
  // }
  

  routeToJoureyType(type) {
    console.log("routeToJoureyType function");
    this.activatedRoute.queryParams.subscribe(
      {
        next: x => {
          this.router.navigate(['./analysis/journeys/' + type + '-journey'], {
            relativeTo: this.activatedRoute,
            queryParams: {
              type: x.type
            }
          });
        }
      }
    );
  }


}
