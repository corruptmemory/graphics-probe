package wayland

import dl "core:dynlib"
import "core:log"

wl_proxy :: struct {}
wl_display :: struct {}

wl_event_queue :: struct {}

WL_MARSHAL_FLAG_DESTROY :: (1 << 0)

wl_event_queue_destroy: proc "c" (queue: ^wl_event_queue)

wl_proxy_marshal_flags: proc "c" (proxy: ^wl_proxy, opcode: u32,
           interface: ^wl_interface,
           version: u32,
           flags: u32,
           args: ..any) -> ^wl_proxy

wl_proxy_marshal_array_flags: proc "c" (proxy: ^wl_proxy, opcode: u32,
           interface: ^wl_interface,
           version: u32,
           flags: u32,
           args: [^]wl_argument) -> ^wl_proxy

wl_proxy_marshal: proc "c" (p: ^wl_proxy, opcode: u32, args: ..any)

wl_proxy_marshal_array: proc "c" (p: ^wl_proxy, opcode: u32, args: [^]wl_argument)

wl_proxy_create: proc "c" (factory: ^wl_proxy, interface: ^wl_interface) -> ^wl_proxy

wl_proxy_create_wrapper: proc "c" (proxy: rawptr) -> rawptr

wl_proxy_wrapper_destroy: proc "c" (proxy_wrapper: rawptr)

wl_proxy_marshal_constructor: proc "c" (proxy: ^wl_proxy,
           opcode: u32,
           interface: ^wl_interface,
           args: ..any) -> ^wl_proxy

wl_proxy_marshal_constructor_versioned: proc "c" (proxy: ^wl_proxy,
               opcode: u32,
               interface: ^wl_interface,
               version: u32,
               args: ..any) -> ^wl_proxy

wl_proxy_marshal_array_constructor: proc "c" (proxy: ^wl_proxy,
           opcode: u32, args: ^wl_argument,
           interface: ^wl_interface) -> ^wl_proxy

wl_proxy_marshal_array_constructor_versioned: proc "c" (proxy: ^wl_proxy,
               opcode: u32,
               args: ^wl_argument,
               interface: ^wl_interface,
               version: u32) -> ^wl_proxy

wl_proxy_destroy: proc "c" (proxy: ^wl_proxy)

wl_proxy_add_listener: proc "c" (proxy: ^wl_proxy,
          implementation: ^^proc(), data: rawptr) -> int

wl_proxy_get_listener: proc "c" (proxy: ^wl_proxy) -> rawptr

wl_proxy_add_dispatcher: proc "c" (proxy: ^wl_proxy,
      dispatcher_func: wl_dispatcher_func_t,
      dispatcher_data: rawptr, data: rawptr) -> int

wl_proxy_set_user_data: proc "c" (proxy: ^wl_proxy, user_data: rawptr)

wl_proxy_get_user_data: proc "c" (proxy: ^wl_proxy) -> rawptr

wl_proxy_get_version: proc "c" (proxy: ^wl_proxy) -> u32

wl_proxy_get_id: proc "c" (proxy: ^wl_proxy) -> u32

wl_proxy_set_tag: proc "c" (proxy: ^wl_proxy, tag: cstring)

wl_proxy_get_tag: proc "c" (proxy: ^wl_proxy) -> cstring

wl_proxy_get_class: proc "c" (proxy: ^wl_proxy) -> cstring

wl_proxy_get_display: proc "c" (proxy: ^wl_proxy) -> ^wl_display

wl_proxy_set_queue: proc "c" (proxy: ^wl_proxy, queue: ^wl_event_queue)

wl_display_connect: proc "c" (name: cstring) -> ^wl_display

wl_display_connect_to_fd: proc "c" (fd: int) -> ^wl_display

wl_display_disconnect: proc "c" (display: ^wl_display)

wl_display_get_fd: proc "c" (display: ^wl_display) -> int

wl_display_dispatch: proc "c" (display: ^wl_display) -> int

wl_display_dispatch_queue: proc "c" (display: ^wl_display,
        queue: ^wl_event_queue) -> int

wl_display_dispatch_queue_pending: proc "c" (display: ^wl_display,
          queue: ^wl_event_queue) -> int

wl_display_dispatch_pending: proc "c" (display: ^wl_display) -> int

wl_display_get_error: proc "c" (display: ^wl_display) -> int

wl_display_get_protocol_error: proc "c" (display: ^wl_display,
            interface: ^^wl_interface,
            id: ^u32) -> u32

wl_display_flush: proc "c" (display: ^wl_display) -> int

wl_display_roundtrip_queue: proc "c" (display: ^wl_display,
         queue: ^wl_event_queue) -> int

wl_display_roundtrip: proc "c" (display: ^wl_display) -> int

wl_display_create_queue: proc "c" (display: ^wl_display) -> ^wl_event_queue

wl_display_prepare_read_queue: proc "c" (display: ^wl_display,
            queue: ^wl_event_queue) -> int

wl_display_prepare_read: proc "c" (display: ^wl_display) -> int

wl_display_cancel_read: proc "c" (display: ^wl_display)

wl_display_read_events: proc "c" (display: ^wl_display) -> int

wl_log_set_handler_client: proc "c" (handler: wl_log_func_t)

