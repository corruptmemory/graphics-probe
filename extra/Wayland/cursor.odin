package wayland

wl_cursor_theme :: struct {}
wl_buffer :: struct {}
wl_shm :: struct {}

wl_cursor_image :: struct {
  /** Actual width */
  width: u32,

  /** Actual height */
  height: u32,

  /** Hot spot x (must be inside image) */
  hotspot_x: u32,

  /** Hot spot y (must be inside image) */
  hotspot_y: u32,

  /** Animation delay to next frame (ms) */
  delay: u32,
}

wl_cursor :: struct {
  /** How many images there are in this cursor’s animation */
  image_count: uint,

  /** The array of still images composing this animation */
  images: [^]^wl_cursor_image,

  /** The name of this cursor */
  name: cstring,
}

wl_cursor_theme_load: proc "c" (name: cstring, size: int, shm: ^wl_shm) -> ^wl_cursor_theme

wl_cursor_theme_destroy: proc "c" (theme: ^wl_cursor_theme)

wl_cursor_theme_get_cursor: proc "c" (theme: ^wl_cursor_theme, name: cstring) -> ^wl_cursor

wl_cursor_image_get_buffer: proc "c" (image: ^wl_cursor_image) -> ^wl_buffer

wl_cursor_frame: proc "c" (cursor: ^wl_cursor, time: u32) -> int

wl_cursor_frame_and_duration: proc "c" (cursor: ^wl_cursor, time: u32, duration: ^u32) -> int
