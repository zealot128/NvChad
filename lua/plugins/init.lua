local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
   local plugin_status = require("core.utils").load_config().plugin_status

   -- nvim file:25  - open file with line number
   use "wsdjeg/vim-fetch"
   -- use 'digitaltoad/vim-pug'
   use "tpope/vim-surround"
   -- let g:rg_command = 'rg --no-messages --vimgrep'
   use {
     -- TODO https://github.com/jremmen/vim-ripgrep/pull/56
     -- "jremmen/vim-ripgrep"
    "tacahiroy/vim-ripgrep",
    branch = 'fix-e1208'
   }
   use {
     "github/copilot.vim",
     setup = function()
       vim.g.copilot_no_tab_map = true
     end,
     config = function()
       vim.api.nvim_exec([[
        imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
       ]], true)
     end
   }

   use 'AndrewRadev/diffurcate.vim'
   -- git diff | vim - -R +Diffurcate
   use "tpope/vim-tbone"
   use "tpope/vim-eunuch"
   use "tpope/vim-unimpaired"
   -- use 'tpope/vim-vinegar'
   use "tpope/vim-repeat"
   use "chaoren/vim-wordmotion"
   use "slim-template/vim-slim"
   -- :Bdelete nameless
   -- :Bdelete hidden
   use "Asheq/close-buffers.vim"
   use {
      "lmeijvogel/vim-yaml-helper",
      config = function()
         vim.g["vim_yaml_helper#always_get_root"] = 0
         vim.g["vim_yaml_helper#auto_display_path"] = 0
      end,
   }
   use {
     "vimwiki/vimwiki",
     cmd = "VimwikiIndex",
     setup = function()
       vim.g.vimwiki_list = {
         {
           path = '~/vimwiki/',
           syntax = 'markdown',
           ext = '.md',
           custom_wiki2html = 'vimwiki_markdown',
           template_path = '~/vimwiki/templates/',
           template_default = 'default',
           template_ext = '.tpl',
           path_html = '~/vimwiki/site_html/',
           html_filename_parameterization = 1,
         },
       }
     end
   }
   use {
     "JoosepAlviste/nvim-ts-context-commentstring",
     after = "nvim-treesitter",
   }
   use {
     'nvim-treesitter/playground',
     after = "nvim-treesitter",
     command = "TSPlaygroundToggle",
     config = function()
       require "nvim-treesitter.configs".setup {
         playground = {
           enable = true,
           disable = {},
           updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
           persist_queries = false, -- Whether the query persists across vim sessions
           keybindings = {
             toggle_query_editor = 'o',
             toggle_hl_groups = 'i',
             toggle_injected_languages = 't',
             toggle_anonymous_nodes = 'a',
             toggle_language_display = 'I',
             focus_language = 'f',
             unfocus_language = 'F',
             update = 'R',
             goto_node = '<cr>',
             show_help = '?',
           },
         }
       }
      end,
   }
   use {
      "tpope/vim-rails",
      setup = function()
         require "plugins/configs/vim-rails"
      end,
   }
   use {
      "tpope/vim-bundler",
   }
   use {
      "AndrewRadev/splitjoin.vim",
      setup = function()
         vim.g.splitjoin_ruby_curly_braces = 0
         vim.g.splitjoin_ruby_hanging_args = 0
         vim.g.splitjoin_ruby_do_block_split = 0
      end,
   }
   use {
     "dense-analysis/ale",
     setup = function()
       require("plugins.configs.ale")
     end
   }
   use {
     "rhysd/vim-lsp-ale"
   }



   -- this is arranged on the basis of when a plugin starts

   -- this is the nvchad core repo containing utilities for some features like theme swticher, no need to lazy load
   use {
      "Nvchad/extensions",
   }

   use {
      "nvim-lua/plenary.nvim",
   }

   use {
      "wbthomason/packer.nvim",
      event = "VimEnter",
   }

   use {
      "NvChad/nvim-base16.lua",
      after = "packer.nvim",
      config = function()
         require("colors").init()
      end,
   }

   use {
      "kyazdani42/nvim-web-devicons",
      after = "nvim-base16.lua",
      config = function()
         require "plugins.configs.icons"
      end,
   }

   use {
      "famiu/feline.nvim",
      disable = not plugin_status.feline,
      after = "nvim-web-devicons",
      config = function()
         require "plugins.configs.statusline"
      end,
   }

   use {
      "akinsho/bufferline.nvim",
      disable = not plugin_status.bufferline,
      after = "nvim-web-devicons",
      config = function()
         require "plugins.configs.bufferline"
      end,
      setup = function()
         require("core.mappings").bufferline()
      end,
   }

   use {
      "lukas-reineke/indent-blankline.nvim",
      disable = not plugin_status.blankline,
      event = "BufRead",
      config = function()
         require("plugins.configs.others").blankline()
      end,
   }

   use {
      "norcalli/nvim-colorizer.lua",
      disable = not plugin_status.colorizer,
      event = "BufRead",
      config = function()
         require("plugins.configs.others").colorizer()
      end,
   }

   use {
      "nvim-treesitter/nvim-treesitter",
      branch = "0.5-compat",
      event = "BufRead",
      config = function()
         require "plugins.configs.treesitter"
      end,
   }

   -- git stuff
   use {
      "lewis6991/gitsigns.nvim",
      disable = not plugin_status.gitsigns,
      opt = true,
      config = function()
         require "plugins.configs.gitsigns"
      end,
      setup = function()
         require("core.utils").packer_lazy_load "gitsigns.nvim"
      end,
   }

   -- lsp stuff

   use {
     'williamboman/nvim-lsp-installer'
   }
   use {
      "neovim/nvim-lspconfig",
      config = function()
         require "plugins.configs.lspconfig"
      end,
   }

   use {
      "ray-x/lsp_signature.nvim",
      disable = not plugin_status.lspsignature,
      after = "nvim-lspconfig",
      config = function()
         require("plugins.configs.others").signature()
      end,
   }


   -- load luasnips + cmp related in insert mode only
   -- use {
   --    "rafamadriz/friendly-snippets",
   --    -- event = "InsertEnter",
   -- }

   use {
      "hrsh7th/nvim-cmp",
      config = function()
         require "plugins.configs.cmp"
      end,
   }

   use {
      "hrsh7th/cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   -- misc plugins
   --use {
   --   "windwp/nvim-autopairs",
   --   after = "nvim-cmp",
   --   config = function()
   --      require("plugins.configs.others").autopairs()
   --   end,
   --}

   use {
      "sbdchd/neoformat",
      disable = not plugin_status.neoformat,
      cmd = "Neoformat",
      setup = function()
         require("core.mappings").neoformat()
      end,
   }

   --   use "alvan/vim-closetag" -- for html autoclosing tag
   use {
      "terrortylor/nvim-comment",
      disable = not plugin_status.comment,
      cmd = "CommentToggle",
      config = function()
         require("plugins.configs.others").comment()
      end,
      setup = function()
         require("core.mappings").comment()
      end,
   }

   -- file managing , picker etc
   use {
      "kyazdani42/nvim-tree.lua",
      -- cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require "plugins.configs.nvimtree"
      end,
      setup = function()
         require("core.mappings").nvimtree()
      end,
   }

   use {
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      -- because cheatsheet is not activated by a teleacope command
      module = "cheatsheet",
      requires = {
         {
            "sudormrfbin/cheatsheet.nvim",
            disable = not plugin_status.cheatsheet,
            after = "telescope.nvim",
            config = function()
               require "plugins.configs.chadsheet"
            end,
            setup = function()
               require("core.mappings").chadsheet()
            end,
         },
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
         },
         {
            "nvim-telescope/telescope-media-files.nvim",
            disable = not plugin_status.telescope_media,
            setup = function()
               require("core.mappings").telescope_media()
            end,
         },
      },
      config = function()
         require "plugins.configs.telescope"
      end,
      setup = function()
         require("core.mappings").telescope()
      end,
   }

   use {
      "tpope/vim-fugitive",
      -- disable = not plugin_status.vim_fugitive,
      -- cmd = {
      --    "Git",
      --    "Gdiff",
      --    "Gdiffsplit",
      --    "Gvdiffsplit",
      --    "Gwrite",
      --    "Gw",
      -- },
      setup = function()
         require("core.mappings").vim_fugitive()
      end,
   }
end)
