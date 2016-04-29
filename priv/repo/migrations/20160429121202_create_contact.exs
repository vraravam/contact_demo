defmodule Nested.Repo.Migrations.CreateContact do
  use Ecto.Migration

  def change do
    create table(:contacts) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps
    end
    create index(:contacts, [:category_id])

  end
end