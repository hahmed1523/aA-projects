# Number -> Number
# uses recursion to calculate the sum from 1 to n (inclusive)
def sum_to(n)
    if n < 0
        return nil
    elsif n == 1
        return n
    else
        n + sum_to(n-1)
    end
end

# p sum_to(5) == 15
# p sum_to(1) == 1
# p sum_to(-8) == nil

#Array -> Number
#takes array and ints and returns sum of those numbers
def add_numbers(arr)
    if arr.empty?
        return nil 
    elsif arr.length == 1
        return arr[0]
    else
        return arr[0] + add_numbers(arr[1..-1])
    end
end

# p add_numbers([1,2,3,4]) == 10
# p add_numbers([3]) == 3
# p add_numbers([]) == nil 


#Number -> Number
#factorial
def factorial(n)
    if n <= 0
        return nil 
    elsif n == 1
        return n 
    else
        return n * factorial(n-1)
    end
end

#p factorial(7) == 5040



#Number -> Number
#solve The Gamma Function r(n) = (n-1)!
def gamma_fnc(n)
    if n == 1
        return 1
    else
        return factorial(n-1)
    end
end

# p gamma_fnc(0) == nil
# p gamma_fnc(1) == 1
# p gamma_fnc(4) == 6
# p gamma_fnc(8) == 5040

# Array String -> Boolean
# Check if String is in Array
def ice_cream_shop(flavors_arr, flavor)
    if flavors_arr.empty?
        return false 
    else
        if flavors_arr[0] == flavor 
            return true 
        else
            ice_cream_shop[flavors_arr[1..-1], flavor]
        end
    end
end

# p ice_cream_shop([], 'honey lavender') == false
# p ice_cream_shop(['moose tracks'], 'moose tracks') == true 


# String -> String
# Reverse String
def reverse(str)
    if str.length <= 1
        return str 
    else
        return reverse(str[1..-1]) + str[0]
    end
end

p reverse("house") == "esuoh"