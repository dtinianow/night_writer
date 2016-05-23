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
    pairs = find_all_pairs(lines)
    braille_key = create_braille_key(pairs)
    message = turn_into_english(braille_key)
  end

  def make_array(braille)
    line_pieces = braille.split("\n")
  end

  ["..0..0..", "..000.00", ".0....0.", "..0.0.", "..0.0.", ".00.0."]

  def group_by_line(line_pieces)
    unjoined_lines = [[],[],[]]
    index = 0
    line_pieces.each do |piece|
      unjoined_lines[0] << piece if index % 3 == 0
      unjoined_lines[1] << piece if index % 3 == 1
      unjoined_lines[2] << piece if index % 3 == 2
      index += 1
    end
    unjoined_lines
  end

  def join_lines(unjoined_lines)
    lines = unjoined_lines.map { |line| line.join }
  end

  def find_all_pairs(lines)
    pairs = lines.map { |line| line.scan(/../) }
  end

  def create_braille_key(pairs)
    iteration = 0
    braille_key = []
    while iteration < pairs.first.length
      line = 0
      code = []
      while line < 3
        code << pairs[line][iteration]
        line += 1
      end
      iteration += 1
      braille_key << code
    end
    braille_key
  end

  def turn_into_english(braille_key)
    message = ""
    shift = false
    braille_key.each do |braille|
      if alphabet.code.key(braille) == :shift
        shift = true
        next
      end
      if shift == true
        message << alphabet.code.key(braille).upcase
        shift = false
      else
        message << alphabet.code.key(braille)
      end
    end
    message
  end

end
