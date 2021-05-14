require "byebug"

class PolyTreeNode

    attr_reader :value, :parent, :children 
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if node != nil 
            if @parent != nil 
                @parent.children.delete(self) #remove self from current parent if parent not nil
            end
            @parent = node 
            @parent.children << self if !@parent.children.include?(self)
        else
            @parent = node 
        end

    end

    def add_child(child_node)
        child_node.parent = self 
    end

    def remove_child(child_node)
        if child_node.parent != nil 
            child_node.parent = nil
        else
            raise "Error"
        end

    end

    #check if the node has the target_value using depth first
    def dfs(target_value)
        if @value == target_value 
            return self 
        else
            search_children(@children, target_value)
        end

    end

    #searches through children array of nodes for dfs method
    def search_children(children, target_value)
        if children.empty?
            return nil 
        else
            try = children.first.dfs(target_value)
            if try 
                return try 
            else
                search_children(children[1..-1], target_value)
            end
        end 
    end

    #checks if target value is in node with breadth first
    def bfs(target_value)
        q = [self]

        until q.empty?
            node = q.shift 

            if node.value == target_value
                return node 
            end

            q.concat(node.children)
        end
    end

end
