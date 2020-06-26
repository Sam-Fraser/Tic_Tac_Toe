#spec/game_spec.rb

require './game'

describe Board do
  describe "#valid_move" do
    it "returns true if the move is on the board and empty" do
      board = Board.new
      expect(board.valid_move?(2)).to eql(true)
    end

    it "returns false if the move is off the board" do
      board = Board.new
      expect(board.valid_move?(10)).to eql(false)
    end

    it "returns false if the space on the board is taken" do
      board = Board.new
      board.place_token(1,'x')
      expect(board.valid_move?(1)).to eql(false)
    end
  end

  describe "#winning_combo" do
    it "returns true if the combo is a winning combo" do
      board = Board.new
      board.place_token(0,'x')
      board.place_token(1,'x')
      board.place_token(2,'x')
      expect(board.winning_combo?("x")).to eql(true)
    end
    
    it "returns false if the combo is not a winning combo" do
      board = Board.new
      board.place_token(2,'x')
      board.place_token(3,'x')
      board.place_token(4,'x')
      expect(board.winning_combo?("x")).to eql(false)
    end
  end

  describe "#full?" do
    it "returns true if the gameboard is full" do
      board = Board.new
      board.place_token(0,'x')
      board.place_token(1,'x')
      board.place_token(2,'x')
      board.place_token(3,'x')
      board.place_token(4,'x')
      board.place_token(5,'x')
      board.place_token(6,'x')
      board.place_token(7,'x')
      board.place_token(8,'x')
      expect(board.full?).to eql(true)
    end

    it "returns false if the gameboard is not full" do
      board = Board.new
      board.place_token(0,'x')
      board.place_token(1,'x')
      board.place_token(2,'x')
      board.place_token(3,'x')
      board.place_token(4,'x')
      board.place_token(5,'x')
      board.place_token(6,'x')
      expect(board.full?).to eql(false)
    end
  end

  describe "#open_space" do
    it "returns true if the space is open" do
      board = Board.new
      expect(board.open_space?(1)).to eql(true)
    end

    it "returns false if the space is occupied" do
      board = Board.new
      board.place_token(1,'x')
      expect(board.open_space?(1)).to eql(false)
    end
  end

  describe "#place_token" do
    it "places piece at certain spot on board" do
      board = Board.new
      board.place_token(1,"x")
      expect(board.game_board[1]).to eql("x")
    end
  end
end