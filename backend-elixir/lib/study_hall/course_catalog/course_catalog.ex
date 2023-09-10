defmodule StudyHall.CourseCatalog do
  use Ash.Api

  resources do
    registry StudyHall.CourseCatalog.Registry
  end
end
