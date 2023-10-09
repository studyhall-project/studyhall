defmodule StudyHall.Emails.DemoMessage do
  @moduledoc """
  A simple email for demo testing.
  """

  import Swoosh.Email, except: [new: 0]

  def new(demo_message) do
    Swoosh.Email.new()
    |> from({"Mike Zornek", "zorn@zornlabs.com"})
    |> to({"StudyHall Server", "zorn@zornlabs.com"})
    |> put_provider_option(:template_alias, "demo-message")
    |> put_provider_option(:template_model, %{
      product_url: "https://github.com/studyhall-project/studyhall",
      product_name: "StudyHall",
      demo_message: demo_message,
      company_name: "Zorn Labs LLC",
      company_address: "123 Fake Street, Philadelphia, PA 19147"
    })
  end
end
