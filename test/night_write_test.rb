require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_writer_starter'
require './lib/alphabet'
require './lib/braille_converter'

class NightWriterTest < Minitest::Test

attr_reader :file,
            :alphabet

  def setup
    @file = NightWriter.new
  end

  def test_alphabet_has_letters_and_braille_values
    #skip
    assert file.alphabet.code.has_key?("a")
    assert file.alphabet.code.has_value?(["0.","..",".."])
    assert_equal ["0.",".0","00"], file.alphabet.code["z"]
  end

  def test_convert_letter_into_braille_array
    assert_equal ["0.", "..", ".."], file.encode_to_braille("a").first
  end

  def test_convert_capitalized_letter_into_braille_array
    assert_equal [["..", "..", ".0"],["0.", "..", ".."]], file.encode_to_braille("A")
  end

  def test_convert_two_letters_into_braille_array
    assert_equal [["0.", "..", ".."],["0.","0.",".."]], file.encode_to_braille("ab")
  end

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
