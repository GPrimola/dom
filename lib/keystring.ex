defmodule Keystring do

  @type t :: list({key :: binary(), value:: any()})

  def is_keystring([]), do: true
  def is_keystring([head | tail]) do
    cond do
      not match?({_key, _value}, head) ->
        {false, head}

      not is_binary(elem(head, 0)) ->
        {false, head}

      true ->
        is_keystring(tail)
    end
  end
  def is_keystring(value), do: {false, value}

  def get(list, key, default \\ nil)
  when is_list(list) and is_binary(key) do
    case List.keyfind(list, key, 0, default) do
      nil -> nil
      {_, value} -> value
      value -> value
    end
  end

  def put(list, key, value)
  when is_list(list) and is_binary(key),
    do: List.insert_at(list, -1, {key, value})

  def has_key?(list, key)
  when is_list(list) and is_binary(key),
    do: List.keymember?(list, key, 0)

  def keys(list) do
    case is_keystring(list) do
      true ->
        Enum.map(list, &elem(&1, 0))

      {false, where} ->
        raise ArgumentError, "expected a keystring list, but an entry in the list is not a two-element tuple with a binary as its first element, got: #{inspect where}"
    end
  end
end
