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

    def build_tree_from_unsorted(arr)
      root = nil
      arr.each { |new_value| root = insert(new_value, root) }

      root
    end

    def insert(new_value, node, parent_node=nil)
      if node.nil?
        node = new_node(new_value)
      elsif new_value < node.value
        node.left_child = insert(new_value, node.left_child, node)
      else
        node.right_child = insert(new_value, node.right_child, node)
      end

      node.parent = parent_node

      if height_diff(node) > 1
        node = rebalance(node)
      end

      node
    end

    def rebalance(current_root)
      left_height  = find_height(current_root.left_child)
      right_height = find_height(current_root.right_child)

      if left_height < right_height
        current_root = current_root.left_rotation
      else
        current_root = current_root.right_rotation
      end
      current_root
    end

    def depth_first_search(search_value)
      # puts "\nCURRENT NODE VALUE: #{value}"
      return self if value == search_value

      if left_child && search_value < value
        return left_child if left_child.value == search_value
      elsif right_child
        return right_child if right_child.value == search_value
      end

      if left_child && search_value < value
        found_on_left_child = left_child.depth_first_search(search_value)
        return found_on_left_child if found_on_left_child
      elsif right_child
        found_on_right_child = right_child.depth_first_search(search_value) if right_child
        return found_on_right_child if found_on_right_child
      end
    end
    alias_method :df_search, :depth_first_search

    def breadth_first_search(search_value, queue=[])
      # puts "\nCURRENT NODE VALUE: #{value}\n"
      return self if value == search_value

      if left_child && search_value < value
        return left_child if left_child.value == search_value
        queue << left_child
      elsif right_child
        return right_child if right_child.value == search_value
        queue << right_child
      end

      return if queue.empty?

      next_node = queue.shift
      next_node.breadth_first_search(search_value, queue)
    end
    alias_method :bf_search, :breadth_first_search

    protected
    def left_rotation
      shift_nodes(counter_clockwise: true)
    end

    def right_rotation
      shift_nodes(counter_clockwise: false)
    end

    private
    def find_midpoint(arr)
      (arr.length - 1) / 2
    end

    def new_node(new_value=nil)
      self.class.new(new_value)
    end

    def height_diff(node=self)
      (find_height(node.left_child) - find_height(node.right_child)).abs
    end

    def find_height(node=self)
      return -1 unless node

      left_height  = find_height(node.left_child)
      right_height = find_height(node.right_child)

      left_height >= right_height ? left_height + 1 : right_height + 1
    end

    def shift_nodes(counter_clockwise:)
      child_to_shift   = counter_clockwise ? :right_child : :left_child
      new_child_source = counter_clockwise ? :left_child  : :right_child

      original_parent = parent
      original_child  = self.send(child_to_shift)
      new_child       = original_child.send(new_child_source)

      self.send("#{child_to_shift}=".to_sym, new_child)
      @parent = original_child

      original_child.send("#{new_child_source}=".to_sym, self)
      original_child.parent = original_parent
      original_child
    end
  end
end

# arr = [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345]
# root = BinaryTree::Node.new
# tree = root.build_tree(arr.dup)
# last = tree.bf_search(6345)
# diff = last.send(:height_diff, last.parent)
# puts "height diff for node with value #{last.parent.value} is 1? #{diff == 1}"
# tree = root.build_tree_from_unsorted([7, 324, 7, 9, 23, 8, 6345, 4, 4, 3, 1, 9, 67, 5])
# pp tree
# pp arr
#
# 1.times do
  # ut = BinaryTree::Node.new
  # ut = ut.build_tree_from_unsorted([1, 2, 3])
  # pp ut
  # binding.pry
# end
