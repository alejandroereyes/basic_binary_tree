require_relative 'spec_helper'

def expect_all_children_to_be_to_one_side(tree, side:)
  opposite_side = side == :right_child ? :left_child : :right_child
  expect(tree.send(opposite_side)).to be_nil
  expect_all_children_to_be_to_one_side(tree.send(side), side: side) if tree.send(side)
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

    context 'given a sorted DESC list, uses the midpoint as the root and builds out each side' do
      # it 'places all the children to the left' do
      #   tree = BinaryTree::Node.new.build_tree(desc_sorted)
      #   expect_all_children_to_be_to_one_side(tree, side: :left_child)
      # end
    end

    context 'given an unsorted list' do
      let(:unsorted_arr) { [7, 324.7, 9 , 23, 8, 6345, 4, 4, 3, 1, 9, 67, 5] }
      skip 'will build a binary tree' do

      end
    end
  end
end
