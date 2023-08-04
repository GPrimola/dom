defmodule KeystringTest do
  use ExUnit.Case, async: true

  describe "get/3" do
    test "should return the value of the given key when it's in the list" do
      keystring_list = [{"foo", "bar"}]
      assert "bar" = Keystring.get(keystring_list, "foo")
    end

    test "should return nil when key isn't in the list" do
      keystring_list = [{"foo", "bar"}]
      assert Keystring.get(keystring_list, "bar") == nil
    end

    test "should return default value when key isn't in the list" do
      keystring_list = [{"foo", "bar"}]
      assert "zoo" = Keystring.get(keystring_list, "bar", "zoo")
    end

    test "should raise FunctionClauseError when given list is not a keystring list" do
      assert_raise(FunctionClauseError, fn ->
        Keystring.get(:anything, "foo")
      end)
    end

    test "should raise FunctionClauseError when key is not a binary" do
      assert_raise(FunctionClauseError, fn ->
        Keystring.get([], :somekey)
      end)
    end
  end

  describe "put/3" do
    test "should append a new key-value pair in the list" do
      keystring_list = [{"foo", "bar"}]

      assert [{"foo", "bar"}, {"zoo", "qux"}] = Keystring.put(keystring_list, "zoo", "qux")
    end

    test "should append a new key-value pair in the list when any value type is given" do
      keystring_list = [{"foo", "bar"}]

      value = Enum.random([%{}, {}, 1, :atom, [], "str", 1.0])
      assert [{"foo", "bar"}, {"zoo", ^value}] = Keystring.put(keystring_list, "zoo", value)
    end

    test "should raise FunctionClauseError when given list is not a keystring list" do
      assert_raise(FunctionClauseError, fn ->
        Keystring.get(:anything, "foo", "val")
      end)
    end

    test "should raise FunctionClauseError when key is not a binary" do
      assert_raise(FunctionClauseError, fn ->
        Keystring.put([], :somekey, "val")
      end)
    end
  end

  describe "has_key?/2" do
    test "should return true when given key is in the list" do
      keystring_list = [{"foo", "bar"}]
      assert  Keystring.has_key?(keystring_list, "foo")
    end

    test "should false when given key isn't in the list" do
      keystring_list = [{"foo", "bar"}]
      refute Keystring.has_key?(keystring_list, "bar")
    end

    test "should return true when key is in the list even with a nil value" do
      keystring_list = [{"foo", nil}]
      assert Keystring.has_key?(keystring_list, "foo")
    end

    test "should raise FunctionClauseError when given list is not a keystring list" do
      assert_raise(FunctionClauseError, fn ->
        Keystring.has_key?(:anything, "foo")
      end)
    end

    test "should raise FunctionClauseError when key is not a binary" do
      assert_raise(FunctionClauseError, fn ->
        Keystring.has_key?([], :somekey)
      end)
    end
  end

  describe "keys/1" do
    test "should return a list containing all keys in the keystring list" do
      keystring_list = [{"foo", "bar"}, {"flo", "wer"}]
      assert ["foo", "flo"] = Keystring.keys(keystring_list)
    end

    test "should return an empty list when keystring list is empty" do
      keystring_list = []
      assert [] = Keystring.keys(keystring_list)
    end

    test "should raise ArgumentError when given list is not a keystring list" do
      assert_raise ArgumentError, fn ->
        Keystring.keys([{:foo, "bar"}])
      end
    end
  end

end
