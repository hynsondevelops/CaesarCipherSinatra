require 'sinatra'
#require 'sinatra/reloader'


num = rand(100)

get '/' do
	correct = false
	if (params['guess'].to_i > (num + 5))
		message = "Way Too High"
	elsif (params['guess'].to_i < (num - 5) )
		message = "Way Too Low"
	elsif (params['guess'].to_i > num)
		message = "Too High"
	elsif (params['guess'].to_i < num)
		message = "Too Low"
	elsif (params['guess'].to_i == num)
		message = "Correct" 
		correct = true
	end
  	erb :index, :locals => {:num => num, :message => message, :correct => correct}
end
