require './lib/night_writer'
require './lib/code'
require './lib/file_reader'
require 'pry'

message = NightWriter.new
encodement = message.encode_file_to_braille
braille = File.open(ARGV[1], 'a+')
File.write(braille, encodement)

#Alternative way to write to a file: new_file.puts text

braille.read #Reads the newly created file, so that we can access the position/number of characters below
puts "Created '#{ARGV[1]}' containing #{braille.pos} characters"
