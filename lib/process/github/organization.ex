defmodule GitHub.Organization do

  @organization_members_url "https://api.github.com/orgs/:org/members"
  @http_options [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
  @access_token Application.get_env(:elixir_katas_exercises, :access_token)
  @headers ["Authorization": "token #{@access_token}"]

  def members_of(organization_name) do
    organization_name
    |> create_url
    |> HTTPoison.get(@headers, @http_options)
    |> parse_response
    |> extract_login_information
  end

  defp create_url(organization_name) do
    @organization_members_url
    |> String.replace(":org", organization_name)
  end

  defp parse_response({:ok, %HTTPoison.Response{body: body, headers: _headers, status_code: 200}}) do
    body
    |> JSON.decode
  end

  defp parse_response({_, %HTTPoison.Response{body: body, headers: headers, status_code: _}}) do
    IO.inspect body
    IO.inspect headers
    raise "ops"
  end

  defp extract_login_information({:ok, users_info}) do
    users_info
    |> Enum.map(fn %{"id" => id, "login" => login} -> {id, login} end)
  end

end
