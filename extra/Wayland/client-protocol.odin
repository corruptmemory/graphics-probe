package wayland

wl_buffer :: struct {}
wl_callback :: struct {}
wl_compositor :: struct {}
wl_data_device :: struct {}
wl_data_device_manager :: struct {}
wl_data_offer :: struct {}
wl_data_source :: struct {}
wl_display :: struct {}
wl_keyboard :: struct {}
wl_output :: struct {}
wl_pointer :: struct {}
wl_region :: struct {}
wl_registry :: struct {}
wl_seat :: struct {}
wl_shell :: struct {}
wl_shell_surface :: struct {}
wl_shm :: struct {}
wl_shm_pool :: struct {}
wl_subcompositor :: struct {}
wl_subsurface :: struct {}
wl_surface :: struct {}
wl_touch :: struct {}

wl_display_interface: wl_interface
wl_registry_interface: wl_interface
wl_callback_interface: wl_interface
wl_compositor_interface: wl_interface
wl_shm_pool_interface: wl_interface
wl_shm_interface: wl_interface
wl_buffer_interface: wl_interface
wl_data_offer_interface: wl_interface
wl_data_source_interface: wl_interface
wl_data_device_interface: wl_interface
wl_data_device_manager_interface: wl_interface
wl_shell_interface: wl_interface
wl_shell_surface_interface: wl_interface
wl_surface_interface: wl_interface
wl_seat_interface: wl_interface
wl_pointer_interface: wl_interface
wl_keyboard_interface: wl_interface
wl_touch_interface: wl_interface
wl_output_interface: wl_interface
wl_region_interface: wl_interface
wl_subcompositor_interface: wl_interface
wl_subsurface_interface: wl_interface

wl_display_error :: enum {
  WL_DISPLAY_ERROR_INVALID_OBJECT = 0,
  WL_DISPLAY_ERROR_INVALID_METHOD = 1,
  WL_DISPLAY_ERROR_NO_MEMORY      = 2,
  WL_DISPLAY_ERROR_IMPLEMENTATION = 3,
}

wl_display_listener :: struct {
  error: proc "c" (data: rawptr, wl_display: ^wl_display, object_id: rawptr, code: u32, message: cstring),
  delete_id: proc "c" (data: rawptr, wl_display: ^wl_display, id: u32),
}

wl_display_add_listener :: #force_inline proc "c" (wl_display: ^wl_display,
      listener: ^wl_display_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_display),(^^proc())(listener),data)
}

WL_DISPLAY_SYNC :: 0
WL_DISPLAY_GET_REGISTRY :: 1
WL_DISPLAY_ERROR_SINCE_VERSION :: 1
WL_DISPLAY_DELETE_ID_SINCE_VERSION :: 1
WL_DISPLAY_SYNC_SINCE_VERSION :: 1
WL_DISPLAY_GET_REGISTRY_SINCE_VERSION :: 1

wl_display_set_user_data :: #force_inline proc "c" (wl_display: ^wl_display, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_display), user_data)
}

wl_display_get_user_data :: #force_inline proc "c" (wl_display: ^wl_display) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_display))
}

wl_display_get_version :: #force_inline proc "c" (wl_display: ^wl_display) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_display))
}

wl_display_sync :: #force_inline proc "c" (wl_display: ^wl_display) -> ^wl_callback {
  callback := wl_proxy_marshal_flags((^wl_proxy)(wl_display),
       WL_DISPLAY_SYNC, &wl_callback_interface, wl_proxy_get_version((^wl_proxy)(wl_display)), 0, nil)

  return (^wl_callback)(callback)
}

wl_display_get_registry :: #force_inline proc "c" (wl_display: ^wl_display) -> ^wl_registry {
  registry := wl_proxy_marshal_flags((^wl_proxy)(wl_display),
       WL_DISPLAY_GET_REGISTRY, &wl_registry_interface, wl_proxy_get_version((^wl_proxy)(wl_display)), 0, nil)

  return (^wl_registry)(registry)
}

wl_registry_listener :: struct {
  global: proc "c" (data: rawptr, wl_registry: ^wl_registry, name: u32, interface: cstring, version: u32)
  global_remove: proc "c" (data: rawptr, wl_registry: ^wl_registry, name: u32)
}

wl_registry_add_listener :: #force_inline proc "c" (wl_registry: ^wl_registry,
       listener: ^wl_registry_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_registry),
             (^^proc())(listener), data)
}

WL_REGISTRY_BIND :: 0
WL_REGISTRY_GLOBAL_SINCE_VERSION :: 1
WL_REGISTRY_GLOBAL_REMOVE_SINCE_VERSION :: 1
WL_REGISTRY_BIND_SINCE_VERSION :: 1

wl_registry_set_user_data :: #force_inline proc "c" (wl_registry: ^wl_registry, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_registry), user_data)
}

wl_registry_get_user_data :: #force_inline proc "c" (wl_registry: ^wl_registry) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_registry))
}

wl_registry_get_version :: #force_inline proc "c" (wl_registry: ^wl_registry) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_registry))
}

wl_registry_destroy :: #force_inline proc "c" (wl_registry: ^wl_registry) {
  wl_proxy_destroy((^wl_proxy)(wl_registry))
}

wl_registry_bind :: #force_inline proc "c" (wl_registry: ^wl_registry, name: u32, interface: ^wl_interface, version: u32) -> rawptr {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_registry),
       WL_REGISTRY_BIND, interface, version, 0, name, interface->name, version, nil)

  return (rawptr)(id)
}

wl_callback_listener :: struct {
  done: proc "c" (data: rawptr, wl_callback: ^wl_callback, callback_data: u32),
}

wl_callback_add_listener :: #force_inline proc "c" (wl_callback: ^wl_callback,
       listener: ^wl_callback_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_callback),
             (^^proc())(listener), data)
}

WL_CALLBACK_DONE_SINCE_VERSION :: 1


wl_callback_set_user_data :: #force_inline proc "c" (wl_callback: ^wl_callback, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_callback), user_data)
}

wl_callback_get_user_data :: #force_inline proc "c" (wl_callback: ^wl_callback) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_callback))
}

wl_callback_get_version :: #force_inline proc "c" (wl_callback: ^wl_callback) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_callback))
}

wl_callback_destroy :: #force_inline proc "c" (wl_callback: ^wl_callback) {
  wl_proxy_destroy((^wl_proxy)(wl_callback))
}

WL_COMPOSITOR_CREATE_SURFACE :: 0
WL_COMPOSITOR_CREATE_REGION :: 1
WL_COMPOSITOR_CREATE_SURFACE_SINCE_VERSION :: 1
WL_COMPOSITOR_CREATE_REGION_SINCE_VERSION :: 1

wl_compositor_set_user_data :: #force_inline proc "c" (wl_compositor: ^wl_compositor, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_compositor), user_data)
}

wl_compositor_get_user_data :: #force_inline proc "c" (wl_compositor: ^wl_compositor) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_compositor))
}

wl_compositor_get_version :: #force_inline proc "c" (wl_compositor: ^wl_compositor) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_compositor))
}

wl_compositor_destroy :: #force_inline proc "c" (wl_compositor: ^wl_compositor) {
  wl_proxy_destroy((^wl_proxy)(wl_compositor))
}

wl_compositor_create_surface :: #force_inline proc "c" (wl_compositor: ^wl_compositor) -> ^wl_surface {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_compositor),
       WL_COMPOSITOR_CREATE_SURFACE, &wl_surface_interface, wl_proxy_get_version((^wl_proxy)(wl_compositor)), 0, nil)

  return (^wl_surface)(id)
}

wl_compositor_create_region :: #force_inline proc "c" (wl_compositor: ^wl_compositor) -> ^wl_region {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_compositor),
       WL_COMPOSITOR_CREATE_REGION, &wl_region_interface, wl_proxy_get_version((^wl_proxy)(wl_compositor)), 0, nil)

  return (^wl_region)(id)
}

WL_SHM_POOL_CREATE_BUFFER :: 0
WL_SHM_POOL_DESTROY :: 1
WL_SHM_POOL_RESIZE :: 2
WL_SHM_POOL_CREATE_BUFFER_SINCE_VERSION :: 1
WL_SHM_POOL_DESTROY_SINCE_VERSION :: 1
WL_SHM_POOL_RESIZE_SINCE_VERSION :: 1

wl_shm_pool_set_user_data :: #force_inline proc "c" (wl_shm_pool: ^wl_shm_pool, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_shm_pool), user_data)
}

wl_shm_pool_get_user_data :: #force_inline proc "c" (wl_shm_pool: ^wl_shm_pool) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_shm_pool))
}

wl_shm_pool_get_version :: #force_inline proc "c" (wl_shm_pool: ^wl_shm_pool) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_shm_pool))
}

wl_shm_pool_create_buffer :: #force_inline proc "c" (wl_shm_pool: ^wl_shm_pool, offset: i32, width: i32, height: i32, stride: i32, format: u32) -> ^wl_buffer {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_shm_pool),
       WL_SHM_POOL_CREATE_BUFFER, &wl_buffer_interface, wl_proxy_get_version((^wl_proxy)(wl_shm_pool)), 0, nil, offset, width, height, stride, format)

  return (^wl_buffer)(id)
}

wl_shm_pool_destroy :: #force_inline proc "c" (wl_shm_pool: ^wl_shm_pool) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shm_pool),
       WL_SHM_POOL_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_shm_pool)), WL_MARSHAL_FLAG_DESTROY)
}

wl_shm_pool_resize :: #force_inline proc "c" (wl_shm_pool: ^wl_shm_pool, size: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shm_pool),
       WL_SHM_POOL_RESIZE, nil, wl_proxy_get_version((^wl_proxy)(wl_shm_pool)), 0, size)
}

wl_shm_error :: enum {
  /**
   * buffer format is not known
   */
  WL_SHM_ERROR_INVALID_FORMAT = 0,
  /**
   * invalid size or stride during pool or buffer creation
   */
  WL_SHM_ERROR_INVALID_STRIDE = 1,
  /**
   * mmapping the file descriptor failed
   */
  WL_SHM_ERROR_INVALID_FD = 2,
}

