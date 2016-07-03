defmodule PageObject.Mixfile do
  use Mix.Project

  def project do
    [app: :page_object,
     version: "0.0.1",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:hound, "~> 1.0.1"},
     {:cowboy, "~> 1.0.3", only: :test},
     {:plug, "~> 1.0", only: :test},
     {:inflex, "~> 1.7.0" }]
  end
end
