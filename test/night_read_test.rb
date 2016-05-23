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
    line_pieces = file.make_array(input_1)
    assert_equal [["..0..0..", "..0.0."], ["..000.00", "...0.."], [".0....0.", ".00.0."]], file.group_by_line(line_pieces)
  end

  def test_join_pieces_of_each_line_into_single_lines
    # skip
    line_pieces = file.make_array(input_1)
    unjoined_lines = file.group_by_line(line_pieces)
    assert_equal ["..0..0....0.0.", "..000.00...0..", ".0....0..00.0."], file.join_lines(unjoined_lines)
  end

  def test_seperate_each_line_into_pairs_of_braille_code
    # skip
    line_pieces = file.make_array(input_1)
    unjoined_lines = file.group_by_line(line_pieces)
    lines = file.join_lines(unjoined_lines)
    assert_equal [["..", "0.", ".0", "..", "..", "0.", "0."], ["..", "00", "0.", "00", "..", ".0", ".."], [".0", "..", "..", "0.", ".0", "0.", "0."]], file.find_all_pairs(lines)
  end

  def test_create_array_of_braille_key_using_pairs
    #skip
    line_pieces = file.make_array(input_1)
    unjoined_lines = file.group_by_line(line_pieces)
    lines = file.join_lines(unjoined_lines)
    pairs = file.find_all_pairs(lines)
    assert_equal [["..", "..", ".0"], ["0.", "00", ".."], [".0", "0.", ".."], ["..", "00", "0."], ["..", "..", ".0"], ["0.", ".0", "0."], ["0.", "..", "0."]], file.create_braille_key(pairs)
  end

  def test_turn_braille_key_into_english
    #skip
    line_pieces = file.make_array(input_1)
    unjoined_lines = file.group_by_line(line_pieces)
    lines = file.join_lines(unjoined_lines)
    pairs = file.find_all_pairs(lines)
    braille_key = file.create_braille_key(pairs)
    assert_equal "Hi!Ok", file.turn_into_english(braille_key)
  end

end
