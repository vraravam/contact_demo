defmodule ContactDemo.Group do
  use ContactDemo.Web, :model
  use Whatwasit

  alias ContactDemo.AppConstants

  schema "groups" do
    field :name, :string, null: false

    has_many :contacts_groups, ContactDemo.ContactGroup
    has_many :contacts, through: [:contacts_groups, :contact]

    timestamps
  end

  @required_fields ~w(name)

  def changeset(model, params \\ %{}, opts \\ []) do
    model
    |> cast(params, @required_fields)
    |> validate_required(Enum.map(@required_fields, &String.to_atom(&1)))
    |> validate_format(:name, AppConstants.name_format)
    |> validate_length(:name, min: 1, max: 255)
    |> unique_constraint(:name, name: :groups_name_index)
    |> prepare_version(opts)
  end
end
