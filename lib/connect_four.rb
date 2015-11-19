require_relative 'board'
require_relative 'player'

class ConnectFour
  attr_reader :board, :player_1, :player_2

  def initialize
    @board = Board.new
    @player_1_name = nil
    @player_2_name = nil
  end

  def play_game
    start_game
    @turn = player_1
    while @winner != true
      board.print_board
      player_turn
    end

    board.print_board
    puts "\n#{@turn.name} wins!"
  end

  private

  VALID_COLUMNS = %w(A B C D E F G H I J)

  def start_game
    @player_1 = Player.new(prompt_player_name, 'X')
    @player_2 = Player.new(prompt_player_name, 'O')
    greet_player(player_1)
    greet_player(player_2)
  end

  def prompt_player_name
    puts "Welcome, what is your name?"
    input = STDIN.gets.chomp
  end

  def greet_player(player)
    puts "Hello #{player.name}.  Your piece is #{player.symbol}."
  end

  def player_turn
    @input = false

    while VALID_COLUMNS.include?(@input) == false
      prompt_move
    end

    column_index = VALID_COLUMNS.index(@input)

    board.drop_piece(column_index, @turn)
    @winner = board.winner?

    unless @winner
      next_turn = @turn == player_1 ? player_2 : player_1
      @turn = next_turn
    end
  end

  def prompt_move
    puts "\n#{@turn.name}'s turn:"
    puts "In which column would you like to drop your piece?"
    @input = STDIN.gets.chomp.capitalize
  end

end

a = ConnectFour.new
a.play_game
