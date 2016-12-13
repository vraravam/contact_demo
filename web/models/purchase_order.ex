defmodule ContactDemo.PurchaseOrder do
  use ContactDemo.Web, :model
  use Whatwasit

  schema "purchase_orders" do
    field :placed_on, Ecto.Date, null: false
    field :name, :string, null: false
    field :buying_price, :decimal, null: false, precision: 10, scale: 2
    field :currency_code, :string, null: false

    timestamps
  end

  @required_fields ~w(placed_on name buying_price currency_code)

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields)
    |> validate_required(Enum.map(@required_fields, &String.to_atom(&1)))
    # TODO: 'placed_on' should be today or earlier
    |> validate_length(:name, min: 1, max: 255)
    |> validate_number(:buying_price, greater_than: 0)
    |> prepare_version(opts)
  end
end
