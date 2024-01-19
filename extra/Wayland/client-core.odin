package wayland

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
