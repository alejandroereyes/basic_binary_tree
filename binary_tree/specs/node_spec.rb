require_relative 'spec_helper'

class TreeTraversal
  attr_reader :root_vlaue, :left_values, :right_values, :left_nodes, :right_nodes

  def initialize(tree)
    @tree = tree
    @root_value = tree.value
    @left_nodes = []
    @right_nodes = []
    @left_values = left_nodes.map(&:value)
    @right_values = right_nodes.map(&:value)
  end

  def nodes_to_array(node=@tree, arr=[])
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
end

describe BinaryTree::Node do

  let(:node) { BinaryTree::Node.new }

  it "can be instantiated" do
    expect(node).to an_instance_of(BinaryTree::Node)
  end

  [:value, :parent, :left_child, :right_child].each do |attr|
    it "has a setter & getter for #{attr}" do
      node.send("#{attr}=", 'some cool information')

      expect(node.send(attr)).to eq('some cool information')
    end
  end

  describe '#leaf?' do
    it 'returns true if node has no children' do
      expect(node.leaf?).to be true
    end

    it 'return false if it has a left_child' do
      node.left_child = 'left node'
      expect(node.leaf?).to be false
    end

    it 'return false if it has a right child' do
      node.right_child = 'right node'
      expect(node.leaf?).to be false
    end
  end

  describe '#build_tree builds a binary tree' do
    context 'given a ASC sorted list' do
      let(:asc_sorted)  { [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345] }
      it 'uses the midpoint as the root and builds out each side' do
        tree = BinaryTree::Node.new.build_tree(asc_sorted)
        # left side of tree
        expect(tree.value).to eq(8)
        expect(tree.left_child.value).to eq(4)
        expect(tree.left_child.left_child.value).to eq(1)
        expect(tree.left_child.left_child.left_child).to be_nil
        expect(tree.left_child.left_child.right_child.value).to eq(3)
        expect(tree.left_child.left_child.right_child.leaf?).to be true
        expect(tree.left_child.right_child.value).to eq(5)
        expect(tree.left_child.right_child.left_child).to be_nil
        expect(tree.left_child.right_child.right_child.value).to eq(7)
        expect(tree.left_child.right_child.right_child.leaf?).to be true
        # right side of tree
        expect(tree.right_child.value).to eq(67)
        expect(tree.right_child.left_child.value).to eq(9)
        expect(tree.right_child.left_child.left_child).to be_nil
        expect(tree.right_child.left_child.right_child.value).to eq(23)
        expect(tree.right_child.left_child.right_child.leaf?).to be true
        expect(tree.right_child.right_child.value).to eq(324)
        expect(tree.right_child.right_child.left_child).to be_nil
        expect(tree.right_child.right_child.right_child.value).to eq(6345)
        expect(tree.right_child.right_child.right_child.leaf?).to be true
      end
    end
  end

  describe '#build_tree_from_unsorted' do
    context 'given a sorted ASC list' do
      context 'with values needing a single left rotation' do
        it 'creates a balanced tree' do
          tree = BinaryTree::Node.new
          root = tree.build_tree_from_unsorted([1, 2, 3])

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
          tree = BinaryTree::Node.new
          root = tree.build_tree_from_unsorted([1, 2, 3, 4, 5, 6, 7])

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
          tree = BinaryTree::Node.new
          root = tree.build_tree_from_unsorted([3, 2, 1])

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
          tree = BinaryTree::Node.new
          root = tree.build_tree_from_unsorted([7, 6, 5, 4, 3, 2, 1])

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
          tree = BinaryTree::Node.new
          root = tree.build_tree_from_unsorted([1, 3, 2])

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
          tree = BinaryTree::Node.new
          root = tree.build_tree_from_unsorted([2, 3, 1])

          expect(root.value).to eq(2)
          expect(root.left_child.value).to eq(1)
          expect(root.right_child.value).to eq(3)

          expect(root.parent).to be_nil
          expect(root.left_child.parent.value).to eq(2)
          expect(root.right_child.parent.value).to eq(2)
        end
      end

      context 'with values needing rotations in varying directions, will build a valid balanced tree' do
        # let(:unsorted_arr) { [7, 324, 7, 9, 23, 8, 6345, 4, 4, 3, 1, 9, 67, 5] }
        let(:unsorted_no_dups_arr) { [7, 324, 9, 23, 8, 6345, 4, 3, 1, 67, 5] }
        let(:tree) { BinaryTree::Node.new.build_tree_from_unsorted(unsorted_no_dups_arr) }
        let(:root_value) { tree.value }
        let(:traversal) { TreeTraversal.new(tree) }
        let(:nodes) { traversal.nodes_to_array }
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
            current_traversal = TreeTraversal.new(current_node)
            current_left_values = current_traversal.left_values

            verify_left_subtree_values_are_less_than(current_node.value, current_left_values)
          end
        end

        it 'all the values on the right sub-tree the root are greater than the root value' do
          nodes.each do |current_node|
            current_traversal = TreeTraversal.new(current_node)
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
  end

  describe '#depth_first_search' do
    let(:asc_sorted) { [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345] }
    let(:tree) { BinaryTree::Node.new.build_tree(asc_sorted) }

    it 'will return the node that holds the value being searched for' do
      expect(tree.depth_first_search(7).value).to eq(7)
    end

    it 'will return nil if value is not found in the tree' do
      expect(tree.depth_first_search(19)).to be_nil
    end
  end

  describe '#breadth_first_search' do
    let(:asc_sorted) { [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345] }
    let(:tree) { BinaryTree::Node.new.build_tree(asc_sorted) }

    it 'will return the node that holds the value being searched for' do
      expect(tree.breadth_first_search(7).value).to eq(7)
    end

    it 'will return nil if value is not found in the tree' do
      expect(tree.breadth_first_search(19)).to be_nil
    end
  end
end
