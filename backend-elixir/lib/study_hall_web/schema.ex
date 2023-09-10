defmodule StudyHallWeb.Schema do
  use Absinthe.Schema

  @apis [StudyHall.CourseCatalog]

  use AshGraphql, apis: @apis

  query do
  end

  mutation do
  end
end
