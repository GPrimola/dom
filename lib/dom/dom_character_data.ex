defmodule DOM.DOMCharacterData do
  @moduledoc """
    Defines interface CharacterData
    https://dom.spec.whatwg.org/#interface-characterdata
  """
  use DOM

  defmacro __using__(_opts \\ []) do
    quote do
      use DOMNode
      @dom_character_data_fields @dom_node_fields ++ [length: 0, data: ""]
    end
  end

  @type t :: Map.merge(DOMNode.t(), %{
    data: binary(),
    length: integer()
  })
end
