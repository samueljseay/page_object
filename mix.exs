defmodule PageObject.Mixfile do
  use Mix.Project

  @version "0.2.0"

  def project do
    [app: :page_object,
     version: @version,
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description(),
     package: package()]
  end

  def application do
    []
  end

  defp deps do
    [{:hound, "~> 1.0.1"},
     {:cowboy, "~> 1.0.3", only: :test},
     {:plug, "~> 1.0", only: :test},
     {:ex_doc, ">= 0.0.0", only: :dev},
     {:inflex, "~> 1.7.0" }]
  end

  defp description do
    """
    page_object is a DSL implementing a Page Object pattern for automated testing in Elixir.
    The API for page_object is inspired by ember-cli-page-object. The package relies on hound to provide
    web page interaction.
    """
  end

  defp package do
    [name: :page_object,
     files: ["lib", "mix.exs", "README.md", "LICENSE*"],
     maintainers: ["Samuel Seay"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/samueljseay/page_object"}]
  end
end
