require 'spec_helper'

module TicTacToe
  describe Board do
    let(:board) { Board.new }

    it 'has a default size of 3' do
      board.board.length.should eql(3)
      board.board[0].length.should eql(3)
    end

    context 'when player X' do
      it 'marks a position' do
        board.mark_cross(0, 0)
        board.board[0][0].should eql(:x)
      end
    end

    context 'when Player Y' do
      it 'marks a position' do
        board.mark_circle(0,1)
        board.board[0][1].should eql(:o)
      end

      it 'cannot mark already marked position' do
        board.mark_cross(0,0)
        board.mark_circle(0,0)
        board.board[0][0].should eql(:x)
      end
    end

    context 'when three in a row' do
      it 'return true for three crosses' do
        board.mark_cross(0,0)
        board.mark_cross(0,1)
        board.mark_cross(0,2)
        board.check_win?(:x, 0, 2).should be_true
      end

      it 'return false for three crosses for circle player' do
        board.mark_cross(0,0)
        board.mark_cross(0,1)
        board.mark_cross(0,2)
        board.check_win?(:o, 0, 2).should be_false
      end

      it 'return true for three crosses in row two' do
        board.mark_cross(2,0)
        board.mark_cross(2,1)
        board.mark_cross(2,2)
        board.check_win?(:x, 2, 2).should be_true
      end

      it 'return true for three crosses in a column' do
        board.mark_cross(0,0)
        board.mark_cross(1,0)
        board.mark_cross(2,0)
        board.check_win?(:x, 2, 0).should be_true
      end

      it 'return true for three crosses in column two' do
        board.mark_cross(0,2)
        board.mark_cross(1,2)
        board.mark_cross(2,2)
        board.check_win?(:x, 2, 2).should be_true
      end

      it 'return true for three crosses in a diagonal' do
        board.mark_cross(0,0)
        board.mark_cross(1,1)
        board.mark_cross(2,2)
        board.check_win?(:x, 2, 2).should be_true
      end

      it 'return false when marks differs' do
        board.mark_cross(0,0)
        board.mark_circle(0,1)
        board.mark_cross(0,2)
        board.check_win?(:x, 0, 2).should be_false
      end
    end
  end
end
