defmodule DOM.DOMDocument do
  @moduledoc """
    Implements interface Document
    https://dom.spec.whatwg.org/#interface-document
  """
  use DOM

  defmacro __using__(_opts \\ []) do
    quote do
      use DOMNode
      @behaviour DOMDocument

      @dom_document_fields @node_fields ++
                             [
                               :url,
                               :document_uri,
                               :compat_mode,
                               :character_set,
                               :charset,
                               :input_encoding,
                               :content_type,
                               :document_element,
                               :doctype_name,
                               :doctype_public_id,
                               :doctype_system_id
                             ]
    end
  end

  @type t ::
          Map.merge(DOMNode.t(), %{
            url: binary(),
            document_uri: binary(),
            compat_mode: binary(),
            character_set: binary(),
            charset: binary(),
            input_encoding: binary(),
            content_type: binary(),
            document_element: DOMElement.t(),
            doctype_name: binary(),
            doctype_public_id: binary(),
            doctype_system_id: binary()
          })

  @doc """
    Creates an Element.

    https://dom.spec.whatwg.org/#dom-document-createelement
  """
  @callback create_element(DOMDocument.t(), local_name :: binary(), opts :: %{}) :: any()
  @callback create_element_ns(
              DOMDocument.t(),
              namespace :: binary(),
              qualified_name :: binary(),
              opts :: %{}
            ) :: any()
  @callback create_document_fragment(DOMDocument.t()) :: DOMDocumentFragment.t()
  @callback create_text_node(DOMDocument.t(), data :: binary()) :: any()
  @callback create_attribute(DOMDocument.t(), local_name :: binary()) :: DOMAttr.t()
end
