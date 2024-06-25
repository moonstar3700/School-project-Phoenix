defmodule DeGymApp.Repo do
  use Ecto.Repo,
    otp_app: :de_gym_app,
    adapter: Ecto.Adapters.Postgres
end
