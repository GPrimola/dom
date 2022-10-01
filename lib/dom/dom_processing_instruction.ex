defmodule DOM.DOMProcessingInstruction do
  @moduledoc """
    Defines interface ProcessingInstruction
    https://dom.spec.whatwg.org/#interface-processinginstruction
  """
  use DOM
  use DOMCharacterData

  defstruct @dom_character_data_fields ++ [:target]

  @type t ::
          Map.merge(DOMCharacterData.t(), %__MODULE__{
            target: binary()
          })
end
