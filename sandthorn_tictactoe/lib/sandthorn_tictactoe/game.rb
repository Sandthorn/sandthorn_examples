module TicTacToe
  class Game

    attr_reader :sessions, :interface

    def initialize
      @sessions = []
      @interface = CommandLineInterface.new
    end

    def start
      session = create_session
      interface.run session
    end

    private

    def create_session
      @sessions << Session.new
      sessions.last
    end
  end

  class CommandLineInterface
    attr_reader :current_session

    def initialize
      @current_session = nil
    end

    def run session
      @current_session = session
      current_session.start
      current_session.save
      run_loop
    end

    def run_loop
      moves = 0
      while true
        print_board
        player = select_player moves
        puts 'Player %s, make your move.' % player
        input = STDIN.gets
        coords = format_input input
        win = current_session.play player, coords[0], coords[1]
        moves = moves + 1
        if win
          puts 'Player %s won!' % player
          break
        end
      end
      puts 'Game over.'
      print_board
    end

    def print_board
      current_session.board.board.each do |row|
        p row
      end
    end

    def format_input input
      input.split(',').map { |x| x.strip.to_i }
    end

    def select_player moves
      moves % 2 == 0 ? :x : :o
    end

    def play player, x, y
      status = current_session.play player, x, y
      current_session.save
      status
    end
  end
end
