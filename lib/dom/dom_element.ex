defmodule DOM.DOMElement do
  @moduledoc """
    Defines interface Element
    https://dom.spec.whatwg.org/#interface-element
  """
  use DOM

  defmacro __using__(_opts \\ []) do
    quote do
      use DOMNode

      @dom_element_fields @dom_node_fields ++
                            [
                              :namespace_uri,
                              :prefix,
                              :local_name,
                              :tag_name,
                              :id,
                              :class_name,
                              :class_list,
                              :slot,
                              :shadow_root,
                              attributes: []
                            ]
    end
  end

  @type t ::
          Map.merge(DOMNode.t(), %{
            namespace_uri: binary(),
            prefix: binary(),
            local_name: binary(),
            tag_name: binary(),
            id: binary(),
            class_name: binary(),
            class_list: list(),
            slot: binary(),

            # using keyword list to preserve document order
            attributes: keyword(),
            shadow_root: map()
          })

  @doc """
    https://dom.spec.whatwg.org/#dom-element-hasattributes
  """
  @spec has_attributes(__MODULE__.t()) :: boolean()
  def has_attributes(element)

  def has_attributes(%{attributes: attrs} = _dom_element),
    do: length(attrs) > 0

  @doc """
    https://dom.spec.whatwg.org/#dom-element-getattributenames
  """
  @spec get_attribute_names(__MODULE__.t()) :: list(binary())
  def get_attribute_names(element)

  def get_attribute_names(%{attributes: attrs} = _dom_element),
    do: Keystring.keys(attrs)

  @doc """
    https://dom.spec.whatwg.org/#dom-element-getattribute
  """
  @spec get_attribute(__MODULE__.t(), binary()) :: binary()
  def get_attribute(element, qualified_name)

  def get_attribute(%{attributes: attrs} = _dom_element, qualified_name),
    do: attrs |> Keystring.get(qualified_name, %DOMAttr{}) |> Map.get(:value)

  @doc """
    https://dom.spec.whatwg.org/#dom-element-setattribute
  """
  @spec set_attribute(__MODULE__.t(), binary(), binary()) :: __MODULE__.t()
  def set_attribute(element, qualified_name, value)

  def set_attribute(dom_element, qualified_name, value) do
    qualified_name = String.downcase(qualified_name)

    attr = %DOMAttr{
      node_name: qualified_name,
      node_value: value,
      text_content: value,
      owner_document: dom_element.owner_document,
      owner_element: dom_element,
      local_name: qualified_name,
      name: qualified_name,
      value: value
    }

    set_attribute_node(dom_element, attr)
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-element-setattributenode
  """
  @spec set_attribute_node(__MODULE__.t(), DOMAttr.t()) :: __MODULE__.t()
  def set_attribute_node(element, attribute)

  def set_attribute_node(dom_element, %DOMAttr{} = attribute),
    do:
      Map.update(
        dom_element,
        :attributes,
        [],
        &Keystring.put(&1, attribute.local_name, attribute)
      )

  @doc """
    https://dom.spec.whatwg.org/#dom-element-hasattribute
  """
  @spec has_attribute(__MODULE__.t(), binary()) :: boolean()
  def has_attribute(element, qualified_name)

  def has_attribute(%{attributes: attrs} = _dom_element, qualified_name),
    do: Keystring.has_key?(attrs, String.downcase(qualified_name))

  @doc """
    https://dom.spec.whatwg.org/#dom-element-getattributenode
  """
  @spec get_attribute_node(__MODULE__.t(), binary()) :: DOMAttr.t()
  def get_attribute_node(element, qualified_name)

  def get_attribute_node(%{attributes: attrs}, qualified_name),
    do: Keystring.get(attrs, qualified_name)

  @doc """
    This function is not part of the official DOM Element interface
  """
  @spec get_attribute_nodes(__MODULE__.t()) :: list(DOMAttr.t())
  def get_attribute_nodes(element)

  def get_attribute_nodes(%{attributes: attrs} = _dom_element),
    do: attrs |> Enum.map(&elem(&1, 1))

  @doc """
    https://dom.spec.whatwg.org/#dom-element-attachshadow
  """
  @spec attach_shadow(__MODULE__.t(), :open | :closed, boolean(), :manual | :named) ::
          __MODULE__.t()
  def attach_shadow(element, mode, delegate_focus \\ false, slot_assignment \\ :named)

  def attach_shadow(dom_element, mode, delegate_focus, slot_assignment) do
    shadow_root = %DOMShadowRoot{
      host: dom_element,
      mode: mode,
      delegate_focus: delegate_focus,
      slot_assignment: slot_assignment
    }

    %{dom_element | shadow_root: shadow_root}
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-element-getelementsbytagname
  """
  @spec get_elements_by_tag_name(__MODULE__.t(), binary()) :: list(__MODULE__.t())
  def get_elements_by_tag_name(element, qualified_name)

  def get_elements_by_tag_name(%{child_nodes: child_nodes} = dom_element, qualified_name) do
    elements =
      child_nodes
      |> Enum.filter(fn
        %{tag_name: tag_name} ->
          qualified_name == "*" or tag_name =~ qualified_name

        _ ->
          false
      end)
      |> Enum.reduce([], fn element, elements ->
        elements = get_elements_by_tag_name(element, qualified_name) ++ elements
        [element | elements]
      end)

      if qualified_name == "*" or dom_element.tag_name == qualified_name,
      do: [dom_element | elements],
      else: elements
  end

  def get_elements_by_id(%{child_nodes: child_nodes} = dom_element, element_id) do
    elements =
      child_nodes
      |> Enum.filter(fn
        %{id: id} ->
          id == element_id

        _ ->
          false
      end)
      |> Enum.reduce([], fn element, elements ->
        elements = get_elements_by_id(element, element_id) ++ elements
        [element | elements]
      end)

    if dom_element.id == element_id,
      do: [dom_element | elements],
      else: elements
  end

  @doc """
    https://dom.spec.whatwg.org/#dom-nonelementparentnode-getelementbyid
  """
  @spec get_element_by_id(__MODULE__.t(), binary()) :: __MODULE__.t()
  def get_element_by_id(element, element_id)

  def get_element_by_id(%{id: id} = dom_element, element_id) when id == element_id,
    do: dom_element

  def get_element_by_id(dom_element, element_id) do
    dom_element
    |> get_elements_by_id(element_id)
    |> List.first()
  end
end
