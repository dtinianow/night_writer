require './lib/night_reader'
require './lib/alphabet'
require './lib/file_reader'
require 'pry'

braille = NightReader.new
encodement = braille.decode_file_to_english
message = File.open(ARGV[1], 'a+')
File.write(ARGV[1], message)

message.read #Reads the newly created file, so that we can access the position/number of characters below
puts "Created '#{ARGV[1]}' containing #{message.pos} characters"
