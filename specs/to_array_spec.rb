require_relative "spec_helper"

describe BinaryTree::ToArray do
  let(:left_leaf)  { BinaryTree::Node.new(1) }
  let(:left_child) do
    node = BinaryTree::Node.new(2)
    node.left_child = left_leaf
    node
  end
  let(:right_leaf) { BinaryTree::Node.new(5) }
  let(:right_child) do
    node = BinaryTree::Node.new(4)
    node.right_child = right_leaf
    node
  end
  let(:root) do
    node = BinaryTree::Node.new(3)
    node.left_child = left_child
    node.right_child = right_child
    node
  end
  let(:tree_traverser) { BinaryTree::ToArray.new(root) }
  let(:node_values_in_expected_order) { [3, 2, 1, 4, 5] }

  describe "#nodes_to_array" do
    it "returns nodes in order of root, " +
      " left children from highest value to lowest" +
      " right children from highest value to lowest" do
      expect(tree_traverser.to_ary.map(&:value)).to eq(node_values_in_expected_order)
    end
  end

  describe "#left_nodes" do
    # let(:tree_traverser) { TreeTraversal.new(root) }
    context "before to_ary called" do
      it "it returns an empty array" do
        expect(tree_traverser.left_nodes).to be_empty
      end
    end
    context "after to_ary has been called" do
      it "it returns the left child nodes" do
        tree_traverser.to_ary
        expect(tree_traverser.left_nodes).to eq([left_child, left_leaf])
      end
    end
  end

  describe "#left_values" do
    context "before to_ary called" do
      it "returns an empty array" do
        expect(tree_traverser.left_values).to be_empty
      end
    end
    context "after to_ary has been called" do
      it "returns the left child values" do
        tree_traverser.to_ary
        expect(tree_traverser.left_values).to eq([left_child.value, left_leaf.value])
      end
    end
  end

  describe "#right_nodes" do
    context "before to_ary called" do
      it "it returns an empty array" do
        expect(tree_traverser.right_nodes).to be_empty
      end
    end
    context "after to_ary has been called" do
      it "it returns the right child nodes" do
        tree_traverser.to_ary
        expect(tree_traverser.right_nodes).to eq([right_child, right_leaf])
      end
    end
  end

  describe "#right_values" do
    context "before to_ary called" do
      it "returns an empty array" do
        expect(tree_traverser.right_values).to be_empty
      end
    end
    context "after to_ary has been called" do
      it "returns the right child node values" do
        tree_traverser.to_ary
        expect(tree_traverser.right_values).to eq([right_child.value, right_leaf.value])
      end
    end
  end
end
