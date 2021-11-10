# ExBrewery

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


    mix phx.gen.live Barrel Brewery breweries obdb_id:string:unique name:string brewery_type:string street:string address_2:string address_3:string city:string state:string county_province:string postal_code:string website_url:string phone:string country:string longitude:float latitude:float tags:string 

    mix phx.gen.json Animals Canine canines breed:string weight:string average_weight_pounds:float average_weight_kg:float size_category:string --web Api --no-schema

obdb_id:string:unique name:string brewery_type:string street:string address_2:string address_3:string city:string state:string county_province:string postal_code:string website_url:string phone:string country:string longitude:float latitude:float tags:string 