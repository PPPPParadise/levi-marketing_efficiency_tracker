import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ApprovedrejectComponent } from './approvedreject.component';

describe('ApprovedrejectComponent', () => {
  let component: ApprovedrejectComponent;
  let fixture: ComponentFixture<ApprovedrejectComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ApprovedrejectComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApprovedrejectComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
