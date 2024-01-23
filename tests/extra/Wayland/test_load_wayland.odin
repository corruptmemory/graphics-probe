package test_wayland

import "core:testing"
import wl "extra:Wayland"

@(test)
test_load_wayland :: proc(t: ^testing.T) {
  loaded := wl.wl_global_init()

  expect_value(t, loaded, true)
}