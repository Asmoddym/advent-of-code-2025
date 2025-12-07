require 'pry'

class Base
  def input
    @input ||= File.read(ARGV.first).split("\n")
  end
end

class Part1 < Base
  def columns
    @columns ||= begin
                   column_positions = input.last.to_enum(:scan, /[^ ]/).map { Regexp.last_match.offset(0).first }

                   column_positions.each_with_object([]).with_index do |(from, results), idx|
                     to = idx + 1 == column_positions.size ? input.last.size : column_positions[idx + 1]

                     result = {nums: [], op: nil}

                     (input.size - 1).times do |y|
                       offset = 1 # for the beginning of next op
                       offset += 1 unless idx + 1 == column_positions.size # remove column separator if we're not at last column
                       current_cell = input[y][from..to - offset]

                       result[:nums] << current_cell
                     end

                     result[:op] = input.last[from]

                     results << result
                   end
                 end
  end

  def perform
    total = 0

    columns.each do |col|
      total += col[:nums].map { |n| n.strip.to_i }.reduce(col[:op].to_sym)
    end

    puts total
  end
end

class Part2 < Part1
  def perform
    total = 0

    columns.each do |col|
      col[:nums].map!(&:to_s).map!(&:reverse)

      max_digit_size = col[:nums].max { |a, b| a.chars.size <=> b.chars.size }.chars.size

      reconstructed = max_digit_size.times.with_object([]) do |x, reconstructed|
        str = ""

        col[:nums].each do |num|
          str << num[x] if x < num.size
        end

        reconstructed << str
      end

      puts reconstructed.join(", ")
      total += reconstructed.map!(&:to_i).reduce(col[:op])
    end

    puts total
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

