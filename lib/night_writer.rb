require './lib/code'
require './lib/file_reader'
require 'pry'

class NightWriter
  attr_reader :file,
              :code

  def initialize
    @file = FileReader.new
    @code = Code.new
  end

  def encode_file_to_braille
    # I wouldn't worry about testing this method
    # unless you get everything else done
    plain = file.read.delete("\n")
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(text)
    letters = make_array(text)
    braille = turn_into_braille(letters)
    lines = make_lines(braille)
    braille_lines = turn_into_single_lines(lines)
    sliced_lines = slice_lines(braille_lines)
    message = add_line_breaks(sliced_lines)
    prepare_for_printing(message)
  end

  def make_array(message)
    message.chars
  end

  def turn_into_braille(letters)
    braille = []
    letters.each do |letter|
      if (letter == letter.upcase) && (letter != letter.downcase)
        braille << code.alphabet[:shift]
        braille << code.alphabet[letter.downcase]
      else
        braille << code.alphabet[letter]
      end
    end
    braille
  end

  def make_lines(braille)
    i = 0
    lines = [[],[],[]]
      while i < 3
        braille.each do |chunk_of_braille|
          lines[i] << chunk_of_braille[i]
        end
        i += 1
      end
    lines
  end

  def turn_into_single_lines(lines)
    braille_lines = lines.map { |line| line.join }
  end

  def slice_lines(braille_lines)
    sliced_lines = []
    x = braille_lines.first.length
    while x > 0
      braille_lines.map do |line|
        slice = line.slice!(0..79)
        sliced_lines << slice
      end
      x -= 80
    end
    sliced_lines
  end

  def add_line_breaks(sliced_lines)
    lines = sliced_lines.map { |line_piece| line_piece << "\n" }
  end

  def prepare_for_printing(message)
    message.join
  end

end

puts ARGV.inspect
