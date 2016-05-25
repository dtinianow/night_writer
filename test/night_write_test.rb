require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_writer'
require './lib/code'
require './lib/file_reader'

class NightWriterTest < Minitest::Test

attr_reader :file,
            :code

  def setup
    @file = NightWriter.new
    @code = Code.new
  end

  def test_alphabet_has_letters_and_braille_values
    #skip
    assert code.alphabet.has_key?("a")
    assert code.alphabet.has_value?(["0.","..",".."])
    assert_equal ["0.",".0","00"], code.alphabet["z"]
    assert code.alphabet.has_key?(" ")
    assert_equal ["..", "..", ".0"], code.alphabet[:shift]
    refute code.alphabet.has_key?("&")
    assert_equal nil, code.alphabet["$"]
  end

  def test_letter_is_capitalized
    #skip
    assert file.capitalized?("A")
    refute file.capitalized?("a")
  end

  def test_convert_message_into_array_of_letters
    #skip
    assert_equal ["a"], file.make_array("a")
    assert_equal ["A", " ", "m", "e", "s", "s", "a", "g", "e", "!"], file.make_array("A message!")
  end

  def test_convert_letters_into_braille_array
    #skip
    letter1 = file.make_array("a")
    letter2 = file.make_array("A")
    letters = file.make_array("ab")
    assert_equal ["0.", "..", ".."], file.turn_into_braille(letter1).first
    assert_equal [["..", "..", ".0"],["0.", "..", ".."]], file.turn_into_braille(letter2)
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

  def test_turn_into_braille_with_numbers
    #skip
    chars1 = ["h", "i", "1", " "]
    chars2 = ["1", "A"]
    expected1 = [["0.","00",".."], [".0","0.",".."], [".0",".0","00"], ["0.","..",".."], ["..","..",".."], ["..","..",".."]]
    expected2 = [[".0",".0","00"], ["0.","..",".."], ["..","..",".."], ["..", "..", ".0"], ["0.","..",".."]]
    assert_equal expected1, file.turn_into_braille(chars1)
    assert_equal expected2, file.turn_into_braille(chars2)
  end

  def test_turn_braille_array_into_lines_of_braille
    #skip
    letters = file.make_array("Hi!")
    braille = file.turn_into_braille(letters)
    expected = [["..", "0.", ".0", ".."], ["..", "00", "0.", "00"], [".0", "..", "..", "0."]]
    assert_equal expected, file.make_lines(braille)
  end

  def test_turn_braille_line_into_text_lines
    #skip
    lines = [["..", "0.", ".0", ".."], ["..", "00", "0.", "00"], [".0", "..", "..", "0."]]
    expected = ["..0..0..", "..000.00", ".0....0."]
    assert_equal expected, file.turn_into_single_lines(lines)
  end

  def test_slice_braille_lines_longer_than_80_chars
    #skip
    braille_lines = ["...00..0.0...0.0..0...0.0.0.00..0.0.0000..000..0.00.000..........00..0.0..000..0.00.000....0.0..0.0.0000...00....00...000.00..0.0.0.0.0....00.0...0..0000...0.0.0.0.......0.0..0...00...000.0.0.00..0.0..00...0.0.0.00..000..00000..0.0000..000..00000..0.0000..000..00000..0.0000..000..00000..0.0000..000..00000..0.0000..000.000.00000.0.00..",
    "..00000.0...0.0.......0..000.0..0..0.000.....00.0...00.000......00000.0......00.0...00.0..0.0...0..0.000..0..0..00.0.......0..0.00.0......0000.0..0.0..0.0..00.000.000....0...00..00.0.....0..0..0....0.0..0.....0.00...00.00..000.....0.0..00.00..000.....0.0..00.00..000.....0.0..00.00..000.....0.0..00.00..000.....0.0.....0.0...0.000....00",
    ".00.....0.....0.......00..0.00..0.0.0.....0...0.0.......0......00.....0...0...0.0...........0...0.0.0.....0.0....0........0.....0.....0...0.......0...0.........0....0...0..000....0......0.000.......0.0.0...0.....0.....0...0.......0.......0...0.......0.......0...0.......0.......0...0.......0.......0...0.......0.......0.0.000...0.000..0"]
    expected = ["...00..0.0...0.0..0...0.0.0.00..0.0.0000..000..0.00.000..........00..0.0..000..0", "..00000.0...0.0.......0..000.0..0..0.000.....00.0...00.000......00000.0......00.", ".00.....0.....0.......00..0.00..0.0.0.....0...0.0.......0......00.....0...0...0.", ".00.000....0.0..0.0.0000...00....00...000.00..0.0.0.0.0....00.0...0..0000...0.0.",
    "0...00.0..0.0...0..0.000..0..0..00.0.......0..0.00.0......0000.0..0.0..0.0..00.0", "0...........0...0.0.0.....0.0....0........0.....0.....0...0.......0...0.........", "0.0.......0.0..0...00...000.0.0.00..0.0..00...0.0.0.00..000..00000..0.0000..000.", "00.000....0...00..00.0.....0..0..0....0.0..0.....0.00...00.00..000.....0.0..00.0",
    "0....0...0..000....0......0.000.......0.0.0...0.....0.....0...0.......0.......0.", ".00000..0.0000..000..00000..0.0000..000..00000..0.0000..000..00000..0.0000..000.", "0..000.....0.0..00.00..000.....0.0..00.00..000.....0.0..00.00..000.....0.0.....0", "..0.......0.......0...0.......0.......0...0.......0.......0...0.......0.......0.", "000.00000.0.00..",
    ".0...0.000....00", "0.000...0.000..0"]
    assert_equal expected, file.slice_lines(braille_lines)
  end

  def test_add_line_breaks_to_end_of_text_lines
    #skip
    braille_lines = ["..0..0..", "..000.00", ".0....0."]
    expected = ["..0..0..\n", "..000.00\n", ".0....0.\n"]
    assert_equal expected, file.add_line_breaks(braille_lines)
  end

  def test_convert_array_into_single_line
    #skip
    braille = ["..0..0..\n", "..000.00\n", ".0....0.\n"]
    expected = "..0..0..\n..000.00\n.0....0.\n"
    assert_equal expected, file.prepare_for_printing(braille)
  end

  def test_encode_to_braille
    skip

  end

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
