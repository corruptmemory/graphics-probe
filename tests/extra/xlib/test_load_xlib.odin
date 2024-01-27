package test_xlib

import "core:testing"
import xlib "extra:x11/xlib"
import "core:fmt"
import "core:os"
import "core:intrinsics"
import "core:reflect"


TEST_count := 0
TEST_fail  := 0

when ODIN_TEST {
  expect_value :: testing.expect_value
} else {
  expect_value :: proc(t: ^testing.T, value, expected: $T, loc := #caller_location) -> bool where intrinsics.type_is_comparable(T) {
    TEST_count += 1
    ok := value == expected || reflect.is_nil(value) && reflect.is_nil(expected)
    if !ok {
      TEST_fail += 1
      fmt.printf("[%v] expected %v, got %v\n", loc, expected, value)
    }
    return ok
  }
}

main :: proc() {
  t := testing.T{}

  test_load_xlib(&t)

  fmt.printf("%v/%v tests successful.\n", TEST_count - TEST_fail, TEST_count)
  if TEST_fail > 0 {
    os.exit(1)
  }
}


@(test)
test_load_xlib :: proc(t: ^testing.T) {
  loaded := xlib.xlib_global_init()

  expect_value(t, loaded, true)
}