wl_shm_format :: enum {
  /**
   * 32-bit ARGB format, [31:0] A:R:G:B 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_ARGB8888 = 0,
  /**
   * 32-bit RGB format, [31:0] x:R:G:B 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_XRGB8888 = 1,
  /**
   * 8-bit color index format, [7:0] C
   */
  WL_SHM_FORMAT_C8 = 0x20203843,
  /**
   * 8-bit RGB format, [7:0] R:G:B 3:3:2
   */
  WL_SHM_FORMAT_RGB332 = 0x38424752,
  /**
   * 8-bit BGR format, [7:0] B:G:R 2:3:3
   */
  WL_SHM_FORMAT_BGR233 = 0x38524742,
  /**
   * 16-bit xRGB format, [15:0] x:R:G:B 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_XRGB4444 = 0x32315258,
  /**
   * 16-bit xBGR format, [15:0] x:B:G:R 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_XBGR4444 = 0x32314258,
  /**
   * 16-bit RGBx format, [15:0] R:G:B:x 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_RGBX4444 = 0x32315852,
  /**
   * 16-bit BGRx format, [15:0] B:G:R:x 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_BGRX4444 = 0x32315842,
  /**
   * 16-bit ARGB format, [15:0] A:R:G:B 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_ARGB4444 = 0x32315241,
  /**
   * 16-bit ABGR format, [15:0] A:B:G:R 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_ABGR4444 = 0x32314241,
  /**
   * 16-bit RBGA format, [15:0] R:G:B:A 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_RGBA4444 = 0x32314152,
  /**
   * 16-bit BGRA format, [15:0] B:G:R:A 4:4:4:4 little endian
   */
  WL_SHM_FORMAT_BGRA4444 = 0x32314142,
  /**
   * 16-bit xRGB format, [15:0] x:R:G:B 1:5:5:5 little endian
   */
  WL_SHM_FORMAT_XRGB1555 = 0x35315258,
  /**
   * 16-bit xBGR 1555 format, [15:0] x:B:G:R 1:5:5:5 little endian
   */
  WL_SHM_FORMAT_XBGR1555 = 0x35314258,
  /**
   * 16-bit RGBx 5551 format, [15:0] R:G:B:x 5:5:5:1 little endian
   */
  WL_SHM_FORMAT_RGBX5551 = 0x35315852,
  /**
   * 16-bit BGRx 5551 format, [15:0] B:G:R:x 5:5:5:1 little endian
   */
  WL_SHM_FORMAT_BGRX5551 = 0x35315842,
  /**
   * 16-bit ARGB 1555 format, [15:0] A:R:G:B 1:5:5:5 little endian
   */
  WL_SHM_FORMAT_ARGB1555 = 0x35315241,
  /**
   * 16-bit ABGR 1555 format, [15:0] A:B:G:R 1:5:5:5 little endian
   */
  WL_SHM_FORMAT_ABGR1555 = 0x35314241,
  /**
   * 16-bit RGBA 5551 format, [15:0] R:G:B:A 5:5:5:1 little endian
   */
  WL_SHM_FORMAT_RGBA5551 = 0x35314152,
  /**
   * 16-bit BGRA 5551 format, [15:0] B:G:R:A 5:5:5:1 little endian
   */
  WL_SHM_FORMAT_BGRA5551 = 0x35314142,
  /**
   * 16-bit RGB 565 format, [15:0] R:G:B 5:6:5 little endian
   */
  WL_SHM_FORMAT_RGB565 = 0x36314752,
  /**
   * 16-bit BGR 565 format, [15:0] B:G:R 5:6:5 little endian
   */
  WL_SHM_FORMAT_BGR565 = 0x36314742,
  /**
   * 24-bit RGB format, [23:0] R:G:B little endian
   */
  WL_SHM_FORMAT_RGB888 = 0x34324752,
  /**
   * 24-bit BGR format, [23:0] B:G:R little endian
   */
  WL_SHM_FORMAT_BGR888 = 0x34324742,
  /**
   * 32-bit xBGR format, [31:0] x:B:G:R 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_XBGR8888 = 0x34324258,
  /**
   * 32-bit RGBx format, [31:0] R:G:B:x 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_RGBX8888 = 0x34325852,
  /**
   * 32-bit BGRx format, [31:0] B:G:R:x 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_BGRX8888 = 0x34325842,
  /**
   * 32-bit ABGR format, [31:0] A:B:G:R 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_ABGR8888 = 0x34324241,
  /**
   * 32-bit RGBA format, [31:0] R:G:B:A 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_RGBA8888 = 0x34324152,
  /**
   * 32-bit BGRA format, [31:0] B:G:R:A 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_BGRA8888 = 0x34324142,
  /**
   * 32-bit xRGB format, [31:0] x:R:G:B 2:10:10:10 little endian
   */
  WL_SHM_FORMAT_XRGB2101010 = 0x30335258,
  /**
   * 32-bit xBGR format, [31:0] x:B:G:R 2:10:10:10 little endian
   */
  WL_SHM_FORMAT_XBGR2101010 = 0x30334258,
  /**
   * 32-bit RGBx format, [31:0] R:G:B:x 10:10:10:2 little endian
   */
  WL_SHM_FORMAT_RGBX1010102 = 0x30335852,
  /**
   * 32-bit BGRx format, [31:0] B:G:R:x 10:10:10:2 little endian
   */
  WL_SHM_FORMAT_BGRX1010102 = 0x30335842,
  /**
   * 32-bit ARGB format, [31:0] A:R:G:B 2:10:10:10 little endian
   */
  WL_SHM_FORMAT_ARGB2101010 = 0x30335241,
  /**
   * 32-bit ABGR format, [31:0] A:B:G:R 2:10:10:10 little endian
   */
  WL_SHM_FORMAT_ABGR2101010 = 0x30334241,
  /**
   * 32-bit RGBA format, [31:0] R:G:B:A 10:10:10:2 little endian
   */
  WL_SHM_FORMAT_RGBA1010102 = 0x30334152,
  /**
   * 32-bit BGRA format, [31:0] B:G:R:A 10:10:10:2 little endian
   */
  WL_SHM_FORMAT_BGRA1010102 = 0x30334142,
  /**
   * packed YCbCr format, [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_YUYV = 0x56595559,
  /**
   * packed YCbCr format, [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_YVYU = 0x55595659,
  /**
   * packed YCbCr format, [31:0] Y1:Cr0:Y0:Cb0 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_UYVY = 0x59565955,
  /**
   * packed YCbCr format, [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_VYUY = 0x59555956,
  /**
   * packed AYCbCr format, [31:0] A:Y:Cb:Cr 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_AYUV = 0x56555941,
  /**
   * 2 plane YCbCr Cr:Cb format, 2x2 subsampled Cr:Cb plane
   */
  WL_SHM_FORMAT_NV12 = 0x3231564e,
  /**
   * 2 plane YCbCr Cb:Cr format, 2x2 subsampled Cb:Cr plane
   */
  WL_SHM_FORMAT_NV21 = 0x3132564e,
  /**
   * 2 plane YCbCr Cr:Cb format, 2x1 subsampled Cr:Cb plane
   */
  WL_SHM_FORMAT_NV16 = 0x3631564e,
  /**
   * 2 plane YCbCr Cb:Cr format, 2x1 subsampled Cb:Cr plane
   */
  WL_SHM_FORMAT_NV61 = 0x3136564e,
  /**
   * 3 plane YCbCr format, 4x4 subsampled Cb (1) and Cr (2) planes
   */
  WL_SHM_FORMAT_YUV410 = 0x39565559,
  /**
   * 3 plane YCbCr format, 4x4 subsampled Cr (1) and Cb (2) planes
   */
  WL_SHM_FORMAT_YVU410 = 0x39555659,
  /**
   * 3 plane YCbCr format, 4x1 subsampled Cb (1) and Cr (2) planes
   */
  WL_SHM_FORMAT_YUV411 = 0x31315559,
  /**
   * 3 plane YCbCr format, 4x1 subsampled Cr (1) and Cb (2) planes
   */
  WL_SHM_FORMAT_YVU411 = 0x31315659,
  /**
   * 3 plane YCbCr format, 2x2 subsampled Cb (1) and Cr (2) planes
   */
  WL_SHM_FORMAT_YUV420 = 0x32315559,
  /**
   * 3 plane YCbCr format, 2x2 subsampled Cr (1) and Cb (2) planes
   */
  WL_SHM_FORMAT_YVU420 = 0x32315659,
  /**
   * 3 plane YCbCr format, 2x1 subsampled Cb (1) and Cr (2) planes
   */
  WL_SHM_FORMAT_YUV422 = 0x36315559,
  /**
   * 3 plane YCbCr format, 2x1 subsampled Cr (1) and Cb (2) planes
   */
  WL_SHM_FORMAT_YVU422 = 0x36315659,
  /**
   * 3 plane YCbCr format, non-subsampled Cb (1) and Cr (2) planes
   */
  WL_SHM_FORMAT_YUV444 = 0x34325559,
  /**
   * 3 plane YCbCr format, non-subsampled Cr (1) and Cb (2) planes
   */
  WL_SHM_FORMAT_YVU444 = 0x34325659,
  /**
   * [7:0] R
   */
  WL_SHM_FORMAT_R8 = 0x20203852,
  /**
   * [15:0] R little endian
   */
  WL_SHM_FORMAT_R16 = 0x20363152,
  /**
   * [15:0] R:G 8:8 little endian
   */
  WL_SHM_FORMAT_RG88 = 0x38384752,
  /**
   * [15:0] G:R 8:8 little endian
   */
  WL_SHM_FORMAT_GR88 = 0x38385247,
  /**
   * [31:0] R:G 16:16 little endian
   */
  WL_SHM_FORMAT_RG1616 = 0x32334752,
  /**
   * [31:0] G:R 16:16 little endian
   */
  WL_SHM_FORMAT_GR1616 = 0x32335247,
  /**
   * [63:0] x:R:G:B 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_XRGB16161616F = 0x48345258,
  /**
   * [63:0] x:B:G:R 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_XBGR16161616F = 0x48344258,
  /**
   * [63:0] A:R:G:B 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_ARGB16161616F = 0x48345241,
  /**
   * [63:0] A:B:G:R 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_ABGR16161616F = 0x48344241,
  /**
   * [31:0] X:Y:Cb:Cr 8:8:8:8 little endian
   */
  WL_SHM_FORMAT_XYUV8888 = 0x56555958,
  /**
   * [23:0] Cr:Cb:Y 8:8:8 little endian
   */
  WL_SHM_FORMAT_VUY888 = 0x34325556,
  /**
   * Y followed by U then V, 10:10:10. Non-linear modifier only
   */
  WL_SHM_FORMAT_VUY101010 = 0x30335556,
  /**
   * [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian per 2 Y pixels
   */
  WL_SHM_FORMAT_Y210 = 0x30313259,
  /**
   * [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 12:4:12:4:12:4:12:4 little endian per 2 Y pixels
   */
  WL_SHM_FORMAT_Y212 = 0x32313259,
  /**
   * [63:0] Cr0:Y1:Cb0:Y0 16:16:16:16 little endian per 2 Y pixels
   */
  WL_SHM_FORMAT_Y216 = 0x36313259,
  /**
   * [31:0] A:Cr:Y:Cb 2:10:10:10 little endian
   */
  WL_SHM_FORMAT_Y410 = 0x30313459,
  /**
   * [63:0] A:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian
   */
  WL_SHM_FORMAT_Y412 = 0x32313459,
  /**
   * [63:0] A:Cr:Y:Cb 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_Y416 = 0x36313459,
  /**
   * [31:0] X:Cr:Y:Cb 2:10:10:10 little endian
   */
  WL_SHM_FORMAT_XVYU2101010 = 0x30335658,
  /**
   * [63:0] X:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian
   */
  WL_SHM_FORMAT_XVYU12_16161616 = 0x36335658,
  /**
   * [63:0] X:Cr:Y:Cb 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_XVYU16161616 = 0x38345658,
  /**
   * [63:0]   A3:A2:Y3:0:Cr0:0:Y2:0:A1:A0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian
   */
  WL_SHM_FORMAT_Y0L0 = 0x304c3059,
  /**
   * [63:0]   X3:X2:Y3:0:Cr0:0:Y2:0:X1:X0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian
   */
  WL_SHM_FORMAT_X0L0 = 0x304c3058,
  /**
   * [63:0]   A3:A2:Y3:Cr0:Y2:A1:A0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian
   */
  WL_SHM_FORMAT_Y0L2 = 0x324c3059,
  /**
   * [63:0]   X3:X2:Y3:Cr0:Y2:X1:X0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian
   */
  WL_SHM_FORMAT_X0L2 = 0x324c3058,
  WL_SHM_FORMAT_YUV420_8BIT = 0x38305559,
  WL_SHM_FORMAT_YUV420_10BIT = 0x30315559,
  WL_SHM_FORMAT_XRGB8888_A8 = 0x38415258,
  WL_SHM_FORMAT_XBGR8888_A8 = 0x38414258,
  WL_SHM_FORMAT_RGBX8888_A8 = 0x38415852,
  WL_SHM_FORMAT_BGRX8888_A8 = 0x38415842,
  WL_SHM_FORMAT_RGB888_A8 = 0x38413852,
  WL_SHM_FORMAT_BGR888_A8 = 0x38413842,
  WL_SHM_FORMAT_RGB565_A8 = 0x38413552,
  WL_SHM_FORMAT_BGR565_A8 = 0x38413542,
  /**
   * non-subsampled Cr:Cb plane
   */
  WL_SHM_FORMAT_NV24 = 0x3432564e,
  /**
   * non-subsampled Cb:Cr plane
   */
  WL_SHM_FORMAT_NV42 = 0x3234564e,
  /**
   * 2x1 subsampled Cr:Cb plane, 10 bit per channel
   */
  WL_SHM_FORMAT_P210 = 0x30313250,
  /**
   * 2x2 subsampled Cr:Cb plane 10 bits per channel
   */
  WL_SHM_FORMAT_P010 = 0x30313050,
  /**
   * 2x2 subsampled Cr:Cb plane 12 bits per channel
   */
  WL_SHM_FORMAT_P012 = 0x32313050,
  /**
   * 2x2 subsampled Cr:Cb plane 16 bits per channel
   */
  WL_SHM_FORMAT_P016 = 0x36313050,
  /**
   * [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian
   */
  WL_SHM_FORMAT_AXBXGXRX106106106106 = 0x30314241,
  /**
   * 2x2 subsampled Cr:Cb plane
   */
  WL_SHM_FORMAT_NV15 = 0x3531564e,
  WL_SHM_FORMAT_Q410 = 0x30313451,
  WL_SHM_FORMAT_Q401 = 0x31303451,
  /**
   * [63:0] x:R:G:B 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_XRGB16161616 = 0x38345258,
  /**
   * [63:0] x:B:G:R 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_XBGR16161616 = 0x38344258,
  /**
   * [63:0] A:R:G:B 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_ARGB16161616 = 0x38345241,
  /**
   * [63:0] A:B:G:R 16:16:16:16 little endian
   */
  WL_SHM_FORMAT_ABGR16161616 = 0x38344241,
}

wl_shm_listener :: struct  {
  format: proc "c" (data: rawptr, wl_shm: ^wl_shm, format: u32),
}

wl_shm_add_listener :: #force_inline proc "c" (wl_shm: ^wl_shm,
        listener: ^wl_shm_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_shm),
             (^^proc())(listener), data)
}

WL_SHM_CREATE_POOL :: 0
WL_SHM_FORMAT_SINCE_VERSION :: 1
WL_SHM_CREATE_POOL_SINCE_VERSION :: 1

/** @ingroup iface_wl_shm */
wl_shm_set_user_data :: #force_inline proc "c" (wl_shm: ^wl_shm, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_shm), user_data)
}

wl_shm_get_user_data :: #force_inline proc "c" (wl_shm: ^wl_shm) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_shm))
}

wl_shm_get_version :: #force_inline proc "c" (wl_shm: ^wl_shm) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_shm))
}

wl_shm_destroy :: #force_inline proc "c" (wl_shm: ^wl_shm) {
  wl_proxy_destroy((^wl_proxy)(wl_shm))
}

wl_shm_create_pool :: #force_inline proc "c" (wl_shm: ^wl_shm, fd: i32, size: i32) -> ^wl_shm_pool {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_shm),
       WL_SHM_CREATE_POOL, &wl_shm_pool_interface, wl_proxy_get_version((^wl_proxy)(wl_shm)), 0, nil, fd, size)

  return (^wl_shm_pool)(id)
}

wl_buffer_listener :: struct {
  release: proc "c" (data: rawptr, wl_buffer: ^wl_buffer),
}

wl_buffer_add_listener :: #force_inline proc "c" (wl_buffer: ^wl_buffer,
           listener: ^wl_buffer_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_buffer),
             (^^proc())(listener), data)
}

WL_BUFFER_DESTROY :: 0
WL_BUFFER_RELEASE_SINCE_VERSION :: 1
WL_BUFFER_DESTROY_SINCE_VERSION :: 1

wl_buffer_set_user_data :: #force_inline proc "c" (wl_buffer: ^wl_buffer, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_buffer), user_data)
}

wl_buffer_get_user_data :: #force_inline proc "c" (wl_buffer: ^wl_buffer) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_buffer))
}

wl_buffer_get_version :: #force_inline proc "c" (wl_buffer: ^wl_buffer) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_buffer))
}

wl_buffer_destroy :: #force_inline proc "c" (wl_buffer: ^wl_buffer) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_buffer),
       WL_BUFFER_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_buffer)), WL_MARSHAL_FLAG_DESTROY)
}

wl_data_offer_error :: enum {
  /**
   * finish request was called untimely
   */
  WL_DATA_OFFER_ERROR_INVALID_FINISH = 0,
  /**
   * action mask contains invalid values
   */
  WL_DATA_OFFER_ERROR_INVALID_ACTION_MASK = 1,
  /**
   * action argument has an invalid value
   */
  WL_DATA_OFFER_ERROR_INVALID_ACTION = 2,
  /**
   * offer doesn't accept this request
   */
  WL_DATA_OFFER_ERROR_INVALID_OFFER = 3,
}

wl_data_offer_listener :: struct {
  offer: proc "c" (data: rawptr, wl_data_offer: ^wl_data_offer, mime_type: cstring),
  source_actions: proc "c" (data: rawptr, wl_data_offer: ^wl_data_offer, source_actions: u32),
  action: proc "c" (data: rawptr, wl_data_offer: ^wl_data_offer, dnd_action: u32),
}

wl_data_offer_add_listener :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer,
         listener: ^wl_data_offer_listener, data: rawptr) -> int
{
  return wl_proxy_add_listener((^wl_proxy)(wl_data_offer),
             (^^proc())(listener), data)
}

WL_DATA_OFFER_ACCEPT :: 0
WL_DATA_OFFER_RECEIVE :: 1
WL_DATA_OFFER_DESTROY :: 2
WL_DATA_OFFER_FINISH :: 3
WL_DATA_OFFER_SET_ACTIONS :: 4
WL_DATA_OFFER_OFFER_SINCE_VERSION :: 1
WL_DATA_OFFER_SOURCE_ACTIONS_SINCE_VERSION :: 3
WL_DATA_OFFER_ACTION_SINCE_VERSION :: 3
WL_DATA_OFFER_ACCEPT_SINCE_VERSION :: 1
WL_DATA_OFFER_RECEIVE_SINCE_VERSION :: 1
WL_DATA_OFFER_DESTROY_SINCE_VERSION :: 1
WL_DATA_OFFER_FINISH_SINCE_VERSION :: 3
WL_DATA_OFFER_SET_ACTIONS_SINCE_VERSION :: 3

