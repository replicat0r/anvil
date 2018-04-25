defmodule Anvil.WatchController do
    use Anvil.Web, :controller
    alias Anvil.Video
    
    def show(conn, %{"id" => id}) do
        video = Repo.get!(Video, id)
        render conn, "show.html", video: video
    
    end
end