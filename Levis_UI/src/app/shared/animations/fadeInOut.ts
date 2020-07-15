import { trigger, transition, style, animate } from '@angular/animations';


export const fadeInOut = trigger('fadeInOut', [
    transition('void => *', [
        style({
            opacity: 0
        }),
        animate(500, style({
            opacity: 1
        }))
    ]),
    transition('* => void', [
        style({
            opacity: 1
        }),
        animate(500, style({
            opacity: 0
        }))
    ])
]);
