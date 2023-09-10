defmodule StudyHall.Repo do
  use Ecto.Repo,
    otp_app: :study_hall,
    adapter: Ecto.Adapters.Postgres
end
