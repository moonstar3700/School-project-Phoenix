import Config

# Only in tests, remove the complexity from the password hashing algorithm
config :pbkdf2_elixir, :rounds, 1

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :de_gym_app, DeGymApp.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "de_gym_app_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :de_gym_app_web, DeGymAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "a6ZppzbsMtFBcTM3+BftiZTRPMWz4kslkOmUZ3oFjDI7WKeHAV3RjAQp4vaMTCi5",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# In test we don't send emails.
config :de_gym_app, DeGymApp.Mailer, adapter: Swoosh.Adapters.Test

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
