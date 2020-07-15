import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { WelcomeGenomeComponent } from './welcome-genome.component';

describe('WelcomeGenomeComponent', () => {
  let component: WelcomeGenomeComponent;
  let fixture: ComponentFixture<WelcomeGenomeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ WelcomeGenomeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(WelcomeGenomeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
