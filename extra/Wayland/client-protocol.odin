//+build linux, freebsd, openbsd
package wayland

wl_buffer :: struct {}
wl_callback :: struct {}
wl_compositor :: struct {}
wl_data_device :: struct {}
wl_data_device_manager :: struct {}
wl_data_offer :: struct {}
wl_data_source :: struct {}
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
  global: proc "c" (data: rawptr, wl_registry: ^wl_registry, name: u32, interface: cstring, version: u32),
  global_remove: proc "c" (data: rawptr, wl_registry: ^wl_registry, name: u32),
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
       WL_REGISTRY_BIND, interface, version, 0, name, interface.name, version, nil)

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
  enter: proc "c" (data: rawptr, wl_data_device: ^wl_data_device, serial: u32, surface: ^wl_surface, x: wl_fixed, y: wl_fixed, id: ^wl_data_offer),
  leave: proc "c" (data: rawptr, wl_data_device: ^wl_data_device),
  motion: proc "c" (data: rawptr, wl_data_device: ^wl_data_device, time: u32, x: wl_fixed, y: wl_fixed),
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

wl_data_device_manager_get_data_device :: #force_inline proc "c" (wl_data_device_manager: ^wl_data_device_manager, seat: ^wl_seat) -> ^wl_data_device {
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

wl_shell_surface_resize_enum :: enum {
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
       WL_SHELL_SURFACE_SET_CLASS, nil, wl_proxy_get_version((^wl_proxy)(wl_shell_surface)), 0, class)
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
wl_seat_add_listener :: #force_inline proc "c" (wl_seat: ^wl_seat,
         listener: ^wl_seat_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_seat),
             (^^proc())(listener), data)
}

WL_SEAT_GET_POINTER :: 0
WL_SEAT_GET_KEYBOARD :: 1
WL_SEAT_GET_TOUCH :: 2
WL_SEAT_RELEASE :: 3
WL_SEAT_CAPABILITIES_SINCE_VERSION :: 1
WL_SEAT_NAME_SINCE_VERSION :: 2
WL_SEAT_GET_POINTER_SINCE_VERSION :: 1
WL_SEAT_GET_KEYBOARD_SINCE_VERSION :: 1
WL_SEAT_GET_TOUCH_SINCE_VERSION :: 1
WL_SEAT_RELEASE_SINCE_VERSION :: 5

wl_seat_set_user_data :: #force_inline proc "c" (wl_seat: ^wl_seat, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_seat), user_data)
}

wl_seat_get_user_data :: #force_inline proc "c" (wl_seat: ^wl_seat) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_seat))
}

wl_seat_get_version :: #force_inline proc "c" (wl_seat: ^wl_seat) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_seat))
}

wl_seat_destroy :: #force_inline proc "c" (wl_seat: ^wl_seat) {
  wl_proxy_destroy((^wl_proxy)(wl_seat))
}

wl_seat_get_pointer :: #force_inline proc "c" (wl_seat: ^wl_seat) -> ^wl_pointer {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_seat),
       WL_SEAT_GET_POINTER, &wl_pointer_interface, wl_proxy_get_version((^wl_proxy)(wl_seat)), 0, nil)

  return (^wl_pointer)(id)
}

wl_seat_get_keyboard :: #force_inline proc "c" (wl_seat: ^wl_seat) -> ^wl_keyboard  {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_seat),
       WL_SEAT_GET_KEYBOARD, &wl_keyboard_interface, wl_proxy_get_version((^wl_proxy)(wl_seat)), 0, nil)

  return (^wl_keyboard)(id)
}

wl_seat_get_touch :: #force_inline proc "c" (wl_seat: ^wl_seat) -> ^wl_touch {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_seat),
       WL_SEAT_GET_TOUCH, &wl_touch_interface, wl_proxy_get_version((^wl_proxy)(wl_seat)), 0, nil)

  return (^wl_touch)(id)
}

wl_seat_release :: #force_inline proc "c" (wl_seat: ^wl_seat) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_seat),
       WL_SEAT_RELEASE, nil, wl_proxy_get_version((^wl_proxy)(wl_seat)), WL_MARSHAL_FLAG_DESTROY)
}

