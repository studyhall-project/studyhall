defmodule StudyHall.CourseCatalog.Registry do
  use Ash.Registry,
    extensions: [
      Ash.Registry.ResourceValidations
    ]

  entries do
    entry StudyHall.CourseCatalog.Course
  end
end
