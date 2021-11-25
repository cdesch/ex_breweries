# ExBrewery

API for Breweries using [OpenBreweryDB](https://www.openbrewerydb.org/)

## Data Source

    https://github.com/openbrewerydb/openbrewerydb

## Setup & Start

To start your Phoenix server:

* Install dependencies with `mix deps.get`
* Create and migrate your database with `mix ecto.setup`
* Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Tests, Linting, and more

Run Tests

    mix test

Run Static Code Analysis  

    mix credo

## Database Operations

Reset Database

    mix ecto.reset

## Generators

    mix phx.gen.live Barrel Brewery breweries obdb_id:string:unique name:string brewery_type:string street:string address_2:string address_3:string city:string state:string county_province:string postal_code:string website_url:string phone:string country:string longitude:float latitude:float tags:string 

    mix phx.gen.json Barrel Brewery breweries obdb_id:string:unique name:string brewery_type:string street:string address_2:string address_3:string city:string state:string county_province:string postal_code:string website_url:string phone:string country:string longitude:float latitude:float tags:string --web Api --no-schema

    obdb_id:string:unique name:string brewery_type:string street:string address_2:string address_3:string city:string state:string county_province:string postal_code:string website_url:string phone:string country:string longitude:float latitude:float tags:string 

    name, street, brewery_type, city, state (or county_province), postal_code, and country