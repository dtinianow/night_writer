require './lib/alphabet'
require './lib/file_reader'
require 'pry'

class NightWriter
  attr_reader :reader,
              :alphabet

  def initialize
    @reader = FileReader.new
    @alphabet = Alphabet.new
  end

  def encode_file_to_braille
    # I wouldn't worry about testing this method
    # unless you get everything else done
    plain = reader.read.chomp
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(text)
    #Method that contains all the other methods
    # letters = make_array(text)
    # braille = turn_into_braille(letters)
    # lines = make_lines(braille)
    # braille_strings = turn_into_strings(lines)
    # # braille_strings = length_check(braille_strings) #newly added
    # strings = add_line_breaks(braille_strings)
    # prepare_for_printing(strings)
    prepare_for_printing(add_line_breaks(length_check(turn_into_strings(make_lines(turn_into_braille(make_array(text)))))))
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


  def turn_into_strings(lines)
    braille_strings = lines.map { |line| line.join }
  end

  # newly added
  def length_check(braille_strings)
    extra = []
      braille_strings.each do |string|
        if string.length > 80
          extra << string.slice!(80)
        end
      braille_strings
    end
    braille_strings << extra
    binding.pry
  end

  def add_line_breaks(braille_strings)
    strings = braille_strings.map { |string| string << "\n"}
  end

  def prepare_for_printing(strings)
    strings.join
  end


end

puts ARGV.inspect
