class ConnectFourController < ApplicationController
	def new
		@current_player = 'red'
		@grid_arr = Grid.blank_grid
		
		save_player
    save_grid_arr   
  
    render :game_board
	end

	def drop_piece
    @current_player = retrieve_current_player
    @grid = Grid.new(retrieve_grid_arr)
    @grid.add_piece(retrieve_move, @current_player)

    @game_over = game_over_message
    
    @grid_arr = @grid.grid_arr
    switch_player
    save_player 
    save_grid_arr
		
	  render :game_board
	end

  private

  def switch_player
  	@current_player = (@current_player == 'red' ? 'yellow' : 'red')
  end

  def retrieve_current_player
  	session[:current_player]
  end

  def save_player
  	session[:current_player] = @current_player
  end
  
  def save_grid_arr
  	session[:saved_grid_arr] = @grid_arr
  end

  def retrieve_grid_arr
  	session[:saved_grid_arr]
  end
  
  def retrieve_move
  	params[:move].to_i
  end

  def game_over_message
  	if @grid.winning_combination?(@current_player)
  		@game_over = "Game over, #{@current_player} wins!"
  	elsif @grid.full?
  		@game_over = "Game over! You've drawn."
  	end
  end
end
