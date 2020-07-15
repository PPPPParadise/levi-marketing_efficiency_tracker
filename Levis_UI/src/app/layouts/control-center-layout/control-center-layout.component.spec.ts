import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ControlCenterLayoutComponent } from './control-center-layout.component';

describe('ControlCenterLayoutComponent', () => {
  let component: ControlCenterLayoutComponent;
  let fixture: ComponentFixture<ControlCenterLayoutComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ControlCenterLayoutComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ControlCenterLayoutComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
