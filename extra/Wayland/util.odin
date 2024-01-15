package wayland

import "core:c/libc"

wl_object :: struct {}

wl_message :: struct {
  name:      cstring,
  signature: cstring,
  types:     [^]wl_interface,
}

wl_interface :: struct  {
  name: cstring,
  version: i32,
  method_count: i32,
  methods: ^wl_message,
  event_count: i32,
  events: ^wl_message,
}


wl_fixed :: i32

wl_fixed_to_double :: #force_inline proc "c" (f: wl_fixed) -> f64 {
  return auto_cast(f) / 256.0
}

wl_fixed_from_double :: #force_inline proc "c" (d: f64) -> wl_fixed {
  return auto_cast(d * 256.0)
}

wl_fixed_to_int :: #force_inline proc "c" (f: wl_fixed) -> int {
  return auto_cast(f / 256)
}

wl_fixed_from_int :: #force_inline proc "c" (i: int) -> wl_fixed {
  return auto_cast(i * 256)
}

wl_argument :: struct #raw_union {
  i: i32,
  u: u32,
  f: wl_fixed,
  s: cstring,
  o: ^wl_object,
  n: u32,
  a: ^wl_array,
  h: i32,
}

wl_dispatcher_func_t :: proc "c" (user_date: rawptr, target: rawptr, opcode: u32, msg: ^wl_message, args: [^]wl_argument) -> int
wl_log_func_t :: proc "c" (fmt: cstring, args: libc.va_list)

wl_iterator_result :: enum {
  WL_ITERATOR_STOP,
  WL_ITERATOR_CONTINUE,
}

