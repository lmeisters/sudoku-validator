class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    rows = @puzzle_string.split("\n").map { |row| row.split(" ").map(&:to_i) } # Converts the puzzle into a two-dimensional array of integers, where each inner array represents a row of the Sudoku puzzle

    if is_valid_sudoku(rows) && !is_incomplete_sudoku(rows) 
      return 'Sudoku is valid.' # Returns if the sudoku is valid and complete
    elsif is_valid_sudoku(rows) 
      return 'Sudoku is valid but incomplete.' # Returns if the sudoku is valid but incomplete
    else
      return 'Sudoku is invalid.' # Returns if the sudoku isn't valid or incomplete
    end
  end

  def is_valid_sudoku(board)
    board.all? { |row| row.uniq.size == 9 } && # Checks if no numbers are repeated in any of the rows
      board.transpose.all? { |col| col.uniq.size == 9 } && # Checks if no numbers are repeated in any of the columns 
      is_valid_subgrid(board) # Checks if 3x3 square has no repeated numbers
  end

  def is_valid_subgrid(board)
    subgrids = board.each_slice(3).to_a # Divides the board into subgrid rows, each containing 3 rows from the board
    subgrids.all? do |rows| # Checks each subgrid row for valid subgrids
      subgrid_rows = rows.transpose # Converts the subgrid rows into subgrid columns
      subgrid_rows.all? { |subgrid_row| subgrid_row.flatten.uniq.size == 9 } # Checks each subgrid column has no duplicates
    end
  end

  def is_incomplete_sudoku(board)
    board.any? { |row| row.include?(0) } # Checks if any row in the board has a 0 for empty cells
  end
end