defmodule StudyHall.CourseCatalog.Registry do
  @moduledoc false

  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry StudyHall.CourseCatalog.Course
  end
end
