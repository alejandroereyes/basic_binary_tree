module BinaryTree
  module Search
    class DepthFirst
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
      def perform_search(node)
        if value_may_be_found_on_left_side?(node)
          left_child = node.left_child

          left_child.value == search_value ? left_child : perform_search(left_child)
        elsif node.right_child
          right_child = node.right_child

          right_child.value == search_value ? right_child : perform_search(right_child)
        end
      end

      def value_may_be_found_on_left_side?(node)
        node.left_child && search_value < node.value
      end
    end
  end
end
