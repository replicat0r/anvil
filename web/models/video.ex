defmodule Anvil.Video do
  use Anvil.Web, :model
  @primary_key {:id, Anvil.Permalink, autogenerate: true}
  defimpl Phoenix.Param, for: Rumbl.Video do
    def to_param(%{slug: slug, id: id}) do
      "#{id}-#{slug}"
    end
  end
  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Anvil.User
    belongs_to :category, Anvil.Category

    timestamps
  end

  @required_fields ~w(url title description)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  
  
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> slugify_title()
    |> assoc_constraint(:category)
  end
  
  defp slugify_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugify(title))
    else
      IO.puts("asdasdsa")
      changeset
    end
  end
  
  defp slugify(str) do
    str |> String.downcase() |> String.replace(~r/[^\w-]+/u, "-")
  end
end
