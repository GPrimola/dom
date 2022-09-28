defmodule DOM.DOMNode do
  @moduledoc """
    Implements interface Node
    https://dom.spec.whatwg.org/#interface-node
  """
  use DOM

  defmacro __using__(_opts \\ []) do
    quote do
      @dom_node_fields [
        :node_type,
        :node_name,
        :node_value,
        :base_uri,
        :is_connected,
        :owner_document,
        :parent_node,
        :parent_element,
        :first_child,
        :last_child,
        :previous_sibling,
        :next_sibling,
        :text_content,
        child_nodes: []
      ]

      @element_node 1
      @attribute_node 2
      @text_node 3
      @cdata_section_node 4
      @entity_reference_node 5
      @entity_node 6
      @processing_instruction_node 7
      @comment_node 8
      @document_node 9
      @document_type_node 10
      @document_fragment_node 11
      @notation_node 12

      @node_type_map %{
        element: @element_node,
        attribute: @attribute_node,
        text: @text_node,
        cdata_section: @cdata_section_node,
        entity_reference: @entity_reference_node,
        entity: @entity_node,
        processing_instruction: @processing_instruction_node,
        comment: @comment_node,
        document: @document_node,
        document_type: @document_type_node,
        document_fragment: @document_fragment_node,
        notation: @notation_node
      }

      @document_position_disconnected 0x01
      @document_position_preceding 0x02
      @document_position_following 0x04
      @document_position_contains 0x08
      @document_position_contained_by 0x10
      @document_position_implementation_specific 0x20

      @document_position_mode_map %{
        disconnected: @document_position_disconnected,
        preceding: @document_position_preceding,
        following: @document_position_following,
        contains: @document_position_contains,
        contained_by: @document_position_contained_by,
        implementation_specific: @document_position_implementation_specific
      }

      defimpl Enumerable do

    def count(%{child_nodes: children} = _node)
    when children == [], do: 1

    def count(node) do
      Enum.reduce(node.child_nodes, 1, fn node, count_nodes ->
        count_nodes + count(node)
      end)
    end

    def member?(_node, _element), do: {:error, __MODULE__}

    @doc """
      This reduce function traverse the tree in pre-order.
    """
    def reduce(_node, {:halt, acc}, _fun), do: {:halted, acc}
    def reduce(node, {:suspend, acc}, fun), do: {:suspended, acc, &reduce(node, &1, fun)}
    def reduce(%{child_nodes: children} = node, {:cont, acc}, fun), do: reduce(children, fun.(node, acc), fun)
    def reduce([] = _children, {:cont, acc}, fun), do: {:done, acc}
    def reduce([node | siblings] = _children, {:cont, acc}, fun) do
      with {:done, accu} <- reduce(node, {:cont, acc}, fun),
        {:done, accu} <- reduce(siblings, {:cont, accu}, fun) do
        {:done, accu}
      end
    end

    def slice(node), do: {:error, __MODULE__}
  end
    end
  end

  @type t :: %{
          node_type: integer(),
          node_name: binary(),
          node_value: binary(),
          base_uri: binary(),
          is_connected: boolean(),
          owner_document: DOMDocument.t(),
          parent_node: __MODULE__.t(),
          parent_element: DOMElement.t(),
          child_nodes: list(__MODULE__.t()),
          first_child: __MODULE__.t(),
          last_child: __MODULE__.t(),
          previous_sibling: __MODULE__.t(),
          next_sibling: __MODULE__.t(),
          text_content: binary()
        }

  @spec get_root_node(__MODULE__.t(), boolean()) :: __MODULE__.t()
  def get_root_node(dom_node, composed \\ false) do
    if is_nil(dom_node.parent_node),
      do: dom_node,
      else: get_root_node(dom_node.parent_node, composed)
  end

  @spec has_child_nodes(__MODULE__.t()) :: boolean()
  def has_child_nodes(dom_node),
    do: not (is_nil(dom_node.child_nodes) or dom_node.child_nodes == [])

  @spec append_child(__MODULE__.t(), __MODULE__.t()) :: __MODULE__.t()
  def append_child(%{child_nodes: child_nodes} = dom_node, child_node) do
    child_node = %{child_node | parent_node: dom_node}
    child_nodes = List.insert_at(child_nodes, -1, child_node)
    %{dom_node | child_nodes: child_nodes}
  end
end
