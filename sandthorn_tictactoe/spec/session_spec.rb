require 'spec_helper'

module TicTacToe
  describe Session do
    let(:session) { Session.new }

    it 'creates board on start' do
      session.start
      session.board.should_not be_nil
    end

    context 'when player makes a move' do
      it 'return false if not a winning move' do
        session.start
        session.play(:x, 0, 0).should be_false
      end

      it 'return true if it is a winning move' do
        session.start
        session.play(:x, 0, 0)
        session.play(:x, 0, 1)
        session.play(:x, 0, 2).should be_true
      end
    end

    context 'when game is over' do
      it 'set game as over' do
        session.start
        session.play :x, 0, 0
        session.play :x, 0, 1
        session.play :x, 0, 2
        session.gameover.should be_true
      end

      it 'save player name' do
        session.start
        session.play :x, 0, 0
        session.play :x, 0, 1
        session.play :x, 0, 2
        session.winner.should eql(:x)
      end
    end
  end
end