wayland_core_protocol_init :: proc() {
  wayland_core_protocol_load_sym(&wl_event_queue_destroy, "wl_event_queue_destroy")
  wayland_core_protocol_load_sym(&wl_proxy_marshal_flags, "wl_proxy_marshal_flags")
  wayland_core_protocol_load_sym(&wl_proxy_marshal_array_flags, "wl_proxy_marshal_array_flags")
  wayland_core_protocol_load_sym(&wl_proxy_marshal, "wl_proxy_marshal")
  wayland_core_protocol_load_sym(&wl_proxy_marshal_array, "wl_proxy_marshal_array")
  wayland_core_protocol_load_sym(&wl_proxy_create, "wl_proxy_create")
  wayland_core_protocol_load_sym(&wl_proxy_create_wrapper, "wl_proxy_create_wrapper")
  wayland_core_protocol_load_sym(&wl_proxy_wrapper_destroy, "wl_proxy_wrapper_destroy")
  wayland_core_protocol_load_sym(&wl_proxy_marshal_constructor, "wl_proxy_marshal_constructor")
  wayland_core_protocol_load_sym(&wl_proxy_marshal_constructor_versioned, "wl_proxy_marshal_constructor_versioned")
  wayland_core_protocol_load_sym(&wl_proxy_marshal_array_constructor, "wl_proxy_marshal_array_constructor")
  wayland_core_protocol_load_sym(&wl_proxy_marshal_array_constructor_versioned, "wl_proxy_marshal_array_constructor_versioned")
  wayland_core_protocol_load_sym(&wl_proxy_destroy, "wl_proxy_destroy")
  wayland_core_protocol_load_sym(&wl_proxy_add_listener, "wl_proxy_add_listener")
  wayland_core_protocol_load_sym(&wl_proxy_get_listener, "wl_proxy_get_listener")
  wayland_core_protocol_load_sym(&wl_proxy_add_dispatcher, "wl_proxy_add_dispatcher")
  wayland_core_protocol_load_sym(&wl_proxy_set_user_data, "wl_proxy_set_user_data")
  wayland_core_protocol_load_sym(&wl_proxy_get_user_data, "wl_proxy_get_user_data")
  wayland_core_protocol_load_sym(&wl_proxy_get_version, "wl_proxy_get_version")
  wayland_core_protocol_load_sym(&wl_proxy_get_id, "wl_proxy_get_id")
  wayland_core_protocol_load_sym(&wl_proxy_set_tag, "wl_proxy_set_tag")
  wayland_core_protocol_load_sym(&wl_proxy_get_tag, "wl_proxy_get_tag")
  wayland_core_protocol_load_sym(&wl_proxy_get_class, "wl_proxy_get_class")
  wayland_core_protocol_load_sym(&wl_proxy_get_display, "wl_proxy_get_display")
  wayland_core_protocol_load_sym(&wl_proxy_set_queue, "wl_proxy_set_queue")
  wayland_core_protocol_load_sym(&wl_display_connect, "wl_display_connect")
  wayland_core_protocol_load_sym(&wl_display_connect_to_fd, "wl_display_connect_to_fd")
  wayland_core_protocol_load_sym(&wl_display_disconnect, "wl_display_disconnect")
  wayland_core_protocol_load_sym(&wl_display_get_fd, "wl_display_get_fd")
  wayland_core_protocol_load_sym(&wl_display_dispatch, "wl_display_dispatch")
  wayland_core_protocol_load_sym(&wl_display_dispatch_queue, "wl_display_dispatch_queue")
  wayland_core_protocol_load_sym(&wl_display_dispatch_queue_pending, "wl_display_dispatch_queue_pending")
  wayland_core_protocol_load_sym(&wl_display_dispatch_pending, "wl_display_dispatch_pending")
  wayland_core_protocol_load_sym(&wl_display_get_error, "wl_display_get_error")
  wayland_core_protocol_load_sym(&wl_display_get_protocol_error, "wl_display_get_protocol_error")
  wayland_core_protocol_load_sym(&wl_display_flush, "wl_display_flush")
  wayland_core_protocol_load_sym(&wl_display_roundtrip_queue, "wl_display_roundtrip_queue")
  wayland_core_protocol_load_sym(&wl_display_roundtrip, "wl_display_roundtrip")
  wayland_core_protocol_load_sym(&wl_display_create_queue, "wl_display_create_queue")
  wayland_core_protocol_load_sym(&wl_display_prepare_read_queue, "wl_display_prepare_read_queue")
  wayland_core_protocol_load_sym(&wl_display_prepare_read, "wl_display_prepare_read")
  wayland_core_protocol_load_sym(&wl_display_cancel_read, "wl_display_cancel_read")
  wayland_core_protocol_load_sym(&wl_display_read_events, "wl_display_read_events")
  wayland_core_protocol_load_sym(&wl_log_set_handler_client, "wl_log_set_handler_client")
}

@(private)
wayland_core_protocol_load_sym :: proc(p: rawptr, name: cstring) {
  n := string(name)
  rp: rawptr
  found: bool
  rp, found = dl.symbol_address(waylandLib, n)

  if !found {
  log.errorf("error looking up: %s", n)
  }
  (cast(^rawptr)p)^ = rp
}
