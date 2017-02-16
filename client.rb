require 'sinatra'
require_relative 'cipher'
require_relative 'hangmanWeb'
#require 'sinatra/reloader'


configure do
  enable :sessions
  set :session_secret, "secret"
end


get '/' do	
	erb :index
end

get '/cipher' do
	if (params[:message] == nil)
		message = "Blank"
	else
		message = params[:message]
	end
	if (params[:shift] == nil)
		shift = 0
	else
		shift = params[:shift].to_i
	end
	encrypted = caesar_cipher(message, shift)
  	erb :cipher, :locals  => {:encrypted => encrypted}
end

get '/hangman' do
	session[:name] = "Adam"
	session[:hangman] = Hangman.new
	@session = session
	erb :hangman
end

post '/hangman/guess' do
	status = session[:hangman].checkGuess(params[:guess])
	if (status == nil)
		guessMessage = "Letter already guessed"
	elsif (status == false)
		guessMessage = "Letter not in word"
	elsif (status == true)
		guessMessage = "Correct. Letter in word"
	end
	loss = session[:hangman].lose?
	win = session[:hangman].win?
	if (win)
		winOrLose = "<p> Winner! </p>"
		erb :hangmanDone, :locals => {:winOrLose => winOrLose}
	elsif (loss)
		winOrLose = "<p> You Lose, Try Again </p>"
		erb :hangmanDone, :locals => {:winOrLose => winOrLose}
	else
		erb :hangmanGuess, :locals => {:guessMessage => guessMessage}	
	end
end