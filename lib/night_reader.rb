require './lib/alphabet'
require './lib/file_reader'
require 'pry'

class NightReader
  attr_reader :file,
              :alphabet

  def initialize
    @file = FileReader.new
    @alphabet = Alphabet.new
  end

  def decode_file_to_english
    braille = file.read.chomp
    message = decode_to_english(braille)
  end

  def decode_to_english(braille)
    # Method that contains all the other methods
    line_pieces = make_array(braille)
    unjoined_lines = group_by_line(line_pieces)
    lines = join_lines(unjoined_lines)
    ungrouped_pairs = find_all_pairs(lines)
    pairs = group_by_pairs(ungrouped_pairs)
  end

  def make_array(braille)
    line_pieces = braille.split("\n")
  end

  def group_by_line(line_pieces)
    unjoined_lines = [[],[],[]]
    line_pieces.each do |piece|
      unjoined_lines[0] << piece if line_pieces.index(piece) % 3 == 0
      unjoined_lines[1] << piece if line_pieces.index(piece) % 3 == 1
      unjoined_lines[2] << piece if line_pieces.index(piece) % 3 == 2
    end
    unjoined_lines
  end

  def join_lines(unjoined_lines)
    lines = unjoined_lines.map { |line| line.join }
  end

  def find_all_pairs(lines)
    ungrouped_pairs = lines.map { |line| line.scan(/../) }
  end

  def group_pairs(ungrouped_pairs)
    pairs = ungrouped_pairs.map { |pair| pair.each_slice(1).to_a }
  end

  #Turn braille into array
  #Iterate through every third line and shovel it into an array
    # Join all the new elements together
  #

end
