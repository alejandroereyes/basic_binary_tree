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

    def depth_first_search(search_value)
      # puts "\nCURRENT NODE VALUE: #{value}"
      return self if value == search_value

      if left_child
        return left_child if left_child.value == search_value
      end

      if right_child
        return right_child if right_child.value == search_value
      end

      found_on_left_child = left_child.depth_first_search(search_value) if left_child
      return found_on_left_child if found_on_left_child

      found_on_right_child = right_child.depth_first_search(search_value) if right_child
      return found_on_right_child if found_on_right_child
    end
    alias_method :df_search, :depth_first_search

    def breadth_first_search(search_value, queue=[])
      # puts "\nCURRENT NODE VALUE: #{value}\n"
      return self if value == search_value

      if left_child
        return left_child if left_child.value == search_value
        queue << left_child
      end

      if right_child
        return right_child if right_child.value == search_value
        queue << right_child
      end

      return if queue.empty?

      next_node = queue.shift
      next_node.breadth_first_search(search_value, queue)
    end
    alias_method :bf_search, :breadth_first_search

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
