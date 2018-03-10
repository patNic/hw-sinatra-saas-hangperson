require 'sinatra/base'
require 'sinatra/flash'
require './lib/hangperson_game.rb'

class HangpersonApp < Sinatra::Base

  enable :sessions
  register Sinatra::Flash
  
  before do
    @game = session[:game] || HangpersonGame.new('')
  end
  
  after do
    session[:game] = @game
  end
  
  # These two routes are good examples of Sinatra syntax
  # to help you with the rest of the assignment
  get '/' do
    redirect '/new'
  end
  
  get '/new' do
    erb :new
  end

  post '/create' do
    # NOTE: don't change next line - it's needed by autograder!
    word = params[:word] || HangpersonGame.get_random_word
    # NOTE: don't change previous line - it's needed by autograder!

    @game = HangpersonGame.new(word)
    redirect '/show'
  end
  
  # Use existing methods in HangpersonGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    letter = params[:guess].to_s[0]
	if !(letter =~ /[A-Za-z]/) || letter.nil? or letter == ''
		flash[:message] = "Invalid guess."
	else
		if !(@game.guesses.include? letter)
			@game.guess(letter)
		else
			flash[:message] = "You have already used that letter."
		end
	end
    redirect '/show'
  end
 
  get '/show' do
   if @game.check_win_or_lose == :win
		erb :win
	elsif @game.check_win_or_lose == :lose
		erb :lose
	else
		erb :show
	end
  end
  
  get '/win' do
    ### YOUR CODE HERE ###
    erb :win # You may change/remove this line
  end
  
  get '/lose' do
    ### YOUR CODE HERE ###
    erb :lose # You may change/remove this line
  end
  
end
