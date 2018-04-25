defmodule Anvil.WatchView do
  use Anvil.Web, :view

  def player_id(video) do
    ~r/^.*(?:youtu.be\/|v\/|e\/|u\/\w+\/|embed\/|v=)(?<id>[^#\&\?]*).*/
    |> Regex.named_captures(video.url)
    |> get_in(["id"])
  end
end