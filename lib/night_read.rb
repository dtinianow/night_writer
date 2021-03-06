require './lib/night_reader'
require './lib/code'
require './lib/file_reader'
require 'pry'

braille = NightReader.new
encodement = braille.decode_file_to_english
message = File.open(ARGV[1], 'a+')
File.write(message, encodement)

message.read #Reads the newly created file, so that we can access the position/number of characters below
puts "Created '#{ARGV[1]}' containing #{message.pos} characters"
