local prettier = require("prettier")

prettier.setup({
  bin = 'prettierd', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
  cli_options = {
    arrow_parens = "always",
    bracket_spacing = true,
    html_whitespace_sensitivity = "css",
    print_width = 80,
    semi = true,
    single_quote = false,
    tab_width = 2,
    trailing_comma = "es5",
    use_tabs = false,
  },
})
