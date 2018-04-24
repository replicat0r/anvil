defmodule Anvil.SessionController do
    use Anvil.Web, :controller
    
    def new(conn, _) do
        render conn, "new.html"
    end
    
    def create(conn, %{"session"=> %{"username" => user, "password" => pass, repo: Repo}}) do
        case Anvil.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
        {:ok, conn} ->
        conn
        |> put_flash(:info,"logged in")
        |> redirect(to: page_path(conn, "index.html"))
        {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password")
        |> render("new.html")
        end
    end
    
    
    def delete(conn, _params) do
        conn
        |> Anvil.Auth.logout()
        |> redirect(to: page_path(conn, :index))
    end
end