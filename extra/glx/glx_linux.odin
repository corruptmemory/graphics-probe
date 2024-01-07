package glx

import x "vendor:x11/xlib"
import gl "vendor:OpenGL"

GLXContext :: ^struct {}
GLXDrawable :: x.XID

GLXFBConfigRec :: struct {
    visualType: i32,
    transparentType: i32,
                                /*    colors are floats scaled to ints */
    transparentRed, transparentGreen, transparentBlue, transparentAlpha: i32,
    transparentIndex: i32,

    visualCaveat: i32,

    associatedVisualId: i32,
    screen: i32,

    drawableType: i32,
    renderType: i32,

    maxPbufferWidth, maxPbufferHeight, maxPbufferPixels: i32,
    optimalPbufferWidth, optimalPbufferHeight: i32,  /* for SGIX_pbuffer */

    visualSelectGroup: i32,    /* visuals grouped by select priority */

    id: u32,

    rgbMode: u8,
    colorIndexMode: u8,
    doubleBufferMode: u8,
    stereoMode: u8,
    haveAccumBuffer: u8,
    haveDepthBuffer: u8,
    haveStencilBuffer: u8,

    /* The number of bits present in various buffers */
    accumRedBits, accumGreenBits, accumBlueBits, accumAlphaBits: i32,
    depthBits: i32,
    stencilBits: i32,
    indexBits: i32,
    redBits, greenBits, blueBits, alphaBits: i32,
    redMask, greenMask, blueMask, alphaMask: u32,

    multiSampleSize: u32,     /* Number of samples per pixel (0 if no ms) */

    nMultiSampleBuffers: u32, /* Number of available ms buffers */
    maxAuxBuffers: i32,

    /* frame buffer level */
    level: i32,

    /* color ranges (for SGI_color_range) */
    extendedRange: u8,
    minRed, maxRed: f64,
    minGreen, maxGreen: f64,
    minBlue, maxBlue: f64,
    minAlpha, maxAlpha: f64,
}

GLXFBConfig :: ^GLXFBConfigRec

impl_XCreateContextAttribsARB: proc "c" (dpy: ^x.Display, config: GLXFBConfig, share_context: GLXContext, direct: i32, attrib_list: [^]i32) -> GLXContext
impl_XChooseVisual: proc "c" (dpy: ^x.Display, screen: i32, attribList: [^]i32) -> ^x.XVisualInfo
impl_XCreateContext: proc "c" (dpy: ^x.Display, vis: ^x.XVisualInfo, shareList: GLXContext, direct: i32) -> GLXContext
impl_XMakeCurrent: proc "c" (dpy: ^x.Display, drawable: GLXDrawable, ctx: GLXContext) -> u8
impl_XSwapBuffers: proc "c" (dpy: ^x.Display, drawable: GLXDrawable)
impl_XDestroyContext: proc "c" (dpy: ^x.Display, ctx: GLXContext)
impl_XChooseFBConfig: proc "c" (dpy: ^x.Display, screen: i32, attrib_list: [^]i32, nelements: ^i32) -> ^GLXFBConfig
impl_XGetVisualFromFBConfig: proc "c" (dpy: ^x.Display, config: GLXFBConfig) -> ^x.XVisualInfo
impl_XGetFBConfigAttrib: proc "c" (dpy: ^x.Display, config: GLXFBConfig, attribute: i32, value: ^i32) -> i32

load_all_glx :: proc(set_proc_address: gl.Set_Proc_Address_Type) {
    set_proc_address(&impl_XCreateContextAttribsARB, "glXCreateContextAttribsARB")
    set_proc_address(&impl_XChooseVisual, "glXChooseVisual")
    set_proc_address(&impl_XCreateContext, "glXCreateContext")
    set_proc_address(&impl_XMakeCurrent, "glXMakeCurrent")
    set_proc_address(&impl_XSwapBuffers, "glXSwapBuffers")
    set_proc_address(&impl_XDestroyContext, "glXDestroyContext")
    set_proc_address(&impl_XChooseFBConfig, "glXChooseFBConfig")
    set_proc_address(&impl_XGetVisualFromFBConfig, "glXGetVisualFromFBConfig")
    set_proc_address(&impl_XGetFBConfigAttrib, "glXGetFBConfigAttrib")
}

XCreateContextAttribsARB :: proc "c" (dpy: ^x.Display, config: GLXFBConfig, share_context: GLXContext, direct: i32, attrib_list: [^]i32) -> GLXContext  { return impl_XCreateContextAttribsARB(dpy, config, share_context, direct, attrib_list); }
XChooseVisual :: proc "c" (dpy: ^x.Display, screen: i32, attribList: [^]i32) -> ^x.XVisualInfo { return impl_XChooseVisual(dpy, screen, attribList); }
XCreateContext :: proc "c" (dpy: ^x.Display, vis: ^x.XVisualInfo, shareList: GLXContext, direct: i32) -> GLXContext { return impl_XCreateContext(dpy, vis, shareList, direct); }
XMakeCurrent :: proc "c" (dpy: ^x.Display, drawable: GLXDrawable, ctx: GLXContext) -> u8 { return impl_XMakeCurrent(dpy, drawable, ctx); }
XSwapBuffers :: proc "c" (dpy: ^x.Display, drawable: GLXDrawable) { impl_XSwapBuffers(dpy, drawable); }
XDestroyContext :: proc "c" (dpy: ^x.Display, ctx: GLXContext) { impl_XDestroyContext(dpy, ctx); }
XChooseFBConfig :: proc "c" (dpy: ^x.Display, screen: i32, attrib_list: [^]i32, nelements: ^i32) -> ^GLXFBConfig { return impl_XChooseFBConfig(dpy, screen, attrib_list, nelements); }
XGetVisualFromFBConfig :: proc "c" (dpy: ^x.Display, config: GLXFBConfig) -> ^x.XVisualInfo { return impl_XGetVisualFromFBConfig(dpy, config); }
XGetFBConfigAttrib :: proc "c" (dpy: ^x.Display, config: GLXFBConfig, attribute: i32, value: ^i32) -> i32 { return impl_XGetFBConfigAttrib(dpy, config, attribute, value); }