wl_pointer_error :: enum {
  /**
   * given wl_surface has another role
   */
  WL_POINTER_ERROR_ROLE = 0,
}

wl_pointer_button_state :: enum {
  /**
   * the button is not pressed
   */
  WL_POINTER_BUTTON_STATE_RELEASED = 0,
  /**
   * the button is pressed
   */
  WL_POINTER_BUTTON_STATE_PRESSED = 1,
}

wl_pointer_axis :: enum {
  /**
   * vertical axis
   */
  WL_POINTER_AXIS_VERTICAL_SCROLL = 0,
  /**
   * horizontal axis
   */
  WL_POINTER_AXIS_HORIZONTAL_SCROLL = 1,
}

wl_pointer_axis_source :: enum {
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

WL_POINTER_AXIS_SOURCE_WHEEL_TILT_SINCE_VERSION :: 6

wl_pointer_axis_relative_direction :: enum {
  /**
   * physical motion matches axis direction
   */
  WL_POINTER_AXIS_RELATIVE_DIRECTION_IDENTICAL = 0,
  /**
   * physical motion is the inverse of the axis direction
   */
  WL_POINTER_AXIS_RELATIVE_DIRECTION_INVERTED = 1,
}

wl_pointer_listener :: struct {
  enter: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, serial: u32, surface: ^wl_surface, surface_x: wl_fixed, surface_y: wl_fixed),
  leave: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, serial: u32, surface: ^wl_surface),
  motion: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, time: u32, surface_x: wl_fixed, surface_y: wl_fixed),
  button: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, serial: u32, time: u32, button: u32, state: u32),
  axis: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, time: u32, axis: u32, value: wl_fixed),
  frame: proc "c" (data: rawptr, wl_pointer: ^wl_pointer),
  axis_source: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, axis_source: u32),
  axis_stop: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, time: u32, axis: u32),
  axis_discrete: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, axis: u32, discrete: i32),
  axis_value120: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, axis: u32, value120: i32),
  axis_relative_direction: proc "c" (data: rawptr, wl_pointer: ^wl_pointer, axis: u32, direction: u32),
}

wl_pointer_add_listener :: #force_inline proc "c" (wl_pointer: ^wl_pointer,
      listener: ^wl_pointer_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_pointer),
             (^^proc())(listener), data)
}

WL_POINTER_SET_CURSOR :: 0
WL_POINTER_RELEASE :: 1
WL_POINTER_ENTER_SINCE_VERSION :: 1
WL_POINTER_LEAVE_SINCE_VERSION :: 1
WL_POINTER_MOTION_SINCE_VERSION :: 1
WL_POINTER_BUTTON_SINCE_VERSION :: 1
WL_POINTER_AXIS_SINCE_VERSION :: 1
WL_POINTER_FRAME_SINCE_VERSION :: 5
WL_POINTER_AXIS_SOURCE_SINCE_VERSION :: 5
WL_POINTER_AXIS_STOP_SINCE_VERSION :: 5
WL_POINTER_AXIS_DISCRETE_SINCE_VERSION :: 5
WL_POINTER_AXIS_VALUE120_SINCE_VERSION :: 8
WL_POINTER_AXIS_RELATIVE_DIRECTION_SINCE_VERSION :: 9
WL_POINTER_SET_CURSOR_SINCE_VERSION :: 1
WL_POINTER_RELEASE_SINCE_VERSION :: 3

wl_pointer_set_user_data :: #force_inline proc "c" (wl_pointer: ^wl_pointer, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_pointer), user_data)
}

wl_pointer_get_user_data :: #force_inline proc "c" (wl_pointer: ^wl_pointer) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_pointer))
}

wl_pointer_get_version :: #force_inline proc "c" (wl_pointer: ^wl_pointer) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_pointer))
}

wl_pointer_destroy :: #force_inline proc "c" (wl_pointer: ^wl_pointer) {
  wl_proxy_destroy((^wl_proxy)(wl_pointer))
}


