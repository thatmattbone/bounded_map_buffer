defmodule BoundedMapBuffer do
  @moduledoc """
  Documentation for `BoundedMapBuffer`.
  """

  defstruct [
    :data_map,
    :current_position,
    :length
  ]

  def new(size) do
    %BoundedMapBuffer{
      data_map: (for i <- 0..(size - 1), into: %{}, do: {i, nil}),
      current_position: 0,
      length: size
    }
  end


  def push(buffer = %BoundedMapBuffer{}, obj) do
    %BoundedMapBuffer{
      data_map: Map.put(buffer.data_map, buffer.current_position, obj),
      current_position: rem(buffer.current_position + 1, buffer.length),
      length: buffer.length
    }
  end

  def peek(buffer = %BoundedMapBuffer{}) when buffer.current_position == 0 do
    buffer.data_map[buffer.length - 1]
  end

  def peek(buffer = %BoundedMapBuffer{}) do
    buffer.data_map[buffer.current_position - 1]
  end

  defp fix_index(index, size) when index < size do
    index
  end

  defp fix_index(index, size) do
    index - size
  end

  def to_list(buffer = %BoundedMapBuffer{}) do
    for i <- buffer.current_position..(buffer.current_position + buffer.length - 1) do
      fixed_i = fix_index(i, buffer.length)
      Map.get(buffer.data_map, fixed_i)
    end
  end
end
