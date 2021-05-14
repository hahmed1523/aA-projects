require "byebug"

class ComputerPlayer
    
    attr_reader :name, :known_cards

    def initialize
        @name = "CPU"
        @known_cards = Hash.new {|hash, k| hash[k] = []}
        @match_cards = []
    end

    #add pos to known cards with value if it doesnt already exist
    def receive_revealed_card(pos, val)
        if @known_cards[val].empty?
            @known_cards[val] << pos
        else
            @known_cards[val] << pos if @known_cards[val].none? {|loc| loc == pos}
        end
    end

    #add match positions to matched cards
    def receive_match(pos1, pos2)
        @match_cards << pos1
        @match_cards << pos2 
    end

    #computer takes turn
    def take_turn(board)
        board.render
        puts
        prompt
        sleep(2)
        if two_cards? && !in_match?(get_two_cards)
            pos1, pos2 = get_two_cards
            puts "#{pos1[0]} #{pos1[1]}"
            sleep(1)
            card1 = board.reveal(pos1)
            system("clear")
            board.render
            puts
            prompt
            sleep(1)
            puts "#{pos2[0]} #{pos2[1]}"
            sleep(1)
            card2  = board.reveal(pos2)
            system("clear")
            board.render
            puts
            sleep(1)
            puts "Its a Match!"
            receive_match(pos1, pos2)
            sleep(2)
            !board.won?
        else 
            guess = random_guess(board)
            puts "#{guess[0]} #{guess[1]}"
            card1 = board.reveal(guess)
            system("clear")
            board.render
            puts
            prompt 
            sleep(2)
            if in_known?(card1)
                next_guess = @known_cards[card1][0]
                puts "#{next_guess[0]} #{next_guess[1]}"
                sleep(1)
                card2 = board.reveal(next_guess)
                system("clear")
                board.render
                puts
                sleep(1)
                puts "Its a Match!"
                receive_match(guess, next_guess)
                sleep(2)
                system("clear")
                !board.won?
            else
                not_valid = true 
                while not_valid
                    next_guess = random_guess(board)
                    not_valid = false if next_guess != guess 
                end
                puts "#{next_guess[0]} #{next_guess[1]}"
                sleep(1)
                card2 = board.reveal(next_guess)
                system("clear")
                board.render
                puts
                sleep(1)
                if card1 != card2
                    puts "Not a Match!"
                    sleep(2)
                    board.grid[guess[0]][guess[1]].hide 
                    board.grid[next_guess[0]][next_guess[1]].hide
                    receive_revealed_card(guess, card1)
                    receive_revealed_card(next_guess, card2)
                    return false
        
                else
                    puts "Its a Match!"
                    receive_match(guess, next_guess)
                    sleep(2)
                    system("clear")
                    !board.won?
                    
                end
            end           
        end
    end

    #return random guess
    def random_guess(board)
        not_valid = true 
        while not_valid 
            row = rand(0..board.row-1)
            col = rand(0..board.col-1)
            if !@match_cards.include?([row,col]) && !pos_in_known?([row, col])
                not_valid = false 
            end
        end

        return row, col 
    end

    def prompt
        puts "Computer, Enter a row and column for your guess with space in between (eg. 0 1):"
    end

    #look at known_cards to see if there are any values with two positions
    def two_cards?
        @known_cards.any? {|k,v| v.length > 1}
    end

    #return the positions of the two cards
    def get_two_cards
        @known_cards.each {|k,v| return v if v.length > 1}
    end

    #check if one of the positions is in the match which means they both are.
    def in_match?(arr_of_pos)
        pos1, pos2 = arr_of_pos 
        @match_cards.include?(pos1)
    end

    #check if value is in known location
    def in_known?(val)
        @known_cards.include?(val)
    end

    #check if position is in known cards
    def pos_in_known?(pos)
        @known_cards.any? {|k,v| v.any?{|loc| loc == pos}}
    end

end