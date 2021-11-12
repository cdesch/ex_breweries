# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ExBrewery.Repo.insert!(%ExMink.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# alias NimbleCSV.RFC4180, as: CSV


defmodule ExBrewery.Seeds do

  @doc """
  Convert the given fields to float values for the Map
  """
  def convert_fields_to_float(row, keys) do
    Enum.reduce(keys, row, fn key, acc -> convert_to_float(acc, key) end)
  end

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
      {value, exp} -> value
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

# file = './alabama.csv'
file = './breweries.csv'

File.stream!(file)
  |> Stream.drop(1)
  |> CSV.decode(headers: [:obdb_id, :name, :brewery_type, :street, :address_2, :address_3, :city, :state, :county_province, :postal_code, :website_url, :phone, :country, :longitude, :latitude, :tags])
  |> Enum.each(fn {:ok, map} ->
      map
      |> ExBrewery.Seeds.convert_fields_to_float([:longitude, :latitude])
      |> IO.inspect
      |> ExBrewery.Seeds.store_it
  end)
