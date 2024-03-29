defmodule GitHub.User do
  defstruct id: 0, username: "", followers: []

  def new(id, username) do
    %__MODULE__{id: id, username: username}
  end

  @followers_url "https://api.github.com/users/:username/followers"
  @http_options [ssl: [{:versions, [:"tlsv1.2"]}], recv_timeout: 500]
  @access_token Application.compile_env(:elixir_katas_exercises, :access_token)
  @headers [{"Authorization", "token #{@access_token}"}]

  def loop do
    receive do
      {sender_id, username} ->
        send(sender_id, {:ok, followers_of(username)})

      _ ->
        {:ok, "Unknown Message"}
    end

    loop()
  end

  def followers_of(username) do
    username
    |> create_url
    |> make_a_request
    |> parse_response
    |> extract_followers_info
    |> convert_to_users(username)
  end

  defp create_url(username) do
    @followers_url
    |> String.replace(":username", username)
  end

  defp make_a_request(url) do
    HTTPoison.get(url, @headers, @http_options)
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, headers: _headers, status_code: 200}}) do
    body
    |> JSON.decode()
  end

  defp parse_response({_, error}) do
    IO.inspect(error)
    raise "ops"
  end

  defp extract_followers_info({:ok, users_info}) do
    users_info
    |> Enum.map(fn %{"id" => id, "login" => login} -> {id, login} end)
  end

  defp convert_to_users(followers, username) do
    user = new(0, username)
    users = for {id, login} <- followers, do: new(id, login)
    %{user | followers: users}
  end
end
