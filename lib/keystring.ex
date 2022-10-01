defmodule Keystring do
  def get(list, key, default \\ nil) do
    case List.keyfind(list, key, 0, default) do
      nil -> nil
      {_, value} -> value
      value -> value
    end
  end

  def put(list, key, value),
    do: List.insert_at(list, -1, {key, value})

  def has_key?(list, key),
    do: List.keymember?(list, key, 0)
end