/** @ingroup iface_wl_data_offer */

wl_data_offer_set_user_data :: #force_inline proc "c"(wl_data_offer: ^wl_data_offer, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_data_offer), user_data)
}

/** @ingroup iface_wl_data_offer */
wl_data_offer_get_user_data :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_data_offer))
}

wl_data_offer_get_version :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_data_offer))
}

wl_data_offer_accept :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer, serial: u32, mime_type: cstring) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_offer),
       WL_DATA_OFFER_ACCEPT, nil, wl_proxy_get_version((^wl_proxy)(wl_data_offer)), 0, serial, mime_type)
}

wl_data_offer_receive :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer, mime_type: cstring, fd: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_offer),
       WL_DATA_OFFER_RECEIVE, nil, wl_proxy_get_version((^wl_proxy)(wl_data_offer)), 0, mime_type, fd)
}

wl_data_offer_destroy :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_offer),
       WL_DATA_OFFER_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_data_offer)), WL_MARSHAL_FLAG_DESTROY)
}

wl_data_offer_finish :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_offer),
       WL_DATA_OFFER_FINISH, nil, wl_proxy_get_version((^wl_proxy)(wl_data_offer)), 0)
}

wl_data_offer_set_actions :: #force_inline proc "c" (wl_data_offer: ^wl_data_offer, dnd_actions: u32, preferred_action: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_offer),
       WL_DATA_OFFER_SET_ACTIONS, nil, wl_proxy_get_version((^wl_proxy)(wl_data_offer)), 0, dnd_actions, preferred_action)
}

wl_data_source_error :: enum {
  /**
   * action mask contains invalid values
   */
  WL_DATA_SOURCE_ERROR_INVALID_ACTION_MASK = 0,
  /**
   * source doesn't accept this request
   */
  WL_DATA_SOURCE_ERROR_INVALID_SOURCE = 1,
}

wl_data_source_listener :: struct {
  target: proc "c" (data: rawptr, wl_data_source: ^wl_data_source, mime_type: cstring),
  send: proc "c" (data: rawptr, wl_data_source: ^wl_data_source, mime_type: cstring, fd: i32),
  cancelled: proc "c" (data: rawptr, wl_data_source: ^wl_data_source),
  dnd_performed: proc "c" (data: rawptr, wl_data_source: ^wl_data_source),
  dnd_finished: proc "c" (data: rawptr, wl_data_source: ^wl_data_source),
  action: proc "c" (data: rawptr, wl_data_source: ^wl_data_source, dnd_action: u32),
}

wl_data_source_add_listener :: #force_inline proc "c" (wl_data_source: ^wl_data_source,
          listener: ^wl_data_source_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_data_source),
             (^^proc())(listener), data)
}

WL_DATA_SOURCE_OFFER :: 0
WL_DATA_SOURCE_DESTROY :: 1
WL_DATA_SOURCE_SET_ACTIONS :: 2
WL_DATA_SOURCE_TARGET_SINCE_VERSION :: 1
WL_DATA_SOURCE_SEND_SINCE_VERSION :: 1
WL_DATA_SOURCE_CANCELLED_SINCE_VERSION :: 1
WL_DATA_SOURCE_DND_DROP_PERFORMED_SINCE_VERSION :: 3
WL_DATA_SOURCE_DND_FINISHED_SINCE_VERSION :: 3
WL_DATA_SOURCE_ACTION_SINCE_VERSION :: 3
WL_DATA_SOURCE_OFFER_SINCE_VERSION :: 1
WL_DATA_SOURCE_DESTROY_SINCE_VERSION :: 1
WL_DATA_SOURCE_SET_ACTIONS_SINCE_VERSION :: 3

wl_data_source_set_user_data :: #force_inline proc "c" (wl_data_source: ^wl_data_source, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_data_source), user_data)
}

wl_data_source_get_user_data :: #force_inline proc "c" (wl_data_source: ^wl_data_source) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_data_source))
}

wl_data_source_get_version :: #force_inline proc "c" (wl_data_source: ^wl_data_source) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_data_source))
}

wl_data_source_offer :: #force_inline proc "c" (wl_data_source: ^wl_data_source, mime_type: cstring) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_source),
       WL_DATA_SOURCE_OFFER, nil, wl_proxy_get_version((^wl_proxy)(wl_data_source)), 0, mime_type)
}


wl_data_source_destroy :: #force_inline proc "c" (wl_data_source: ^wl_data_source) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_source),
       WL_DATA_SOURCE_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_data_source)), WL_MARSHAL_FLAG_DESTROY)
}

wl_data_source_set_actions :: #force_inline proc "c" (wl_data_source: ^wl_data_source, dnd_actions: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_source),
       WL_DATA_SOURCE_SET_ACTIONS, nil, wl_proxy_get_version((^wl_proxy)(wl_data_source)), 0, dnd_actions)
}

wl_data_device_error :: enum {
  WL_DATA_DEVICE_ERROR_ROLE = 0,
}

wl_data_device_listener :: struct {
  data_offer: proc "c" (data: rawptr, wl_data_device: ^wl_data_device, id: ^wl_data_offer),
  enter: proc "c" (data: rawptr, wl_data_device: ^wl_data_device, serial: u32, surface: ^wl_surface, x: wl_fixed_t, y: wl_fixed_t, id: ^wl_data_offer),
  leave: proc "c" (data: rawptr, wl_data_device: ^wl_data_device),
  motion: proc "c" (data: rawptr, wl_data_device: ^wl_data_device, time: u32, x: wl_fixed_t, y: wl_fixed_t),
  drop: proc "c" (data: rawptr, wl_data_device: ^wl_data_device),
  selection: proc "c" (data: rawptr, wl_data_device: ^wl_data_device, id: ^wl_data_offer),
}

wl_data_device_add_listener :: #force_inline proc "c" (wl_data_device: ^wl_data_device,
          listener: ^wl_data_device_listener, data: rawptr) -> int  {
  return wl_proxy_add_listener((^wl_proxy)(wl_data_device),
             (^^proc())(listener), data)
}

WL_DATA_DEVICE_START_DRAG :: 0
WL_DATA_DEVICE_SET_SELECTION :: 1
WL_DATA_DEVICE_RELEASE :: 2
WL_DATA_DEVICE_DATA_OFFER_SINCE_VERSION :: 1
WL_DATA_DEVICE_ENTER_SINCE_VERSION :: 1
WL_DATA_DEVICE_LEAVE_SINCE_VERSION :: 1
WL_DATA_DEVICE_MOTION_SINCE_VERSION :: 1
WL_DATA_DEVICE_DROP_SINCE_VERSION :: 1
WL_DATA_DEVICE_SELECTION_SINCE_VERSION :: 1
WL_DATA_DEVICE_START_DRAG_SINCE_VERSION :: 1
WL_DATA_DEVICE_SET_SELECTION_SINCE_VERSION :: 1
WL_DATA_DEVICE_RELEASE_SINCE_VERSION :: 2


wl_data_device_set_user_data :: #force_inline proc "c" (wl_data_device: ^wl_data_device, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_data_device), user_data)
}

wl_data_device_get_user_data :: #force_inline proc "c" (wl_data_device: ^wl_data_device) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_data_device))
}

wl_data_device_get_version :: #force_inline proc "c" (wl_data_device: ^wl_data_device) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_data_device))
}

wl_data_device_destroy :: #force_inline proc "c" (wl_data_device: ^wl_data_device) {
  wl_proxy_destroy((^wl_proxy)(wl_data_device))
}

wl_data_device_start_drag :: #force_inline proc "c" (wl_data_device: ^wl_data_device, source: ^wl_data_source, origin: ^wl_surface, icon: ^wl_surface, serial: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_device),
       WL_DATA_DEVICE_START_DRAG, nil, wl_proxy_get_version((^wl_proxy)(wl_data_device)), 0, source, origin, icon, serial)
}

wl_data_device_set_selection :: #force_inline proc "c" (wl_data_device: ^wl_data_device, source: ^wl_data_source, serial: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_device),
       WL_DATA_DEVICE_SET_SELECTION, nil, wl_proxy_get_version((^wl_proxy)(wl_data_device)), 0, source, serial)
}

wl_data_device_release :: #force_inline proc "c" (wl_data_device: ^wl_data_device) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_data_device),
       WL_DATA_DEVICE_RELEASE, nil, wl_proxy_get_version((^wl_proxy)(wl_data_device)), WL_MARSHAL_FLAG_DESTROY)
}

wl_data_device_manager_dnd_action :: enum {
  /**
   * no action
   */
  WL_DATA_DEVICE_MANAGER_DND_ACTION_NONE = 0,
  /**
   * copy action
   */
  WL_DATA_DEVICE_MANAGER_DND_ACTION_COPY = 1,
  /**
   * move action
   */
  WL_DATA_DEVICE_MANAGER_DND_ACTION_MOVE = 2,
  /**
   * ask action
   */
  WL_DATA_DEVICE_MANAGER_DND_ACTION_ASK = 4,
}

WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE :: 0
WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE :: 1
WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE_SINCE_VERSION :: 1
WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE_SINCE_VERSION :: 1

wl_data_device_manager_set_user_data :: #force_inline proc "c" (wl_data_device_manager: ^wl_data_device_manager, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_data_device_manager), user_data)
}

wl_data_device_manager_get_user_data :: #force_inline proc "c" (wl_data_device_manager: ^wl_data_device_manager) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_data_device_manager))
}

wl_data_device_manager_get_version :: #force_inline proc "c" (wl_data_device_manager: ^wl_data_device_manager) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_data_device_manager))
}

wl_data_device_manager_destroy :: #force_inline proc "c" (wl_data_device_manager: ^wl_data_device_manager) {
  wl_proxy_destroy((^wl_proxy)(wl_data_device_manager))
}

wl_data_device_manager_create_data_source :: #force_inline proc "c" (wl_data_device_manager: ^wl_data_device_manager) -> ^wl_data_source {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_data_device_manager),
       WL_DATA_DEVICE_MANAGER_CREATE_DATA_SOURCE, &wl_data_source_interface, wl_proxy_get_version((^wl_proxy)(wl_data_device_manager)), 0, nil)

  return (^wl_data_source)(id)
}

wl_data_device_manager_get_data_device :: #force_inline proc "c" (wl_data_device_manager: ^wl_data_device_manager, seat: ^wl_seat) -> ^wl_data_device_manager {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_data_device_manager),
       WL_DATA_DEVICE_MANAGER_GET_DATA_DEVICE, &wl_data_device_interface, wl_proxy_get_version((^wl_proxy)(wl_data_device_manager)), 0, nil, seat)

  return (^wl_data_device)(id)
}

wl_shell_error :: enum {
  /**
   * given wl_surface has another role
   */
  WL_SHELL_ERROR_ROLE = 0,
}

WL_SHELL_GET_SHELL_SURFACE :: 0
WL_SHELL_GET_SHELL_SURFACE_SINCE_VERSION :: 1

wl_shell_set_user_data :: #force_inline proc "c" (wl_shell: ^wl_shell, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_shell), user_data)
}

wl_shell_get_user_data :: #force_inline proc "c" (wl_shell: ^wl_shell) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_shell))
}

wl_shell_get_version :: #force_inline proc "c" (wl_shell: ^wl_shell) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_shell))
}

wl_shell_destroy :: #force_inline proc "c" (wl_shell: ^wl_shell) {
  wl_proxy_destroy((^wl_proxy)(wl_shell))
}

wl_shell_get_shell_surface :: #force_inline proc "c" (wl_shell: ^wl_shell, surface: ^wl_surface) -> ^wl_shell_surface {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_shell),
       WL_SHELL_GET_SHELL_SURFACE, &wl_shell_surface_interface, wl_proxy_get_version((^wl_proxy)(wl_shell)), 0, nil, surface)

  return (^wl_shell_surface)(id)
}

wl_shell_surface_resize :: enum {
  /**
   * no edge
   */
  WL_SHELL_SURFACE_RESIZE_NONE = 0,
  /**
   * top edge
   */
  WL_SHELL_SURFACE_RESIZE_TOP = 1,
  /**
   * bottom edge
   */
  WL_SHELL_SURFACE_RESIZE_BOTTOM = 2,
  /**
   * left edge
   */
  WL_SHELL_SURFACE_RESIZE_LEFT = 4,
  /**
   * top and left edges
   */
  WL_SHELL_SURFACE_RESIZE_TOP_LEFT = 5,
  /**
   * bottom and left edges
   */
  WL_SHELL_SURFACE_RESIZE_BOTTOM_LEFT = 6,
  /**
   * right edge
   */
  WL_SHELL_SURFACE_RESIZE_RIGHT = 8,
  /**
   * top and right edges
   */
  WL_SHELL_SURFACE_RESIZE_TOP_RIGHT = 9,
  /**
   * bottom and right edges
   */
  WL_SHELL_SURFACE_RESIZE_BOTTOM_RIGHT = 10,
}

wl_shell_surface_transient :: enum {
  /**
   * do not set keyboard focus
   */
  WL_SHELL_SURFACE_TRANSIENT_INACTIVE = 0x1,
}

wl_shell_surface_fullscreen_method :: enum {
  /**
   * no preference, apply default policy
   */
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_DEFAULT = 0,
  /**
   * scale, preserve the surface's aspect ratio and center on output
   */
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_SCALE = 1,
  /**
   * switch output mode to the smallest mode that can fit the surface, add black borders to compensate size mismatch
   */
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_DRIVER = 2,
  /**
   * no upscaling, center on output and add black borders to compensate size mismatch
   */
  WL_SHELL_SURFACE_FULLSCREEN_METHOD_FILL = 3,
}

wl_shell_surface_listener :: struct {
  ping: proc "c" (data: rawptr, wl_shell_surface: ^wl_shell_surface, serial: u32),
  configure: proc "c" (data: rawptr, wl_shell_surface: ^wl_shell_surface, edges: u32, width: i32, height: i32),
  popup_done: proc "c" (data: rawptr, wl_shell_surface: ^wl_shell_surface),
}

wl_shell_surface_add_listener :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface,
            listener: ^wl_shell_surface_listener, data: rawptr) -> int
{
  return wl_proxy_add_listener((^wl_proxy)(wl_shell_surface),
             (^^proc())(listener), data)
}

