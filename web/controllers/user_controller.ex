defmodule Anvil.UserController do
  use Anvil.Web, :controller
  alias Anvil.User

  def index(conn, _params) do
    render conn, "index.html"
  end
  
  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end
  
  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    case Repo.insert(changeset) do
    {:ok, user} ->
        conn |> put_flash(:info, "#{user.name} created")
        |> redirect(to: user_path(conn, :index))
    {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
