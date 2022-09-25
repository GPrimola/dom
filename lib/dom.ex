defmodule DOM do
  defmacro __using__(_opts \\ []) do
    quote do
      alias DOM.{
        DOMAttr,
        DOMDocument,
        DOMDocumentFragment,
        DOMDocumentType,
        DOMElement,
        DOMMatrix,
        DOMNode,
        DOMPoint,
        DOMRect,
        DOMShadowRoot,
        HTMLOrSVGElement
      }
    end
  end
end
