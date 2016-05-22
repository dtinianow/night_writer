require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/night_writer'
require './lib/alphabet'
require './lib/file_reader'

class NightReaderTest < Minitest::Test

attr_reader :file,
            :alphabet

  def setup
    @file = NightWriter.new
    @alphabet = Alphabet.new
  end

  def test

  end

end
