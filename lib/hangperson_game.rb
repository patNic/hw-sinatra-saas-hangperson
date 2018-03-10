class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_accessor :temp
  attr_accessor :count
  @bool = true
  
  def initialize(word)
    @word = word.downcase
	@guesses= ""
	@wrong_guesses = ""
	@temp = "-"*word.length;
	@count = 0
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def word_with_guesses
	wrd = word.split(//)
	ges = guesses.split(//)
	
	ges.each_with_index do |elem|
		wrd.each_with_index do |value, i|
			if value==elem and i < @temp.length
				@temp[i] = elem
			end
		end
	end
	return @temp
  end
  def guess letter
	if(letter == '' or !(letter =~ /[A-Za-z]/) or letter.nil?)
		raise ArgumentError
	end
	letter.downcase!
	if @word.include? letter
		guess = guesses
		if !(guess.include? letter)
			guesses=(guess<<letter)
			true
		else
			false
		end
	else
		w_guess = wrong_guesses
		if !(w_guess.include? letter)
			wrong_guesses=(w_guess<<letter)
		end
		false
	end
  end
  def check_win_or_lose
	if word_with_guesses == word and wrong_guesses.length <= 7
		return :win
	elsif word_with_guesses != word and wrong_guesses.length >= 7
		return :lose
	else
		return :play
	end
  end
end
