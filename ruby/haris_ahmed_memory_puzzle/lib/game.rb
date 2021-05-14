require_relative "board.rb"
require_relative "humanplayer.rb"
require_relative "computerplayer.rb"

class Game

    attr_reader :board, :prev_guess

    def initialize
        @prev_guess = []
        puts "Enter Your Name:"
        name = gets.chomp
        @player = HumanPlayer.new(name)
        @cpu = ComputerPlayer.new
    end

    #Main loop
    def run 
        welcome 
        level = @player.get_diff
        @board = Board.new(level)
        @board.populate 
        play until over?
        @board.render
        puts "You Win! You made all the matches!"
    end

    #Welcome Message
    def welcome
        puts "Memory Puzzle!"
        puts
        puts "Select A Difficulty Level"
        puts "0: Easy"
        puts "1: Normal"
        puts "2: Hard"
        puts
        puts "Enter a number 0 - 2:"
    end


    #Render, Prompt, Make Guess
    def play
        system("clear")
        puts 
        while make_guess
        end
        if !over?
            while @cpu.take_turn(@board)
            end
        end
    end

    #Check if the cards match and if so then keep them Face Up for either player or CPU
    def make_guess
        pos = @player.prompt(@board)
        card1 = @board.reveal(pos)
        guess_2 = @player.prompt(@board)
        card2 = @board.reveal(guess_2)
        @board.render
        puts
        if card1 != card2
            puts "Not a Match!"
            sleep(2)
            @board.grid[pos[0]][pos[1]].hide 
            @board.grid[guess_2[0]][guess_2[1]].hide
            @cpu.receive_revealed_card(pos, card1)
            @cpu.receive_revealed_card(guess_2, card2)
            system("clear")
            return false

        else
            puts "Its a Match!"
            @cpu.receive_match(pos, guess_2)
            sleep(2)
            system("clear")
            !@board.won?

        end        
    end

    #Check if all cards are face up
    def over?
        @board.won?       
    end
end

