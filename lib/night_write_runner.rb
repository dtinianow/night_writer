require './lib/night_writer_starter'
require './lib/alphabet'
require 'pry'

original_file = FileReader.new
text = original_file.read #Save text from document as variable
text.length #Length of original file
array_of_text_characters = text.chomp.chars #Returns array of original file

# turned_to_braille = original_file.some_method_here


File.write(ARGV[1], original_file.read)
File.write(ARGV[1], original_file.read)
File.write(ARGV[1], original_file.read)
#Reads the newly created file, so that we can access the position/number of characters below
new_file = File.open(ARGV[1], 'r')
new_file.read
puts "Created '#{ARGV[1]}' containing #{new_file.pos} characters"
