LINES = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

class Game
  def initialize(player1, player2)
    @board = Array.new(9)

    # the board looks like this:
    #  0 | 1 | 2
    # ---+---+---
    #  3 | 4 | 5
    # ---+---+---
    #  6 | 7 | 8

    @current_player_id = 0
    @players = [player1 = Player.new(self, 'X'), player2 = Player.new(self, 'O')]
    puts "#{current_player} goes first."
  end

  attr_reader :board, current_player_id

  def play
    # code to run the actual game

    # check current_player
    # ask current_player to select_position
    # update board with selection

    # repeat
  end
end

def free_positions
  # determine which positions are still available
  (0..8).select { |position| @board[position].nil?}
end

def place_marker
  # mark the place chosen with current_player's marker
  position = player.select_position
  puts "#{player} selects #{player.marker} position #{position}"
end

def winner?
  # determine who the winner of the game is
  LINES.any? do |line|
    line.all? { |position| @board[position] === player.marker}
  end
end

def board_full?
  # check if the board if full
  free_positions.empty?
end

def other_player
  1 - @current_player_id
end

def swap_players
  @current_player_id = other_player_id
end

def current_player
  # check who the current player is
  @players[current_player_id]
end

def opponent
  @players[other_player_id]
end

def turn_number
  # keep track of number of turns remaining
  10 - free_positions.size
end

def print_board
  # print the board after each turn

  # example of what the board looks like
  # fill in O's with player's markers
  puts " O | O | O"
  puts "---+---+---"
  puts " O | O | O"
  puts "---+---+---"
  puts " O | O | O"
end

class Player
  attr_reader :marker

  def initialize(game, marker)
    @game = game
    @marker = marker
  end

  def select_position

  end
end

class Player1 < Player

end

class Player2 < Player

end

Game.new(Player, Player).play