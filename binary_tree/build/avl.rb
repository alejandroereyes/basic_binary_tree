require_relative "../node"
require_relative "../search/depth_first"
require_relative "../to_array"
module BinaryTree
  module Build
    class AVL
      attr_reader :init_arr, :root

      def initialize(init_arr)
        @init_arr = init_arr
        @root = build_tree_from_unsorted
      end

      def depth_first_search(search_value)
        depth_first = Search::DepthFirst.new(root, search_value)
        depth_first.search
      end

      def to_a
        @to_a ||= BinaryTree::ToArray.new(root).to_ary
      end

      private
      def build_tree_from_unsorted
        root = BinaryTree::Node.new

        init_arr.each do |integer|
          if root.value.nil?
            root = root.insert(integer, root.value)
          else
            root = root.insert(integer, root)
          end
        end

        root
      end
    end
  end
end
