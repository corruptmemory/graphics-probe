//+build linux, freebsd, openbsd
package wayland

wl_list :: struct {
  prev: ^wl_list,
  next: ^wl_list,
}

wl_list_init: proc "c" (list: ^wl_list)
wl_list_insert: proc "c" (list: ^wl_list, elm: ^wl_list)
wl_list_remove: proc "c" (elm: ^wl_list)
wl_list_length: proc "c" (list: ^wl_list) -> int
wl_list_empty: proc "c" (list: ^wl_list) -> bool
wl_list_insert_list: proc "c" (list: ^wl_list, other: ^wl_list)

wl_container_of :: #force_inline proc(ptr: ^$T, $U: typeid, $M: string) -> ^U {
    return (^U)(uintptr(ptr)-offset_of_by_string(U, M))
}

wl_next_container_of :: #force_inline proc(ptr: ^wl_list, $U: typeid, $M: string) -> ^U {
  if ptr == nil || ptr.next == nil do return nil
  return wl_container_of(ptr.next,U,M)
}

wl_prev_container_of :: #force_inline proc(ptr: ^wl_list, $U: typeid, $M: string) -> ^U {
  if ptr == nil || ptr.prev == nil do return nil
  return wl_container_of(ptr.prev,U,M)
}
