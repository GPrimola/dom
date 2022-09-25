defmodule DOM.DOMPoint do
  @moduledoc """
    Implements the DOMPoint interface
    https://www.w3.org/TR/geometry-1/#DOMPoint
  """
  defstruct x: 0.0, y: 0.0, z: 0.0, w: 1.0

  @type t :: %__MODULE__{
          x: float(),
          y: float(),
          z: float(),
          w: float()
        }
end