wl_pointer_set_cursor :: #force_inline proc "c" (wl_pointer: ^wl_pointer, serial: u32, surface: ^wl_surface, hotspot_x: i32, hotspot_y: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_pointer),
       WL_POINTER_SET_CURSOR, nil, wl_proxy_get_version((^wl_proxy)(wl_pointer)), 0, serial, surface, hotspot_x, hotspot_y)
}

wl_pointer_release :: #force_inline proc "c" (wl_pointer: ^wl_pointer) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_pointer),
       WL_POINTER_RELEASE, nil, wl_proxy_get_version((^wl_proxy)(wl_pointer)), WL_MARSHAL_FLAG_DESTROY)
}

wl_keyboard_keymap_format :: enum {
  /**
   * no keymap; client must understand how to interpret the raw keycode
   */
  WL_KEYBOARD_KEYMAP_FORMAT_NO_KEYMAP = 0,
  /**
   * libxkbcommon compatible, nil-terminated string; to determine the xkb keycode, clients must add 8 to the key event keycode
   */
  WL_KEYBOARD_KEYMAP_FORMAT_XKB_V1 = 1,
}

wl_keyboard_key_state :: enum {
  /**
   * key is not pressed
   */
  WL_KEYBOARD_KEY_STATE_RELEASED = 0,
  /**
   * key is pressed
   */
  WL_KEYBOARD_KEY_STATE_PRESSED = 1,
}

wl_keyboard_listener :: struct {
  keymap: proc "c" (data: rawptr, wl_keyboard: ^wl_keyboard, format: u32, fd: i32, size: u32),
  enter: proc "c" (data: rawptr, wl_keyboard: ^wl_keyboard, serial: u32, surface: ^wl_surface, keys: ^wl_array),
  leave: proc "c" (data: rawptr, wl_keyboard: ^wl_keyboard, serial: u32, surface: ^wl_surface),
  key: proc "c" (data: rawptr, wl_keyboard: ^wl_keyboard, serial: u32, time: u32, key: u32, state: u32),
  modifiers: proc "c" (data: rawptr, wl_keyboard: ^wl_keyboard, serial: u32, mods_depressed: u32, mods_latched: u32, mods_locked: u32, group: u32),
  repeate_info: proc "c" (data: rawptr, wl_keyboard: ^wl_keyboard, rate: i32, delay: i32),
}

wl_keyboard_add_listener :: #force_inline proc "c" (wl_keyboard: ^wl_keyboard,
       listener: ^wl_keyboard_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_keyboard),
             (^^proc())(listener), data)
}

WL_KEYBOARD_RELEASE :: 0
WL_KEYBOARD_KEYMAP_SINCE_VERSION :: 1
WL_KEYBOARD_ENTER_SINCE_VERSION :: 1
WL_KEYBOARD_LEAVE_SINCE_VERSION :: 1
WL_KEYBOARD_KEY_SINCE_VERSION :: 1
WL_KEYBOARD_MODIFIERS_SINCE_VERSION :: 1
WL_KEYBOARD_REPEAT_INFO_SINCE_VERSION :: 4
WL_KEYBOARD_RELEASE_SINCE_VERSION :: 3

wl_keyboard_set_user_data :: #force_inline proc "c" (wl_keyboard: ^wl_keyboard, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_keyboard), user_data)
}

wl_keyboard_get_user_data :: #force_inline proc "c" (wl_keyboard: ^wl_keyboard) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_keyboard))
}

wl_keyboard_get_version :: #force_inline proc "c" (wl_keyboard: ^wl_keyboard) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_keyboard))
}

wl_keyboard_destroy :: #force_inline proc "c" (wl_keyboard: ^wl_keyboard) {
  wl_proxy_destroy((^wl_proxy)(wl_keyboard))
}

wl_keyboard_release :: #force_inline proc "c" (wl_keyboard: ^wl_keyboard) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_keyboard),
       WL_KEYBOARD_RELEASE, nil, wl_proxy_get_version((^wl_proxy)(wl_keyboard)), WL_MARSHAL_FLAG_DESTROY)
}

