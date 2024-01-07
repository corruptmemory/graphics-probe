package main

import "core:fmt"
import "core:log"
import dl "core:dynlib"
import "core:os"
import "core:strings"
import "vendor:x11/xlib"
import gl "vendor:OpenGL"
import glx "extra:glx"

glLib: dl.Library
gluLib: dl.Library

load_sym :: proc(p: rawptr, name: cstring) {
    // log.debugf("Loading: %s", string(name));
    n := string(name)
    rp: rawptr
    found: bool
    if strings.has_prefix(n, "glu") {
      rp, found = dl.symbol_address(gluLib, n)
    } else {
      rp, found = dl.symbol_address(glLib, n)
    }
  
    if !found {
      log.errorf("error looking up: %s", n)
    }
    (cast(^rawptr)p)^ = rp
  }
  

main :: proc() {
    logger := log.create_console_logger(lowest = log.Level.Debug)
    context.logger = logger
    loaded: bool
    gwa: xlib.XWindowAttributes
  
    glLib, loaded = dl.load_library("/usr/lib/libGL.so")
    if !loaded {
      log.error("Failed to load OpenGL")
      os.exit(-1)
    }
    log.debug("Woot! Loaded OpenGL")
    defer dl.unload_library(glLib)
  
    gluLib, loaded = dl.load_library("/usr/lib/libGLU.so")
    if !loaded {
      log.error("Failed to load OpenGL Utility lib")
      os.exit(-1)
    }
    log.debug("Woot! Loaded OpenGL Utility")
    defer dl.unload_library(gluLib)
  
    gl.load_up_to(4, 6, load_sym)
    glx.load_all_glx(load_sym)

    att := []i32{gl.RGBA, gl.DEPTH, 24, gl.DOUBLEBUFFER, gl.NONE}
    attribs := []i32{
        gl.GLX_CONTEXT_MAJOR_VERSION_ARB, 4,
        gl.GLX_CONTEXT_MINOR_VERSION_ARB, 6,
        0,
    }
    d := xlib.XOpenDisplay(nil)
    if d == nil {
        fmt.println("Cannot open display")
        return
    }
    defer xlib.XCloseDisplay(d)
    s := xlib.XDefaultScreen(d)
    root := xlib.XDefaultRootWindow(d)
    vi := glx.XChooseVisual(d, s, raw_data(att))
    if vi == nil {
        fmt.println("No appropriate visual found")
        return
    }
    log.debugf("Visual %d selected\n", vi.visualid)
    cmap := xlib.XCreateColormap(d, root, vi.visual, .AllocNone)
    swa := xlib.XSetWindowAttributes{
        colormap = cmap,
        event_mask = {.Exposure, .KeyPress}
    }
    w := xlib.XCreateWindow(d, root, 0, 0, 600, 600, 0, vi.depth, .InputOutput, vi.visual, {.CWColormap, .CWEventMask}, &swa)
    // xlib.XSelectInput(d, w, {.Exposure, .KeyPress})
    xlib.XMapWindow(d, w)
    xlib.XStoreName(d, w, "VERY SIMPLE APPLICATION")

    glc := glx.XCreateContext(d, vi, nil, 1)
    log.debugf("Created context: %p", glc)
    glx.XMakeCurrent(d, w, glc)
    gl.Enable(gl.DEPTH_TEST)
    gl.Enable(gl.DEBUG_OUTPUT)
    for {
        e := xlib.XEvent{}
        xlib.XNextEvent(d, &e)
        #partial switch e.type {
        case .Expose:
            xlib.XGetWindowAttributes(d, w, &gwa)
            gl.Viewport(0, 0, gwa.width, gwa.height)
            draw_a_quad() // function to draw a quad
            glx.XSwapBuffers(d, w)

            xlib.XFillRectangle(d, w, xlib.XDefaultGC(d, s), 20, 20, 10, 10)
        case .KeyPress:
            glx.XMakeCurrent(d, xlib.None, nil)
            glx.XDestroyContext(d, glc)
            xlib.XDestroyWindow(d, w)
            return
        }
    }
}

draw_a_quad :: proc() {
    log.debug("Drawing a quad")
    gl.ClearColor(1.0, 1.0, 1.0, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)

    gl.MatrixMode(gl.PROJECTION)
    gl.LoadIdentity()
    gl.Ortho2D(-1, 1, -1, 1)

    gl.Begin(gl.QUADS)
        gl.Color3f(1., 0., 0.); gl.Vertex2f(-.75, -.75)
        gl.Color3f(0., 1., 0.); gl.Vertex2f( .75, -.75)
        gl.Color3f(0., 0., 1.); gl.Vertex2f( .75,  .75)
        gl.Color3f(1., 1., 0.); gl.Vertex2f(-.75,  .75)
    gl.End()
}
   