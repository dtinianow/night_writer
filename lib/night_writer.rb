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

  def capitalized?(letter)
    (letter == letter.upcase) && (letter != letter.downcase)
  end

  def turn_into_braille(chars)
    braille = []
    using_numbers = false
    chars.each do |char| 
      if code.alphabet.has_key?(char) && using_numbers
        braille << code.alphabet[" "]
        braille << code.alphabet[char]
        using_numbers = false
      elsif code.alphabet.has_key?(char)
        braille << code.alphabet[char]
      elsif capitalized?(char) && using_numbers
        braille << code.alphabet[" "]
        braille << code.alphabet[:shift]
        braille << code.alphabet[char.downcase]
        using_numbers = false
      elsif capitalized?(char)
        braille << code.alphabet[:shift]
        braille << code.alphabet[char.downcase]
      elsif using_numbers
        braille << code.numbers[char]
      elsif code.numbers.has_key?(char)
        braille << code.numbers["#"]
        braille << code.numbers[char]
        using_numbers = true
      end
    end
    braille
  end

  def make_lines(braille)
    3.times.map do |i|
      braille.map do |braille_char|
        braille_char[i]
      end
    end
  end

    # lines = [[],[],[]]
    #   3.times do |i|
    #     braille.each { |chunk_of_braille| lines[i] << chunk_of_braille[i] }
    #   end
    # lines

  def turn_into_single_lines(lines)
    lines.map { |line| line.join }
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
    sliced_lines.map { |line_piece| line_piece << "\n" }
  end

  def prepare_for_printing(message)
    message.join
  end

end

puts ARGV.inspect
