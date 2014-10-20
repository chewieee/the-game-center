class Grid

	attr_reader :grid_arr

	def initialize(grid_arr=nil)
		@grid_arr = grid_arr || blank_grid
	end
  
  def self.blank_grid
  	Array.new(7) { Array.new }
  end

  def add_piece(move, piece)
  	@grid_arr[move] << piece
  end


end
