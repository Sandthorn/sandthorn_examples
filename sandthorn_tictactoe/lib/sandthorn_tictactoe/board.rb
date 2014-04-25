require 'sandthorn'

module TicTacToe

  class Board
    include Sandthorn::AggregateRoot

    attr_reader :board

    def initialize size = 3
      @board = create_board size
    end

    ### Commands API

    def mark_cross x, y
      mark :x, x, y
    end

    def mark_circle x, y
      mark :o, x, y
    end

    def mark player, x, y
      if within_bounds? x, y
        unless marked? x, y
          marked player, x, y
        end
      end
    end

    def check_win? player, x, y
      return (check_row player, x, y or
              check_col player, x, y or
              check_diagonal player, x, y or
              check_antidiagonal player, x, y)
    end

    private

    def player_marked? player, x, y
      board[x][y] == player
    end

    def marked? x, y
      board[x][y] != nil
    end

    def within_bounds? x, y
      size = board.length
      x >= 0 and y >= 0 and x < size and y < size
    end

    def create_board size
      rows = Array.new
      (1..size).each do |i|
        rows << Array.new(size)
      end
      rows
    end

    def check_row player, x, y
      for i in 0..@board.length
        if @board[x][i] != player
          break
        end
        if i == @board.length - 1
          return true
        end
      end
      return false
    end

    def check_col player, x, y
      for i in 0..@board.length
        if @board[i][y] != player
          break
        end
        if i == @board.length - 1
          return true
        end
      end
      return false
    end

    def check_diagonal player, x, y
      if x == y
        for i in 0..@board.length
          if @board[i][i] != player
            break
          end
          if i == @board.length - 1
            return true
          end
        end
      end
      return false
    end

    def check_antidiagonal player, x, y
      # Honestly stolen from http://bit.ly/1gUYDIT
      for i in 0..@board.length
        if @board[i][(@board.length - 1) - i] != player
          break
        end
        if i == @board.length - 1
          return true
        end
      end
      return false
    end

    ### Events
    def marked player, x, y
      board[x][y] = player
      commit
    end
  end
end
