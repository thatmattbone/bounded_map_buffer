defmodule BoundedMapBufferTest do
  use ExUnit.Case
  doctest BoundedMapBuffer

  test "new buffer" do
    buffer = BoundedMapBuffer.new(5)

    assert buffer.current_position == 0
    assert buffer.length == 5
    assert buffer.data_map == %{
      0 => nil,
      1 => nil,
      2 => nil,
      3 => nil,
      4 => nil
    }
  end

  test "push buffer" do
    buffer = BoundedMapBuffer.new(3)

    buffer = BoundedMapBuffer.push(buffer, "one")

    assert buffer.current_position == 1
    assert buffer.data_map == %{
      0 => "one",
      1 => nil,
      2 => nil
    }

    buffer = buffer
      |> BoundedMapBuffer.push("two")
      |> BoundedMapBuffer.push("three")
      |> BoundedMapBuffer.push("four")

    assert buffer.current_position == 1
    assert buffer.data_map == %{
      0 => "four",
      1 => "two",
      2 => "three"
    }
  end

  test "push_all buffer" do
    buffer = BoundedMapBuffer.new(3)

    buffer = BoundedMapBuffer.push_all(buffer, ["one"])

    assert buffer.current_position == 1
    assert buffer.data_map == %{
      0 => "one",
      1 => nil,
      2 => nil
    }

    buffer = buffer |> BoundedMapBuffer.push_all(["two", "three", "four"])

    assert buffer.current_position == 1
    assert buffer.data_map == %{
      0 => "four",
      1 => "two",
      2 => "three"
    }
  end

  test "buffer peek" do
    buffer = BoundedMapBuffer.new(5)
    buffer = buffer
      |> BoundedMapBuffer.push("one")

    assert BoundedMapBuffer.peek(buffer) == "one"

    buffer = buffer
      |> BoundedMapBuffer.push("two")
      |> BoundedMapBuffer.push("three")
      |> BoundedMapBuffer.push("four")

    assert BoundedMapBuffer.peek(buffer) == "four"

    buffer = buffer
      |> BoundedMapBuffer.push("five")
      |> BoundedMapBuffer.push("six")
      |> BoundedMapBuffer.push("seven")

    assert BoundedMapBuffer.peek(buffer) == "seven"
  end

  test "to list" do
    buffer = BoundedMapBuffer.new(3)
      |> BoundedMapBuffer.push("a")
      |> BoundedMapBuffer.push("b")
      |> BoundedMapBuffer.push("c")

    assert BoundedMapBuffer.to_list(buffer) == ["a", "b", "c"]

    buffer = buffer |> BoundedMapBuffer.push("d") |> BoundedMapBuffer.push("e")

    assert BoundedMapBuffer.to_list(buffer) == ["c", "d", "e"]
  end
end
