
class Game

  public def initialize
    @first_player_score = 0
    @second_player_score = 0
    @finish_game_score = 3
    @weapons = %w[rock paper scissors] # %w[smth smth] is a shortcut for ["smth", "smth"]
  end

  public def do_game

    display_welcome

    # Ruby until loop will executes the statements or code till the given condition evaluates to true
    until @first_player_score == @finish_game_score || @second_player_score == @finish_game_score

      puts "Choose: 1.rock 2.paper 3.scissors"

      user_answer = gets.to_i - 1

      if user_answer < 0 || user_answer >= 3
        abort "Invalid data"
      end

      first_player_weapon =  @weapons[user_answer]
      second_player_weapon = @weapons[rand(3)] # because of we have only 3 variants (0-2)

      display_weapons(first_player_weapon, second_player_weapon)

      if first_player_weapon == second_player_weapon
          puts "Draw"
      elsif (first_player_weapon == "rock" && second_player_weapon == "scissors") || (first_player_weapon == "scissors" && second_player_weapon == "paper") || (first_player_weapon == "paper" && second_player_weapon == "rock")
          @first_player_score = @first_player_score + 1
          puts "-> First player won <-"
      else
          @second_player_score = @second_player_score + 1
          puts "-> Second player won <-"
      end

      display_score

    end
  end

  private def display_weapons(first_player_weapon, second_player_weapon)
    puts "First player weapon: #{first_player_weapon}"
    puts "Second player weapon: #{second_player_weapon}"
  end

  private def display_welcome
    puts "Rock Paper Scissors game"
  end

  private def display_score
    puts "----------------------"
    puts "Score: "
    puts "First player #{@first_player_score}"
    puts "Second player #{@second_player_score}"
    puts "----------------------"
  end

end

object = Game.new
object.do_game
