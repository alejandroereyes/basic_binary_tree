module BinaryTree
  class ToArray
    attr_reader :left_values, :right_values, :left_nodes, :right_nodes
    attr_accessor :root, :root_value

    def initialize(root)
      @root = root
      @root_value = root.value
      @left_nodes = []
      @right_nodes = []
      @left_values = left_nodes.map(&:value)
      @right_values = right_nodes.map(&:value)
    end

    def to_ary
      nodes_to_array(@root)
    end

    def left_values
      @left_values.empty? ? set_value_array(@left_nodes, @left_values) : @left_values
    end

    def right_values
      @right_values.empty? ? set_value_array(@right_nodes, @right_values) : @right_values
    end

    private
    def nodes_to_array(node, arr=[])
      return arr.uniq.flatten unless node
      arr << node

      left_child_nodes  = nodes_to_array(node.left_child) if node.left_child
      right_child_nodes = nodes_to_array(node.right_child) if node.right_child

      if node.value == @root_value
        @left_nodes  = left_child_nodes.uniq.flatten
        @right_nodes = right_child_nodes.uniq.flatten
      end

      arr << left_child_nodes if node.left_child
      arr << right_child_nodes if node.right_child

      arr.uniq.flatten
    end

    def set_value_array(source, target)
      target = source.map(&:value)
    end
  end
end
