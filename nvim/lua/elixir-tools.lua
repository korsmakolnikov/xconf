require("elixir").setup(
  {
    nextls = {
      enable = false, -- defaults to false
      init_options = {
        mix_env = "dev",
        mix_target = "host",
        experimental = {
          completions = {
            enable = true -- control if completions are enabled. defaults to false
          }
        }
      },
    },
    credo = {
      enable = true, -- defaults to true
    },
    elixirls = {
      settings = {
        dialyzerEnabled = true,
        fetchDeps = false,
        enableTestLenses = false,
        suggestSpecs = false,
      },
    }
  }
)
