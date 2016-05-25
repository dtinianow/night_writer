require './lib/code'
require './lib/file_reader'
require 'pry'

class NightReader
  attr_reader :file,
              :code

  def initialize
    @file = FileReader.new
    @code = Code.new
  end

  def decode_file_to_english
    braille = file.read.chomp
    message = decode_to_english(braille)
  end

  def decode_to_english(braille)
    # Method that contains all the other methods
    line_pieces = make_array(braille)
    unjoined_lines = group_by_line(line_pieces)
    lines = join_lines(unjoined_lines)
    pairs = find_all_pairs(lines)
    braille_key = create_braille_key(pairs)
    text = turn_into_english(braille_key)
    sliced_text = slice_text(text)
    text_with_line_breaks = add_line_breaks(sliced_text)
    join_characters(text_with_line_breaks)
  end

  def make_array(braille)
    braille.split("\n")
  end

  def group_by_line(line_pieces)
    unjoined_lines = [[],[],[]]
    index = 0
    line_pieces.each do |piece|
      unjoined_lines[0] << piece if index % 3 == 0
      unjoined_lines[1] << piece if index % 3 == 1
      unjoined_lines[2] << piece if index % 3 == 2
      index += 1
    end
    unjoined_lines
  end

  def join_lines(unjoined_lines)
    unjoined_lines.map { |line| line.join }
  end

  def find_all_pairs(lines)
    lines.map { |line| line.scan(/../) }
  end

  def create_braille_key(pairs)
    pairs.first.length.times.map do |i|
      3.times.map { |line| pairs[line][i] }
    end
  end

  def turn_into_english(braille_key)
    text = ""
    shift = false
    using_numbers = false
    braille_key.each do |char|
      if code.alphabet.key(char) == :shift
        shift = true
      elsif shift == true
        text << code.alphabet.key(char).upcase
        shift = false
      elsif code.numbers.key(char) == "#"
        using_numbers = true
      elsif code.alphabet.key(char) == " " && using_numbers == true
        text << code.alphabet.key(char)
        using_numbers = false
      elsif using_numbers == true
        text << code.numbers.key(char)
      else
        text << code.alphabet.key(char)
      end
    end
    text
  end

  def slice_text(text)
    text.chars.each_slice(80).to_a
  end

  def add_line_breaks(sliced_text)
    sliced_text.each { |slice| slice.push("\n") }
  end

  def join_characters(text_with_line_breaks)
    text_with_line_breaks.join
  end

end
