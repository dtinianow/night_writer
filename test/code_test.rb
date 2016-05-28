require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './lib/code'

class CodeTest < Minitest::Test

def test_alphabet_has_letters_and_braille_values
  #skip
  code = Code.new
  assert code.alphabet.has_key?("a")
  assert code.alphabet.has_value?(["0.","..",".."])
  assert_equal ["0.",".0","00"], code.alphabet["z"]
  assert code.alphabet.has_key?(" ")
  assert_equal ["..", "..", ".0"], code.alphabet[:shift]
  refute code.alphabet.has_key?("&")
  assert_equal nil, code.alphabet["$"]
end

end
