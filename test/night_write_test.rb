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
    assert file.is_capitalized?("A")
    refute file.is_capitalized?("a")
  end

  def test_char_is_a_letter?
    #skip
    assert file.is_letter?("a")
    refute file.is_letter?("1")
  end

  def test_char_is_a_number?
    assert file.is_number?("1")
    refute file.is_number?("a")
  end

  def test_convert_message_into_array_of_letters
    #skip
    assert_equal ["a"], file.split_message_into_chars("a")
    assert_equal ["A", " ", "m", "e", "s", "s", "a", "g", "e", "!"], file.split_message_into_chars("A message!")
  end

  def test_convert_letters_into_braille_array
    #skip
    letter1 = file.split_message_into_chars("a")
    letter2 = file.split_message_into_chars("A")
    letters = file.split_message_into_chars("ab")
    assert_equal ["0.", "..", ".."], file.turn_chars_into_braille(letter1).first
    assert_equal [["..", "..", ".0"],["0.", "..", ".."]], file.turn_chars_into_braille(letter2)
    assert_equal [["0.", "..", ".."],["0.","0.",".."]], file.turn_chars_into_braille(letters)
  end

  def test_convert_non_alphabetic_characters_into_braille_array
    #skip
    char1 = file.split_message_into_chars(" ")
    char2 = file.split_message_into_chars("?")
    char3 = file.split_message_into_chars("!'")
    assert_equal ["..","..",".."], file.turn_chars_into_braille(char1).first
    assert_equal ["..","0.","00"], file.turn_chars_into_braille(char2).first
    assert_equal [["..","00","0."], ["..","..","0."]], file.turn_chars_into_braille(char3)
  end

  def test_turn_into_braille_with_numbers
    #skip
    chars1 = ["h", "i", "1", " "]
    chars2 = ["1", "A"]
    expected1 = [["0.","00",".."], [".0","0.",".."], [".0",".0","00"], ["0.","..",".."], ["..","..",".."], ["..","..",".."]]
    expected2 = [[".0",".0","00"], ["0.","..",".."], ["..","..",".."], ["..", "..", ".0"], ["0.","..",".."]]
    assert_equal expected1, file.turn_chars_into_braille(chars1)
    assert_equal expected2, file.turn_chars_into_braille(chars2)
  end

  def test_turn_braille_array_into_lines_of_braille
    #skip
    letters = file.split_message_into_chars("Hi!")
    braille = file.turn_chars_into_braille(letters)
    expected = [["..", "0.", ".0", ".."], ["..", "00", "0.", "00"], [".0", "..", "..", "0."]]
    assert_equal expected, file.sort_braille_into_lines(braille)
  end

  def test_turn_braille_line_into_text_lines
    #skip
    lines = [["..", "0.", ".0", ".."], ["..", "00", "0.", "00"], [".0", "..", "..", "0."]]
    expected = ["..0..0..", "..000.00", ".0....0."]
    assert_equal expected, file.join_line_pieces(lines)
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
    assert_equal expected, file.slice_lines_to_fit_page(braille_lines)
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
    #skip
    text_1 = "Hi!Ok"
    text_2 = "1 A"
    expected_1 = "..0..0....0.0.\n..000.00...0..\n.0....0..00.0.\n"
    expected_2 = ".00.......0.\n.0..........\n00.......0..\n"
    assert_equal expected_1, file.encode_to_braille(text_1)
    assert_equal expected_2, file.encode_to_braille(text_2)
  end

end
