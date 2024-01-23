package main

import "core:fmt"
import "core:log"
import "core:mem"
import dl "core:dynlib"
import "core:os"
import "core:strings"
import "vendor:x11/xlib"
import gl "extra:OpenGL"

glLib: dl.Library
gluLib: dl.Library

load_sym :: proc(p: rawptr, name: cstring) {
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

    visual_attribs := []i32{
      gl.GLX_X_RENDERABLE    , 1,
      gl.GLX_DRAWABLE_TYPE   , gl.GLX_WINDOW_BIT,
      gl.GLX_RENDER_TYPE     , gl.GLX_RGBA_BIT,
      gl.GLX_X_VISUAL_TYPE   , gl.GLX_TRUE_COLOR,
      gl.GLX_RED_SIZE        , 8,
      gl.GLX_GREEN_SIZE      , 8,
      gl.GLX_BLUE_SIZE       , 8,
      gl.GLX_ALPHA_SIZE      , 8,
      gl.GLX_DEPTH_SIZE      , 24,
      gl.GLX_STENCIL_SIZE    , 8,
      gl.GLX_DOUBLEBUFFER    , 1,
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

    fbcount: i32
    fbc := gl.XChooseFBConfig(d, s, raw_data(visual_attribs), &fbcount)
    if fbc == nil {
        log.error("Error in XChooseFBConfig")
        return
    }
    log.infof("Found %d fbconfigs", fbcount)
    fbcs := mem.slice_ptr(fbc, int(fbcount))

    best_fbc : i32 = -1
    best_num_samp : i32 = -1

    for fb, i in fbcs {
        vi1 := gl.XGetVisualFromFBConfig(d, fb)
        if vi1 != nil {
            samp_buf, samples: i32
            gl.XGetFBConfigAttrib(d, fb, gl.GLX_SAMPLE_BUFFERS, &samp_buf)
            gl.XGetFBConfigAttrib(d, fb, gl.GLX_SAMPLES       , &samples)
            if best_fbc < 0 || (samp_buf != 0 && samples > best_num_samp) {
                best_fbc = i32(i)
                best_num_samp = samples
            }
        }
        xlib.XFree(vi1)
    }

    bestFbc := fbcs[best_fbc]

    vi := gl.XGetVisualFromFBConfig(d, bestFbc)
    if vi == nil {
        fmt.println("No appropriate visual found")
        return
    }
    log.debugf("Visual %d selected\n", vi.visualid)
    cmap := xlib.XCreateColormap(d, root, vi.visual, .AllocNone)
    swa := xlib.XSetWindowAttributes{
        colormap = cmap,
        event_mask = { .Exposure, .KeyPress },
    }
    w := xlib.XCreateWindow(d, root, 0, 0, 600, 600, 0, vi.depth, .InputOutput, vi.visual, {.CWColormap, .CWEventMask}, &swa)
    xlib.XMapWindow(d, w)
    xlib.XStoreName(d, w, "VERY SIMPLE APPLICATION")

    glc := gl.XCreateContext(d, vi, nil, 1)
    log.debugf("Created context: %p", glc)
    gl.XMakeCurrent(d, w, glc)
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
            gl.XSwapBuffers(d, w)

        case .KeyPress:
            gl.XMakeCurrent(d, xlib.None, nil)
            gl.XDestroyContext(d, glc)
            xlib.XDestroyWindow(d, w)
            return
        }
    }
}

draw_a_quad :: proc() {
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
   