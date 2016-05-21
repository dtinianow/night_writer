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
    plain = reader.read
    braille = encode_to_braille(plain)
  end

  def encode_to_braille(message)
    #convert string to array by using chars
    array_of_braille = turn_letters_into_braille(message.chars)
    three_lines_of_braille = turn_braille_into_three_separate_lines(array_of_braille)
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

  def turn_array_of_braille_into_three_seperate_lines(array_of_braille)
    braille
  end

end

puts ARGV.inspect
