#Array -> Array
#removes duplicates from an array
def my_unique(arr)
    raise 'This is not an Array!' unless arr.is_a?(Array)
    new_arr = []
    arr.each {|ele| new_arr << ele if !new_arr.include?(ele)}
    return new_arr 
end