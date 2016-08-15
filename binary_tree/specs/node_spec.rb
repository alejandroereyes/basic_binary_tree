require_relative 'spec_helper'

describe BinaryTree::Node do

  it 'can be instantiated' do
    new_node = BinaryTree::Node.new

    expect(new_node).to an_instance_of(BinaryTree::Node)
  end
end
