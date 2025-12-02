package day

import "core:slice"
import "core:log"
import "core:os"
import "core:strings"
import "core:fmt"
import "core:strconv"

part_1 :: proc(str: string) -> bool {
  if len(str) % 2 != 0 do return false

  first_half := str[0:len(str) / 2]
  second_half := str[len(str) / 2:len(str)]

  if first_half == second_half {
    fmt.println(str)
    return true
  }

  return false
}

part_2 :: proc(str: string) -> bool {
  for y in 1..<len(str) / 2 + 1 {
    result := slice.unique(strings.split(str, str[0:y]))
    if len(result) == 1 && result[0] == "" {
      fmt.println(str)

      return true
    }
  }

  return false
}

run_with_callback :: proc(content: []string, callback: proc(str: string) -> bool) -> int {
  sum := 0

  for range in content {
    items := strings.split(range, "-", context.temp_allocator)
    from, _ := strconv.parse_int(items[0])
    to, _ := strconv.parse_int(items[1])

    for idx := from; idx <= to; idx += 1 {
      str := fmt.tprint(idx)

      if callback(str) do sum += idx
    }
  }

  return sum
}

main :: proc() {
  context.logger = log.create_console_logger(.Debug, {.Level, .Time, .Short_File_Path, .Line, .Procedure, .Terminal_Color})

  data, ok := os.read_entire_file(os.args[1], context.allocator)
  defer delete(data, context.allocator)

  if !ok {
    log.error("Error reading file")
    os.exit(1)
  }

  text := string(data)
  content := strings.split(text, ",", context.temp_allocator)

  fmt.println("Part 1:", run_with_callback(content, part_1))
  fmt.println("Part 2:", run_with_callback(content, part_2))
}