WL_SHELL_SURFACE_PONG :: 0
WL_SHELL_SURFACE_MOVE :: 1
WL_SHELL_SURFACE_RESIZE :: 2
WL_SHELL_SURFACE_SET_TOPLEVEL :: 3
WL_SHELL_SURFACE_SET_TRANSIENT :: 4
WL_SHELL_SURFACE_SET_FULLSCREEN :: 5
WL_SHELL_SURFACE_SET_POPUP :: 6
WL_SHELL_SURFACE_SET_MAXIMIZED :: 7
WL_SHELL_SURFACE_SET_TITLE :: 8
WL_SHELL_SURFACE_SET_CLASS :: 9
WL_SHELL_SURFACE_PING_SINCE_VERSION :: 1
WL_SHELL_SURFACE_CONFIGURE_SINCE_VERSION :: 1
WL_SHELL_SURFACE_POPUP_DONE_SINCE_VERSION :: 1
WL_SHELL_SURFACE_PONG_SINCE_VERSION :: 1
WL_SHELL_SURFACE_MOVE_SINCE_VERSION :: 1
WL_SHELL_SURFACE_RESIZE_SINCE_VERSION :: 1
WL_SHELL_SURFACE_SET_TOPLEVEL_SINCE_VERSION :: 1
WL_SHELL_SURFACE_SET_TRANSIENT_SINCE_VERSION :: 1
WL_SHELL_SURFACE_SET_FULLSCREEN_SINCE_VERSION :: 1
WL_SHELL_SURFACE_SET_POPUP_SINCE_VERSION :: 1
WL_SHELL_SURFACE_SET_MAXIMIZED_SINCE_VERSION :: 1
WL_SHELL_SURFACE_SET_TITLE_SINCE_VERSION :: 1
WL_SHELL_SURFACE_SET_CLASS_SINCE_VERSION :: 1

wl_shell_surface_set_user_data :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_shell_surface), user_data)
}

wl_shell_surface_get_user_data :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_shell_surface))
}

wl_shell_surface_get_version :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_shell_surface))
}

wl_shell_surface_destroy :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface) {
  wl_proxy_destroy((^wl_proxy)(wl_shell_surface))
}

wl_shell_surface_pong :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, serial: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_PONG, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, serial)
}

wl_shell_surface_move :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, seat: ^wl_seat, serial: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_MOVE, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, seat, serial)
}

wl_shell_surface_resize :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, seat: ^wl_seat, serial: u32, edges: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_RESIZE, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, seat, serial, edges)
}

wl_shell_surface_set_toplevel :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_SET_TOPLEVEL, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0)
}

wl_shell_surface_set_transient :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, parent: ^wl_surface, x: i32, y: i32, flags: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_SET_TRANSIENT, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, parent, x, y, flags)
}

wl_shell_surface_set_fullscreen :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, method: u32, framerate: u32, output: ^wl_output) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_SET_FULLSCREEN, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, method, framerate, output)
}

wl_shell_surface_set_popup :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, seat: ^wl_seat, serial: u32, parent: ^wl_surface, x: i32, y: i32, flags: u32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_SET_POPUP, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, seat, serial, parent, x, y, flags)
}

wl_shell_surface_set_maximized :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, output: ^wl_output) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_SET_MAXIMIZED, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, output)
}

wl_shell_surface_set_title :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, title: cstring) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_SET_TITLE, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, title)
}

wl_shell_surface_set_class :: #force_inline proc "c" (wl_shell_surface: ^wl_shell_surface, class: cstring) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_shell_surface),
       WL_SHELL_SURFACE_SET_CLASS, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, class_)
}

wl_surface_error :: enum {
  /**
   * buffer scale value is invalid
   */
  WL_SURFACE_ERROR_INVALID_SCALE = 0,
  /**
   * buffer transform value is invalid
   */
  WL_SURFACE_ERROR_INVALID_TRANSFORM = 1,
  /**
   * buffer size is invalid
   */
  WL_SURFACE_ERROR_INVALID_SIZE = 2,
  /**
   * buffer offset is invalid
   */
  WL_SURFACE_ERROR_INVALID_OFFSET = 3,
  /**
   * surface was destroyed before its role object
   */
  WL_SURFACE_ERROR_DEFUNCT_ROLE_OBJECT = 4,
}

/**
 * @ingroup iface_wl_surface
 * @struct wl_surface_listener
 */
wl_surface_listener :: struct {
  enter: proc "c" (data: rawptr, wl_surface: ^wl_surface, output: ^wl_output),
  leave: proc "c" (data: rawptr, wl_surface: ^wl_surface, output: ^wl_output),
  preferred_buffer_scale: proc "c" (data: rawptr, wl_surface: ^wl_surface, factor: i32),
  preferred_buffer_transform: proc "c" (data: rawptr, wl_surface: ^wl_surface, transform: u32),
}

wl_surface_add_listener :: #force_inline proc "c" (wl_surface: ^wl_surface,
      listener: ^wl_surface_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_surface),
             (^^proc())(listener), data)
}

WL_SURFACE_DESTROY :: 0
WL_SURFACE_ATTACH :: 1
WL_SURFACE_DAMAGE :: 2
WL_SURFACE_FRAME :: 3
WL_SURFACE_SET_OPAQUE_REGION :: 4
WL_SURFACE_SET_INPUT_REGION :: 5
WL_SURFACE_COMMIT :: 6
WL_SURFACE_SET_BUFFER_TRANSFORM :: 7
WL_SURFACE_SET_BUFFER_SCALE :: 8
WL_SURFACE_DAMAGE_BUFFER :: 9
WL_SURFACE_OFFSET :: 10
WL_SURFACE_ENTER_SINCE_VERSION :: 1
WL_SURFACE_LEAVE_SINCE_VERSION :: 1
WL_SURFACE_PREFERRED_BUFFER_SCALE_SINCE_VERSION :: 6
WL_SURFACE_PREFERRED_BUFFER_TRANSFORM_SINCE_VERSION :: 6
WL_SURFACE_DESTROY_SINCE_VERSION :: 1
WL_SURFACE_ATTACH_SINCE_VERSION :: 1
WL_SURFACE_DAMAGE_SINCE_VERSION :: 1
WL_SURFACE_FRAME_SINCE_VERSION :: 1
WL_SURFACE_SET_OPAQUE_REGION_SINCE_VERSION :: 1
WL_SURFACE_SET_INPUT_REGION_SINCE_VERSION :: 1
WL_SURFACE_COMMIT_SINCE_VERSION :: 1
WL_SURFACE_SET_BUFFER_TRANSFORM_SINCE_VERSION :: 2
WL_SURFACE_SET_BUFFER_SCALE_SINCE_VERSION :: 3
WL_SURFACE_DAMAGE_BUFFER_SINCE_VERSION :: 4
WL_SURFACE_OFFSET_SINCE_VERSION :: 5

wl_surface_set_user_data :: #force_inline proc "c" (wl_surface: ^wl_surface, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_surface), user_data)
}

/** @ingroup iface_wl_surface */
wl_surface_get_user_data :: #force_inline proc "c" (wl_surface: ^wl_surface) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_surface))
}

wl_surface_get_version :: #force_inline proc "c" (wl_surface: ^wl_surface) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_surface))
}

wl_surface_destroy :: #force_inline proc "c" (wl_surface: ^wl_surface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), WL_MARSHAL_FLAG_DESTROY)
}

wl_surface_attach :: #force_inline proc "c" (wl_surface: ^wl_surface, buffer: ^wl_buffer, x: i32, y: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_ATTACH, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, buffer, x, y)
}

wl_surface_damage :: #force_inline proc "c" (wl_surface: ^wl_surface, x: i32, y: i32, width: i32, height: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_DAMAGE, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, x, y, width, height)
}

wl_surface_frame :: #force_inline proc "c" (wl_surface: ^wl_surface) -> ^wl_callback {
  callback := wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_FRAME, &wl_callback_interface, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, nil)

  return (^wl_callback)(callback)
}

wl_surface_set_opaque_region :: #force_inline proc "c" (wl_surface: ^wl_surface, region: ^wl_region) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_SET_OPAQUE_REGION, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, region)
}

wl_surface_set_input_region :: #force_inline proc "c" (wl_surface: ^wl_surface, region: ^wl_region) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_SET_INPUT_REGION, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, region)
}

wl_surface_commit :: #force_inline proc "c" (wl_surface: ^wl_surface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_COMMIT, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0)
}

wl_surface_set_buffer_transform :: #force_inline proc "c" (wl_surface: ^wl_surface, transform: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_SET_BUFFER_TRANSFORM, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, transform)
}

wl_surface_set_buffer_scale :: #force_inline proc "c" (wl_surface: ^wl_surface, scale: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_SET_BUFFER_SCALE, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, scale)
}

wl_surface_damage_buffer :: #force_inline proc "c" (wl_surface: ^wl_surface, x: i32, y: i32, width: i32, height: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_DAMAGE_BUFFER, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, x, y, width, height)
}

wl_surface_offset :: #force_inline proc "c" (wl_surface: ^wl_surface, x: i32, y: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_surface),
       WL_SURFACE_OFFSET, nil, wl_proxy_get_version((^wl_proxy)(wl_surface)), 0, x, y)
}

wl_seat_capability :: enum {
  /**
   * the seat has pointer devices
   */
  WL_SEAT_CAPABILITY_POINTER = 1,
  /**
   * the seat has one or more keyboards
   */
  WL_SEAT_CAPABILITY_KEYBOARD = 2,
  /**
   * the seat has touch devices
   */
  WL_SEAT_CAPABILITY_TOUCH = 4,
}

wl_seat_error :: enum {
  /**
   * get_pointer, get_keyboard or get_touch called on seat without the matching capability
   */
  WL_SEAT_ERROR_MISSING_CAPABILITY = 0,
}

wl_seat_listener :: struct {
  capabilities: proc "c" (data: rawptr, wl_seat: ^wl_seat, capabilities: u32),
  name: proc "c" (data: rawptr, wl_seat: ^wl_seat, name: cstring),
}

/**
 * @ingroup iface_wl_seat
 */
static inline int
wl_seat_add_listener :: #force_inline proc "c" (struct wl_seat *wl_seat,
         const struct wl_seat_listener *listener, data: rawptr)
{
  return wl_proxy_add_listener((struct wl_proxy *) wl_seat,
             (^^proc())(listener), data)
}

#define WL_SEAT_GET_POINTER 0
#define WL_SEAT_GET_KEYBOARD 1
#define WL_SEAT_GET_TOUCH 2
#define WL_SEAT_RELEASE 3

/**
 * @ingroup iface_wl_seat
 */
#define WL_SEAT_CAPABILITIES_SINCE_VERSION 1
/**
 * @ingroup iface_wl_seat
 */
#define WL_SEAT_NAME_SINCE_VERSION 2

/**
 * @ingroup iface_wl_seat
 */
#define WL_SEAT_GET_POINTER_SINCE_VERSION 1
/**
 * @ingroup iface_wl_seat
 */
#define WL_SEAT_GET_KEYBOARD_SINCE_VERSION 1
/**
 * @ingroup iface_wl_seat
 */
#define WL_SEAT_GET_TOUCH_SINCE_VERSION 1
/**
 * @ingroup iface_wl_seat
 */
#define WL_SEAT_RELEASE_SINCE_VERSION 5

/** @ingroup iface_wl_seat */

wl_seat_set_user_data :: #force_inline proc "c" (struct wl_seat *wl_seat, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_seat, user_data)
}

/** @ingroup iface_wl_seat */
wl_seat_get_user_data :: #force_inline proc "c" (struct wl_seat *wl_seat) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_seat)
}

wl_seat_get_version :: #force_inline proc "c" (struct wl_seat *wl_seat) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_seat)
}

/** @ingroup iface_wl_seat */

wl_seat_destroy :: #force_inline proc "c" (struct wl_seat *wl_seat) {
  wl_proxy_destroy((struct wl_proxy *) wl_seat)
}

/**
 * @ingroup iface_wl_seat
 *
 * The ID provided will be initialized to the wl_pointer interface
 * for this seat.
 *
 * This request only takes effect if the seat has the pointer
 * capability, or has had the pointer capability in the past.
 * It is a protocol violation to issue this request on a seat that has
 * never had the pointer capability. The missing_capability error will
 * be sent in this case.
 */
static inline struct wl_pointer *
wl_seat_get_pointer :: #force_inline proc "c" (struct wl_seat *wl_seat)
{
  struct wl_proxy *id

  id = wl_proxy_marshal_flags((struct wl_proxy *) wl_seat,
       WL_SEAT_GET_POINTER, &wl_pointer_interface, wl_proxy_get_version((struct wl_proxy *) wl_seat), 0, nil)

  return (struct wl_pointer *) id
}

/**
 * @ingroup iface_wl_seat
 *
 * The ID provided will be initialized to the wl_keyboard interface
 * for this seat.
 *
 * This request only takes effect if the seat has the keyboard
 * capability, or has had the keyboard capability in the past.
 * It is a protocol violation to issue this request on a seat that has
 * never had the keyboard capability. The missing_capability error will
 * be sent in this case.
 */
static inline struct wl_keyboard *
wl_seat_get_keyboard :: #force_inline proc "c" (struct wl_seat *wl_seat)
{
  struct wl_proxy *id

  id = wl_proxy_marshal_flags((struct wl_proxy *) wl_seat,
       WL_SEAT_GET_KEYBOARD, &wl_keyboard_interface, wl_proxy_get_version((struct wl_proxy *) wl_seat), 0, nil)

  return (struct wl_keyboard *) id
}

/**
 * @ingroup iface_wl_seat
 *
 * The ID provided will be initialized to the wl_touch interface
 * for this seat.
 *
 * This request only takes effect if the seat has the touch
 * capability, or has had the touch capability in the past.
 * It is a protocol violation to issue this request on a seat that has
 * never had the touch capability. The missing_capability error will
 * be sent in this case.
 */
static inline struct wl_touch *
wl_seat_get_touch :: #force_inline proc "c" (struct wl_seat *wl_seat)
{
  struct wl_proxy *id

  id = wl_proxy_marshal_flags((struct wl_proxy *) wl_seat,
       WL_SEAT_GET_TOUCH, &wl_touch_interface, wl_proxy_get_version((struct wl_proxy *) wl_seat), 0, nil)

  return (struct wl_touch *) id
}

/**
 * @ingroup iface_wl_seat
 *
 * Using this request a client can tell the server that it is not going to
 * use the seat object anymore.
 */

wl_seat_release :: #force_inline proc "c" (struct wl_seat *wl_seat) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_seat,
       WL_SEAT_RELEASE, nil, wl_proxy_get_version((struct wl_proxy *) wl_seat), WL_MARSHAL_FLAG_DESTROY)
}

#ifndef WL_POINTER_ERROR_ENUM
#define WL_POINTER_ERROR_ENUM
enum wl_pointer_error {
  /**
   * given wl_surface has another role
   */
  WL_POINTER_ERROR_ROLE = 0,
}
#endif /* WL_POINTER_ERROR_ENUM */

