//+build linux, freebsd, openbsd
package wayland

import dl "core:dynlib"

waylandLib: dl.Library
waylandEGLLib: dl.Library
waylandCursorLib: dl.Library

wl_global_init :: proc () -> bool {
  loaded: bool
  waylandLib, loaded = dl.load_library("libwayland-client.so")
  if !loaded {
    return false
  }
  waylandEGLLib, loaded = dl.load_library("libwayland-egl.so")
  if !loaded {
    _ = dl.unload_library(waylandLib)
    return false
  }
  waylandCursorLib, loaded = dl.load_library("libwayland-cursor.so")
  if !loaded {
    _ = dl.unload_library(waylandLib)
    _ = dl.unload_library(waylandEGLLib)
    return false
  }

  wayland_core_protocol_init()
  return true
}