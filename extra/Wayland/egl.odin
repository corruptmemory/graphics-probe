//+build linux, freebsd, openbsd
package wayland

WL_EGL_PLATFORM :: 1

wl_egl_window :: struct {}

wl_egl_window_create: proc "c" (surface: ^wl_surface,
         width: int, height: int) -> ^wl_egl_window

wl_egl_window_destroy: proc "c" (egl_window: ^wl_egl_window)

wl_egl_window_resize: proc "c" (egl_window: ^wl_egl_window,
         width: int, height: int,
         dx: int, dy: int)

wl_egl_window_get_attached_size: proc "c" (egl_window: ^wl_egl_window,
        width: ^int, height: ^int)