#ifndef WL_POINTER_BUTTON_STATE_ENUM
#define WL_POINTER_BUTTON_STATE_ENUM
/**
 * @ingroup iface_wl_pointer
 * physical button state
 *
 * Describes the physical state of a button that produced the button
 * event.
 */
enum wl_pointer_button_state {
  /**
   * the button is not pressed
   */
  WL_POINTER_BUTTON_STATE_RELEASED = 0,
  /**
   * the button is pressed
   */
  WL_POINTER_BUTTON_STATE_PRESSED = 1,
}
#endif /* WL_POINTER_BUTTON_STATE_ENUM */

#ifndef WL_POINTER_AXIS_ENUM
#define WL_POINTER_AXIS_ENUM
/**
 * @ingroup iface_wl_pointer
 * axis types
 *
 * Describes the axis types of scroll events.
 */
enum wl_pointer_axis {
  /**
   * vertical axis
   */
  WL_POINTER_AXIS_VERTICAL_SCROLL = 0,
  /**
   * horizontal axis
   */
  WL_POINTER_AXIS_HORIZONTAL_SCROLL = 1,
}
#endif /* WL_POINTER_AXIS_ENUM */

#ifndef WL_POINTER_AXIS_SOURCE_ENUM
#define WL_POINTER_AXIS_SOURCE_ENUM
/**
 * @ingroup iface_wl_pointer
 * axis source types
 *
 * Describes the source types for axis events. This indicates to the
 * client how an axis event was physically generated; a client may
 * adjust the user interface accordingly. For example, scroll events
 * from a "finger" source may be in a smooth coordinate space with
 * kinetic scrolling whereas a "wheel" source may be in discrete steps
 * of a number of lines.
 *
 * The "continuous" axis source is a device generating events in a
 * continuous coordinate space, but using something other than a
 * finger. One example for this source is button-based scrolling where
 * the vertical motion of a device is converted to scroll events while
 * a button is held down.
 *
 * The "wheel tilt" axis source indicates that the actual device is a
 * wheel but the scroll event is not caused by a rotation but a
 * (usually sideways) tilt of the wheel.
 */
enum wl_pointer_axis_source {
  /**
   * a physical wheel rotation
   */
  WL_POINTER_AXIS_SOURCE_WHEEL = 0,
  /**
   * finger on a touch surface
   */
  WL_POINTER_AXIS_SOURCE_FINGER = 1,
  /**
   * continuous coordinate space
   */
  WL_POINTER_AXIS_SOURCE_CONTINUOUS = 2,
  /**
   * a physical wheel tilt
   * @since 6
   */
  WL_POINTER_AXIS_SOURCE_WHEEL_TILT = 3,
}
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_AXIS_SOURCE_WHEEL_TILT_SINCE_VERSION 6
#endif /* WL_POINTER_AXIS_SOURCE_ENUM */

#ifndef WL_POINTER_AXIS_RELATIVE_DIRECTION_ENUM
#define WL_POINTER_AXIS_RELATIVE_DIRECTION_ENUM
/**
 * @ingroup iface_wl_pointer
 * axis relative direction
 *
 * This specifies the direction of the physical motion that caused a
 * wl_pointer.axis event, relative to the wl_pointer.axis direction.
 */
enum wl_pointer_axis_relative_direction {
  /**
   * physical motion matches axis direction
   */
  WL_POINTER_AXIS_RELATIVE_DIRECTION_IDENTICAL = 0,
  /**
   * physical motion is the inverse of the axis direction
   */
  WL_POINTER_AXIS_RELATIVE_DIRECTION_INVERTED = 1,
}
#endif /* WL_POINTER_AXIS_RELATIVE_DIRECTION_ENUM */

/**
 * @ingroup iface_wl_pointer
 * @struct wl_pointer_listener
 */
struct wl_pointer_listener {
  /**
   * enter event
   *
   * Notification that this seat's pointer is focused on a certain
   * surface.
   *
   * When a seat's focus enters a surface, the pointer image is
   * undefined and a client should respond to this event by setting
   * an appropriate pointer image with the set_cursor request.
   * @param serial serial number of the enter event
   * @param surface surface entered by the pointer
   * @param surface_x surface-local x coordinate
   * @param surface_y surface-local y coordinate
   */
  void (*enter)(data: rawptr,
          struct wl_pointer *wl_pointer,
          uint32_t serial,
          struct wl_surface *surface,
          wl_fixed_t surface_x,
          wl_fixed_t surface_y)
  /**
   * leave event
   *
   * Notification that this seat's pointer is no longer focused on
   * a certain surface.
   *
   * The leave notification is sent before the enter notification for
   * the new focus.
   * @param serial serial number of the leave event
   * @param surface surface left by the pointer
   */
  void (*leave)(data: rawptr,
          struct wl_pointer *wl_pointer,
          uint32_t serial,
          struct wl_surface *surface)
  /**
   * pointer motion event
   *
   * Notification of pointer location change. The arguments
   * surface_x and surface_y are the location relative to the focused
   * surface.
   * @param time timestamp with millisecond granularity
   * @param surface_x surface-local x coordinate
   * @param surface_y surface-local y coordinate
   */
  void (*motion)(data: rawptr,
           struct wl_pointer *wl_pointer,
           uint32_t time,
           wl_fixed_t surface_x,
           wl_fixed_t surface_y)
  /**
   * pointer button event
   *
   * Mouse button click and release notifications.
   *
   * The location of the click is given by the last motion or enter
   * event. The time argument is a timestamp with millisecond
   * granularity, with an undefined base.
   *
   * The button is a button code as defined in the Linux kernel's
   * linux/input-event-codes.h header file, e.g. BTN_LEFT.
   *
   * Any 16-bit button code value is reserved for future additions to
   * the kernel's event code list. All other button codes above
   * 0xFFFF are currently undefined but may be used in future
   * versions of this protocol.
   * @param serial serial number of the button event
   * @param time timestamp with millisecond granularity
   * @param button button that produced the event
   * @param state physical state of the button
   */
  void (*button)(data: rawptr,
           struct wl_pointer *wl_pointer,
           uint32_t serial,
           uint32_t time,
           uint32_t button,
           uint32_t state)
  /**
   * axis event
   *
   * Scroll and other axis notifications.
   *
   * For scroll events (vertical and horizontal scroll axes), the
   * value parameter is the length of a vector along the specified
   * axis in a coordinate space identical to those of motion events,
   * representing a relative movement along the specified axis.
   *
   * For devices that support movements non-parallel to axes multiple
   * axis events will be emitted.
   *
   * When applicable, for example for touch pads, the server can
   * choose to emit scroll events where the motion vector is
   * equivalent to a motion event vector.
   *
   * When applicable, a client can transform its content relative to
   * the scroll distance.
   * @param time timestamp with millisecond granularity
   * @param axis axis type
   * @param value length of vector in surface-local coordinate space
   */
  void (*axis)(data: rawptr,
         struct wl_pointer *wl_pointer,
         uint32_t time,
         uint32_t axis,
         wl_fixed_t value)
  /**
   * end of a pointer event sequence
   *
   * Indicates the end of a set of events that logically belong
   * together. A client is expected to accumulate the data in all
   * events within the frame before proceeding.
   *
   * All wl_pointer events before a wl_pointer.frame event belong
   * logically together. For example, in a diagonal scroll motion the
   * compositor will send an optional wl_pointer.axis_source event,
   * two wl_pointer.axis events (horizontal and vertical) and finally
   * a wl_pointer.frame event. The client may use this information to
   * calculate a diagonal vector for scrolling.
   *
   * When multiple wl_pointer.axis events occur within the same
   * frame, the motion vector is the combined motion of all events.
   * When a wl_pointer.axis and a wl_pointer.axis_stop event occur
   * within the same frame, this indicates that axis movement in one
   * axis has stopped but continues in the other axis. When multiple
   * wl_pointer.axis_stop events occur within the same frame, this
   * indicates that these axes stopped in the same instance.
   *
   * A wl_pointer.frame event is sent for every logical event group,
   * even if the group only contains a single wl_pointer event.
   * Specifically, a client may get a sequence: motion, frame,
   * button, frame, axis, frame, axis_stop, frame.
   *
   * The wl_pointer.enter and wl_pointer.leave events are logical
   * events generated by the compositor and not the hardware. These
   * events are also grouped by a wl_pointer.frame. When a pointer
   * moves from one surface to another, a compositor should group the
   * wl_pointer.leave event within the same wl_pointer.frame.
   * However, a client must not rely on wl_pointer.leave and
   * wl_pointer.enter being in the same wl_pointer.frame.
   * Compositor-specific policies may require the wl_pointer.leave
   * and wl_pointer.enter event being split across multiple
   * wl_pointer.frame groups.
   * @since 5
   */
  void (*frame)(data: rawptr,
          struct wl_pointer *wl_pointer)
  /**
   * axis source event
   *
   * Source information for scroll and other axes.
   *
   * This event does not occur on its own. It is sent before a
   * wl_pointer.frame event and carries the source information for
   * all events within that frame.
   *
   * The source specifies how this event was generated. If the source
   * is wl_pointer.axis_source.finger, a wl_pointer.axis_stop event
   * will be sent when the user lifts the finger off the device.
   *
   * If the source is wl_pointer.axis_source.wheel,
   * wl_pointer.axis_source.wheel_tilt or
   * wl_pointer.axis_source.continuous, a wl_pointer.axis_stop event
   * may or may not be sent. Whether a compositor sends an axis_stop
   * event for these sources is hardware-specific and
   * implementation-dependent; clients must not rely on receiving an
   * axis_stop event for these scroll sources and should treat scroll
   * sequences from these scroll sources as unterminated by default.
   *
   * This event is optional. If the source is unknown for a
   * particular axis event sequence, no event is sent. Only one
   * wl_pointer.axis_source event is permitted per frame.
   *
   * The order of wl_pointer.axis_discrete and wl_pointer.axis_source
   * is not guaranteed.
   * @param axis_source source of the axis event
   * @since 5
   */
  void (*axis_source)(data: rawptr,
          struct wl_pointer *wl_pointer,
          uint32_t axis_source)
  /**
   * axis stop event
   *
   * Stop notification for scroll and other axes.
   *
   * For some wl_pointer.axis_source types, a wl_pointer.axis_stop
   * event is sent to notify a client that the axis sequence has
   * terminated. This enables the client to implement kinetic
   * scrolling. See the wl_pointer.axis_source documentation for
   * information on when this event may be generated.
   *
   * Any wl_pointer.axis events with the same axis_source after this
   * event should be considered as the start of a new axis motion.
   *
   * The timestamp is to be interpreted identical to the timestamp in
   * the wl_pointer.axis event. The timestamp value may be the same
   * as a preceding wl_pointer.axis event.
   * @param time timestamp with millisecond granularity
   * @param axis the axis stopped with this event
   * @since 5
   */
  void (*axis_stop)(data: rawptr,
        struct wl_pointer *wl_pointer,
        uint32_t time,
        uint32_t axis)
  /**
   * axis click event
   *
   * Discrete step information for scroll and other axes.
   *
   * This event carries the axis value of the wl_pointer.axis event
   * in discrete steps (e.g. mouse wheel clicks).
   *
   * This event is deprecated with wl_pointer version 8 - this event
   * is not sent to clients supporting version 8 or later.
   *
   * This event does not occur on its own, it is coupled with a
   * wl_pointer.axis event that represents this axis value on a
   * continuous scale. The protocol guarantees that each
   * axis_discrete event is always followed by exactly one axis event
   * with the same axis number within the same wl_pointer.frame. Note
   * that the protocol allows for other events to occur between the
   * axis_discrete and its coupled axis event, including other
   * axis_discrete or axis events. A wl_pointer.frame must not
   * contain more than one axis_discrete event per axis type.
   *
   * This event is optional; continuous scrolling devices like
   * two-finger scrolling on touchpads do not have discrete steps and
   * do not generate this event.
   *
   * The discrete value carries the directional information. e.g. a
   * value of -2 is two steps towards the negative direction of this
   * axis.
   *
   * The axis number is identical to the axis number in the
   * associated axis event.
   *
   * The order of wl_pointer.axis_discrete and wl_pointer.axis_source
   * is not guaranteed.
   * @param axis axis type
   * @param discrete number of steps
   * @since 5
   */
  void (*axis_discrete)(data: rawptr,
            struct wl_pointer *wl_pointer,
            uint32_t axis,
            int32_t discrete)
  /**
   * axis high-resolution scroll event
   *
   * Discrete high-resolution scroll information.
   *
   * This event carries high-resolution wheel scroll information,
   * with each multiple of 120 representing one logical scroll step
   * (a wheel detent). For example, an axis_value120 of 30 is one
   * quarter of a logical scroll step in the positive direction, a
   * value120 of -240 are two logical scroll steps in the negative
   * direction within the same hardware event. Clients that rely on
   * discrete scrolling should accumulate the value120 to multiples
   * of 120 before processing the event.
   *
   * The value120 must not be zero.
   *
   * This event replaces the wl_pointer.axis_discrete event in
   * clients supporting wl_pointer version 8 or later.
   *
   * Where a wl_pointer.axis_source event occurs in the same
   * wl_pointer.frame, the axis source applies to this event.
   *
   * The order of wl_pointer.axis_value120 and wl_pointer.axis_source
   * is not guaranteed.
   * @param axis axis type
   * @param value120 scroll distance as fraction of 120
   * @since 8
   */
  void (*axis_value120)(data: rawptr,
            struct wl_pointer *wl_pointer,
            uint32_t axis,
            int32_t value120)
  /**
   * axis relative physical direction event
   *
   * Relative directional information of the entity causing the
   * axis motion.
   *
   * For a wl_pointer.axis event, the
   * wl_pointer.axis_relative_direction event specifies the movement
   * direction of the entity causing the wl_pointer.axis event. For
   * example: - if a user's fingers on a touchpad move down and this
   * causes a wl_pointer.axis vertical_scroll down event, the
   * physical direction is 'identical' - if a user's fingers on a
   * touchpad move down and this causes a wl_pointer.axis
   * vertical_scroll up scroll up event ('natural scrolling'), the
   * physical direction is 'inverted'.
   *
   * A client may use this information to adjust scroll motion of
   * components. Specifically, enabling natural scrolling causes the
   * content to change direction compared to traditional scrolling.
   * Some widgets like volume control sliders should usually match
   * the physical direction regardless of whether natural scrolling
   * is active. This event enables clients to match the scroll
   * direction of a widget to the physical direction.
   *
   * This event does not occur on its own, it is coupled with a
   * wl_pointer.axis event that represents this axis value. The
   * protocol guarantees that each axis_relative_direction event is
   * always followed by exactly one axis event with the same axis
   * number within the same wl_pointer.frame. Note that the protocol
   * allows for other events to occur between the
   * axis_relative_direction and its coupled axis event.
   *
   * The axis number is identical to the axis number in the
   * associated axis event.
   *
   * The order of wl_pointer.axis_relative_direction,
   * wl_pointer.axis_discrete and wl_pointer.axis_source is not
   * guaranteed.
   * @param axis axis type
   * @param direction physical direction relative to axis motion
   * @since 9
   */
  void (*axis_relative_direction)(data: rawptr,
          struct wl_pointer *wl_pointer,
          uint32_t axis,
          uint32_t direction)
}

