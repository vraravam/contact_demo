defmodule HimachalErp.Repo.Migrations.CreatePurchaseOrder do
  use Ecto.Migration

  def change do
    create table(:purchase_orders) do
      add :placed_on, :date, null: false
      add :name, :string, null: false
      add :buying_price, :decimal, null: false, precision: 10, scale: 2
      add :currency_code, :string, null: false

      timestamps
    end
  end
end
