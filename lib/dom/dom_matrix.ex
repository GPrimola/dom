defmodule DOM.DOMMatrix do
  @moduledoc """
    Implements DOMMatrix interface
    https://www.w3.org/TR/geometry-1/#DOMMatrix
  """
  defstruct [
    :a,
    :b,
    :c,
    :d,
    :e,
    :f,
    :m11,
    :m12,
    :m13,
    :m14,
    :m21,
    :m22,
    :m23,
    :m24,
    :m31,
    :m32,
    :m33,
    :m34,
    :m41,
    :m42,
    :m43,
    :m44,
    :is2D,
    :isIdentity
  ]

  @type t :: %__MODULE__{
          a: float(),
          b: float(),
          c: float(),
          d: float(),
          e: float(),
          f: float(),
          m11: float(),
          m12: float(),
          m13: float(),
          m14: float(),
          m21: float(),
          m22: float(),
          m23: float(),
          m24: float(),
          m31: float(),
          m32: float(),
          m33: float(),
          m34: float(),
          m41: float(),
          m42: float(),
          m43: float(),
          m44: float(),
          is2D: boolean(),
          isIdentity: boolean()
        }
end
