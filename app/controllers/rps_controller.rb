class RpsController < ApplicationController
	def new
		@score = [0,0]
		save_score
    
    render :rps
	end

	def throw
		@score = retrieve_current_score
		@computer_throw = computer_choice
		@player_throw = retrieve_player_throw

		@result = evaluate_winner(@player_throw, @computer_throw)

    save_score
    render :rps
	end

	def reset
		@score = [0,0]
		render :rps
	end

  
	private

	def retrieve_current_score
		session[:score]
	end

	def save_score
		session[:score] = @score
	end

	def computer_choice
		choices = %w{ paper rock scissors }
		@computer_choice = choices.sample
	end

	def retrieve_player_throw
		params[:player_choice]
	end

	
	def evaluate_winner(player_throw, computer_throw)
  	case [player_throw, computer_throw]

  	when %w{ paper rock }, %w{ scissors paper }, %w{ rock scissors }
  		@score[0] += 1
			@result = "You win!"

		when %w{ rock paper }, %w{ paper scissors }, %w{ scissors rock }
			@score[1] += 1
			@result = "Bummer, you lost."
			
		else
			# it's a tie
			@result = "It's a tie!"
		end
	end

end
