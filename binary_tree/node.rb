require 'pry'
require 'pp'
module BinaryTree
  class Node
    attr_accessor :value, :parent, :left_child, :right_child

    def initialize(value=nil)
      @value = value
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
      left_height  = current_root.left_height
      right_height = current_root.right_height

      if left_height < right_height
        child = current_root.right_child
        if child.left_heavy?
          current_root.right_child = child.right_rotation
        end

        current_root = current_root.left_rotation
      elsif right_height < left_height
        child = current_root.left_child
        if child.right_heavy?
          current_root.left_child = child.left_rotation
        end

        current_root = current_root.right_rotation
      end
      current_root
    end

    protected
    def left_rotation
      shift_nodes(counter_clockwise: true)
    end

    def right_rotation
      shift_nodes(counter_clockwise: false)
    end

    def left_height
      find_height(left_child)
    end

    def right_height
      find_height(right_child)
    end

    def left_heavy?
      left_height > right_height
    end

    def right_heavy?
      right_height > left_height
    end

    private
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
