# game board, has 9 empty slots
# 2 players, player1 = "x" player2 = "o"
# players take turns playing by placing their token on 1 slot per turn
# players can only place their piece on an empty slot
# 8 winning combinations [top row, middle row, bottom row, left col, middle col, right col, left diagonal, right diagonal]
# if game board is full of x's and o's with no winning combination present, the game is a tie.

# game class: 
  # show_board method:
  # should show game board with empty spots denoted by numbers and filled spots denoted by x's or o's
  # play method:
  # should ask current player where they want to place their token
  # should know if a winning combination currently exists
    # if one does print which player is the winner
    # if not, switch players and repeat
  # should loop until a winner is found or game is a tie

  #should know if 

# player class: 
  # should be able to place respective token on the game board in specific spot
  # can only place token on an empty slot

class Game
  #creates a game board and the two players
  def initialize
    #sets up board
    @board = Board.new
    
    #sets up players
    @player1 = Player.new("Player 1", "X", @board)
    @player2 = Player.new("Player 2", "O", @board)

    #sets current player
    @current_player = @player1
  end

  def play
    #start game and loop until finished
    loop do
      #display board
      @board.display_board

      #get player move
      @current_player.get_move

      #check if game is over
      break if game_over?

      #switch player
      switch_player
    end
  end

  def game_over?
    #checks for win or draw
    win? || draw?
  end

  def win?
    #checks board to see if a winning combo has been played by 
    if @board.winning_combo?(@current_player.token)
      puts "Congrats #{@current_player.name}! YOU WIN!"
      @board.display_board
      true
    else
      false
    end
  end

  def draw?
    #checks if board is full 
    if @board.full?
      puts "Cat's game ..."
      true
    else
      false
    end
  end

  def switch_player
    if @current_player == @player1 
      @current_player = @player2
    else
      @current_player = @player1
    end
  end
  
  
end

class Player
  attr_accessor :name, :token

  def initialize(name, token, board)
    @name = name
    @token = token
    @board = board
  end

  def get_move
    loop do 
      #gets postion to place token
      position = ask_for_move

      #checks for validity
      if @board.valid_move?(position)
        @board.place_token(position, @token)
        break
      end
    end
  end

  def ask_for_move
    #Gets board position player would like to place token
    print "Which space number do you want to place your token? "
    gets.chomp.to_i - 1
  end
end


class Board
  #all winning combos
  WINNING_COMBOS = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]

  def initialize
    @game_board = Array(1..9)
  end

  def valid_move?(position)
    #checks if number entered is between 1 and 9 and if the space is open
    if position >= 0 && position <= 8 && open_space?(position)
      true
    else
      false
    end 
  end

  def open_space?(position)
    #checks if space is open by converting contents to a number
    #if contents are "X" or "O", return false
    if @game_board[position].to_i == 0
      false
    else
      true
    end
  end

  def place_token(position, token)
    #replaces current contents with current players token
    @game_board[position] = token
  end

  def winning_combo?(token)
    WINNING_COMBOS.any? do |arr|
      a = @game_board[arr[0]]
      b = @game_board[arr[1]]
      c = @game_board[arr[2]]
      
      a == token && b == token && c == token
    end
  end

  def full?
    @game_board.all? { |i| i.to_i == 0 }
  end
  
  def display_board
    puts " #{@game_board[0]} | #{@game_board[1]} | #{@game_board[2]} "
    puts separator = '-----------'
    puts " #{@game_board[3]} | #{@game_board[4]} | #{@game_board[5]} "
    puts separator
    puts " #{@game_board[6]} | #{@game_board[7]} | #{@game_board[8]} "
  end
end

t = Game.new
t.play