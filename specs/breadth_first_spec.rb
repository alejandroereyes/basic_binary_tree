require_relative 'spec_helper'

describe BinaryTree::Search::BreadthFirst do
  arr = [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345]
  let(:tree) { BinaryTree::Build::AVL.new(arr) }
  let(:breadth_first) { BinaryTree::Search::BreadthFirst.new(tree.root) }

  describe '#search' do

    arr.each do |current_value|
      it 'will return the node that holds the value being searched for' do
        breadth_first.search_value = current_value

        expect(breadth_first.search.value).to eq(current_value)
      end
    end

    it 'will return nil if value is not found in the tree' do
      breadth_first.search_value = 19

      expect(breadth_first.search).to be_nil
    end
  end
end
