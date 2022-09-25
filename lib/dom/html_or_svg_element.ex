defmodule DOM.HTMLOrSVGElement do
  defstruct [
    :dataset,
    :nonce,
    :autofocus,
    tab_index: 0
  ]

  @type t :: %__MODULE__{
          dataset: map(),
          nonce: binary(),
          autofocus: boolean(),
          tab_index: integer()
        }
end
