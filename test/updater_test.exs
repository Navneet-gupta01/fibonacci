defmodule UpdaterTest do
  use ExUnit.Case
  doctest Updater

  test "Updater.update/1 with nil argument should return {nil, 1}" do
    assert Updater.update(nil) == {nil, 1}
  end

  test "Updater.update/1 wiht Interger argument should succeed" do
    assert Updater.update(0) == {0, 1}
    assert Updater.update(1) == {1, 2}
    assert Updater.update(15) == {15, 16}
  end

  test "Updater.update/1 with argument of other than integer type should give error" do
    assert Updater.update("asas") == {:error, :invalid_argument}
  end
end
