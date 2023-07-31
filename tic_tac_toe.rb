module TicTacToe
  LINES = [
    [1,2,3],
    [4,5,6],
    [7,8,9],
    [1,4,7],
    [2,5,8],
    [3,6,9],
    [1,5,9],
    [3,5,7]
  ]

  class Game
    def initialize(player1, player2)
      @board = Array.new(10)

      # the board looks like this:
      #  1 | 2 | 3
      # ---+---+---
      #  4 | 5 | 6
      # ---+---+---
      #  7 | 8 | 9

      # spot 0 is skipped to easier differentiate between 'O' and 0 during gameplay

      @current_player_id = 0
      @players = [player1 = Player.new(self, 'X'), player2 = Player.new(self, 'O')]
      puts "#{current_player} goes first."
    end

    attr_reader :board, :current_player_id

    def play
      loop do
        place_marker(current_player)

        if winner?(current_player)
          puts "#{current_player} wins!"
          print_board
          return
        elsif board_full?
          puts "It's a draw."
          print_board
          return
        end

        swap_players
      end
    end

    def print_board
      column_separator = ' | '
      row_separator = '---+---+---'

      position_label = lambda{ |position| @board[position] ? @board[position] : position }
      row_display = lambda{ |row| row.map(&position_label).join(column_separator) }
      row_positions = [ [1,2,3], [4,5,6], [7,8,9] ]
      display_rows = row_positions.map(&row_display)

      puts "\n " + display_rows.join("\n#{row_separator}\n ") + "\n\n"
    end

    def free_positions
      (1..9).select { |position| @board[position].nil?}
    end

    private

    def place_marker(player)
      position = player.select_position
      puts "\n#{player} selects position #{position}"
      @board[position] = player.marker
    end

    def winner?(player)
      LINES.any? do |line|
        line.all? { |position| @board[position] === player.marker}
      end
    end

    def board_full?
      free_positions.empty?
    end

    def other_player_id
      1 - @current_player_id
    end

    def swap_players
      @current_player_id = other_player_id
    end

    def current_player
      @players[current_player_id]
    end

    def opponent
      @players[other_player_id]
    end

  end

  class Player
    attr_reader :marker

    def initialize(game, marker)
      @game = game
      @marker = marker
    end

    def select_position
      @game.print_board
      loop do
        puts "Your turn, Player #{marker}!"
        print "Select your position: "
        selection = gets.chomp.to_i
        return selection if @game.free_positions.include?(selection)
        puts "Position #{selection} is not available. Try again."
      end
    end

    def to_s
      "Player #{marker}"
    end
  end
end

include TicTacToe

Game.new(Player, Player).play
