defmodule DOM.DOMAttr do
  @moduledoc """
    Implements interface Attr
    https://dom.spec.whatwg.org/#interface-attr
  """
  use DOM
  use DOMNode

  defstruct @node_fields ++
              [
                :namespace_uri,
                :prefix,
                :local_name,
                :name,
                :value,
                :owner_element,
                specified: true
              ]

  @type t ::
          Map.merge(DOMNode.t(), %__MODULE__{
            namespace_uri: binary(),
            prefix: binary(),
            local_name: binary(),
            name: binary(),
            value: binary(),
            owner_element: DOMElement.t(),
            specified: true
          })

  @doc """
    Creates an initialized instance of __MODULE__.t()
    It sets some attributes with default values
  """
  def new(attrs \\ [])

  def new(attrs) when is_list(attrs),
    do: attrs |> Map.new() |> new()

  def new(attrs) when is_map(attrs) do
    struct(__MODULE__, Map.merge(attrs, %{node_type: :attribute}))
  end
end
