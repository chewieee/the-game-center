class TicTacToeController < ApplicationController
  def new
  	@current_player = 'X'
  	@board_arr = Board.blank_board

  	save_player
  	save_board_arr

  	render :game_board 
  end

  def make_move
  	@current_player = retrieve_current_player
    
    @board = Board.new(retrieve_board_arr)
    @board.add_piece(retrieve_coords, @current_player)

    @game_over = game_over_message

    @board_arr = @board.board_arr
  	switch_player
  	save_player
    save_board_arr

  	render :game_board
  end


  private

  def switch_player
  	@current_player = (@current_player == 'X' ? 'O' : 'X')
  end

  def retrieve_current_player
  	session[:current_player]
  end

  def save_player
  	session[:current_player] = @current_player
  end

  def save_board_arr
  	session[:saved_board_arr] = @board_arr
  end

  def retrieve_board_arr
  	session[:saved_board_arr]
  end

  def retrieve_coords
  	params[:move].split(",").map(&:to_i)
  end

  def game_over_message
  	if @board.winning_combination?(@current_player)
  		@game_over = "Game over, player #{@current_player} wins!"
  	elsif @board.full?
  		@game_over = "Game Over! You've drawn."
  	end
  end
end
