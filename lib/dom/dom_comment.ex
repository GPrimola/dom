defmodule DOM.DOMComment do
  @moduledoc """
    Defines interface Comment
    https://dom.spec.whatwg.org/#interface-comment
  """

  use DOM
  use DOMCharacterData

  defstruct @dom_character_data_fields

  @type t :: %__MODULE__{}

end
