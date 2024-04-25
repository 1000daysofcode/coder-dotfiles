return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

   {
     "neovim/nvim-lspconfig",
     config = function()
       require("nvchad.configs.lspconfig").defaults()
       require "configs.lspconfig"
     end,
   },

   {
   	"williamboman/mason.nvim",
   	opts = {
   		ensure_installed = {
   			"html", "cssls", "ast-grep", "cql-language-server", "css-lsp",
        "cssmodules-language-server", "docker-compose-language-server",
        "dockerfile-language-server", "graphql-language-server", "html-lsp",
        "htmx-lsp", "json-lsp", "nginx-language-server", "python-language-server",
        "rust_analyzer", "svelte-language-server",
      },
   	},
   },
  
   {
   	"nvim-treesitter/nvim-treesitter",
   	opts = {
   		ensure_installed = {
   			"vim", "lua", "vimdoc",
        "html", "css", "typescript",
        "rust", "svelte", "dockerfile",
        "json"
   		},
   	},
   },
}
