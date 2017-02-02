defmodule GitHub do
  import Enum, only: [map: 2, reduce: 3]
  import Map, only: [merge: 2]

  def users_and_followers_of(organization) do
    GitHub.Organization.members_of(organization)
    |> map(&(extract_username(&1)))
    |> map(&(GitHub.User.followers_of/1))
    |> reduce(%{},(fn({username, followers}, acc) -> merge acc, %{username => followers} end))
  end

  defp extract_username({_id, username}) do
    username
  end

  def followers_of(users) do
    coordinator_pid = spawn(GitHub.Coordinator, :loop, [ [], Enum.count(users) ])
    users |> (Enum.each fn user ->
      worker_pid = spawn(GitHub.User, :loop, [])
      send worker_pid, {coordinator_pid, user}
    end)
  end
end
