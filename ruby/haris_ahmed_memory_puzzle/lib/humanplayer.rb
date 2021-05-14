
class HumanPlayer

    attr_reader :name 
    def initialize(name)
        @name = name
    end

    #ask user for difficulty level until answer is between 0-2
    def get_diff
        not_valid = true

        while not_valid
            ans = gets.chomp.to_i 
            if (0..2).include?(ans)
                not_valid = false 
            else
                puts "Make sure the number is between 0 - 2"
            end
        end
        return ans 
    end

    #Prompt the user for an answer
    def prompt(board)
        board.render
        puts
        puts "#{@name}, Enter a row and column for your guess with space in between (eg. 0 1):"
        not_valid = true 
        while not_valid 
            row, col = gets.chomp.split(" ")
            row, col = row.to_i, col.to_i
            if (0...board.row).include?(row) && (0...board.col).include?(col) && !board.grid[row][col].face_up
                not_valid = false
            else
                puts "Not valid! Make sure the number of columns and rows are available and the position is face down!"
            end
        end
        system("clear")
        return row, col 
    end

end