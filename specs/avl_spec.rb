require_relative "spec_helper"

describe BinaryTree::Build::AVL do

  context 'given a sorted ASC list' do
    context 'with values needing a single left rotation' do
      it 'creates a balanced tree' do
        tree = BinaryTree::Build::AVL.new([1, 2, 3])
        root = tree.root

        expect(root.value).to eq(2)
        expect(root.left_child.value).to eq(1)
        expect(root.right_child.value).to eq(3)

        expect(root.parent).to be_nil
        expect(root.left_child.parent.value).to eq(2)
        expect(root.right_child.parent.value).to eq(2)
      end
    end

    context 'with values needing more than a single left rotation' do
      it 'creates a balanced tree' do
        tree = BinaryTree::Build::AVL.new([1, 2, 3, 4, 5, 6, 7])
        root = tree.root

        expect(root.value).to eq(4)
        expect(root.right_child.value).to eq(6)
        expect(root.right_child.left_child.value).to eq(5)
        expect(root.right_child.left_child.leaf?).to be true
        expect(root.right_child.right_child.value).to eq(7)
        expect(root.right_child.right_child.leaf?).to be true
        expect(root.left_child.value).to eq(2)
        expect(root.left_child.left_child.value).to eq(1)
        expect(root.left_child.left_child.leaf?).to be true
        expect(root.left_child.right_child.value).to eq(3)
        expect(root.left_child.right_child.leaf?).to be true
      end
    end
  end

  context 'given a sorted DESC list' do
    context 'with values needing a single right rotation' do
      it 'creates a balanced tree' do
        tree = BinaryTree::Build::AVL.new([3, 2, 1])
        root = tree.root

        expect(root.value).to eq(2)
        expect(root.left_child.value).to eq(1)
        expect(root.right_child.value).to eq(3)

        expect(root.parent).to be_nil
        expect(root.left_child.parent.value).to eq(2)
        expect(root.right_child.parent.value).to eq(2)
      end
    end

    context 'with values needing more than a single right rotation' do
      it 'creates a balanced tree' do
        tree = BinaryTree::Build::AVL.new([7, 6, 5, 4, 3, 2, 1])
        root = tree.root

        expect(root.value).to eq(4)
        expect(root.right_child.value).to eq(6)
        expect(root.right_child.left_child.value).to eq(5)
        expect(root.right_child.left_child.leaf?).to be true
        expect(root.right_child.right_child.value).to eq(7)
        expect(root.right_child.right_child.leaf?).to be true
        expect(root.left_child.value).to eq(2)
        expect(root.left_child.left_child.value).to eq(1)
        expect(root.left_child.left_child.leaf?).to be true
        expect(root.left_child.right_child.value).to eq(3)
        expect(root.left_child.right_child.leaf?).to be true
      end
    end
  end

  context 'given an unsorted list' do
    context 'with values needing only a right and then left rotation' do
      it 'creates a balanced tree' do
        tree = BinaryTree::Build::AVL.new([1, 3, 2])
        root = tree.root

        expect(root.value).to eq(2)
        expect(root.left_child.value).to eq(1)
        expect(root.right_child.value).to eq(3)

        expect(root.parent).to be_nil
        expect(root.left_child.parent.value).to eq(2)
        expect(root.right_child.parent.value).to eq(2)
      end
    end

    context 'with values needing only a left and then right rotation' do
      it 'creates a balanced tree' do
        tree = BinaryTree::Build::AVL.new([2, 3, 1])
        root = tree.root

        expect(root.value).to eq(2)
        expect(root.left_child.value).to eq(1)
        expect(root.right_child.value).to eq(3)

        expect(root.parent).to be_nil
        expect(root.left_child.parent.value).to eq(2)
        expect(root.right_child.parent.value).to eq(2)
      end
    end

    context 'with values needing rotations in varying directions, will build a valid balanced tree' do
      let(:unsorted_no_dups_arr) { [7, 324, 9, 23, 8, 6345, 4, 3, 1, 67, 5] }
      let(:tree) { BinaryTree::Build::AVL.new(unsorted_no_dups_arr) }
      let(:root) { tree.root }
      let(:root_value) { root.value }
      let(:traversal) { BinaryTree::ToArray.new(root) }
      let(:nodes) { traversal.to_ary }
      let(:values) { nodes.map(&:value) }
      let(:left_values) { traversal.left_values }
      let(:right_values) { traversal.right_values }
      let(:left_nodes) { traversal.left_nodes }
      let(:right_nodes) { traversal.right_nodes }

      it 'all the nodes array values have been assigned to a node' do
        expect(nodes.count).to eq(unsorted_no_dups_arr.count)
        expect(values - unsorted_no_dups_arr).to be_empty
        expect(unsorted_no_dups_arr - values).to be_empty
      end

      def verify_left_subtree_values_are_less_than(root_node_value, sub_tree_values)
        all_left_are_less_than_root = sub_tree_values.map { |value| value < root_node_value }.all? { |result| result == true }
        expect(all_left_are_less_than_root).to be true
      end

      def verify_right_subtree_values_are_greater_than(root_node_value, sub_tree_values)
        all_right_are_greater_than_root = sub_tree_values.map { |value| value > root_node_value }.all? { |result| result == true}
        expect(all_right_are_greater_than_root).to be true
      end

      it 'all values on the left sub-tree are less then the root value' do
        nodes.each do |current_node|
          current_traversal = BinaryTree::ToArray.new(current_node)
          current_left_values = current_traversal.left_values

          verify_left_subtree_values_are_less_than(current_node.value, current_left_values)
        end
      end

      it 'all the values on the right sub-tree the root are greater than the root value' do
        nodes.each do |current_node|
          current_traversal = BinaryTree::ToArray.new(current_node)
          current_right_values = current_traversal.right_values

          verify_right_subtree_values_are_greater_than(current_node.value, current_right_values)
        end
      end

      it 'all nodes have a height difference between their left and right sub-tree no greater than 1' do
        nodes.each do |current_node|
          expect(current_node.send(:height_diff)).to be <= 1
        end
      end
    end
  end

  describe '#depth_first_search' do
    let(:unsorted_no_dups_arr) { [7, 324, 9, 23, 8, 6345, 4, 3, 1, 67, 5] }
    let(:tree) { BinaryTree::Build::AVL.new(unsorted_no_dups_arr) }
    let(:fake_search) { instance_double(BinaryTree::Search::DepthFirst) }
    let(:search_value) { unsorted_no_dups_arr.sample }
    let(:expected_node) { BinaryTree::Node.new(search_value) }

    context 'search value exists within tree' do
      before do
        expect(fake_search).to receive(:search_value=).with(search_value)
        expect(fake_search).to receive(:search).and_return(expected_node)
        expect(BinaryTree::Search::DepthFirst).to receive(:new).and_return(fake_search)
      end
      it 'delegates to a BinaryTree::Search::DepthFirst object' do
        expect(tree.depth_first_search(search_value).value).to eq(expected_node.value)
      end
    end
  end

  describe '#breadth_first_search' do
    let(:unsorted_no_dups_arr) { [7, 324, 9, 23, 8, 6345, 4, 3, 1, 67, 5] }
    let(:tree) { BinaryTree::Build::AVL.new(unsorted_no_dups_arr) }
    let(:fake_search) { instance_double(BinaryTree::Search::BreadthFirst) }
    let(:search_value) { unsorted_no_dups_arr.sample }
    let(:expected_node) { BinaryTree::Node.new(search_value) }

    context 'search value exists within tree' do
      before do
        expect(fake_search).to receive(:search_value=).with(search_value)
        expect(fake_search).to receive(:search).and_return(expected_node)
        expect(BinaryTree::Search::BreadthFirst).to receive(:new).and_return(fake_search)
      end
      it 'delegates to a BinaryTree::Search::DepthFirst object' do
        expect(tree.breadth_first_search(search_value).value).to eq(expected_node.value)
      end
    end
  end
end
