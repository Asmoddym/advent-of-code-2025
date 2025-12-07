class Base
  def input
    @input ||= File.read(ARGV.first).split("\n")
  end
end

class Part1 < Base
  def perform
    count = 0

    ids.each do |id|
      if ranges.any? { |range| id_in?(id, range) }
        count += 1
      end
    end

    puts count
  end

  def id_in?(id, range)
    split = range.split("-").map(&:to_i)

    split[0] <= id && id <= split[1]
  end

  def ranges
    @ranges ||= input[0..input.index { |line| line.empty? } - 1]
  end

  def ids 
    @ids ||= input[input.index { |line| line.empty? } + 1..].map(&:to_i)
  end
end

class Part2 < Part1
  def ranges
    super.map { |r| r.split("-").map(&:to_i) }
  end

  def sorted
    @sorted ||= ranges.sort { |a, b| a[0] <=> b[0] }
  end

  def round
    puts "order: " + sorted.join(" => ")
    sorted.each_with_index do |sort, i|
      puts "Checking "+ sort.join(", ") + " with " + sorted[i - 1]&.join(", ") if i > 0
      if i > 0 && sorted[i - 1][1] > sort[0]
        puts "ok"
        sorted[i - 1][1] = sort[1]
      end

      puts "Checking "+ sort.join(", ") + " with " + (sorted[i + 1]&.join(", ") || "" ) if i < sorted.size - 1
    if i < sorted.size - 1 && sorted[i + 1][0] < sort[1]
        puts "ok"
        sorted[i + 1][0] = sort[1]
      end
    end

    @sorted = ranges.sort { |a, b| a[0] <=> b[0] }

    to_delete = []
    sorted.each_with_index do |sort, i|

      if i > 0 && sort[0] <= sorted[i - 1][1]
        to_delete << i
      end

      # if i > 0 && sort[0] >= sorted[i - 1][0] && sort[1] <= sorted[i - 1][1]
      #   to_delete << i
      # end

    end

    to_delete.each { |i| sorted.delete_at(i) }
    puts sorted.map { |z| z.join(" => ") }

  end

  def perform
    puts "1"
    round
    puts "2"
    round
    puts "3"
    round

    puts sorted.sum { |s| s[1] - s[0] + 1 }

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

