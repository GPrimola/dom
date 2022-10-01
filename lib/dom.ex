defmodule DOM do
  @moduledoc """
    https://dom.spec.whatwg.org/
  """
  defmacro __using__(_opts \\ []) do
    quote do
      alias DOM.{
        DOMAttr,
        DOMCDataSection,
        DOMComment,
        DOMCharacterData,
        DOMDocument,
        DOMDocumentFragment,
        DOMDocumentType,
        DOMElement,
        DOMMatrix,
        DOMNode,
        DOMNonElementParentNode,
        DOMPoint,
        DOMProcessingInstruction,
        DOMRect,
        DOMShadowRoot,
        DOMText,
        HTMLOrSVGElement
      }
    end
  end
end
