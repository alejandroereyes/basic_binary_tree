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

  describe '#build_tree builds a binary tree' do
    context 'given a sorted ASC list' do
      let(:asc_sorted) { [1, 3, 4, 4, 5, 7, 7, 8, 9, 9, 23, 67, 324, 6345] }

      it 'places all the children to the right' do
        tree = BinaryTree::Node.new.build_tree(asc_sorted)
        expect_all_children_to_be_to_one_side(tree, side: :right_child)
      end
    end

    context 'given a sorted DESC list' do
      let(:desc_sorted) { [6345, 324, 67, 23, 9, 9, 8, 7, 7, 5, 4, 4, 3, 1] }
      it 'places all the children to the left' do
        tree = BinaryTree::Node.new.build_tree(desc_sorted)
        expect_all_children_to_be_to_one_side(tree, side: :left_child)
      end
    end

    context 'given an unsorted list' do
      let(:unsorted_arr) { [7, 324.7, 9 , 23, 8, 6345, 4, 4, 3, 1, 9, 67, 5] }
      skip 'will build a binary tree' do

      end
    end
  end
end
