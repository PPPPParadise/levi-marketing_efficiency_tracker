import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationGenomeComponent } from './navigation-genome.component';

describe('NavigationGenomeComponent', () => {
  let component: NavigationGenomeComponent;
  let fixture: ComponentFixture<NavigationGenomeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ NavigationGenomeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationGenomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
