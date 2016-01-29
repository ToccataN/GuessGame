require 'sinatra'
require 'sinatra/reloader'
x = rand(100)
@@count = 5
get '/' do
	guess = params["guess"]
	cheat = params["cheat"]
	number = cheat == "true" ? (number = "The SECRET NUMBER is #{x}") : ("guess!")
	message = check_guess(guess, x)
	if message.include?"correct"
		color = "green" 
	elsif message.include?"way"
		color = "red"
	else
		color = "orange"
	end
	@@count -= 1
    if message.include?"correct"
   	  x = rand(100)
   	  @@count = 5
   	elsif @@count == 0
   	 message =  "You lose!"
   	  x = rand(100)
   	  @@count = 5
   	end
	erb :index, :locals => {:x => x, :message => message, :color => color, :number => number}
end

def check_guess (guess, n)
  guess = guess.to_i
  if guess == n 
  	"#{guess} is correct"
  elsif guess > n && guess < n+5
  	"#{guess} is too high"
  elsif guess > n+5
  	"#{guess} is way too high!"
  elsif guess < n && guess > n-5
  	"#{guess} is too low"
  elsif guess < n-5
  	"#{guess} is way too low!"
  else
  	"make a guess"
  end
end