/**
 * @ingroup iface_wl_pointer
 */
static inline int
wl_pointer_add_listener :: #force_inline proc "c" (struct wl_pointer *wl_pointer,
      const struct wl_pointer_listener *listener, data: rawptr)
{
  return wl_proxy_add_listener((struct wl_proxy *) wl_pointer,
             (^^proc())(listener), data)
}

#define WL_POINTER_SET_CURSOR 0
#define WL_POINTER_RELEASE 1

/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_ENTER_SINCE_VERSION 1
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_LEAVE_SINCE_VERSION 1
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_MOTION_SINCE_VERSION 1
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_BUTTON_SINCE_VERSION 1
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_AXIS_SINCE_VERSION 1
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_FRAME_SINCE_VERSION 5
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_AXIS_SOURCE_SINCE_VERSION 5
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_AXIS_STOP_SINCE_VERSION 5
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_AXIS_DISCRETE_SINCE_VERSION 5
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_AXIS_VALUE120_SINCE_VERSION 8
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_AXIS_RELATIVE_DIRECTION_SINCE_VERSION 9

/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_SET_CURSOR_SINCE_VERSION 1
/**
 * @ingroup iface_wl_pointer
 */
#define WL_POINTER_RELEASE_SINCE_VERSION 3

/** @ingroup iface_wl_pointer */

wl_pointer_set_user_data :: #force_inline proc "c" (struct wl_pointer *wl_pointer, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_pointer, user_data)
}

/** @ingroup iface_wl_pointer */
wl_pointer_get_user_data :: #force_inline proc "c" (struct wl_pointer *wl_pointer) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_pointer)
}

wl_pointer_get_version :: #force_inline proc "c" (struct wl_pointer *wl_pointer) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_pointer)
}

/** @ingroup iface_wl_pointer */

wl_pointer_destroy :: #force_inline proc "c" (struct wl_pointer *wl_pointer) {
  wl_proxy_destroy((struct wl_proxy *) wl_pointer)
}

/**
 * @ingroup iface_wl_pointer
 *
 * Set the pointer surface, i.e., the surface that contains the
 * pointer image (cursor). This request gives the surface the role
 * of a cursor. If the surface already has another role, it raises
 * a protocol error.
 *
 * The cursor actually changes only if the pointer
 * focus for this device is one of the requesting client's surfaces
 * or the surface parameter is the current pointer surface. If
 * there was a previous surface set with this request it is
 * replaced. If surface is nil, the pointer image is hidden.
 *
 * The parameters hotspot_x and hotspot_y define the position of
 * the pointer surface relative to the pointer location. Its
 * top-left corner is always at (x, y) - (hotspot_x, hotspot_y),
 * where (x, y) are the coordinates of the pointer location, in
 * surface-local coordinates.
 *
 * On surface.attach requests to the pointer surface, hotspot_x
 * and hotspot_y are decremented by the x and y parameters
 * passed to the request. Attach must be confirmed by
 * wl_surface.commit as usual.
 *
 * The hotspot can also be updated by passing the currently set
 * pointer surface to this request with new values for hotspot_x
 * and hotspot_y.
 *
 * The input region is ignored for wl_surfaces with the role of
 * a cursor. When the use as a cursor ends, the wl_surface is
 * unmapped.
 *
 * The serial parameter must match the latest wl_pointer.enter
 * serial number sent to the client. Otherwise the request will be
 * ignored.
 */

wl_pointer_set_cursor :: #force_inline proc "c" (struct wl_pointer *wl_pointer, uint32_t serial, struct wl_surface *surface, int32_t hotspot_x, int32_t hotspot_y) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_pointer,
       WL_POINTER_SET_CURSOR, nil, wl_proxy_get_version((struct wl_proxy *) wl_pointer), 0, serial, surface, hotspot_x, hotspot_y)
}

/**
 * @ingroup iface_wl_pointer
 *
 * Using this request a client can tell the server that it is not going to
 * use the pointer object anymore.
 *
 * This request destroys the pointer proxy object, so clients must not call
 * wl_pointer_destroy() after using this request.
 */

wl_pointer_release :: #force_inline proc "c" (struct wl_pointer *wl_pointer) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_pointer,
       WL_POINTER_RELEASE, nil, wl_proxy_get_version((struct wl_proxy *) wl_pointer), WL_MARSHAL_FLAG_DESTROY)
}

#ifndef WL_KEYBOARD_KEYMAP_FORMAT_ENUM
#define WL_KEYBOARD_KEYMAP_FORMAT_ENUM
/**
 * @ingroup iface_wl_keyboard
 * keyboard mapping format
 *
 * This specifies the format of the keymap provided to the
 * client with the wl_keyboard.keymap event.
 */
enum wl_keyboard_keymap_format {
  /**
   * no keymap; client must understand how to interpret the raw keycode
   */
  WL_KEYBOARD_KEYMAP_FORMAT_NO_KEYMAP = 0,
  /**
   * libxkbcommon compatible, nil-terminated string; to determine the xkb keycode, clients must add 8 to the key event keycode
   */
  WL_KEYBOARD_KEYMAP_FORMAT_XKB_V1 = 1,
}
#endif /* WL_KEYBOARD_KEYMAP_FORMAT_ENUM */

#ifndef WL_KEYBOARD_KEY_STATE_ENUM
#define WL_KEYBOARD_KEY_STATE_ENUM
/**
 * @ingroup iface_wl_keyboard
 * physical key state
 *
 * Describes the physical state of a key that produced the key event.
 */
enum wl_keyboard_key_state {
  /**
   * key is not pressed
   */
  WL_KEYBOARD_KEY_STATE_RELEASED = 0,
  /**
   * key is pressed
   */
  WL_KEYBOARD_KEY_STATE_PRESSED = 1,
}
#endif /* WL_KEYBOARD_KEY_STATE_ENUM */

/**
 * @ingroup iface_wl_keyboard
 * @struct wl_keyboard_listener
 */
struct wl_keyboard_listener {
  /**
   * keyboard mapping
   *
   * This event provides a file descriptor to the client which can
   * be memory-mapped in read-only mode to provide a keyboard mapping
   * description.
   *
   * From version 7 onwards, the fd must be mapped with MAP_PRIVATE
   * by the recipient, as MAP_SHARED may fail.
   * @param format keymap format
   * @param fd keymap file descriptor
   * @param size keymap size, in bytes
   */
  void (*keymap)(data: rawptr,
           struct wl_keyboard *wl_keyboard,
           uint32_t format,
           int32_t fd,
           uint32_t size)
  /**
   * enter event
   *
   * Notification that this seat's keyboard focus is on a certain
   * surface.
   *
   * The compositor must send the wl_keyboard.modifiers event after
   * this event.
   * @param serial serial number of the enter event
   * @param surface surface gaining keyboard focus
   * @param keys the currently pressed keys
   */
  void (*enter)(data: rawptr,
          struct wl_keyboard *wl_keyboard,
          uint32_t serial,
          struct wl_surface *surface,
          struct wl_array *keys)
  /**
   * leave event
   *
   * Notification that this seat's keyboard focus is no longer on a
   * certain surface.
   *
   * The leave notification is sent before the enter notification for
   * the new focus.
   *
   * After this event client must assume that all keys, including
   * modifiers, are lifted and also it must stop key repeating if
   * there's some going on.
   * @param serial serial number of the leave event
   * @param surface surface that lost keyboard focus
   */
  void (*leave)(data: rawptr,
          struct wl_keyboard *wl_keyboard,
          uint32_t serial,
          struct wl_surface *surface)
  /**
   * key event
   *
   * A key was pressed or released. The time argument is a
   * timestamp with millisecond granularity, with an undefined base.
   *
   * The key is a platform-specific key code that can be interpreted
   * by feeding it to the keyboard mapping (see the keymap event).
   *
   * If this event produces a change in modifiers, then the resulting
   * wl_keyboard.modifiers event must be sent after this event.
   * @param serial serial number of the key event
   * @param time timestamp with millisecond granularity
   * @param key key that produced the event
   * @param state physical state of the key
   */
  void (*key)(data: rawptr,
        struct wl_keyboard *wl_keyboard,
        uint32_t serial,
        uint32_t time,
        uint32_t key,
        uint32_t state)
  /**
   * modifier and group state
   *
   * Notifies clients that the modifier and/or group state has
   * changed, and it should update its local state.
   * @param serial serial number of the modifiers event
   * @param mods_depressed depressed modifiers
   * @param mods_latched latched modifiers
   * @param mods_locked locked modifiers
   * @param group keyboard layout
   */
  void (*modifiers)(data: rawptr,
        struct wl_keyboard *wl_keyboard,
        uint32_t serial,
        uint32_t mods_depressed,
        uint32_t mods_latched,
        uint32_t mods_locked,
        uint32_t group)
  /**
   * repeat rate and delay
   *
   * Informs the client about the keyboard's repeat rate and delay.
   *
   * This event is sent as soon as the wl_keyboard object has been
   * created, and is guaranteed to be received by the client before
   * any key press event.
   *
   * Negative values for either rate or delay are illegal. A rate of
   * zero will disable any repeating (regardless of the value of
   * delay).
   *
   * This event can be sent later on as well with a new value if
   * necessary, so clients should continue listening for the event
   * past the creation of wl_keyboard.
   * @param rate the rate of repeating keys in characters per second
   * @param delay delay in milliseconds since key down until repeating starts
   * @since 4
   */
  void (*repeat_info)(data: rawptr,
          struct wl_keyboard *wl_keyboard,
          int32_t rate,
          int32_t delay)
}

/**
 * @ingroup iface_wl_keyboard
 */
static inline int
wl_keyboard_add_listener :: #force_inline proc "c" (struct wl_keyboard *wl_keyboard,
       const struct wl_keyboard_listener *listener, data: rawptr)
{
  return wl_proxy_add_listener((struct wl_proxy *) wl_keyboard,
             (^^proc())(listener), data)
}

#define WL_KEYBOARD_RELEASE 0

/**
 * @ingroup iface_wl_keyboard
 */
#define WL_KEYBOARD_KEYMAP_SINCE_VERSION 1
/**
 * @ingroup iface_wl_keyboard
 */
#define WL_KEYBOARD_ENTER_SINCE_VERSION 1
/**
 * @ingroup iface_wl_keyboard
 */
#define WL_KEYBOARD_LEAVE_SINCE_VERSION 1
/**
 * @ingroup iface_wl_keyboard
 */
#define WL_KEYBOARD_KEY_SINCE_VERSION 1
/**
 * @ingroup iface_wl_keyboard
 */
#define WL_KEYBOARD_MODIFIERS_SINCE_VERSION 1
/**
 * @ingroup iface_wl_keyboard
 */
#define WL_KEYBOARD_REPEAT_INFO_SINCE_VERSION 4

/**
 * @ingroup iface_wl_keyboard
 */
#define WL_KEYBOARD_RELEASE_SINCE_VERSION 3

/** @ingroup iface_wl_keyboard */

wl_keyboard_set_user_data :: #force_inline proc "c" (struct wl_keyboard *wl_keyboard, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_keyboard, user_data)
}

/** @ingroup iface_wl_keyboard */
wl_keyboard_get_user_data :: #force_inline proc "c" (struct wl_keyboard *wl_keyboard) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_keyboard)
}

wl_keyboard_get_version :: #force_inline proc "c" (struct wl_keyboard *wl_keyboard) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_keyboard)
}

/** @ingroup iface_wl_keyboard */

wl_keyboard_destroy :: #force_inline proc "c" (struct wl_keyboard *wl_keyboard) {
  wl_proxy_destroy((struct wl_proxy *) wl_keyboard)
}

/**
 * @ingroup iface_wl_keyboard
 */

wl_keyboard_release :: #force_inline proc "c" (struct wl_keyboard *wl_keyboard) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_keyboard,
       WL_KEYBOARD_RELEASE, nil, wl_proxy_get_version((struct wl_proxy *) wl_keyboard), WL_MARSHAL_FLAG_DESTROY)
}

/**
 * @ingroup iface_wl_touch
 * @struct wl_touch_listener
 */
