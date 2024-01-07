package vendor_gl

import x "vendor:x11/xlib"

when !GL_DEBUG {
  // VERSION_1_4
  XCreateContextAttribsARB :: proc "c" (dpy: ^x.Display, config: GLXFBConfig, share_context: GLXContext, direct: i32, attrib_list: [^]i32) -> GLXContext  { return impl_XCreateContextAttribsARB(dpy, config, share_context, direct, attrib_list) }

  // VERSION_2_1
  XChooseVisual :: proc "c" (dpy: ^x.Display, screen: i32, attribList: [^]i32) -> ^x.XVisualInfo { return impl_XChooseVisual(dpy, screen, attribList) }
  XCreateContext :: proc "c" (dpy: ^x.Display, vis: ^x.XVisualInfo, shareList: GLXContext, direct: i32) -> GLXContext { return impl_XCreateContext(dpy, vis, shareList, direct) }
  XMakeCurrent :: proc "c" (dpy: ^x.Display, drawable: GLXDrawable, ctx: GLXContext) -> u8 { return impl_XMakeCurrent(dpy, drawable, ctx) }
  XSwapBuffers :: proc "c" (dpy: ^x.Display, drawable: GLXDrawable) { impl_XSwapBuffers(dpy, drawable) }
  XDestroyContext :: proc "c" (dpy: ^x.Display, ctx: GLXContext) { impl_XDestroyContext(dpy, ctx) }
  XChooseFBConfig :: proc "c" (dpy: ^x.Display, screen: i32, attrib_list: [^]i32, nelements: ^i32) -> ^GLXFBConfig { return impl_XChooseFBConfig(dpy, screen, attrib_list, nelements) }
  XGetVisualFromFBConfig :: proc "c" (dpy: ^x.Display, config: GLXFBConfig) -> ^x.XVisualInfo { return impl_XGetVisualFromFBConfig(dpy, config) }
  XGetFBConfigAttrib :: proc "c" (dpy: ^x.Display, config: GLXFBConfig, attribute: i32, value: ^i32) -> i32 { return impl_XGetFBConfigAttrib(dpy, config, attribute, value) }
} else {
  // VERSION_1_4
  XCreateContextAttribsARB :: #force_inline proc "c" (dpy: ^x.Display, config: GLXFBConfig, share_context: GLXContext, direct: i32, attrib_list: ^i32, loc := #caller_location) -> GLXContext  {
    r := impl_XCreateContextAttribsARB(dpy, config, share_context, direct, attrib_list)
    debug_helper(loc, 1, r, dpy, config, share_context, direct, attrib_list)
    return r
  }

  // VERSION_2_1
  XChooseVisual :: proc "c" (dpy: ^x.Display, screen: i32, attribList: ^i32, loc := #caller_location) -> ^x.VisualInfo { ret := impl_XChooseVisual(dpy, screen, attribList); debug_helper(loc, 1, ret, dpy, screen, attribList); return ret }
  XCreateContext :: proc "c" (dpy: ^x.Display, vis: ^x.VisualInfo, shareList: GLXContext, direct: x.Bool, loc := #caller_location) -> GLXContext { ret := impl_XCreateContext(dpy, vis, shareList, direct); debug_helper(loc, 1, ret, dpy, vis, shareList, direct); return ret }
  XMakeCurrent :: proc "c" (dpy: ^x.Display, drawable: GLXDrawable, ctx: GLXContext, loc := #caller_location) -> u8 { ret := impl_XMakeCurrent(dpy, drawable, ctx); debug_helper(loc, 1, ret, dpy, drawable, ctx); return ret }
  XSwapBuffers :: proc "c" (dpy: ^x.Display, drawable: GLXDrawable, loc := #caller_location) { impl_XSwapBuffers(dpy, drawable); debug_helper(loc, 0, dpy, drawable) }
  XDestroyContext :: proc "c" (dpy: ^x.Display, ctx: GLXContext, loc := #caller_location) { impl_XDestroyContext(dpy, ctx); debug_helper(loc, 0, dpy, ctx) }
  XChooseFBConfig :: proc "c" (dpy: ^x.Display, screen: i32, attrib_list: ^i32, nelements: ^i32, loc := #caller_location) -> ^GLXFBConfig { ret := impl_XChooseFBConfig(dpy, screen, attrib_list, nelements); debug_helper(loc, 1, ret, dpy, screen, attrib_list, nelements); return ret }
  XGetVisualFromFBConfig :: proc "c" (dpy: ^x.Display, config: GLXFBConfig, loc := #caller_location) -> ^x.VisualInfo { ret := impl_XGetVisualFromFBConfig(dpy, config); debug_helper(loc, 1, ret, dpy, config); return ret }
  XGetFBConfigAttrib :: proc "c" (dpy: ^x.Display, config: GLXFBConfig, attribute: i32, value: ^i32, loc := #caller_location) -> i32 { ret := impl_XGetFBConfigAttrib(dpy, config, attribute, value); debug_helper(loc, 1, ret, dpy, config, attribute, value); return ret }
}