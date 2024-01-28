//+build linux, freebsd, openbsd
package uikit

import os "core:os"
import wl "extra:Wayland"
import xlib "extra:x11/xlib"
import log "core:log"

waylandLoaded: bool
xlibLoaded: bool

init_display :: proc() {
  v, ok := os.lookup_env("XDG_SESSION_TYPE")
  if ok {
    if v == "wayland" {
      waylandLoaded = wl.wl_global_init()
      if waylandLoaded {
        log.debug("Loaded Wayland")
        return
      }
    }
  }
  xlibLoaded = xlib.xlib_global_init()
  if xlibLoaded {
    log.debug("Loaded Xlib")
  }
}

