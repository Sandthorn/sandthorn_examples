module TicTacToe

  class Session
    include Sandthorn::AggregateRoot

    attr_reader :board, :moves, :gameover, :winner

    def initialize
      @board = nil
      @moves = 0
      @gameover = false
      @winner = nil
    end

    ### Commands API
    def start size = 3
      started size
    end

    def play player, x, y

      is_win = case player
      when :x
        board.mark :x, x, y
        played_cross x, y
        board.check_win? :x, x, y
      when :o
        board.mark :o, x, y
        played_circle x, y
        board.check_win? :o, x, y
      end
      board.save

      increment_move
      check_win? is_win, player

      is_win
    end

    def check_win? win, player
      player_won player if win
    end

    private

    def increment_move
      @moves = moves + 1
    end

    ### Events API
    def started size
      @board = Board.new size
      commit
    end

    def player_won player
      @gameover = true
      @winner = player
      commit
    end

    def played_cross x, y; commit; end
    def played_circle x, y; commit; end
  end

end