wl_touch_listener :: struct {
  down: proc "c" (data: rawptr, wl_touch: ^wl_touch, serial: u32, time: u32, surface: ^wl_surface, id: i32, x: wl_fixed, y: wl_fixed),
  up: proc "c" (data: rawptr, wl_touch: ^wl_touch, serial: u32, time: u32, id: i32),
  motion: proc "c" (data: rawptr, wl_touch: ^wl_touch, time: u32, id: i32, x: wl_fixed, y: wl_fixed),
  frame: proc "c" (data: rawptr, wl_touch: ^wl_touch),
  cancel: proc "c" (data: rawptr, wl_touch: ^wl_touch),
  shape: proc "c" (data: rawptr, wl_touch: ^wl_touch, id: i32, major: wl_fixed, minor: wl_fixed),
  orientation: proc "c" (data: rawptr, wl_touch: ^wl_touch, id: i32, orientation: wl_fixed),
}

wl_touch_add_listener :: #force_inline proc "c" (wl_touch: ^wl_touch,
          listener: ^wl_touch_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_touch),
             (^^proc())(listener), data)
}

WL_TOUCH_RELEASE :: 0
WL_TOUCH_DOWN_SINCE_VERSION :: 1
WL_TOUCH_UP_SINCE_VERSION :: 1
WL_TOUCH_MOTION_SINCE_VERSION :: 1
WL_TOUCH_FRAME_SINCE_VERSION :: 1
WL_TOUCH_CANCEL_SINCE_VERSION :: 1
WL_TOUCH_SHAPE_SINCE_VERSION :: 6
WL_TOUCH_ORIENTATION_SINCE_VERSION :: 6
WL_TOUCH_RELEASE_SINCE_VERSION :: 3

wl_touch_set_user_data :: #force_inline proc "c" (wl_touch: ^wl_touch, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_touch), user_data)
}

wl_touch_get_user_data :: #force_inline proc "c" (wl_touch: ^wl_touch) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_touch))
}

wl_touch_get_version :: #force_inline proc "c" (wl_touch: ^wl_touch) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_touch))
}

wl_touch_destroy :: #force_inline proc "c" (wl_touch: ^wl_touch) {
  wl_proxy_destroy((^wl_proxy)(wl_touch))
}

wl_touch_release :: #force_inline proc "c" (wl_touch: ^wl_touch) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_touch),
       WL_TOUCH_RELEASE, nil, wl_proxy_get_version((^wl_proxy)(wl_touch)), WL_MARSHAL_FLAG_DESTROY)
}

wl_output_subpixel :: enum {
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

wl_output_transform :: enum {
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

wl_output_mode :: enum {
  /**
   * indicates this is the current mode
   */
  WL_OUTPUT_MODE_CURRENT = 0x1,
  /**
   * indicates this is the preferred mode
   */
  WL_OUTPUT_MODE_PREFERRED = 0x2,
}

wl_output_listener :: struct {
  geometry: proc "c" (data: rawptr, wl_output: ^wl_output, x: i32, y: i32, physical_width: i32, physical_height: i32, subpixel: i32, make: cstring, model: cstring, transform: i32),
  mode: proc "c" (data: rawptr, wl_output: ^wl_output, flags: u32, width: i32, height: i32, refresh: i32),
  done: proc "c" (data: rawptr, wl_output: ^wl_output),
  scale: proc "c" (data: rawptr, wl_output: ^wl_output, factor: i32),
  name: proc "c" (data: rawptr, wl_output: ^wl_output, name: cstring),
  description: proc "c" (data: rawptr, wl_output: ^wl_output, description: cstring),
}

wl_output_add_listener :: #force_inline proc "c" (wl_output: ^wl_output,
           listener: ^wl_output_listener, data: rawptr) -> int {
  return wl_proxy_add_listener((^wl_proxy)(wl_output),
             (^^proc())(listener), data)
}

WL_OUTPUT_RELEASE :: 0
WL_OUTPUT_GEOMETRY_SINCE_VERSION :: 1
WL_OUTPUT_MODE_SINCE_VERSION :: 1
WL_OUTPUT_DONE_SINCE_VERSION :: 2
WL_OUTPUT_SCALE_SINCE_VERSION :: 2
WL_OUTPUT_NAME_SINCE_VERSION :: 4
WL_OUTPUT_DESCRIPTION_SINCE_VERSION :: 4
WL_OUTPUT_RELEASE_SINCE_VERSION :: 3

wl_output_set_user_data :: #force_inline proc "c" (wl_output: ^wl_output, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_output), user_data)
}

