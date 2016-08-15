require_relative 'spec_helper'

describe BinaryTree::Node do

  let(:node) { BinaryTree::Node.new }

  it "can be instantiated" do
    expect(node).to an_instance_of(BinaryTree::Node)
  end

  [:value, :parent, :child].each do |attr|
    it "has a setter & getter for #{attr}" do
      node.send("#{attr}=", 'some cool information')

      expect(node.send(attr)).to eq('some cool information')
    end
  end
end
