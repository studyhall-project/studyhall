defmodule StudyHall.CourseCatalog.Course do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "courses"
    repo StudyHall.Repo
  end

  code_interface do
    define_for StudyHall.CourseCatalog
    define :create, action: :create
    define :read_all, action: :read
    define :update, action: :update
    define :destroy, action: :destroy
    define :get_by_id, args: [:id], action: :by_id
  end

  actions do
    defaults [:create, :read, :update, :destroy]

    read :by_id do
      argument :id, :uuid, allow_nil?: false
      get? true
      filter expr(id == ^arg(:id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
    end

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end
end
