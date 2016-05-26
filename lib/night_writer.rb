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
    plain = file.read.delete("\n")
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(text)
    letters = split_message_into_chars(text)
    braille = turn_chars_into_braille(letters)
    lines = sort_braille_into_lines(braille)
    braille_lines = join_line_pieces(lines)
    sliced_lines = slice_lines_to_fit_page(braille_lines)
    message = add_line_breaks(sliced_lines)
    prepare_for_printing(message)
  end

  def split_message_into_chars(message)
    message.chars
  end

  def is_capitalized?(letter)
    (letter == letter.upcase) && (letter != letter.downcase)
  end

  def is_letter?(char)
    code.alphabet.has_key?(char)
  end

  def is_number?(char)
    code.numbers.has_key?(char)
  end

  def put_letter(char)
    code.alphabet[char]
  end

  def put_number(char)
    code.numbers[char]
  end

    def turn_chars_into_braille(chars)
      braille = []
      using_numbers = false
      chars.each do |char|
        if is_letter?(char) && using_numbers
          braille << put_letter(" ")
          braille << put_letter(char)
          using_numbers = false
        elsif is_letter?(char)
          braille << put_letter(char)
        elsif is_capitalized?(char) && using_numbers
          braille << put_letter(" ")
          braille << put_letter(:shift)
          braille << put_letter(char.downcase)
          using_numbers = false
        elsif is_capitalized?(char)
          braille << put_letter(:shift)
          braille << put_letter(char.downcase)
        elsif using_numbers
          braille << put_number(char)
        elsif is_number?(char)
          braille << put_number("#")
          braille << put_number(char)
          using_numbers = true
        end
      end
    braille
  end

  # def turn_chars_into_braille(chars)
  #   braille = []
  #   using_numbers = false
  #   chars.each do |char|
  #     if code.alphabet.has_key?(char) && using_numbers
  #       braille << code.alphabet[" "]
  #       braille << code.alphabet[char]
  #       using_numbers = false
  #     elsif code.alphabet.has_key?(char)
  #       braille << code.alphabet[char]
  #     elsif is_capitalized?(char) && using_numbers
  #       braille << code.alphabet[" "]
  #       braille << code.alphabet[:shift]
  #       braille << code.alphabet[char.downcase]
  #       using_numbers = false
  #     elsif is_capitalized?(char)
  #       braille << code.alphabet[:shift]
  #       braille << code.alphabet[char.downcase]
  #     elsif using_numbers
  #       braille << code.numbers[char]
  #     elsif code.numbers.has_key?(char)
  #       braille << code.numbers["#"]
  #       braille << code.numbers[char]
  #       using_numbers = true
  #     end
  #   end
  #   braille
  # end

  def sort_braille_into_lines(braille)
    3.times.map do |i|
      braille.map do |braille_chars|
        braille_chars[i]
      end
    end
  end

  def join_line_pieces(lines)
    lines.map { |line| line.join }
  end

  def slice_lines_to_fit_page(braille_lines)
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
