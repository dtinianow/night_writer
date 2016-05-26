module Methods

    def is_capitalized?(letter)
      (letter == letter.upcase) && (letter != letter.downcase)
    end

    def is_letter?(char)
      code.alphabet.has_key?(char)
    end

    def is_number?(char)
      code.numbers.has_key?(char)
    end

    def add_letter(char)
      code.alphabet[char]
    end

    def add_number(char)
      code.numbers[char]
    end

    def is_capital?(char)
       code.alphabet.key(char) == :shift
    end

    def is_hash?(char)
      code.numbers.key(char) == "#"
    end

    def is_space?(char)
      code.alphabet.key(char) == " "
    end

    def put_letter(char)
      code.alphabet.key(char)
    end

    def put_number(char)
      code.numbers.key(char)
    end


end
