defmodule DOM.XMLDocument do
  @moduledoc """
    Defines interface XMLDocument
    https://dom.spec.whatwg.org/#xmldocument
  """

  use DOM
  use DOMDocument

  defstruct @dom_document_fields

  @type t :: %__MODULE__{}
end
