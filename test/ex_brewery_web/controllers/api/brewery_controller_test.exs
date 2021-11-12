defmodule ExBreweryWeb.Api.BreweryControllerTest do
  use ExBreweryWeb.ConnCase

  import ExBrewery.BarrelFixtures

  alias ExBrewery.Barrel.Brewery

  @create_attrs %{
    address_2: "some address_2",
    address_3: "some address_3",
    brewery_type: "some brewery_type",
    city: "some city",
    country: "some country",
    county_province: "some county_province",
    latitude: 120.5,
    longitude: 120.5,
    name: "some name",
    obdb_id: "some obdb_id",
    phone: "some phone",
    postal_code: "some postal_code",
    state: "some state",
    street: "some street",
    tags: "some tags",
    website_url: "some website_url"
  }
  @update_attrs %{
    address_2: "some updated address_2",
    address_3: "some updated address_3",
    brewery_type: "some updated brewery_type",
    city: "some updated city",
    country: "some updated country",
    county_province: "some updated county_province",
    latitude: 456.7,
    longitude: 456.7,
    name: "some updated name",
    obdb_id: "some updated obdb_id",
    phone: "some updated phone",
    postal_code: "some updated postal_code",
    state: "some updated state",
    street: "some updated street",
    tags: "some updated tags",
    website_url: "some updated website_url"
  }
  @invalid_attrs %{address_2: nil, address_3: nil, brewery_type: nil, city: nil, country: nil, county_province: nil, latitude: nil, longitude: nil, name: nil, obdb_id: nil, phone: nil, postal_code: nil, state: nil, street: nil, tags: nil, website_url: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all breweries", %{conn: conn} do
      conn = get(conn, Routes.api_brewery_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create brewery" do
    test "renders brewery when data is valid", %{conn: conn} do
      conn = post(conn, Routes.api_brewery_path(conn, :create), brewery: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_brewery_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address_2" => "some address_2",
               "address_3" => "some address_3",
               "brewery_type" => "some brewery_type",
               "city" => "some city",
               "country" => "some country",
               "county_province" => "some county_province",
               "latitude" => 120.5,
               "longitude" => 120.5,
               "name" => "some name",
               "obdb_id" => "some obdb_id",
               "phone" => "some phone",
               "postal_code" => "some postal_code",
               "state" => "some state",
               "street" => "some street",
               "tags" => "some tags",
               "website_url" => "some website_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_brewery_path(conn, :create), brewery: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update brewery" do
    setup [:create_brewery]

    test "renders brewery when data is valid", %{conn: conn, brewery: %Brewery{id: id} = brewery} do
      conn = put(conn, Routes.api_brewery_path(conn, :update, brewery), brewery: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_brewery_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address_2" => "some updated address_2",
               "address_3" => "some updated address_3",
               "brewery_type" => "some updated brewery_type",
               "city" => "some updated city",
               "country" => "some updated country",
               "county_province" => "some updated county_province",
               "latitude" => 456.7,
               "longitude" => 456.7,
               "name" => "some updated name",
               "obdb_id" => "some updated obdb_id",
               "phone" => "some updated phone",
               "postal_code" => "some updated postal_code",
               "state" => "some updated state",
               "street" => "some updated street",
               "tags" => "some updated tags",
               "website_url" => "some updated website_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, brewery: brewery} do
      conn = put(conn, Routes.api_brewery_path(conn, :update, brewery), brewery: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete brewery" do
    setup [:create_brewery]

    test "deletes chosen brewery", %{conn: conn, brewery: brewery} do
      conn = delete(conn, Routes.api_brewery_path(conn, :delete, brewery))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_brewery_path(conn, :show, brewery))
      end
    end
  end

  defp create_brewery(_) do
    brewery = brewery_fixture()
    %{brewery: brewery}
  end
end
