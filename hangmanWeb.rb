require "set"
require "json"
class Hangman

	attr_reader :word, :wordCompletion

	def initialize(wordCompletion = nil, lettersGuessed = nil, word = nil)
		@wordCompletion = Array.new
		@lettersGuessed = Array.new
		@turn = 0
		lines = File.readlines "5desk.txt"
		randomIndex =  rand(61406)
		lines.each_with_index do |line,index|
			if (index == randomIndex)
				checkSize = true
				while (checkSize)
					if (lines[index].chomp.downcase.size >= 5 && lines[index].chomp.downcase.size <= 12)
						@word = lines[index].chomp.downcase
						checkSize = false;
					end
					index += 1;
				end
			end
		end
		for i in 0...@word.size
			@wordCompletion.push('_')
		end
	end

	def lose?
		correctGuesses = Set.new
		for i in 0...@wordCompletion.size
			if (@wordCompletion[i] != '_')
				correctGuesses.add(@wordCompletion[i])
			end
		end
		incorrectGuesses = @lettersGuessed.size - correctGuesses.size
		if ((6 - incorrectGuesses) <= 0)
			return true
		else
			return false
		end
	end

	def checkGuess(letter)
		if (!(!@wordCompletion.include?(letter) && !@lettersGuessed.include?(letter)))
			return nil
		end
		if @word.include?(letter) #correct guess
			@lettersGuessed.push(letter)
			updateWord(letter)
			return true
		else
			@lettersGuessed.push(letter)
			return false
		end
	end

	def updateWord(letter) 
		for i in 0...@word.size
			if (@word[i] == letter)
				@wordCompletion[i] = letter
			end
		end
	end

	def displayProgress
		progress = "<p>"
		for i in 0...@wordCompletion.size
			progress += @wordCompletion[i] + " "
		end
		progress += "</p><p>"
		progress += printLettersGuessed
		progress += "</p>"
		return progress
	end

	def printLettersGuessed
		string = "\n"
		string += "Letters guessed: "
		for i in 0...@lettersGuessed.size
			if !(@wordCompletion.include?(@lettersGuessed[i]))
				string += "#{@lettersGuessed[i]}, "
			end
		end
		string += "\n"
		return string
	end

	def chooseImage
		correctGuesses = Set.new
		for i in 0...@wordCompletion.size
			if (@wordCompletion[i] != '_')
				correctGuesses.add(@wordCompletion[i])
			end
		end
		incorrectGuesses = @lettersGuessed.size - correctGuesses.size
		imageName = "<img src = \"/img/"
		case(incorrectGuesses)
		when (0)
			imageName += "HangmanEmpty.png"
		when (1)
			imageName += "Hangman1.png"
		when (2)
			imageName += "Hangman2.png"
		when (3)
			imageName += "Hangman3.png"
		when (4)
			imageName += "Hangman4.png"
		when (5)
			imageName += "Hangman5.png"
		when (6)
			imageName += "Hangman6.png"
		end
		imageName += "\">"
		return imageName
	end

	def win?
		if (@wordCompletion.include?('_'))
			return false
		else
			return true
		end
	end

end