struct wl_touch_listener {
  /**
   * touch down event and beginning of a touch sequence
   *
   * A new touch point has appeared on the surface. This touch
   * point is assigned a unique ID. Future events from this touch
   * point reference this ID. The ID ceases to be valid after a touch
   * up event and may be reused in the future.
   * @param serial serial number of the touch down event
   * @param time timestamp with millisecond granularity
   * @param surface surface touched
   * @param id the unique ID of this touch point
   * @param x surface-local x coordinate
   * @param y surface-local y coordinate
   */
  void (*down)(data: rawptr,
         struct wl_touch *wl_touch,
         uint32_t serial,
         uint32_t time,
         struct wl_surface *surface,
         int32_t id,
         wl_fixed_t x,
         wl_fixed_t y)
  /**
   * end of a touch event sequence
   *
   * The touch point has disappeared. No further events will be
   * sent for this touch point and the touch point's ID is released
   * and may be reused in a future touch down event.
   * @param serial serial number of the touch up event
   * @param time timestamp with millisecond granularity
   * @param id the unique ID of this touch point
   */
  void (*up)(data: rawptr,
       struct wl_touch *wl_touch,
       uint32_t serial,
       uint32_t time,
       int32_t id)
  /**
   * update of touch point coordinates
   *
   * A touch point has changed coordinates.
   * @param time timestamp with millisecond granularity
   * @param id the unique ID of this touch point
   * @param x surface-local x coordinate
   * @param y surface-local y coordinate
   */
  void (*motion)(data: rawptr,
           struct wl_touch *wl_touch,
           uint32_t time,
           int32_t id,
           wl_fixed_t x,
           wl_fixed_t y)
  /**
   * end of touch frame event
   *
   * Indicates the end of a set of events that logically belong
   * together. A client is expected to accumulate the data in all
   * events within the frame before proceeding.
   *
   * A wl_touch.frame terminates at least one event but otherwise no
   * guarantee is provided about the set of events within a frame. A
   * client must assume that any state not updated in a frame is
   * unchanged from the previously known state.
   */
  void (*frame)(data: rawptr,
          struct wl_touch *wl_touch)
  /**
   * touch session cancelled
   *
   * Sent if the compositor decides the touch stream is a global
   * gesture. No further events are sent to the clients from that
   * particular gesture. Touch cancellation applies to all touch
   * points currently active on this client's surface. The client is
   * responsible for finalizing the touch points, future touch points
   * on this surface may reuse the touch point ID.
   */
  void (*cancel)(data: rawptr,
           struct wl_touch *wl_touch)
  /**
   * update shape of touch point
   *
   * Sent when a touchpoint has changed its shape.
   *
   * This event does not occur on its own. It is sent before a
   * wl_touch.frame event and carries the new shape information for
   * any previously reported, or new touch points of that frame.
   *
   * Other events describing the touch point such as wl_touch.down,
   * wl_touch.motion or wl_touch.orientation may be sent within the
   * same wl_touch.frame. A client should treat these events as a
   * single logical touch point update. The order of wl_touch.shape,
   * wl_touch.orientation and wl_touch.motion is not guaranteed. A
   * wl_touch.down event is guaranteed to occur before the first
   * wl_touch.shape event for this touch ID but both events may occur
   * within the same wl_touch.frame.
   *
   * A touchpoint shape is approximated by an ellipse through the
   * major and minor axis length. The major axis length describes the
   * longer diameter of the ellipse, while the minor axis length
   * describes the shorter diameter. Major and minor are orthogonal
   * and both are specified in surface-local coordinates. The center
   * of the ellipse is always at the touchpoint location as reported
   * by wl_touch.down or wl_touch.move.
   *
   * This event is only sent by the compositor if the touch device
   * supports shape reports. The client has to make reasonable
   * assumptions about the shape if it did not receive this event.
   * @param id the unique ID of this touch point
   * @param major length of the major axis in surface-local coordinates
   * @param minor length of the minor axis in surface-local coordinates
   * @since 6
   */
  void (*shape)(data: rawptr,
          struct wl_touch *wl_touch,
          int32_t id,
          wl_fixed_t major,
          wl_fixed_t minor)
  /**
   * update orientation of touch point
   *
   * Sent when a touchpoint has changed its orientation.
   *
   * This event does not occur on its own. It is sent before a
   * wl_touch.frame event and carries the new shape information for
   * any previously reported, or new touch points of that frame.
   *
   * Other events describing the touch point such as wl_touch.down,
   * wl_touch.motion or wl_touch.shape may be sent within the same
   * wl_touch.frame. A client should treat these events as a single
   * logical touch point update. The order of wl_touch.shape,
   * wl_touch.orientation and wl_touch.motion is not guaranteed. A
   * wl_touch.down event is guaranteed to occur before the first
   * wl_touch.orientation event for this touch ID but both events may
   * occur within the same wl_touch.frame.
   *
   * The orientation describes the clockwise angle of a touchpoint's
   * major axis to the positive surface y-axis and is normalized to
   * the -180 to +180 degree range. The granularity of orientation
   * depends on the touch device, some devices only support binary
   * rotation values between 0 and 90 degrees.
   *
   * This event is only sent by the compositor if the touch device
   * supports orientation reports.
   * @param id the unique ID of this touch point
   * @param orientation angle between major axis and positive surface y-axis in degrees
   * @since 6
   */
  void (*orientation)(data: rawptr,
          struct wl_touch *wl_touch,
          int32_t id,
          wl_fixed_t orientation)
}

/**
 * @ingroup iface_wl_touch
 */
static inline int
wl_touch_add_listener :: #force_inline proc "c" (struct wl_touch *wl_touch,
          const struct wl_touch_listener *listener, data: rawptr)
{
  return wl_proxy_add_listener((struct wl_proxy *) wl_touch,
             (^^proc())(listener), data)
}

#define WL_TOUCH_RELEASE 0

/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_DOWN_SINCE_VERSION 1
/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_UP_SINCE_VERSION 1
/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_MOTION_SINCE_VERSION 1
/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_FRAME_SINCE_VERSION 1
/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_CANCEL_SINCE_VERSION 1
/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_SHAPE_SINCE_VERSION 6
/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_ORIENTATION_SINCE_VERSION 6

/**
 * @ingroup iface_wl_touch
 */
#define WL_TOUCH_RELEASE_SINCE_VERSION 3

/** @ingroup iface_wl_touch */

wl_touch_set_user_data :: #force_inline proc "c" (struct wl_touch *wl_touch, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_touch, user_data)
}

/** @ingroup iface_wl_touch */
wl_touch_get_user_data :: #force_inline proc "c" (struct wl_touch *wl_touch) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_touch)
}

wl_touch_get_version :: #force_inline proc "c" (struct wl_touch *wl_touch) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_touch)
}

/** @ingroup iface_wl_touch */

wl_touch_destroy :: #force_inline proc "c" (struct wl_touch *wl_touch) {
  wl_proxy_destroy((struct wl_proxy *) wl_touch)
}

/**
 * @ingroup iface_wl_touch
 */

wl_touch_release :: #force_inline proc "c" (struct wl_touch *wl_touch) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_touch,
       WL_TOUCH_RELEASE, nil, wl_proxy_get_version((struct wl_proxy *) wl_touch), WL_MARSHAL_FLAG_DESTROY)
}

#ifndef WL_OUTPUT_SUBPIXEL_ENUM
#define WL_OUTPUT_SUBPIXEL_ENUM
/**
 * @ingroup iface_wl_output
 * subpixel geometry information
 *
 * This enumeration describes how the physical
 * pixels on an output are laid out.
 */
enum wl_output_subpixel {
  /**
   * unknown geometry
   */
  WL_OUTPUT_SUBPIXEL_UNKNOWN = 0,
  /**
   * no geometry
   */
  WL_OUTPUT_SUBPIXEL_NONE = 1,
  /**
   * horizontal RGB
   */
  WL_OUTPUT_SUBPIXEL_HORIZONTAL_RGB = 2,
  /**
   * horizontal BGR
   */
  WL_OUTPUT_SUBPIXEL_HORIZONTAL_BGR = 3,
  /**
   * vertical RGB
   */
  WL_OUTPUT_SUBPIXEL_VERTICAL_RGB = 4,
  /**
   * vertical BGR
   */
  WL_OUTPUT_SUBPIXEL_VERTICAL_BGR = 5,
}
#endif /* WL_OUTPUT_SUBPIXEL_ENUM */

#ifndef WL_OUTPUT_TRANSFORM_ENUM
#define WL_OUTPUT_TRANSFORM_ENUM
/**
 * @ingroup iface_wl_output
 * transform from framebuffer to output
 *
 * This describes the transform that a compositor will apply to a
 * surface to compensate for the rotation or mirroring of an
 * output device.
 *
 * The flipped values correspond to an initial flip around a
 * vertical axis followed by rotation.
 *
 * The purpose is mainly to allow clients to render accordingly and
 * tell the compositor, so that for fullscreen surfaces, the
 * compositor will still be able to scan out directly from client
 * surfaces.
 */
enum wl_output_transform {
  /**
   * no transform
   */
  WL_OUTPUT_TRANSFORM_NORMAL = 0,
  /**
   * 90 degrees counter-clockwise
   */
  WL_OUTPUT_TRANSFORM_90 = 1,
  /**
   * 180 degrees counter-clockwise
   */
  WL_OUTPUT_TRANSFORM_180 = 2,
  /**
   * 270 degrees counter-clockwise
   */
  WL_OUTPUT_TRANSFORM_270 = 3,
  /**
   * 180 degree flip around a vertical axis
   */
  WL_OUTPUT_TRANSFORM_FLIPPED = 4,
  /**
   * flip and rotate 90 degrees counter-clockwise
   */
  WL_OUTPUT_TRANSFORM_FLIPPED_90 = 5,
  /**
   * flip and rotate 180 degrees counter-clockwise
   */
  WL_OUTPUT_TRANSFORM_FLIPPED_180 = 6,
  /**
   * flip and rotate 270 degrees counter-clockwise
   */
  WL_OUTPUT_TRANSFORM_FLIPPED_270 = 7,
}
#endif /* WL_OUTPUT_TRANSFORM_ENUM */

#ifndef WL_OUTPUT_MODE_ENUM
#define WL_OUTPUT_MODE_ENUM
/**
 * @ingroup iface_wl_output
 * mode information
 *
 * These flags describe properties of an output mode.
 * They are used in the flags bitfield of the mode event.
 */
enum wl_output_mode {
  /**
   * indicates this is the current mode
   */
  WL_OUTPUT_MODE_CURRENT = 0x1,
  /**
   * indicates this is the preferred mode
   */
  WL_OUTPUT_MODE_PREFERRED = 0x2,
}
#endif /* WL_OUTPUT_MODE_ENUM */

/**
 * @ingroup iface_wl_output
 * @struct wl_output_listener
 */
struct wl_output_listener {
  /**
   * properties of the output
   *
   * The geometry event describes geometric properties of the
   * output. The event is sent when binding to the output object and
   * whenever any of the properties change.
   *
   * The physical size can be set to zero if it doesn't make sense
   * for this output (e.g. for projectors or virtual outputs).
   *
   * The geometry event will be followed by a done event (starting
   * from version 2).
   *
   * Note: wl_output only advertises partial information about the
   * output position and identification. Some compositors, for
   * instance those not implementing a desktop-style output layout or
   * those exposing virtual outputs, might fake this information.
   * Instead of using x and y, clients should use
   * xdg_output.logical_position. Instead of using make and model,
   * clients should use name and description.
   * @param x x position within the global compositor space
   * @param y y position within the global compositor space
   * @param physical_width width in millimeters of the output
   * @param physical_height height in millimeters of the output
   * @param subpixel subpixel orientation of the output
   * @param make textual description of the manufacturer
   * @param model textual description of the model
   * @param transform transform that maps framebuffer to output
   */
  void (*geometry)(data: rawptr,
       struct wl_output *wl_output,
       int32_t x,
       int32_t y,
       int32_t physical_width,
       int32_t physical_height,
       int32_t subpixel,
       const char *make,
       const char *model,
       int32_t transform)
  /**
   * advertise available modes for the output
   *
   * The mode event describes an available mode for the output.
   *
   * The event is sent when binding to the output object and there
   * will always be one mode, the current mode. The event is sent
   * again if an output changes mode, for the mode that is now
   * current. In other words, the current mode is always the last
   * mode that was received with the current flag set.
   *
   * Non-current modes are deprecated. A compositor can decide to
   * only advertise the current mode and never send other modes.
   * Clients should not rely on non-current modes.
   *
   * The size of a mode is given in physical hardware units of the
   * output device. This is not necessarily the same as the output
   * size in the global compositor space. For instance, the output
   * may be scaled, as described in wl_output.scale, or transformed,
   * as described in wl_output.transform. Clients willing to retrieve
   * the output size in the global compositor space should use
   * xdg_output.logical_size instead.
   *
   * The vertical refresh rate can be set to zero if it doesn't make
   * sense for this output (e.g. for virtual outputs).
   *
   * The mode event will be followed by a done event (starting from
   * version 2).
   *
   * Clients should not use the refresh rate to schedule frames.
   * Instead, they should use the wl_surface.frame event or the
   * presentation-time protocol.
   *
   * Note: this information is not always meaningful for all outputs.
   * Some compositors, such as those exposing virtual outputs, might
   * fake the refresh rate or the size.
   * @param flags bitfield of mode flags
   * @param width width of the mode in hardware units
   * @param height height of the mode in hardware units
   * @param refresh vertical refresh rate in mHz
   */
  void (*mode)(data: rawptr,
         struct wl_output *wl_output,
         uint32_t flags,
         int32_t width,
         int32_t height,
         int32_t refresh)
  /**
   * sent all information about output
   *
   * This event is sent after all other properties have been sent
   * after binding to the output object and after any other property
   * changes done after that. This allows changes to the output
   * properties to be seen as atomic, even if they happen via
   * multiple events.
   * @since 2
   */
  void (*done)(data: rawptr,
         struct wl_output *wl_output)
  /**
   * output scaling properties
   *
   * This event contains scaling geometry information that is not
   * in the geometry event. It may be sent after binding the output
   * object or if the output scale changes later. If it is not sent,
   * the client should assume a scale of 1.
   *
   * A scale larger than 1 means that the compositor will
   * automatically scale surface buffers by this amount when
   * rendering. This is used for very high resolution displays where
   * applications rendering at the native resolution would be too
   * small to be legible.
   *
   * It is intended that scaling aware clients track the current
   * output of a surface, and if it is on a scaled output it should
   * use wl_surface.set_buffer_scale with the scale of the output.
   * That way the compositor can avoid scaling the surface, and the
   * client can supply a higher detail image.
   *
   * The scale event will be followed by a done event.
   * @param factor scaling factor of output
   * @since 2
   */
  void (*scale)(data: rawptr,
          struct wl_output *wl_output,
          int32_t factor)
  /**
   * name of this output
   *
   * Many compositors will assign user-friendly names to their
   * outputs, show them to the user, allow the user to refer to an
   * output, etc. The client may wish to know this name as well to
   * offer the user similar behaviors.
   *
   * The name is a UTF-8 string with no convention defined for its
   * contents. Each name is unique among all wl_output globals. The
   * name is only guaranteed to be unique for the compositor
   * instance.
   *
   * The same output name is used for all clients for a given
   * wl_output global. Thus, the name can be shared across processes
   * to refer to a specific wl_output global.
   *
   * The name is not guaranteed to be persistent across sessions,
   * thus cannot be used to reliably identify an output in e.g.
   * configuration files.
   *
   * Examples of names include 'HDMI-A-1', 'WL-1', 'X11-1', etc.
   * However, do not assume that the name is a reflection of an
   * underlying DRM connector, X11 connection, etc.
   *
   * The name event is sent after binding the output object. This
   * event is only sent once per output object, and the name does not
   * change over the lifetime of the wl_output global.
   *
   * Compositors may re-use the same output name if the wl_output
   * global is destroyed and re-created later. Compositors should
   * avoid re-using the same name if possible.
   *
   * The name event will be followed by a done event.
   * @param name output name
   * @since 4
   */
  void (*name)(data: rawptr,
         struct wl_output *wl_output,
         const char *name)
  /**
   * human-readable description of this output
   *
   * Many compositors can produce human-readable descriptions of
   * their outputs. The client may wish to know this description as
   * well, e.g. for output selection purposes.
   *
   * The description is a UTF-8 string with no convention defined for
   * its contents. The description is not guaranteed to be unique
   * among all wl_output globals. Examples might include 'Foocorp 11"
   * Display' or 'Virtual X11 output via :1'.
   *
   * The description event is sent after binding the output object
   * and whenever the description changes. The description is
   * optional, and may not be sent at all.
   *
   * The description event will be followed by a done event.
   * @param description output description
   * @since 4
   */
  void (*description)(data: rawptr,
          struct wl_output *wl_output,
          const char *description)
}

/**
 * @ingroup iface_wl_output
 */
