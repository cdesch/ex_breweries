defmodule ExBreweryWeb.BreweryLiveTest do
  use ExBreweryWeb.ConnCase

  import Phoenix.LiveViewTest
  import ExBrewery.BarrelFixtures

  @create_attrs %{address_2: "some address_2", address_3: "some address_3", brewery_type: "some brewery_type", city: "some city", country: "some country", county_province: "some county_province", latitude: 120.5, longitude: 120.5, name: "some name", obdb_id: "some obdb_id", phone: "some phone", postal_code: "some postal_code", state: "some state", street: "some street", tags: "some tags", website_url: "some website_url"}
  @update_attrs %{address_2: "some updated address_2", address_3: "some updated address_3", brewery_type: "some updated brewery_type", city: "some updated city", country: "some updated country", county_province: "some updated county_province", latitude: 456.7, longitude: 456.7, name: "some updated name", obdb_id: "some updated obdb_id", phone: "some updated phone", postal_code: "some updated postal_code", state: "some updated state", street: "some updated street", tags: "some updated tags", website_url: "some updated website_url"}
  @invalid_attrs %{address_2: nil, address_3: nil, brewery_type: nil, city: nil, country: nil, county_province: nil, latitude: nil, longitude: nil, name: nil, obdb_id: nil, phone: nil, postal_code: nil, state: nil, street: nil, tags: nil, website_url: nil}

  defp create_brewery(_) do
    brewery = brewery_fixture()
    %{brewery: brewery}
  end

  describe "Index" do
    setup [:create_brewery]

    test "lists all breweries", %{conn: conn, brewery: brewery} do
      {:ok, _index_live, html} = live(conn, Routes.brewery_index_path(conn, :index))

      assert html =~ "Listing Breweries"
      assert html =~ brewery.address_2
    end

    test "saves new brewery", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.brewery_index_path(conn, :index))

      assert index_live |> element("a", "New Brewery") |> render_click() =~
               "New Brewery"

      assert_patch(index_live, Routes.brewery_index_path(conn, :new))

      assert index_live
             |> form("#brewery-form", brewery: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#brewery-form", brewery: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.brewery_index_path(conn, :index))

      assert html =~ "Brewery created successfully"
      assert html =~ "some address_2"
    end

    test "updates brewery in listing", %{conn: conn, brewery: brewery} do
      {:ok, index_live, _html} = live(conn, Routes.brewery_index_path(conn, :index))

      assert index_live |> element("#brewery-#{brewery.id} a", "Edit") |> render_click() =~
               "Edit Brewery"

      assert_patch(index_live, Routes.brewery_index_path(conn, :edit, brewery))

      assert index_live
             |> form("#brewery-form", brewery: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#brewery-form", brewery: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.brewery_index_path(conn, :index))

      assert html =~ "Brewery updated successfully"
      assert html =~ "some updated address_2"
    end

    test "deletes brewery in listing", %{conn: conn, brewery: brewery} do
      {:ok, index_live, _html} = live(conn, Routes.brewery_index_path(conn, :index))

      assert index_live |> element("#brewery-#{brewery.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#brewery-#{brewery.id}")
    end
  end

  describe "Show" do
    setup [:create_brewery]

    test "displays brewery", %{conn: conn, brewery: brewery} do
      {:ok, _show_live, html} = live(conn, Routes.brewery_show_path(conn, :show, brewery))

      assert html =~ "Show Brewery"
      assert html =~ brewery.address_2
    end

    test "updates brewery within modal", %{conn: conn, brewery: brewery} do
      {:ok, show_live, _html} = live(conn, Routes.brewery_show_path(conn, :show, brewery))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Brewery"

      assert_patch(show_live, Routes.brewery_show_path(conn, :edit, brewery))

      assert show_live
             |> form("#brewery-form", brewery: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#brewery-form", brewery: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.brewery_show_path(conn, :show, brewery))

      assert html =~ "Brewery updated successfully"
      assert html =~ "some updated address_2"
    end
  end
end
