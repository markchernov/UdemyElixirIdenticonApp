defmodule Identicon do
 #iex -S mix

  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello
      :world

  """
  def hello do
    :world
  end

  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    #filter grid with function with args that matched tuple to 2 vars
    grid = Enum.filter grid, fn({code, _index}) -> 
      rem(code, 2) == 0      
    end

    %Identicon.Image{image: | grid: grid}
  end

  def build_grid( %Identicon.Image{hex: hex} = image) do
      grid = 
      hex
      |> Enum.chunk(3)
      #passing in function with 1 arg
      |> Enum.map(&mirrow_row/1)
      |> List.flatten
      |> Enum.with_index

      %Identicon.Image{image | grid: grid}
  end

  def mirrow_row(row) do
      #[145, 46, 200]
      [first, second | _tail] = row       
      #[145, 46, 200, 46, 145]
      row ++ [second, first]
  end
 
  #matching image argument right away
  def pick_color( %Identicon.Image{hex: [r, g, b | _tail]} = image ) do
     # image is a struct with hex property originally set to nil
     # list of numbers image is being pattern match to new list variable 
     # with first 3 named elements so we can access them and pipe the rest to _tail to disregard

     #creating new struct
     %Identicon.Image{ image | color: {r, g, b}}         
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input) |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end 
end
