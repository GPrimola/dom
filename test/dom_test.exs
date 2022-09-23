defmodule DomTest do
  use ExUnit.Case
  doctest Dom

  test "greets the world" do
    assert Dom.hello() == :world
  end
end
