package test_wayland_list

import "core:testing"
import wl "extra:Wayland"
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

  test_wl_container_of(&t)

  fmt.printf("%v/%v tests successful.\n", TEST_count - TEST_fail, TEST_count)
  if TEST_fail > 0 {
    os.exit(1)
  }
}

inner_thing :: struct {
  name: string,
}

example_container :: struct {
  inner: inner_thing,
}

@(test)
test_wl_container_of :: proc(t: ^testing.T) {
  container := example_container {
    inner = {
      name = "hello",
    },
  }

  result := wl.wl_container_of(&container.inner, example_container, "inner")

  expect_value(t, result, &container)
}

list_container :: struct {
  node: int,
  list: wl.wl_list,
}


@(test)
test_wl_next_container_of :: proc(t: ^testing.T) {
  container1 := list_container {
    node = 1,
  }
  container2 := list_container {
    node = 2,
  }

  container1.list.next = &container2.list
  container2.list.prev = &container1.list

  result := wl.wl_next_container_of(&container1.list, list_container, "list")
  result1 := wl.wl_next_container_of(&result.list, list_container, "list")

  expect_value(t, result, &container2)
  expect_value(t, result1, nil)
}


@(test)
test_wl_prev_container_of :: proc(t: ^testing.T) {
  container1 := list_container {
    node = 1,
  }
  container2 := list_container {
    node = 2,
  }

  container1.list.next = &container2.list
  container2.list.prev = &container1.list

  result := wl.wl_prev_container_of(&container2.list, list_container, "list")
  result1 := wl.wl_prev_container_of(&result.list, list_container, "list")

  expect_value(t, result, &container1)
  expect_value(t, result1, nil)
}


@(test)
test_forward_for_of :: proc(t: ^testing.T) {
  container1 := list_container {
    node = 5,
  }
  container2 := list_container {
    node = 8,
  }

  container1.list.next = &container2.list
  container2.list.prev = &container1.list

  sum: int
  for c := &container1; c != nil; c = wl.wl_next_container_of(&c.list, list_container, "list") {
    sum += c.node
  }

  expect_value(t, sum, 13)
}