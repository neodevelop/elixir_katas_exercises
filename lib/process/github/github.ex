defmodule GitHub do

  def users_and_followers_of(organization) do
    GitHub.Organization.members_of(organization)
    |> Enum.map(&(extract_username(&1)))
    |> Enum.map(&(GitHub.User.followers_of/1))
    |> Enum.reduce(%{},(fn({username, followers}, acc) -> Map.merge acc, %{username => followers} end))
  end

  defp extract_username({_id, username}) do
    username
  end
end
