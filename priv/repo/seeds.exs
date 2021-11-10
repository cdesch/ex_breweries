# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ExMink.Repo.insert!(%ExMink.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# alias NimbleCSV.RFC4180, as: CSV


defmodule ExBrewery.Seeds do

  def convert_to_float(row, key) do
    Map.update!(row, key, fn x -> parse_string(x) end)
  end

  # Put a zero in for missing values
  def parse_string(value) do
    case Float.parse(value) do
      {value, exp} -> value
      :error -> nil
    end
  end

  # def fix_amount(%{transaction_type: "debit"} = row) do
  #   Map.update!(row,:amount,&("-"<>&1))
  # end


  def store_it(row) do
    changeset = ExBrewery.Barrel.Brewery.changeset(%ExBrewery.Barrel.Brewery{}, row)
    ExBrewery.Repo.insert!(changeset)
  end

end
file = './alabama.csv'

File.stream!(file)
  |> Stream.drop(1)
  |> CSV.decode(headers: [:obdb_id, :name, :brewery_type, :street, :address_2, :address_3, :city, :state, :county_province, :postal_code, :website_url, :phone, :country, :longitude, :latitude, :tags])
  |> Enum.each(fn {:ok, map} ->
    IO.inspect map
    map
      |> ExBrewery.Seeds.convert_to_float(:longitude)
      |> ExBrewery.Seeds.convert_to_float(:latitude)
      |> IO.inspect
      |> ExBrewery.Seeds.store_it
  end)
