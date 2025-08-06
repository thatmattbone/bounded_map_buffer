defmodule BoundedMapBuffer.MixProject do
  use Mix.Project

  @version "0.1.1"
  @github_url "https://github.com/thatmattbone/bounded_map_buffer"

  def project do
    [
      app: :bounded_map_buffer,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      name: "BoundedMapBuffer",
      source_url: @github_url,
      description: "A bounded circular buffer based on an elixir map."
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README.md LICENSE),
      licenses: ["MIT"],
      links: %{"GitHub" => @github_url}
    ]
  end
end
