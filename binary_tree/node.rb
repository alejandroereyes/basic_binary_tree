require 'pry'
require 'pp'
module BinaryTree
  class Node
    attr_accessor :value, :parent, :left_child, :right_child

    def initialize(value=nil)
      @value = value
    end

    def build_tree(arr, parent_node=nil)
      arr.uniq!

      @value  = arr.shift
      @parent = parent_node

      if next_value = arr.first
        set_left_or_right next_value, arr
      end

      return self if arr.empty?
    end

    private
    def set_left_or_right(next_value, arr)
      if value > next_value
        @left_child = new_node.build_tree(arr, self)
      else
        @right_child = new_node.build_tree(arr, self)
      end
    end

    def new_node
      self.class.new
    end
  end
end

# arr = [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345]
# root = BinaryTree::Node.new
# tree = root.build_tree(arr.dup)
# pp tree
# pp arr
#
# 1.times do
#   binding.pry
# end
