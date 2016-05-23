require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_writer'
require './lib/alphabet'
require './lib/file_reader'

class NightWriterTest < Minitest::Test

attr_reader :file,
            :alphabet

  def setup
    @file = NightWriter.new
    @alphabet = Alphabet.new
  end

  def test_alphabet_has_letters_and_braille_values
    #skip
    assert alphabet.code.has_key?("a")
    assert alphabet.code.has_value?(["0.","..",".."])
    assert_equal ["0.",".0","00"], alphabet.code["z"]
    assert alphabet.code.has_key?(" ")
    assert_equal ["..", "..", ".0"], alphabet.code[:shift]
    refute alphabet.code.has_key?("&")
    assert_equal nil, alphabet.code["$"]
  end

  def test_convert_message_into_array_of_letters
    #skip
    assert_equal ["a"], file.make_array("a")
    assert_equal ["A", " ", "m", "e", "s", "s", "a", "g", "e", "!"], file.make_array("A message!")
  end

  def test_convert_letter_into_braille_array
    #skip
    letters = file.make_array("a")
    assert_equal ["0.", "..", ".."], file.turn_into_braille(letters).first
  end

  def test_convert_capitalized_letter_into_braille_array
    #skip
    letters = file.make_array("A")
    assert_equal [["..", "..", ".0"],["0.", "..", ".."]], file.turn_into_braille(letters)
  end

  def test_convert_two_letters_into_braille_array
    #skip
    letters = file.make_array("ab")
    assert_equal [["0.", "..", ".."],["0.","0.",".."]], file.turn_into_braille(letters)
  end

  def test_convert_non_alphabetic_characters_into_braille_array
    #skip
    char1 = file.make_array(" ")
    char2 = file.make_array("?")
    char3 = file.make_array("!'")
    assert_equal ["..","..",".."], file.turn_into_braille(char1).first
    assert_equal ["..","0.","00"], file.turn_into_braille(char2).first
    assert_equal [["..","00","0."], ["..","..","0."]], file.turn_into_braille(char3)
  end

  def test_turn_braille_array_into_lines_of_braille
    #skip
    letters = file.make_array("Hi!")
    braille = file.turn_into_braille(letters)
    expected = [["..", "0.", ".0", ".."], ["..", "00", "0.", "00"], [".0", "..", "..", "0."]]
    assert_equal expected, file.make_lines(braille)
  end

  def test_turn_lines_of_braille_into_strings
    #skip
    lines = [["..", "0.", ".0", ".."], ["..", "00", "0.", "00"], [".0", "..", "..", "0."]]
    expected = ["..0..0..", "..000.00", ".0....0."]
    assert_equal expected, file.turn_into_strings(lines)
  end

  def test_add_line_breaks_to_end_of_strings
    #skip
    braille_strings = ["..0..0..", "..000.00", ".0....0."]
    expected = ["..0..0..\n", "..000.00\n", ".0....0.\n"]
    assert_equal expected, file.add_line_breaks(braille_strings)
  end

  def test_convert_array_into_single_string
    #skip
    strings = ["..0..0..\n", "..000.00\n", ".0....0.\n"]
    expected = "..0..0..\n..000.00\n.0....0.\n"
    assert_equal expected, file.prepare_for_printing(strings)
  end

  # def test_covert_braille_array_into_lines
  #   assert_equal [["..", "00", "0.", ".0", ".0", "0.", "00", "0."],
  #                 ["..", "..", ".0", "0.", "0.", "..", "00", ".0"],
  #                 [".0", "0.", "..", "0.", "0.", "..", "..", ".."]], file.
  # end

  # def test_braille_converter_returns_text
  #   message = BrailleConverter.new("some text here")
  #   assert_equal "some text here", message.text
  # end

  # def test_can_read_a_message_and_return_character_count
  #   #setup
  #   bc = BrailleConverter.new()
  #   message = "hi friends"
  #
  #   #exercise
  #   bc.count_message(message)
  #
  #   bc.set_message(message)
  #   count = bc.message_count
  #
  #   #verify
  #   assert_equal 10, count
  # end
  #
  # def test_can_open_file_and_return_count
  #   #setup
  #   filename = 'sample.txt'
  #   bc = BrailleConverter.new()
  #
  #   #exercise
  #   count = bc.read_file(filename)
  #
  #   assert_equal 7, count
  # end
  #
  # def read_file(filename)
  #   #Open the file
  #   #access the infomration, store it in a string
  #   #How many characters are in a strin?
  # end
end
