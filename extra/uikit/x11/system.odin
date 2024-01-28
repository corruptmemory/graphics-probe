package x11

import "extra:x11/xlib"

display: ^xlib.Display
screen: i32
root_window: xlib.Window

Window :: struct {
  window: xlib.Window,
  parent: xlib.Window,
  event: xlib.XEvent,
}


create_window :: proc(
  x:         i32,
  y:         i32,
  width:     u32,
  height:    u32,
  bordersz:  u32,)

// #include <X11/Xlib.h>
// #include <stdio.h>
// #include <stdlib.h>
// #include <string.h>

// int main() {
//     Display *d;
//     int s;
//     Window w;
//     XEvent e;

//     /* Open connection with the X server */
//     d = XOpenDisplay(NULL);
//     if (d == NULL) {
//         fprintf(stderr, "Cannot open display\n");
//         exit(1);
//     }

//     s = DefaultScreen(d);

//     /* Create window */
//     w = XCreateSimpleWindow(d, RootWindow(d, s), 10, 10, 200, 200, 1,
//                             BlackPixel(d, s), WhitePixel(d, s));

//     /* Select kind of events we are interested in */
//     XSelectInput(d, w, ExposureMask | KeyPressMask);

//     /* Map (show) the window */
//     XMapWindow(d, w);

//     /* Event loop */
//     while (1) {
//         XNextEvent(d, &e);
//         /* Draw or redraw the window */
//         if (e.type == Expose) {
//             XFillRectangle(d, w, DefaultGC(d, s), 20, 20, 10, 10);
//         }
//         /* Exit on key press */
//         if (e.type == KeyPress)
//             break;
//     }

//     /* Close connection to server */
//     XCloseDisplay(d);

//     return 0;
// }
