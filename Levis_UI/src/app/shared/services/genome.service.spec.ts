import { TestBed } from '@angular/core/testing';

import { GenomeService } from './genome.service';

describe('GenomeService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: GenomeService = TestBed.get(GenomeService);
    expect(service).toBeTruthy();
  });
});
