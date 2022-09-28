defmodule DOM.DOMCDataSection do
  @moduledoc """
    Defines interface CDataSection
    https://dom.spec.whatwg.org/#cdatasection
  """

  use DOM
  use DOMCharacterData

  defstruct Map.keys(%DOMText{})

  @type t :: DOMText.t()
end
