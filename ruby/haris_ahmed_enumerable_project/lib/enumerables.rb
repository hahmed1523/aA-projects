require "byebug"

class Array 
    # Block -> Array
    # Takes a block and calls on every element and return original array
    def my_each(&prc)
        length = self.length 
        i = 0 
        while i < length
            prc.call(self[i])
            i += 1
        end
        return self
    end

    #Block -> Array
    def my_select(&prc)
        arr = []
        self.my_each do |el|
            if prc.call(el)
                arr << el 
            end
        end
        return arr
    end

    #Block -> Array
    def my_reject(&prc)
        arr = []
        self.my_each do |el|
            if !prc.call(el)
                arr << el 
            end
        end
        return arr
    end

    #Block -> Boolean
    def my_any?(&prc)
        self.my_each do |el|
            if prc.call(el)
                return true
            end
        end
        return false 
    end

    #Block -> Boolean
    def my_all?(&prc)
        self.my_each do |el|
            if !prc.call(el)
                return false
            end
        end
        return true
    end

    #Array -> Array
    def my_flatten
        if self.length == 1
            if self[0].is_a?(Array)
                return self[0].my_flatten
            else
                return [self[0]]
            end
        else
            flattened = []
            (0...self.length).each do |idx|
                flattened += self[idx...(idx+1)].my_flatten 
            end

            return flattened 
        end
    end

    #Any number of Array -> Array
    def my_zip(*args)
        length = self.length 
        final_arr = []
        (0...length).each do |idx|
            arr = [self[idx]]
            args.each do |ele|
                arr << ele[idx]
            end
            final_arr << arr 
            arr = []
        end
        return final_arr
    end
    
    def my_rotate(num = 1)
        final_arr = []
        (0...self.length).each do |idx|
            new_idx = (idx + num) % self.length 
            final_arr << self[new_idx]
        end
        return final_arr 
    end

    def my_join(sep = "")
        str = ""
        last_idx = self.length  - 1
        (0...self.length).each do |idx|
            if idx == last_idx 
                str += self[idx]
            else
                str += self[idx].to_s + sep 
            end
        end
        return str 
    end

    def my_reverse
        arr = []
        (0...self.length).each do |idx|
            arr.unshift(self[idx]) 
        end

        return arr 
    end
end

# p [1,2,3].my_select { |num| num > 1} == [1,2,3].select { |num| num > 1}
# p [1,2,3].my_each {|num| puts num} == [1,2,3].each {|num| puts num}
# p [1,2,3].my_reject { |num| num > 1} == [1,2,3].reject { |num| num > 1}
# p [1,2,3].my_any? { |num| num > 1} == [1,2,3].any? { |num| num > 1}
# p [1,2,3].my_all? { |num| num > 1} == [1,2,3].all? { |num| num > 1}
# p [1,[2,3]].my_flatten == [1,2,3]
# p [1,2,3].my_zip([4,5,6], [7,8,9]) == [[1,4,7],[2,5,8],[3,6,9]]
# p ['a','b', 'c', 'd'].my_rotate == ['b','c','d','a']
# p ['a','b', 'c', 'd'].my_rotate(15) == ['d','a','b','c']
# p ['a','b', 'c', 'd'].my_join('$') == "a$b$c$d"
# p ['a','b', 'c', 'd'].my_join == "abcd"
# p ['a','b','c'].my_reverse == ['a','b','c'].reverse 