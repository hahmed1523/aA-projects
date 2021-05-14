require "byebug"
require_relative "players"

class Game
    ALPHABET = ("a".."z")
    MAX_LOSS = 2

    attr_reader :dictionary, :fragment, :losses, :players

    #Takes in any number players and initializes the dictionary and creates a losses hash
    def initialize(*players)
        @players = players
        @dictionary = {}
        File.foreach("./misc/words.txt") {|line| @dictionary[line.chomp] = 0}
        @losses  = Hash.new {|losses, player| losses[player] = 0}
        @players.each {|player| @losses[player.name] = 0 }

    end

    def run
        play_round until game_over?
        puts "#{winner} wins!"
    end

    def game_over?
        remaining_players == 1
    end

    def play_round
        @fragment = ""
        welcome
    
        until round_over?
          take_turn
          next_player!
        end
    
        update_standings
    end



    

