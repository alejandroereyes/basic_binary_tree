require_relative 'spec_helper'

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
        skip 'creates a balanced tree' do
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
        skip 'creates a balanced tree' do
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

      context 'with values needing rotations in varying directions' do
        let(:unsorted_arr) { [7, 324, 7, 9, 23, 8, 6345, 4, 4, 3, 1, 9, 67, 5] }
        skip 'will build a binary tree' do
          tree = BinaryTree::Node.new.build_tree_from_unsorted(unsorted_arr)

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
