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
    @input_1 = "..0..0..\n..000.00\n.0....0.\n" #Hi!
    @input_2 = "..0..0..\n..000.00\n.0....0.\n..0.0.\n..0.0.\n.00.0.\n" #Hi!Ok
  end

  def test_turn_braille_into_array_of_pieces_of_lines
    #skip
    assert_equal ["..0..0..", "..000.00", ".0....0."], file.make_array(input_1)
    assert_equal ["..0..0..", "..000.00", ".0....0.", "..0.0.", "..0.0.", ".00.0."], file.make_array(input_2)
  end

  def test_move_pieces_of_braille_into_correct_line
    #skip
    line_pieces_1 = file.make_array(input_1)
    line_pieces_2 = file.make_array(input_2)
    assert_equal [["..0..0.."], ["..000.00"], [".0....0."]], file.group_by_line(line_pieces_1)
    assert_equal [["..0..0..", "..0.0."], ["..000.00", "..0.0."], [".0....0.", ".00.0."]], file.group_by_line(line_pieces_2)
  end

end
