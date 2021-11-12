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
