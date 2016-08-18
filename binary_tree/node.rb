require 'pry'
require 'pp'
module BinaryTree
  class Node
    attr_accessor :value, :parent, :left_child, :right_child

    def initialize(value=nil)
      @value = value
    end

    def build_tree(arr, parent_node=nil)
      return if arr.empty?
      arr.uniq!
      midpoint   = find_midpoint(arr)
      left_half  = arr[0...midpoint]
      right_half = arr[midpoint + 1..-1]

      @value       = arr[midpoint]
      @parent      = parent_node
      @left_child  = new_node.build_tree(left_half, self)  unless left_half.empty?
      @right_child = new_node.build_tree(right_half, self) unless right_half.empty?

      self
    end

    def leaf?
      left_child.nil? && right_child.nil?
    end

    def breadth_first_search(value)

    end

    private
    def find_midpoint(arr)
      (arr.length - 1) / 2
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
