require_relative "card.rb"

#Board class that takes in Cards

class Board

    LEVELS = [2, 8, 18]
    ROW_COLS = [[2,2], [4,4], [6,6]]
    LETTERS = ("a".."z").to_a

    attr_reader :grid , :cards, :row, :col 

    #create grid with empty array the size of the number of cards times 2 for the pair.
    ##MAYBE NEED TO CHANGE HOW TO CREATE BOARD. MAYBE USE EASY, NORMAL, HARD AND HAVE THAT DETERMINE NUMBER OF CARDS.
    def initialize(difficulty_level = 0)
        @cards = []
        @used_letters = []
        LEVELS[difficulty_level].times.each do 
            @cards << make_card
        end
        @row = ROW_COLS[difficulty_level][0]
        @col = ROW_COLS[difficulty_level][1]

        @grid = Array.new(@row){[]}
    end

    #get a random letter and make a Card if letter hasn't already been used
    def make_card
        rand_num = rand(LETTERS.length)
        letter = LETTERS[rand_num]
        while @used_letters.include?(letter)
            rand_num = rand(LETTERS.length)
            letter = LETTERS[rand_num]
        end
        @used_letters << letter 
        return Card.new(letter)
    end

    #populate grid with shuffled card pairs
    def populate
        new_cards = @cards + create_pair
        new_cards = new_cards.sample(new_cards.length)
        idx = 0 
        (0...@row).each do |ri|
            row = []
            @col.times do 
                row << new_cards[idx]
                idx += 1
            end
            @grid[ri] += row
        end
    end

    #create pair of cards
    def create_pair
        pair_cards = []
        @used_letters.each {|letter| pair_cards << Card.new(letter)}
        return pair_cards 
    end

    #render the columns
    def render_columns
        columns = "  "
        (0...grid.length).each {|n| columns += n.to_s+ " "}
        return columns
    end
    
    #render the board
    def render
        puts render_columns
        @grid.each_with_index do |row, i|
            row_str = "#{i} "
            last_idx = row.length - 1
            (0...row.length).each do |idx|
                if idx == last_idx
                    row_str += row[idx].display
                else
                    row_str += row[idx].display + " "
                end
            end

            puts row_str

        end
    end

    #check if all cards are face up
    def won?
        @grid.all? {|row| row.all? {|card| card.face_up}}
    end

    #reveal the card at the guessed position
    def reveal(guessed_pos)
        row, col = guessed_pos 
        @grid[row][col].reveal 
        return @grid[row][col].value
    end

end