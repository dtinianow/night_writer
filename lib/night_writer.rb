require './lib/alphabet'
require './lib/file_reader'
require 'pry'

class NightWriter
  attr_reader :file,
              :alphabet

  def initialize
    @file = FileReader.new
    @alphabet = Alphabet.new
  end

  def encode_file_to_braille
    # I wouldn't worry about testing this method
    # unless you get everything else done
    plain = file.read.delete("\n")
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(text)
    #Method that contains all the other methods
    letters = make_array(text)
    braille = turn_into_braille(letters)
    lines = make_lines(braille)
    braille_lines = turn_into_single_lines(lines)
    sliced_lines = slice_lines(braille_lines)
    message = add_line_breaks(sliced_lines)
    prepare_for_printing(message)
    # prepare_for_printing(add_line_breaks(length_check(turn_into_strings(make_lines(turn_into_braille(make_array(text)))))))
  end

  def make_array(message)
    message.chars
  end

  def turn_into_braille(letters)
    braille = []
    letters.each do |letter|
      if (letter == letter.upcase) && (letter != letter.downcase)
        braille << alphabet.code[:shift]
        braille << alphabet.code[letter.downcase]
      else
        braille << alphabet.code[letter]
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
    temp = []
    x = braille_lines.first.length
    while x > 0
      braille_lines.map do |line|
        slice = line.slice!(0..79)
        temp << slice
      end
      x -= 80
    end
    temp
  end

  # while braille_lines.first.length > 80
  #   braille_lines.each do |line|
  #     slice = line.slice!(80..-1)
  #     temp << slice
  #   end

  # def slice_lines(braille_lines)
  #   sliced_lines = braille_lines.map do |line|
  #     line.chars.each_slice(80).to_a << "\n"
  #   end
  # end
  #if line
    # add_line_breaks(@line1)
    # @line2 = braille_lines[1].chars.each_slice(80).to_a
    # add_line_breaks(@line2)
    # @line3 = braille_lines[2].chars.each_slice(80).to_a
    # add_line_breaks(@line3)


  def add_line_breaks(sliced_lines)
    lines = sliced_lines.map { |line_piece| line_piece << "\n" }
  end

  def combine_lines

  end

  def prepare_for_printing(message)
    message.join
  end


end

puts ARGV.inspect
