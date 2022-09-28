defmodule DOM.DOMDocumentFragment do
  @moduledoc """
    Defines DOM interface DocumentFragment
    https://dom.spec.whatwg.org/#interface-documentfragment
  """
  use DOM
  use DOMNode

  defmacro __using__(_opts \\ []) do
    quote do
      use DOMNode
      @dom_document_fragment_fields @dom_node_fields
    end
  end

  defstruct @dom_node_fields

  @type t :: DOMNode.t()
end
