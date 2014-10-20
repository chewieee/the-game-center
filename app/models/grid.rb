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

  def winning_combination?(piece)
    winning_diagonal?(piece)    ||  
    winning_horizontal?(piece)  ||
    winning_vertical?(piece)
  end

  def winning_diagonal?(piece)
    diagonals.any? do |diag|
		  if diag.size > 3
			  diag.join('').include?((piece * 4))
			end
		end
  end

  def winning_vertical?(piece)
      verticals.any? do |vert|
        vert.join('').include?(piece * 4)
      end
  end

  def winning_horizontal?(piece)
      horizontals.any? do |horz|
      	hor = horz.map do |x|
      		x.nil? ? x = 'X' : x
      	end
      	hor.join('').include?(piece * 4)
      end
  end

  def diagonals
    [@grid_arr, @grid_arr.map(&:reverse)].inject([]) do |all_diags, matrix|
      ((-matrix.count + 1)..matrix.first.count).each do |offet_index|
        diagonal = []
        (matrix.count).times do |row_index|
          col_index = offet_index + row_index
          diagonal << matrix[row_index][col_index] if col_index >= 0
        end
        all_diags << diagonal.compact if diagonal.compact.count > 1
      end
      all_diags
    end
  end

  def verticals
      @grid_arr
  end

  def horizontals
    horizontals = []
    6.times do |i|
      horizontals << [@grid_arr[0][i],@grid_arr[1][i],@grid_arr[2][i],@grid_arr[3][i],@grid_arr[4][i],@grid_arr[5][i],@grid_arr[6][i]]
    end
    p horizontals 

  end

  def full?
      @grid_arr.all? do |row|
          row.size == 6
      end
  end



end