static inline int
wl_output_add_listener :: #force_inline proc "c" (struct wl_output *wl_output,
           const struct wl_output_listener *listener, data: rawptr)
{
  return wl_proxy_add_listener((struct wl_proxy *) wl_output,
             (^^proc())(listener), data)
}

#define WL_OUTPUT_RELEASE 0

/**
 * @ingroup iface_wl_output
 */
#define WL_OUTPUT_GEOMETRY_SINCE_VERSION 1
/**
 * @ingroup iface_wl_output
 */
#define WL_OUTPUT_MODE_SINCE_VERSION 1
/**
 * @ingroup iface_wl_output
 */
#define WL_OUTPUT_DONE_SINCE_VERSION 2
/**
 * @ingroup iface_wl_output
 */
#define WL_OUTPUT_SCALE_SINCE_VERSION 2
/**
 * @ingroup iface_wl_output
 */
#define WL_OUTPUT_NAME_SINCE_VERSION 4
/**
 * @ingroup iface_wl_output
 */
#define WL_OUTPUT_DESCRIPTION_SINCE_VERSION 4

/**
 * @ingroup iface_wl_output
 */
#define WL_OUTPUT_RELEASE_SINCE_VERSION 3

/** @ingroup iface_wl_output */

wl_output_set_user_data :: #force_inline proc "c" (struct wl_output *wl_output, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_output, user_data)
}

/** @ingroup iface_wl_output */
wl_output_get_user_data :: #force_inline proc "c" (struct wl_output *wl_output) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_output)
}

wl_output_get_version :: #force_inline proc "c" (struct wl_output *wl_output) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_output)
}

/** @ingroup iface_wl_output */

wl_output_destroy :: #force_inline proc "c" (struct wl_output *wl_output) {
  wl_proxy_destroy((struct wl_proxy *) wl_output)
}

/**
 * @ingroup iface_wl_output
 *
 * Using this request a client can tell the server that it is not going to
 * use the output object anymore.
 */

wl_output_release :: #force_inline proc "c" (struct wl_output *wl_output) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_output,
       WL_OUTPUT_RELEASE, nil, wl_proxy_get_version((struct wl_proxy *) wl_output), WL_MARSHAL_FLAG_DESTROY)
}

#define WL_REGION_DESTROY 0
#define WL_REGION_ADD 1
#define WL_REGION_SUBTRACT 2


/**
 * @ingroup iface_wl_region
 */
#define WL_REGION_DESTROY_SINCE_VERSION 1
/**
 * @ingroup iface_wl_region
 */
#define WL_REGION_ADD_SINCE_VERSION 1
/**
 * @ingroup iface_wl_region
 */
#define WL_REGION_SUBTRACT_SINCE_VERSION 1

/** @ingroup iface_wl_region */

wl_region_set_user_data :: #force_inline proc "c" (struct wl_region *wl_region, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_region, user_data)
}

/** @ingroup iface_wl_region */
wl_region_get_user_data :: #force_inline proc "c" (struct wl_region *wl_region) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_region)
}

wl_region_get_version :: #force_inline proc "c" (struct wl_region *wl_region) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_region)
}

/**
 * @ingroup iface_wl_region
 *
 * Destroy the region.  This will invalidate the object ID.
 */

wl_region_destroy :: #force_inline proc "c" (struct wl_region *wl_region) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_region,
       WL_REGION_DESTROY, nil, wl_proxy_get_version((struct wl_proxy *) wl_region), WL_MARSHAL_FLAG_DESTROY)
}

/**
 * @ingroup iface_wl_region
 *
 * Add the specified rectangle to the region.
 */

wl_region_add :: #force_inline proc "c" (struct wl_region *wl_region, int32_t x, int32_t y, int32_t width, int32_t height) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_region,
       WL_REGION_ADD, nil, wl_proxy_get_version((struct wl_proxy *) wl_region), 0, x, y, width, height)
}

/**
 * @ingroup iface_wl_region
 *
 * Subtract the specified rectangle from the region.
 */

wl_region_subtract :: #force_inline proc "c" (struct wl_region *wl_region, int32_t x, int32_t y, int32_t width, int32_t height) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_region,
       WL_REGION_SUBTRACT, nil, wl_proxy_get_version((struct wl_proxy *) wl_region), 0, x, y, width, height)
}

#ifndef WL_SUBCOMPOSITOR_ERROR_ENUM
#define WL_SUBCOMPOSITOR_ERROR_ENUM
enum wl_subcompositor_error {
  /**
   * the to-be sub-surface is invalid
   */
  WL_SUBCOMPOSITOR_ERROR_BAD_SURFACE = 0,
  /**
   * the to-be sub-surface parent is invalid
   */
  WL_SUBCOMPOSITOR_ERROR_BAD_PARENT = 1,
}
#endif /* WL_SUBCOMPOSITOR_ERROR_ENUM */

#define WL_SUBCOMPOSITOR_DESTROY 0
#define WL_SUBCOMPOSITOR_GET_SUBSURFACE 1


/**
 * @ingroup iface_wl_subcompositor
 */
#define WL_SUBCOMPOSITOR_DESTROY_SINCE_VERSION 1
/**
 * @ingroup iface_wl_subcompositor
 */
#define WL_SUBCOMPOSITOR_GET_SUBSURFACE_SINCE_VERSION 1

/** @ingroup iface_wl_subcompositor */

wl_subcompositor_set_user_data :: #force_inline proc "c" (struct wl_subcompositor *wl_subcompositor, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_subcompositor, user_data)
}

/** @ingroup iface_wl_subcompositor */
wl_subcompositor_get_user_data :: #force_inline proc "c" (struct wl_subcompositor *wl_subcompositor) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_subcompositor)
}

wl_subcompositor_get_version :: #force_inline proc "c" (struct wl_subcompositor *wl_subcompositor) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_subcompositor)
}

/**
 * @ingroup iface_wl_subcompositor
 *
 * Informs the server that the client will not be using this
 * protocol object anymore. This does not affect any other
 * objects, wl_subsurface objects included.
 */

wl_subcompositor_destroy :: #force_inline proc "c" (struct wl_subcompositor *wl_subcompositor) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_subcompositor,
       WL_SUBCOMPOSITOR_DESTROY, nil, wl_proxy_get_version((struct wl_proxy *) wl_subcompositor), WL_MARSHAL_FLAG_DESTROY)
}

/**
 * @ingroup iface_wl_subcompositor
 *
 * Create a sub-surface interface for the given surface, and
 * associate it with the given parent surface. This turns a
 * plain wl_surface into a sub-surface.
 *
 * The to-be sub-surface must not already have another role, and it
 * must not have an existing wl_subsurface object. Otherwise the
 * bad_surface protocol error is raised.
 *
 * Adding sub-surfaces to a parent is a double-buffered operation on the
 * parent (see wl_surface.commit). The effect of adding a sub-surface
 * becomes visible on the next time the state of the parent surface is
 * applied.
 *
 * The parent surface must not be one of the child surface's descendants,
 * and the parent must be different from the child surface, otherwise the
 * bad_parent protocol error is raised.
 *
 * This request modifies the behaviour of wl_surface.commit request on
 * the sub-surface, see the documentation on wl_subsurface interface.
 */
static inline struct wl_subsurface *
wl_subcompositor_get_subsurface :: #force_inline proc "c" (struct wl_subcompositor *wl_subcompositor, struct wl_surface *surface, struct wl_surface *parent)
{
  struct wl_proxy *id

  id = wl_proxy_marshal_flags((struct wl_proxy *) wl_subcompositor,
       WL_SUBCOMPOSITOR_GET_SUBSURFACE, &wl_subsurface_interface, wl_proxy_get_version((struct wl_proxy *) wl_subcompositor), 0, nil, surface, parent)

  return (struct wl_subsurface *) id
}

#ifndef WL_SUBSURFACE_ERROR_ENUM
#define WL_SUBSURFACE_ERROR_ENUM
enum wl_subsurface_error {
  /**
   * wl_surface is not a sibling or the parent
   */
  WL_SUBSURFACE_ERROR_BAD_SURFACE = 0,
}
#endif /* WL_SUBSURFACE_ERROR_ENUM */

#define WL_SUBSURFACE_DESTROY 0
#define WL_SUBSURFACE_SET_POSITION 1
#define WL_SUBSURFACE_PLACE_ABOVE 2
#define WL_SUBSURFACE_PLACE_BELOW 3
#define WL_SUBSURFACE_SET_SYNC 4
#define WL_SUBSURFACE_SET_DESYNC 5


/**
 * @ingroup iface_wl_subsurface
 */
#define WL_SUBSURFACE_DESTROY_SINCE_VERSION 1
/**
 * @ingroup iface_wl_subsurface
 */
#define WL_SUBSURFACE_SET_POSITION_SINCE_VERSION 1
/**
 * @ingroup iface_wl_subsurface
 */
#define WL_SUBSURFACE_PLACE_ABOVE_SINCE_VERSION 1
/**
 * @ingroup iface_wl_subsurface
 */
#define WL_SUBSURFACE_PLACE_BELOW_SINCE_VERSION 1
/**
 * @ingroup iface_wl_subsurface
 */
#define WL_SUBSURFACE_SET_SYNC_SINCE_VERSION 1
/**
 * @ingroup iface_wl_subsurface
 */
#define WL_SUBSURFACE_SET_DESYNC_SINCE_VERSION 1

/** @ingroup iface_wl_subsurface */

wl_subsurface_set_user_data :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface, user_data: rawptr) {
  wl_proxy_set_user_data((struct wl_proxy *) wl_subsurface, user_data)
}

/** @ingroup iface_wl_subsurface */
wl_subsurface_get_user_data :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface) -> rawptr {
  return wl_proxy_get_user_data((struct wl_proxy *) wl_subsurface)
}

wl_subsurface_get_version :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface) -> u32 {
  return wl_proxy_get_version((struct wl_proxy *) wl_subsurface)
}

/**
 * @ingroup iface_wl_subsurface
 *
 * The sub-surface interface is removed from the wl_surface object
 * that was turned into a sub-surface with a
 * wl_subcompositor.get_subsurface request. The wl_surface's association
 * to the parent is deleted. The wl_surface is unmapped immediately.
 */

wl_subsurface_destroy :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_subsurface,
       WL_SUBSURFACE_DESTROY, nil, wl_proxy_get_version((struct wl_proxy *) wl_subsurface), WL_MARSHAL_FLAG_DESTROY)
}

/**
 * @ingroup iface_wl_subsurface
 *
 * This schedules a sub-surface position change.
 * The sub-surface will be moved so that its origin (top left
 * corner pixel) will be at the location x, y of the parent surface
 * coordinate system. The coordinates are not restricted to the parent
 * surface area. Negative values are allowed.
 *
 * The scheduled coordinates will take effect whenever the state of the
 * parent surface is applied. When this happens depends on whether the
 * parent surface is in synchronized mode or not. See
 * wl_subsurface.set_sync and wl_subsurface.set_desync for details.
 *
 * If more than one set_position request is invoked by the client before
 * the commit of the parent surface, the position of a new request always
 * replaces the scheduled position from any previous request.
 *
 * The initial position is 0, 0.
 */

wl_subsurface_set_position :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface, int32_t x, int32_t y) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_subsurface,
       WL_SUBSURFACE_SET_POSITION, nil, wl_proxy_get_version((struct wl_proxy *) wl_subsurface), 0, x, y)
}

/**
 * @ingroup iface_wl_subsurface
 *
 * This sub-surface is taken from the stack, and put back just
 * above the reference surface, changing the z-order of the sub-surfaces.
 * The reference surface must be one of the sibling surfaces, or the
 * parent surface. Using any other surface, including this sub-surface,
 * will cause a protocol error.
 *
 * The z-order is double-buffered. Requests are handled in order and
 * applied immediately to a pending state. The final pending state is
 * copied to the active state the next time the state of the parent
 * surface is applied. When this happens depends on whether the parent
 * surface is in synchronized mode or not. See wl_subsurface.set_sync and
 * wl_subsurface.set_desync for details.
 *
 * A new sub-surface is initially added as the top-most in the stack
 * of its siblings and parent.
 */

wl_subsurface_place_above :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface, struct wl_surface *sibling) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_subsurface,
       WL_SUBSURFACE_PLACE_ABOVE, nil, wl_proxy_get_version((struct wl_proxy *) wl_subsurface), 0, sibling)
}

/**
 * @ingroup iface_wl_subsurface
 *
 * The sub-surface is placed just below the reference surface.
 * See wl_subsurface.place_above.
 */

wl_subsurface_place_below :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface, struct wl_surface *sibling) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_subsurface,
       WL_SUBSURFACE_PLACE_BELOW, nil, wl_proxy_get_version((struct wl_proxy *) wl_subsurface), 0, sibling)
}

/**
 * @ingroup iface_wl_subsurface
 *
 * Change the commit behaviour of the sub-surface to synchronized
 * mode, also described as the parent dependent mode.
 *
 * In synchronized mode, wl_surface.commit on a sub-surface will
 * accumulate the committed state in a cache, but the state will
 * not be applied and hence will not change the compositor output.
 * The cached state is applied to the sub-surface immediately after
 * the parent surface's state is applied. This ensures atomic
 * updates of the parent and all its synchronized sub-surfaces.
 * Applying the cached state will invalidate the cache, so further
 * parent surface commits do not (re-)apply old state.
 *
 * See wl_subsurface for the recursive effect of this mode.
 */

wl_subsurface_set_sync :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_subsurface,
       WL_SUBSURFACE_SET_SYNC, nil, wl_proxy_get_version((struct wl_proxy *) wl_subsurface), 0)
}

/**
 * @ingroup iface_wl_subsurface
 *
 * Change the commit behaviour of the sub-surface to desynchronized
 * mode, also described as independent or freely running mode.
 *
 * In desynchronized mode, wl_surface.commit on a sub-surface will
 * apply the pending state directly, without caching, as happens
 * normally with a wl_surface. Calling wl_surface.commit on the
 * parent surface has no effect on the sub-surface's wl_surface
 * state. This mode allows a sub-surface to be updated on its own.
 *
 * If cached state exists when wl_surface.commit is called in
 * desynchronized mode, the pending state is added to the cached
 * state, and applied as a whole. This invalidates the cache.
 *
 * Note: even if a sub-surface is set to desynchronized, a parent
 * sub-surface may override it to behave as synchronized. For details,
 * see wl_subsurface.
 *
 * If a surface's parent surface behaves as desynchronized, then
 * the cached state is applied on set_desync.
 */

wl_subsurface_set_desync :: #force_inline proc "c" (struct wl_subsurface *wl_subsurface) {
  wl_proxy_marshal_flags((struct wl_proxy *) wl_subsurface,
       WL_SUBSURFACE_SET_DESYNC, nil, wl_proxy_get_version((struct wl_proxy *) wl_subsurface), 0)
}

#ifdef  __cplusplus
}
#endif

#endif
