# Card class has a value and a face up or down boolean

class Card 

    attr_reader :value, :face_up 
    #initialize with face_up as false
    def initialize(value)
        @value = value
        @face_up = false
    end

    #if face_up is true then print the value
    def display
        if @face_up
            return @value.to_s
        else
            return " "
        end
    end

    #change face_up to false
    def hide
        @face_up = false 
    end

    #change face_up to true
    def reveal
        @face_up = true 
    end

    #Card -> Boolean
    #Compare this card value with other card value
    def ==(other_card)
        @value == other_card.value 
    end

    #Change value of card to string
    def to_s
        @value.to_s 
    end


end