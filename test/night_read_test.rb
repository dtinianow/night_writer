require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_reader'
require './lib/alphabet'
require './lib/file_reader'

class NightReaderTest < Minitest::Test

attr_reader :file,
            :alphabet,
            :input_1,
            :input_2

  def setup
    @file = NightReader.new
    @alphabet = Alphabet.new
    @input_2 = "..0..0..\n..000.00\n.0....0.\n" #Hi!
    @input_1 = "..0..0..\n..000.00\n.0....0.\n..0.0.\n...0..\n.00.0.\n" #Hi!Ok
  end

  def test_turn_braille_into_array_of_pieces_of_lines
    # skip
    assert_equal ["..0..0..", "..000.00", ".0....0."], file.make_array(input_2)
    assert_equal ["..0..0..", "..000.00", ".0....0.", "..0.0.", "...0..", ".00.0."], file.make_array(input_1)
  end

  def test_move_pieces_of_braille_into_correct_line
    #skip
    line_pieces = ["..0..0..", "..000.00", ".0....0.", "..0.0.", "...0..", ".00.0."]
    expected = [["..0..0..", "..0.0."], ["..000.00", "...0.."], [".0....0.", ".00.0."]]
    assert_equal expected, file.group_by_line(line_pieces)
  end

  def test_join_pieces_of_each_line_into_single_lines
    # skip
    unjoined_lines = [["..0..0..", "..0.0."], ["..000.00", "...0.."], [".0....0.", ".00.0."]]
    expected = ["..0..0....0.0.", "..000.00...0..", ".0....0..00.0."]
    assert_equal expected, file.join_lines(unjoined_lines)
  end

  def test_seperate_each_line_into_pairs_of_braille_code
    # skip
    lines = ["..0..0....0.0.", "..000.00...0..", ".0....0..00.0."]
    expected = [["..", "0.", ".0", "..", "..", "0.", "0."], ["..", "00", "0.", "00", "..", ".0", ".."], [".0", "..", "..", "0.", ".0", "0.", "0."]]
    assert_equal expected, file.find_all_pairs(lines)
  end

  def test_create_array_of_braille_key_using_pairs
    #skip
    pairs = [["..", "0.", ".0", "..", "..", "0.", "0."], ["..", "00", "0.", "00", "..", ".0", ".."], [".0", "..", "..", "0.", ".0", "0.", "0."]]
    expected = [["..", "..", ".0"], ["0.", "00", ".."], [".0", "0.", ".."], ["..", "00", "0."], ["..", "..", ".0"], ["0.", ".0", "0."], ["0.", "..", "0."]]
    assert_equal expected, file.create_braille_key(pairs)
  end

  def test_turn_braille_key_into_message
    #skip
    braille_key = [["..", "..", ".0"], ["0.", "00", ".."], [".0", "0.", ".."], ["..", "00", "0."], ["..", "..", ".0"], ["0.", ".0", "0."], ["0.", "..", "0."]]
    assert_equal "Hi!Ok", file.turn_into_english(braille_key)
  end

  def test_slice_english_text_into_array_80_character_lines
    text = "This is a very long message! This message is long so we can break the line right here."
    expected = [["T", "h", "i", "s", " ", "i", "s", " ", "a", " ", "v", "e", "r", "y", " ", "l", "o", "n", "g", " ", "m", "e", "s", "s", "a", "g", "e", "!", " ", "T", "h", "i", "s", " ", "m", "e", "s", "s", "a", "g", "e", " ", "i", "s", " ", "l", "o", "n", "g", " ", "s", "o", " ", "w", "e", " ", "c", "a", "n", " ", "b", "r", "e", "a", "k", " ", "t", "h", "e", " ", "l", "i", "n", "e", " ", "r", "i", "g", "h", "t"], [" ", "h", "e", "r", "e", "."]]
    assert_equal expected, file.slice_text(text)
  end

  def test_add_line_breaks_to_end_of_each_line
    sliced_text =[["H", "i", "!"], [" ", "O", "k"]]
    expected = [["H", "i", "!", "\n"], [" ", "O", "k", "\n"]]
    assert_equal expected, file.add_line_breaks(sliced_text)
  end

  def test_join_characters_to_create_message
    text_with_line_breaks = [["H", "i", "!", "\n"], [" ", "O", "k", "\n"]]
    expected = "Hi!\n Ok\n"
    assert_equal expected, file.join_characters(text_with_line_breaks)
  end


end
