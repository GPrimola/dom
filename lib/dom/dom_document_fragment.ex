defmodule DOM.DOMDocumentFragment do
  @moduledoc """
    Defines DOM interface DocumentFragment
    https://dom.spec.whatwg.org/#interface-documentfragment
  """
  use DOM

  defmacro __using__(_opts \\ []) do
    quote do
      use DOMNode
      @document_fragment_fields @node_fields
    end
  end

  @type t :: DOMNode.t()
end
