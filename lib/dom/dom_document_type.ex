defmodule DOM.DOMDocumentType do
  @moduledoc """
    https://dom.spec.whatwg.org/#documenttype
  """
  use DOM
  use DOMNode
  defstruct @dom_node_fields ++ [:name, :public_id, :system_id]

  @type t ::
          Map.merge(DOMNode.t(), %__MODULE__{
            name: binary(),
            public_id: binary(),
            system_id: binary()
          })
end
