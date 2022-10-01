defmodule DOM.DOMNonElementParentNode do
  @moduledoc """
    Defines mixin NonElementParentNode
    https://dom.spec.whatwg.org/#interface-nonelementparentnode
  """
  use DOM

  @doc """
    https://dom.spec.whatwg.org/#dom-nonelementparentnode-getelementbyid
  """
  @callback get_element_by_id(DOMDocument.t() | DOMElement.t(), element_id :: binary()) :: DOMElement.t() | nil
end
