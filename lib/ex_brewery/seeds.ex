
defmodule ExBrewery.Seeds do
  @moduledoc """
  Brewery Repo Seed Functions
  """

  @doc """
  Convert the given fields to float values for the Map
  """
  def convert_fields_to_float(row, keys) do
    Enum.reduce(keys, row, fn key, acc -> convert_to_float(acc, key) end)
  end

  @spec convert_to_float(map, any) :: map
  @doc """
  Convert the given field to float value for the Map
  """
  def convert_to_float(row, key) do
    Map.update!(row, key, fn x -> parse_string(x) end)
  end

  @doc """
  Parse the string into a float
  """
  def parse_string(value) do
    case Float.parse(value) do
      {value, _exp} -> value
      :error -> nil
    end
  end

  @doc """
  Store the Brewery Record into the database
  """
  def store_it(row) do
    changeset = ExBrewery.Barrel.Brewery.changeset(%ExBrewery.Barrel.Brewery{}, row)
    ExBrewery.Repo.insert!(changeset)
  end

end
