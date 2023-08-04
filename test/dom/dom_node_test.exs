# defmodule DOM.DOMNodeTest do
#   use ExUnit.Case, async: true
#   use DOM

#   describe "get_root_node/2" do
#     test "should return the same node when node has no parent" do
#       element = %DOMElement{}
#       assert element.dom_node == DOMNode.get_root_node(element)
#     end

#     test "should return parent's node when node has parent" do
#       root_node = %DOMElement{node_name: "svg"}
#       element = %DOMAttr{parent_node: root_node}
#       refute element == DOMNode.get_root_node(element)
#       assert root_node == DOMNode.get_root_node(element)
#     end
#   end

#   describe "has_child_nodes/1" do
#     test "should return false when node has no children" do
#       element = %DOMElement{}
#       refute DOMNode.has_child_nodes(element)
#     end

#     test "should return true when node has children" do
#       element = %DOMElement{child_nodes: [%DOMElement{}]}
#       assert DOMNode.has_child_nodes(element)
#     end
#   end

#   describe "append_child/2" do
#     test "should add node child to given node" do
#       element = %DOMElement{}
#       child = %DOMElement{}
#       refute DOMNode.has_child_nodes(element)
#       element = DOMNode.append_child(element, child)
#       assert DOMNode.has_child_nodes(element)
#     end
#   end
# end
