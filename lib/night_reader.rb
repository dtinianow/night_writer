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
    braille_message = file.read
    message = decode_to_english(braille_message)
  end

  def decode_to_english(braille_message)
    line_pieces = split_braille_by_line(braille_message)
    unjoined_lines = put_line_pieces_in_order(line_pieces)
    lines = join_line_pieces(unjoined_lines)
    pairs = organize_braille_into_pairs(lines)
    braille_key = create_braille_key(pairs)
    text = turn_into_english(braille_key)
    sliced_text = slice_text_to_fit_page(text)
    text_with_line_breaks = add_line_breaks(sliced_text)
    prepare_for_printing(text_with_line_breaks)
  end

  def split_braille_by_line(braille_message)
    braille_message.split("\n")
  end

  def put_line_pieces_in_order(line_pieces)
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

  def join_line_pieces(unjoined_lines)
    unjoined_lines.map { |line| line.join }
  end

  def organize_braille_into_pairs(lines)
    lines.map { |line| line.scan(/../) }
  end

  def create_braille_key(pairs)
    pairs.first.length.times.map do |i|
      3.times.map { |line| pairs[line][i] }
    end
  end

  def is_capital?(char)
     code.alphabet.key(char) == :shift
  end

  def is_hash?(char)
    code.numbers.key(char) == "#"
  end

  def is_space?(char)
    code.alphabet.key(char) == " "
  end

  def put_letter(char)
    code.alphabet.key(char)
  end

  def put_number(char)
    code.numbers.key(char)
  end

  def turn_into_english(braille_key)
    text = ""
    shift = false
    using_numbers = false
    braille_key.each do |char|
      if is_capital?(char)
        shift = true
      elsif shift
        text << put_letter(char).upcase
        shift = false
      elsif is_hash?(char)
        using_numbers = true
      elsif is_space?(char) && using_numbers
        using_numbers = false
      elsif using_numbers
        text << put_number(char)
      else
        text << put_letter(char)
      end
    end
    text
  end

  def slice_text_to_fit_page(text)
    text.chars.each_slice(80).to_a
  end

  def add_line_breaks(sliced_text)
    sliced_text.each { |slice| slice.push("\n") }
  end

  def prepare_for_printing(text_with_line_breaks)
    text_with_line_breaks.join
  end

end
