defmodule DOM.DOMShadowRoot do
  @moduledoc """
    Implements interface ShadowRoot
    https://dom.spec.whatwg.org/#interface-shadowroot
  """
  use DOM
  use DOMDocumentFragment

  defstruct @dom_document_fragment_fields ++
              [
                :mode,
                :delegate_focus,
                :slot_assignment,
                :host,
                :on_slot_change
              ]

  @type t ::
          Map.merge(DOMDocumentFragment.t(), %__MODULE__{
            mode: :open | :closed,
            delegate_focus: boolean(),
            slot_assignment: :manual | :named,
            host: DOMElement.t(),
            on_slot_change: function()
          })
end
