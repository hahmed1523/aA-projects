#Array -> Array
#removes duplicates from an array
def my_unique(arr)
    raise 'This is not an Array!' unless arr.is_a?(Array)
    new_arr = []
    arr.each {|ele| new_arr << ele if !new_arr.include?(ele)}
    return new_arr 
end

class Array

    #Array(self) -> Array
    #find pair of indexes where the pair values equal zero
    def two_sum
        new_arr = []

        (0...self.length).each do |i_1|
            if i_1 == self.length - 1
                break
            end
            val1 = self[i_1]
            (i_1 + 1...self.length).each do |i_2|
                val2 = self[i_2]
                new_arr << [i_1, i_2] if val1 + val2 == 0
            end

        end

        new_arr
    end
end