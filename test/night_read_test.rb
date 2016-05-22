require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_reader'
require './lib/alphabet'
require './lib/file_reader'

class NightReaderTest < Minitest::Test

attr_reader :file,
            :alphabet

  def setup
    @file = NightReader.new
    @alphabet = Alphabet.new
  end

  def test_turn_braille_into_array_of_pieces_of_lines
    #skip
    assert_equal ["..0..0..", "..000.00", ".0....0."], file.make_array("..0..0..\n..000.00\n.0....0.\n")
  end

  def test_move_pieces_of_braille_into_correct_line
    skip
    assert_equal
  end

end
