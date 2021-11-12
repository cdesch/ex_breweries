defmodule ExBrewery.SeedsTest do
  use ExBrewery.DataCase

  import ExBrewery.Seeds
  import ExBrewery.BarrelFixtures

  describe "seed" do

    test "convert_to_float/2 converts map field into float" do
      brewery_data = brewery_seed_fixture()

      brewery = brewery_data
        |> convert_to_float(:longitude)

      assert is_float(brewery[:longitude])
    end

    test "convert_fields_to_float/2 converts map fields into float" do
      brewery_data = brewery_seed_fixture()

      brewery = brewery_data
        |> convert_fields_to_float([:longitude, :latitude])

      assert is_float(brewery[:longitude])
      assert is_float(brewery[:latitude])
    end
  end
end
