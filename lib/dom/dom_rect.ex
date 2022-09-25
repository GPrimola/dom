defmodule DOM.DOMRect do
  @moduledoc """
    Implementation of DOMRect interface
    https://www.w3.org/TR/geometry-1/#DOMRect
  """
  defstruct [
    :top,
    :right,
    :bottom,
    :left,
    x: 0.0,
    y: 0.0,
    width: 0.0,
    height: 0.0
  ]

  @type t :: %__MODULE__{
          x: float(),
          y: float(),
          width: float(),
          height: float(),
          top: float(),
          right: float(),
          bottom: float(),
          left: float()
        }
end
