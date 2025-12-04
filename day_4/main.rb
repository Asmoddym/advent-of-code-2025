
class Base
  def input
    @input ||= File.read(ARGV.first).split("\n")
  end
end

class Part1 < Base
  def process_current_state
    coords = []

    input.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        next unless char == '@'

        min_x = [x - 1, 0].max
        max_x = [x + 1, line.size].min

        str = line[min_x..max_x]
        str += input[y - 1][min_x..max_x] if y > 0
        str += input[y + 1][min_x..max_x] if y < input.size - 1

        boxes = str.count("@") - 1

        coords << [y, x] if boxes < 4
      end
    end

    coords
  end

  def perform
    puts process_current_state.size
  end
end

class Part2 < Part1
  def perform
    count = 0

    loop do
      coords = process_current_state
      break if coords.size == 0

      coords.each { |coord| input[coord[0]][coord[1]] = '.' }

      count += coords.size
    end

    puts count
  end
end

def with_timer
  start_time = Time.now
  yield
  end_time = Time.now
  puts "> #{end_time - start_time}"
end

with_timer { Part1.new.perform }
with_timer { Part2.new.perform }

