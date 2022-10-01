defmodule DOM.DOMDocument do
  @moduledoc """
    Implements interface Document
    https://dom.spec.whatwg.org/#interface-document
  """
  use DOM
  @behaviour NonElementParentNode

  defmacro __using__(_opts \\ []) do
    quote do
      use DOMNode
      @behaviour DOMDocument

      @dom_document_fields @dom_node_fields ++
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

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createelementns
  """
  @callback create_element_ns(
              DOMDocument.t(),
              namespace :: binary(),
              qualified_name :: binary(),
              opts :: %{}
            ) :: any()

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createdocumentfragment
  """
  @spec create_document_fragment(DOMDocument.t()) :: DOMDocumentFragment.t()
  def create_document_fragment(document) do
    %DOMDocumentFragment{
      node_type: :document_fragment,
      node_name: "#document-fragment",
      owner_document: document
    }
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createattribute
  """
  @spec create_attribute(DOMDocument.t(), local_name :: binary()) :: DOMAttr.t()
  def create_attribute(document, local_name),
    do: create_attribute_ns(document, "", local_name)

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createattributens
  """
  @spec create_attribute_ns(DOMDocument.t(), namespace :: binary(), qualified_name :: binary()) ::
          DOMAttr.t()
  def create_attribute_ns(document, namespace, qualified_name) do
    {namespace, prefix, local_name} = validate_and_extract(namespace, qualified_name)

    %DOMAttr{
      namespace_uri: namespace,
      prefix: prefix,
      node_type: :attribute,
      node_name: local_name,
      owner_document: document,
      local_name: local_name,
      name: local_name
    }
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createtextnode
  """
  @spec create_text_node(DOMDocument.t(), data :: binary()) :: DOMText.t()
  def create_text_node(document, data) do
    %DOMText{
      node_type: :text,
      node_name: "#text",
      node_value: data,
      owner_document: document,
      text_content: data,
      data: data,
      length: String.length(data),
      whole_text: data
    }
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createcdatasection
  """
  @spec create_text_node(DOMDocument.t(), data :: binary()) :: DOMText.t()
  def create_cdata_section(document, data) do
    if data =~ "]]>", do: raise("InvalidCharacterError")

    %DOMCDataSection{
      node_type: :cdata_section,
      node_name: "#cdata-section",
      node_value: data,
      owner_document: document,
      text_content: data,
      data: data,
      length: String.length(data),
      whole_text: data
    }
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createcomment
  """
  @spec create_text_node(DOMDocument.t(), data :: binary()) :: DOMText.t()
  def create_comment(document, data) do
    if data =~ "]]>", do: raise("InvalidCharacterError")

    %DOMComment{
      node_type: :comment,
      node_name: "#comment",
      node_value: data,
      owner_document: document,
      text_content: data,
      data: data,
      length: String.length(data)
    }
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-document-createprocessinginstruction
  """
  @spec create_processing_instruction(DOMDocument.t(), target :: binary(), data :: binary()) ::
          DOMText.t()
  def create_processing_instruction(document, target, data) do
    if data =~ "?>", do: raise("InvalidCharacterError")

    %DOMProcessingInstruction{
      node_type: :processing_instruction,
      owner_document: document,
      node_value: data,
      text_content: data,
      target: target,
      data: data,
      length: String.length(data)
    }
  end

  @doc """
    https://dom.spec.whatwg.org/#validate-and-extract
  """
  @spec validate_and_extract(namespace :: binary(), qualified_name :: binary()) ::
          {namespace :: binary(), prefix :: binary(), local_name :: binary()}
  def validate_and_extract(namespace, qualified_name) do
    namespace = if namespace == "", do: nil, else: namespace

    {prefix, local_name} =
      if qualified_name =~ ":" do
        [prefix | local_name] = String.split(qualified_name, ":", trim: true)
        {prefix, local_name}
      else
        {nil, qualified_name}
      end

    {namespace, prefix, local_name}
  end

  @impl NonElementParentNode
  def get_element_by_id(%{document_element: document_element} = _document, element_id)
  when not is_nil(document_element),
   do: DOMElement.get_element_by_id(document_element, element_id)

  def get_element_by_id(%{child_nodes: [element | _]} = _document, element_id),
   do: DOMElement.get_element_by_id(element, element_id)

  def get_element_by_id(_document, _element_id),
   do: nil
end
