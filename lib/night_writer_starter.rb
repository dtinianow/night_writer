require './lib/alphabet'

require 'pry'

class FileReader
  def read
    filename = ARGV[0]
    File.read(filename)
  end
end

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

  def encode_to_braille(message)
    #convert string to array by using chars
    braille = turn_letters_into_braille(message.chars)
    lines_of_brailles = make_lines_of_braille(braille)
    #iterate through each element and each element against the alphabet
      #if char is upcase, and not downcase
    #build new array with braille conversion values
    #
  end

  def turn_letters_into_braille(array_of_letters)
    braille = []
    array_of_letters.each do |letter|
      if (letter == letter.upcase) && (letter != letter.downcase)
        braille << alphabet.code[:shift]
        braille << alphabet.code[letter.downcase]
      else
        braille << alphabet.code[letter]
      end
    end
    braille
  end

  def make_lines_of_braille(array_of_braille)
    i = 0
    lines = [[],[],[]]
      while i < 3
        array_of_braille.each do |chunk_of_braille|
          lines[i] << chunk_of_braille[i]
        end
        i += 1
      end
    lines
  end

  def turn_lines_into_strings(lines)
    string_of_lines = lines.map { |line| line.join }
    binding.pry
  end
#["..0.00.0/n0.0.0."]
#[".00.0.0./n0..0.."]
#[".00.0.0./n0..0.."]

    #Put the first element of each array in a string
    #Put the second element of each array in a string
    #Put the third element of each array in a string

end

puts ARGV.inspect
