defmodule Edge.MixProject do
  use Mix.Project

  def project do
    [
      app: :edge,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Edge.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_termbox, git: "https://github.com/f0x/ex_termbox.git", submodules: true, override: true},
      {:ratatouille, "~> 0.5.1"}
    ]
  end
end
