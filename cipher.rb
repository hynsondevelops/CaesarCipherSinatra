def caesar_cipher(message, shift)
	newMessage = "";
	message.each_byte do |char|
		if (char < 123 && char > 96) #lowercase letter
			char += shift
			if (char >= 123) #warp around
				char -= 26
			end
		elsif (char < 91 && char > 64) #uppercase letter
			char += shift
			if (char >= 91) #warp around
				char -= 26
			end
		end
		newMessage += char.chr;
	end
	return newMessage;
end

#Testing
def caesar_cipher_tests()
	puts "\nCaesar Cipher Unit Tests\n"
	correctCounter = 0;
	incorrectCounter = 0;
	#tests
	test1 = caesar_cipher("What a string!", 5)
	test2 = caesar_cipher("Hi Hello 1$@%#", 26)
	
	#test 1
	puts "\nTest 1"
	if (test1 == "Bmfy f xywnsl!")
		puts "Correct!"
		correctCounter += 1;
	else
		puts "Incorrect"
		incorrectCounter += 1;
	end
	puts "Expected: Bmfy f xywnsl!"
	puts "Output: #{test1}"

	#test 2
	puts "\nTest 2"
	if (test2 == "Hi Hello 1$@%#")
		puts "Correct!"
		correctCounter += 1;
	else 
		puts "Incorrect"
		incorrectCounter += 1;
	end
	puts "Expected: Hi Hello 1$@%#"
	puts "Output: #{test2}"

	#Results
	puts "\n\nTest Results"
	puts "Tests Passed #{correctCounter}"
	puts "Tests Failed: #{incorrectCounter}"
	if (incorrectCounter == 0)
		puts "Passed all unit tests!"
	end
end