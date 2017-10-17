# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :ui, Ui.Repo,
  adapter: Sqlite.Ecto2,
  database: "nerves.sqlite3",
  pool_size: 20

# General application configuration
config :ui,
  ecto_repos: [Ui.Repo]

# Configures the endpoint
config :ui, UiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RzmiWYDzEdA6n6X+liCFJoQGpfr1pp079Di0zddmCLSRNBBW4asl23YfxNbJnzR4",
  render_errors: [view: UiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ui.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
