defmodule DOM.DOMText do
  @moduledoc """
    Defines interface Text
    https://dom.spec.whatwg.org/#interface-text
  """
  use DOM
  use DOMCharacterData

  defstruct @dom_character_data_fields ++ [whole_text: ""]

  @type t :: Map.merge(DOMCharacterData.t(), %__MODULE__{
    whole_text: binary()
  })
end
