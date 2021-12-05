defmodule ExBrewery.BarrelTest do
  use ExBrewery.DataCase

  alias ExBrewery.Barrel

  describe "breweries" do
    alias ExBrewery.Barrel.Brewery

    import ExBrewery.BarrelFixtures

    @invalid_attrs %{address_2: nil, address_3: nil, brewery_type: nil, city: nil, country: nil, county_province: nil, latitude: nil, longitude: nil, name: nil, obdb_id: nil, phone: nil, postal_code: nil, state: nil, street: nil, tags: nil, website_url: nil}

    test "list_breweries/0 returns all breweries" do
      brewery = brewery_fixture()
      assert Barrel.list_breweries() == [brewery]
    end

    test "list_breweries_page/0 returns all breweries" do
      brewery = brewery_fixture()
      page = Barrel.list_breweries_page()
      assert page.entries == [brewery]
    end

    test "get_brewery!/1 returns the brewery with given id" do
      brewery = brewery_fixture()
      assert Barrel.get_brewery!(brewery.id) == brewery
    end

    test "create_brewery/1 with valid data creates a brewery" do
      valid_attrs = %{address_2: "some address_2", address_3: "some address_3", brewery_type: "some brewery_type", city: "some city", country: "some country", county_province: "some county_province", latitude: 120.5, longitude: 120.5, name: "some name", obdb_id: "some obdb_id", phone: "some phone", postal_code: "some postal_code", state: "some state", street: "some street", tags: "some tags", website_url: "some website_url"}

      assert {:ok, %Brewery{} = brewery} = Barrel.create_brewery(valid_attrs)
      assert brewery.address_2 == "some address_2"
      assert brewery.address_3 == "some address_3"
      assert brewery.brewery_type == "some brewery_type"
      assert brewery.city == "some city"
      assert brewery.country == "some country"
      assert brewery.county_province == "some county_province"
      assert brewery.latitude == 120.5
      assert brewery.longitude == 120.5
      assert brewery.name == "some name"
      assert brewery.obdb_id == "some obdb_id"
      assert brewery.phone == "some phone"
      assert brewery.postal_code == "some postal_code"
      assert brewery.state == "some state"
      assert brewery.street == "some street"
      assert brewery.tags == "some tags"
      assert brewery.website_url == "some website_url"
    end

    test "create_brewery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Barrel.create_brewery(@invalid_attrs)
    end

    test "update_brewery/2 with valid data updates the brewery" do
      brewery = brewery_fixture()
      update_attrs = %{address_2: "some updated address_2", address_3: "some updated address_3", brewery_type: "some updated brewery_type", city: "some updated city", country: "some updated country", county_province: "some updated county_province", latitude: 456.7, longitude: 456.7, name: "some updated name", obdb_id: "some updated obdb_id", phone: "some updated phone", postal_code: "some updated postal_code", state: "some updated state", street: "some updated street", tags: "some updated tags", website_url: "some updated website_url"}

      assert {:ok, %Brewery{} = brewery} = Barrel.update_brewery(brewery, update_attrs)
      assert brewery.address_2 == "some updated address_2"
      assert brewery.address_3 == "some updated address_3"
      assert brewery.brewery_type == "some updated brewery_type"
      assert brewery.city == "some updated city"
      assert brewery.country == "some updated country"
      assert brewery.county_province == "some updated county_province"
      assert brewery.latitude == 456.7
      assert brewery.longitude == 456.7
      assert brewery.name == "some updated name"
      assert brewery.obdb_id == "some updated obdb_id"
      assert brewery.phone == "some updated phone"
      assert brewery.postal_code == "some updated postal_code"
      assert brewery.state == "some updated state"
      assert brewery.street == "some updated street"
      assert brewery.tags == "some updated tags"
      assert brewery.website_url == "some updated website_url"
    end

    test "update_brewery/2 with invalid data returns error changeset" do
      brewery = brewery_fixture()
      assert {:error, %Ecto.Changeset{}} = Barrel.update_brewery(brewery, @invalid_attrs)
      assert brewery == Barrel.get_brewery!(brewery.id)
    end

    test "delete_brewery/1 deletes the brewery" do
      brewery = brewery_fixture()
      assert {:ok, %Brewery{}} = Barrel.delete_brewery(brewery)
      assert_raise Ecto.NoResultsError, fn -> Barrel.get_brewery!(brewery.id) end
    end

    test "change_brewery/1 returns a brewery changeset" do
      brewery = brewery_fixture()
      assert %Ecto.Changeset{} = Barrel.change_brewery(brewery)
    end
  end
end