wl_output_get_user_data :: #force_inline proc "c" (wl_output: ^wl_output) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_output))
}

wl_output_get_version :: #force_inline proc "c" (wl_output: ^wl_output) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_output))
}

wl_output_destroy :: #force_inline proc "c" (wl_output: ^wl_output) {
  wl_proxy_destroy((^wl_proxy)(wl_output))
}

wl_output_release :: #force_inline proc "c" (wl_output: ^wl_output) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_output),
       WL_OUTPUT_RELEASE, nil, wl_proxy_get_version((^wl_proxy)(wl_output)), WL_MARSHAL_FLAG_DESTROY)
}

WL_REGION_DESTROY :: 0
WL_REGION_ADD :: 1
WL_REGION_SUBTRACT :: 2
WL_REGION_DESTROY_SINCE_VERSION :: 1
WL_REGION_ADD_SINCE_VERSION :: 1
WL_REGION_SUBTRACT_SINCE_VERSION :: 1

wl_region_set_user_data :: #force_inline proc "c" (wl_region: ^wl_region, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_region), user_data)
}

/** @ingroup iface_wl_region */
wl_region_get_user_data :: #force_inline proc "c" (wl_region: ^wl_region) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_region))
}

wl_region_get_version :: #force_inline proc "c" (wl_region: ^wl_region) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_region))
}

/**
 * @ingroup iface_wl_region
 *
 * Destroy the region.  This will invalidate the object ID.
 */

wl_region_destroy :: #force_inline proc "c" (wl_region: ^wl_region) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_region),
       WL_REGION_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_region)), WL_MARSHAL_FLAG_DESTROY)
}

/**
 * @ingroup iface_wl_region
 *
 * Add the specified rectangle to the region.
 */

wl_region_add :: #force_inline proc "c" (wl_region: ^wl_region, x: i32, y: i32, width: i32, height: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_region),
       WL_REGION_ADD, nil, wl_proxy_get_version((^wl_proxy)(wl_region)), 0, x, y, width, height)
}

/**
 * @ingroup iface_wl_region
 *
 * Subtract the specified rectangle from the region.
 */

wl_region_subtract :: #force_inline proc "c" (wl_region: ^wl_region, x: i32, y: i32, width: i32, height: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_region),
       WL_REGION_SUBTRACT, nil, wl_proxy_get_version((^wl_proxy)(wl_region)), 0, x, y, width, height)
}

wl_subcompositor_error :: enum{
  /**
   * the to-be sub-surface is invalid
   */
  WL_SUBCOMPOSITOR_ERROR_BAD_SURFACE = 0,
  /**
   * the to-be sub-surface parent is invalid
   */
  WL_SUBCOMPOSITOR_ERROR_BAD_PARENT = 1,
}

WL_SUBCOMPOSITOR_DESTROY :: 0
WL_SUBCOMPOSITOR_GET_SUBSURFACE :: 1
WL_SUBCOMPOSITOR_DESTROY_SINCE_VERSION :: 1
WL_SUBCOMPOSITOR_GET_SUBSURFACE_SINCE_VERSION :: 1

wl_subcompositor_set_user_data :: #force_inline proc "c" (wl_subcompositor: ^wl_subcompositor, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_subcompositor), user_data)
}

/** @ingroup iface_wl_subcompositor */
wl_subcompositor_get_user_data :: #force_inline proc "c" (wl_subcompositor: ^wl_subcompositor) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_subcompositor))
}

