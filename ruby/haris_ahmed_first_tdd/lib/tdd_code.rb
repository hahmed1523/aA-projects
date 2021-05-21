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

#Array of Array -> Array of Array
#convert between row-oriented and column-oriented representations
def my_transpose(arr)
    new_arr = []

    col_length = arr[0].length
    current_idx = 0
    while current_idx < col_length
        new_row = []
        arr.each do |row|
            new_row << row[current_idx]
        end

        new_arr << new_row
        current_idx += 1
    end

    return new_arr
end

def pick_stocks(prices)
    # can always make zero dollars by not buying/selling
    best_pair = nil
    best_profit = 0
  
    prices.each_index do |buy_date|
      prices.each_index do |sell_date|
        # can't sell before buy
        next if sell_date < buy_date
  
        profit = prices[sell_date] - prices[buy_date]
        if profit > best_profit
          # Choose best days.
          best_pair, best_profit = [buy_date, sell_date], profit
        end
      end
    end
    return best_pair
end