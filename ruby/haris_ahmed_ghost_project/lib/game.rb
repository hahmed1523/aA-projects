require "byebug"
require_relative "players"

class Game
    ALPHABET = ("a".."z")
    MAX_LOSS = 5

    attr_reader :dictionary, :fragment

    def initialize(*players)
        @players = players
        @dictionary = {}
        File.foreach("/home/hahmed1523/Documents/appacademy/ruby/haris_ahmed_ghost_project/misc/words.txt") {|line| @dictionary[line.chomp] = 0}
        @losses  = Hash.new {|losses, player| losses[player] = 0}
        @players.each {|player| @losses[player.name] = 0 }

    end

    def current_player 
        @players[0].name
    end

    # def previous_player
    #     @players[1].name 
    # end

    def previous_player
        (@players.count - 1).downto(0).each do |idx|
          player = @players[idx]
    
          return player.name if @losses[player.name] < MAX_LOSS
        end
    end

    def next_player! 
        @players.rotate!
    end

    def take_turn(player)
        ans = ""
        while ans == ""
            puts "#{player} enter a letter:"
            ans = gets.chomp.downcase
            while !valid_play?(ans)
                ans = gets.chomp.downcase 
            end
        end

        @fragment += ans 
        @dictionary.keys.include?(@fragment)

    end

    def valid_play?(string)
        temp_frag = @fragment + string 
        if (ALPHABET.include?(string)) && (@dictionary.keys.any? {|word| word.start_with?(temp_frag)})
            return true 
        else
            puts "this is not valid!"
        end
    end

    def play_round 
        @fragment = ""
        puts "------------"
        puts "Round Begins!"       
        player = current_player
        while !take_turn(player)
            puts "Current Fragment: #{@fragment}"
            next_player!
            until @losses[current_player] < MAX_LOSS
                next_player!
            end
            player = current_player
        end
        #debugger
        update_loss
        puts "Current Fragment: #{@fragment}"
        display_standings
    end

    def update_loss
        @losses.each do |k,v|
            if k != current_player && v < MAX_LOSS 
                @losses[k] += 1
            end
        end
    end

    def record(player)
        return "GHOST"[0...@losses[player.name]]
    end

    def display_standings
        puts "Current Standings:"
        puts "-----------------"
        @players.each {|player| puts "#{player.name}: #{record(player)}"}
    end

    # def game_over?(player)
    #     if @losses[player] == MAX_LOSS
    #         puts "#{current_player} WINS!"
    #         puts "Word: #{@fragment}"
    #         display_standings 
    #         return true 
    #     else
    #         return false 
    #     end
    # end


    def game_over?(player)
        total_players = @players.length
        count = 0
        #debugger
        @losses.each {|k,v| count += 1 if v >= MAX_LOSS}
        if count == total_players - 1
            puts "#{current_player} WINS!"
            puts "Word: #{@fragment}"
            display_standings 
            return true 
        else
            return false 
        end
    end

    def run
        until game_over?(previous_player)
            play_round
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    game1 = Game.new(Player.new('Bob'), Player.new("Tom"), Player.new("Hon"))
    game1.run 
end


