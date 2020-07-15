import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Student } from './waterfall.model';
@Injectable({
  providedIn: 'root'
})
export class WaterfallListService {
  students: Student[] = [
    {
      name: 'Krunal'
    },
    {
      name: 'Ankit'
    },
    {
      name: 'Rushabh'
    },
    {
      name: 'Dhaval'
    },
    {
      name: 'Nehal'
    },
  ]

  constructor() { }

  public getStudents(): any {
    const studentsObservable = new Observable(observer => {
      setTimeout(() => {
        observer.next(this.students);
      }, 1000);
    });

    return studentsObservable;
  }
}
