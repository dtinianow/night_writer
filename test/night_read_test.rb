require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_reader'
require './lib/code'
require './lib/file_reader'

class NightReaderTest < Minitest::Test

attr_reader :file,
            :code,
            :braille_message_1,
            :braille_message_2

  def setup
    @file = NightReader.new
    @code = Code.new
    @braille_message_2 = "..0..0..\n..000.00\n.0....0.\n" #Hi!
    @braille_message_1 = "..0..0..\n..000.00\n.0....0.\n..0.0.\n...0..\n.00.0.\n" #Hi!Ok
  end

  def test_turn_braille_message_into_array_of_pieces_of_lines
    #skip
    assert_equal ["..0..0..", "..000.00", ".0....0."], file.split_braille_by_line(braille_message_2)
    assert_equal ["..0..0..", "..000.00", ".0....0.", "..0.0.", "...0..", ".00.0."], file.split_braille_by_line(braille_message_1)
  end

  def test_move_pieces_of_braille_into_correct_line
    #skip
    line_pieces = ["..0..0..", "..000.00", ".0....0.", "..0.0.", "...0..", ".00.0."]
    expected = [["..0..0..", "..0.0."], ["..000.00", "...0.."], [".0....0.", ".00.0."]]
    assert_equal expected, file.put_line_pieces_in_order(line_pieces)
  end

  def test_join_pieces_of_each_line_into_single_lines
    # skip
    unjoined_lines = [["..0..0..", "..0.0."], ["..000.00", "...0.."], [".0....0.", ".00.0."]]
    expected = ["..0..0....0.0.", "..000.00...0..", ".0....0..00.0."]
    assert_equal expected, file.join_line_pieces(unjoined_lines)
  end

  def test_seperate_each_line_into_pairs_of_braille_code
    # skip
    lines = ["..0..0....0.0.", "..000.00...0..", ".0....0..00.0."]
    expected = [["..", "0.", ".0", "..", "..", "0.", "0."], ["..", "00", "0.", "00", "..", ".0", ".."], [".0", "..", "..", "0.", ".0", "0.", "0."]]
    assert_equal expected, file.organize_braille_into_pairs(lines)
  end

  def test_create_array_of_braille_key_using_pairs
    #skip
    pairs = [["..", "0.", ".0", "..", "..", "0.", "0."], ["..", "00", "0.", "00", "..", ".0", ".."], [".0", "..", "..", "0.", ".0", "0.", "0."]]
    expected = [["..", "..", ".0"], ["0.", "00", ".."], [".0", "0.", ".."], ["..", "00", "0."], ["..", "..", ".0"], ["0.", ".0", "0."], ["0.", "..", "0."]]
    assert_equal expected, file.create_braille_key(pairs)
  end

  def test_is_capital?
    assert file.is_capital?(["..", "..", ".0"])
    refute file.is_capital?(["0.","..",".."])
  end

  def test_is_hash?
    assert file.is_hash?([".0",".0","00"])
    refute file.is_hash?(["0.","..",".."])
  end

  def test_is_space?
    assert file.is_space?(["..","..",".."])
    refute file.is_space?(["0.","..",".."])
  end

  def test_puts_letter
    assert_equal "a", file.put_letter(["0.","..",".."])
  end

  def test_puts_number
    assert_equal "1", file.put_number(["0.","..",".."])
  end

  def test_turn_braille_key_into_message
    #skip
    braille_key_1 = [["..", "..", ".0"], ["0.", "00", ".."], [".0", "0.", ".."], ["..", "00", "0."], ["..", "..", ".0"], ["0.", ".0", "0."], ["0.", "..", "0."]]
    braille_key_2 = [["0.","..",".."], [".0",".0","00"], ["0.","..",".."], ["0.",".0",".."], ["..","..",".."], ["..","..",".."], ["0.","..",".."]]
    braille_key_3 = [[".0",".0","00"], ["0.","..",".."], ["00","..",".."], ["..","..",".."], ["..", "..", ".0"], ["0.","..",".."]]
    assert_equal "Hi!Ok", file.turn_into_english(braille_key_1)
    assert_equal "a15 a", file.turn_into_english(braille_key_2)
    assert_equal "13A", file.turn_into_english(braille_key_3)
  end

  def test_slice_english_text_into_array_80_character_lines
    #skip
    text = "This is a very long message! This message is long so we can break the line right here."
    expected = [["T", "h", "i", "s", " ", "i", "s", " ", "a", " ", "v", "e", "r", "y", " ", "l", "o", "n", "g", " ", "m", "e", "s", "s", "a", "g", "e", "!", " ", "T", "h", "i", "s", " ", "m", "e", "s", "s", "a", "g", "e", " ", "i", "s", " ", "l", "o", "n", "g", " ", "s", "o", " ", "w", "e", " ", "c", "a", "n", " ", "b", "r", "e", "a", "k", " ", "t", "h", "e", " ", "l", "i", "n", "e", " ", "r", "i", "g", "h", "t"], [" ", "h", "e", "r", "e", "."]]
    assert_equal expected, file.slice_text_to_fit_page(text)
  end

  def test_add_line_breaks_to_end_of_each_line
    #skip
    sliced_text =[["H", "i", "!"], [" ", "O", "k"]]
    expected = [["H", "i", "!", "\n"], [" ", "O", "k", "\n"]]
    assert_equal expected, file.add_line_breaks(sliced_text)
  end

  def test_join_characters_to_create_message
    #skip
    text_with_line_breaks = [["H", "i", "!", "\n"], [" ", "O", "k", "\n"]]
    expected = "Hi!\n Ok\n"
    assert_equal expected, file.prepare_for_printing(text_with_line_breaks)
  end

  def test_decode_braille_to_english
    #skip
    braille_message = ".00.......0.\n.0..........\n00.......0..\n"
    expected_1 = "Hi!Ok\n"
    expected_2 = "1 A\n"
    assert_equal expected_1, file.decode_to_english(braille_message_1)
    assert_equal expected_2, file.decode_to_english(braille_message)
  end

end
