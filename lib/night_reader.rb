require './lib/alphabet'
require './lib/file_reader'
require 'pry'

class NightReader
  attr_reader :reader,
              :alphabet

  def initialize
    @reader = FileReader.new
    @alphabet = Alphabet.new
  end

  def encode_file_to_english
    braille = reader.read.chomp
    text = encode_to_english(braille)
  end

  def encode_to_english(text)
    #Method that contains all the other methods
    letters = make_array(text)
    braille = turn_into_braille(letters)
    lines = make_lines(braille)
    braille_strings = turn_into_strings(lines)
    strings = add_line_breaks(braille_strings)
    final = prepare_for_printing(strings)
  end
