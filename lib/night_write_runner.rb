require './lib/night_writer_starter'
require './lib/braille_converter'
require './lib/alphabet'
require 'pry'

original_file = NightWriter.new
original_file.encode_file_to_braille
new_file = File.open(ARGV[1], 'a+')

# original_file.length #Length of original file
# array_of_text_characters = original_file.chomp.chars #Returns array of original file

# turned_to_braille = original_file.some_method_here
# text_to_convert = BrailleConverter.new(text)

# File.write(ARGV[1], original_file.read) #Alternative way to write to a file
# new_file.puts text
# new_file.puts text
# new_file.puts text
new_file.read #Reads the newly created file, so that we can access the position/number of characters below
puts "Created '#{ARGV[1]}' containing #{new_file.pos} characters"