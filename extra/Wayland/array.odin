//+build linux, freebsd, openbsd
package wayland

wl_array :: struct {
  size: uint,
  alloc: uint,
  data: rawptr,
}

wl_array_init: proc "c" (array: ^wl_array)
wl_array_release: proc "c" (array: ^wl_array)
wl_array_add: proc "c" (array: ^wl_array, size: uint) -> rawptr
wl_array_copy: proc "c" (array: ^wl_array, source: ^wl_array) -> int
