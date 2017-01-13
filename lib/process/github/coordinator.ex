defmodule GitHub.Coordinator do

  def loop() do
    receive do
      {:ok, members} when is_list(members) ->

      _ ->
        send sender_id, "Unknown message"
    end
  end

end
