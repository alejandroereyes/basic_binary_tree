module BinaryTree
  module Search
    class BreadthFirst
      attr_accessor :search_value
      attr_reader :root

      def initialize(root, search_value=nil)
        @root = root
        @search_value = search_value
      end

      def search
        return root if root.value == search_value

        perform_search(root)
      end

      private
      def perform_search(node, queue=[])
        return unless node

        if value_may_be_found_on_left_side?(node)
          left_child = node.left_child
          return left_child if left_child.value == search_value
          queue << left_child
        elsif node.right_child
          right_child = node.right_child
          return right_child if right_child.value == search_value
          queue << right_child
        end

        next_node = queue.shift
        perform_search(next_node, queue)
      end

      def value_may_be_found_on_left_side?(node)
        node.left_child && search_value < node.value
      end
    end
  end
end
