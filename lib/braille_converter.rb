class BrailleConverter

  def turn_letters_into_braille(array_of_letters)
    braille = []
    array_of_letters.each do |letter|
      if (letter == letter.upcase) && (letter != letter.downcase)
        braille << alphabet.code[:shift]
        braille << alphabet.code[letter.downcase]
      else
        braille << alphabet.code[letter]
      end
    end
    braille
  end

end
