defmodule GitHub.Organization do

  @organization_members_url "https://api.github.com/orgs/:org/members"
  @http_options [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
  @access_token Application.get_env(:elixir_katas_exercises, :access_token)
  @headers ["Authorization": "token #{@access_token}"]

  def members_of(organization_name) do
    organization_name
    |> create_url
    |> HTTPoison.get(@headers, @http_options)
  end

  defp create_url(organization_name) do
    @organization_members_url
    |> String.replace(":org", organization_name)
  end
end
