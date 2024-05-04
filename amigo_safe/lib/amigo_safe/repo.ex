defmodule AmigoSafe.Repo do
  use Ecto.Repo,
    otp_app: :amigo_safe,
    adapter: Ecto.Adapters.Postgres
end
