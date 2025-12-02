package main

import "core:slice"
import "core:log"
import "core:os"
import "core:strings"
import "core:fmt"
import "core:strconv"

part_1 :: proc(content: []string) {
  sum := 0

  for range in content {
    items := strings.split(range, "-", context.temp_allocator)
    from, ok := strconv.parse_int(items[0])
    to, ok2 := strconv.parse_int(items[1])

    for idx := from; idx <= to; idx += 1 {
      str := fmt.tprint(idx)
      if len(str) % 2 != 0 do continue

      first_half := str[0:len(str) / 2]
      second_half := str[len(str) / 2:len(str)]

      if first_half == second_half {
        fmt.println(idx)
        sum += idx
      }
    }
  }

  fmt.println(sum)
}

part_2 :: proc(content: []string) {
  sum := 0

  for range in content {
    items := strings.split(range, "-", context.temp_allocator)
    from, ok := strconv.parse_int(items[0])
    to, ok2 := strconv.parse_int(items[1])

    for idx := from; idx <= to; idx += 1 {
      str := fmt.tprint(idx)

      for y in 1..<len(str) / 2 + 1 {
        result := slice.unique(strings.split(str, str[0:y]))
        if len(result) == 1 && result[0] == "" {
          fmt.println(idx)
          sum += idx
          break
        }
      }
    }

    fmt.println(sum)
  }
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

  part_1(content)
  part_2(content)
}
