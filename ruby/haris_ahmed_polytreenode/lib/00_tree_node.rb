class PolyTreeNode

    attr_reader :value, :parent, :children 
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        @parent = node 
        node.children << self if node != nil 
    end

end