wl_subcompositor_get_version :: #force_inline proc "c" (wl_subcompositor: ^wl_subcompositor) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_subcompositor))
}

wl_subcompositor_destroy :: #force_inline proc "c" (wl_subcompositor: ^wl_subcompositor) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_subcompositor),
       WL_SUBCOMPOSITOR_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_subcompositor)), WL_MARSHAL_FLAG_DESTROY)
}

wl_subcompositor_get_subsurface :: #force_inline proc "c" (wl_subcompositor: ^wl_subcompositor, surface: ^wl_surface, parent: ^wl_surface) -> ^wl_subsurface {
  id := wl_proxy_marshal_flags((^wl_proxy)(wl_subcompositor),
       WL_SUBCOMPOSITOR_GET_SUBSURFACE, &wl_subsurface_interface, wl_proxy_get_version((^wl_proxy)(wl_subcompositor)), 0, nil, surface, parent)

  return (^wl_subsurface)(id)
}

wl_subsurface_error :: enum{
  /**
   * wl_surface is not a sibling or the parent
   */
  WL_SUBSURFACE_ERROR_BAD_SURFACE = 0,
}

WL_SUBSURFACE_DESTROY :: 0
WL_SUBSURFACE_SET_POSITION :: 1
WL_SUBSURFACE_PLACE_ABOVE :: 2
WL_SUBSURFACE_PLACE_BELOW :: 3
WL_SUBSURFACE_SET_SYNC :: 4
WL_SUBSURFACE_SET_DESYNC :: 5
WL_SUBSURFACE_DESTROY_SINCE_VERSION :: 1
WL_SUBSURFACE_SET_POSITION_SINCE_VERSION :: 1
WL_SUBSURFACE_PLACE_ABOVE_SINCE_VERSION :: 1
WL_SUBSURFACE_PLACE_BELOW_SINCE_VERSION :: 1
WL_SUBSURFACE_SET_SYNC_SINCE_VERSION :: 1
WL_SUBSURFACE_SET_DESYNC_SINCE_VERSION :: 1

wl_subsurface_set_user_data :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface, user_data: rawptr) {
  wl_proxy_set_user_data((^wl_proxy)(wl_subsurface), user_data)
}

wl_subsurface_get_user_data :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface) -> rawptr {
  return wl_proxy_get_user_data((^wl_proxy)(wl_subsurface))
}

wl_subsurface_get_version :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface) -> u32 {
  return wl_proxy_get_version((^wl_proxy)(wl_subsurface))
}

wl_subsurface_destroy :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_subsurface),
       WL_SUBSURFACE_DESTROY, nil, wl_proxy_get_version((^wl_proxy)(wl_subsurface)), WL_MARSHAL_FLAG_DESTROY)
}

wl_subsurface_set_position :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface, x: i32, y: i32) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_subsurface),
       WL_SUBSURFACE_SET_POSITION, nil, wl_proxy_get_version((^wl_proxy)(wl_subsurface)), 0, x, y)
}

wl_subsurface_place_above :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface, sibling: ^wl_surface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_subsurface),
       WL_SUBSURFACE_PLACE_ABOVE, nil, wl_proxy_get_version((^wl_proxy)(wl_subsurface)), 0, sibling)
}

wl_subsurface_place_below :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface, sibling: ^wl_surface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_subsurface),
       WL_SUBSURFACE_PLACE_BELOW, nil, wl_proxy_get_version((^wl_proxy)(wl_subsurface)), 0, sibling)
}

wl_subsurface_set_sync :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_subsurface),
       WL_SUBSURFACE_SET_SYNC, nil, wl_proxy_get_version((^wl_proxy)(wl_subsurface)), 0)
}


wl_subsurface_set_desync :: #force_inline proc "c" (wl_subsurface: ^wl_subsurface) {
  wl_proxy_marshal_flags((^wl_proxy)(wl_subsurface),
       WL_SUBSURFACE_SET_DESYNC, nil, wl_proxy_get_version((^wl_proxy)(wl_subsurface)), 0)
}
