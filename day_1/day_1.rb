class Base
  def input
    @input ||= File.read(ARGV.first).split("\n")
  end
end

class Part1 < Base
  attr_reader :dial_start, :dial_position

  def initialize
    @dial_start = 50
    @dial_position = dial_start
  end

  def perform
    zero_occurrences = 0

    input.each do |line|
      zero_occurrences += process_line(line)
    end

    puts zero_occurrences
  end

  def process_line(line)
    @dial_position += (line[0] == "L" ? -1 : 1) * line[1..-1].to_i
    @dial_position %= 100

    dial_position == 0 ? 1 : 0
  end
end

class Part2 < Part1
  def process_line(line)
    direction = line[0]
    past_position = @dial_position
    occurrences = 0
    clicks = line[1..-1].to_i

    # Surely there is a much more elegant way of doing it but.... well. I tried.
    clicks.times do
      @dial_position += (direction == "L" ? -1 : 1)
      if @dial_position % 100 == 0
        occurrences += 1
      end
      @dial_position %= 100
    end

    occurrences

    # Doesn't work but for the record:
    #
    #
    #     @dial_position += step
    #
    #
    #     loops = @dial_position / 100
    #     puts "=> processing #{line}, from #{past_position} to #{@dial_position}"
    #     puts "   loops: #{loops} (step: #{step})"
    #
    #       @dial_position %= 100
    #
    # if loops != 0 && past_position != 0
    #     occurrences += loops.abs
    # elsif dial_position == 0
    #     occurrences += 1 if dial_position == 0
    # end
    #     puts "Occurrences found: #{occurrences}"
    #
    #     occurrences
    #
end
end

Part1.new.perform
Part2.new.perform

