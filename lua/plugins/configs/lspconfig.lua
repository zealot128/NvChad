local present1, lspconfig = pcall(require, "lspconfig")
local present2, lspinstall = pcall(require, "lspinstall")

if not (present1 or present2) then
   return
end

local function on_attach(_, bufnr)
   local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
   end
   local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
   end

   -- Enable completion triggered by <c-x><c-o>
   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

   -- Mappings.
   local opts = { noremap = true, silent = true }

   -- See `:help vim.lsp.*` for documentation on any of the below functions
   buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
   buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   buf_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
   buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
   buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
   buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
   buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
   buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
   buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
   buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
   buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
   buf_set_keymap("v", "<space>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
   properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
   },
}

-- lspInstall + lspconfig stuff
local lspconfig_configs = require'lspconfig/configs'
local lspconfig_util = require 'lspconfig/util'

local function on_new_config(new_config, new_root_dir)
  local function get_typescript_server_path(root_dir)
    local project_root = lspconfig_util.find_node_modules_ancestor(root_dir)
    return project_root and (lspconfig_util.path.join(project_root, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js'))
      or ''
  end

  if
    new_config.init_options
    and new_config.init_options.typescript
    and new_config.init_options.typescript.serverPath == ''
  then
    new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
  end
end

local volar_cmd = {'volar-server', '--stdio'}
local volar_root_dir = lspconfig_util.root_pattern 'package.json'




local function setup_servers()
   lspinstall.setup()
   local servers = lspinstall.installed_servers()
   lspconfig_configs.volar_api = {
     default_config = {
       cmd = volar_cmd,
       root_dir = volar_root_dir,
       on_new_config = on_new_config,
       filetypes = { 'vue'},
       -- If you want to use Volar's Take Over Mode (if you know, you know)
       --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
       init_options = {
         typescript = {
           serverPath = ''
         },
         languageFeatures = {
           references = true,
           definition = true,
           typeDefinition = true,
           callHierarchy = true,
           hover = true,
           rename = true,
           renameFileRefactoring = true,
           signatureHelp = true,
           codeAction = true,
           workspaceSymbol = true,
           completion = {
             defaultTagNameCase = 'both',
             defaultAttrNameCase = 'kebabCase',
             getDocumentNameCasesRequest = false,
             getDocumentSelectionRequest = false,
           },
         }
       },
     }
   }
   lspconfig.volar_api.setup{
     on_attach = on_attach,
     capabilities = capabilities,
   }

   lspconfig_configs.volar_doc = {
     default_config = {
       cmd = volar_cmd,
       root_dir = volar_root_dir,
       on_new_config = on_new_config,

       filetypes = { 'vue'},
       -- If you want to use Volar's Take Over Mode (if you know, you know):
       --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
       init_options = {
         typescript = {
           serverPath = ''
         },
         languageFeatures = {
           documentHighlight = true,
           documentLink = true,
           codeLens = { showReferencesNotification = true},
           -- not supported - https://github.com/neovim/neovim/pull/14122
           semanticTokens = false,
           diagnostics = true,
           schemaRequestService = true,
         }
       },
     }
   }
   lspconfig.volar_doc.setup{
     on_attach = on_attach,
     capabilities = capabilities,
   }

   lspconfig_configs.volar_html = {
     default_config = {
       cmd = volar_cmd,
       root_dir = volar_root_dir,
       on_new_config = on_new_config,

       filetypes = { 'vue'},
       -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
       --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
       init_options = {
         typescript = {
           serverPath = ''
         },
         documentFeatures = {
           selectionRange = true,
           foldingRange = true,
           linkedEditingRange = true,
           documentSymbol = true,
           -- not supported - https://github.com/neovim/neovim/pull/13654
           documentColor = false,
           documentFormatting = {
             defaultPrintWidth = 100,
           },
         }
       },
     }
   }
   lspconfig.volar_html.setup{
     on_attach = on_attach,
     capabilities = capabilities,
   }

   for _, lang in pairs(servers) do
      if lang ~= "lua" then
         lspconfig[lang].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
               debounce_text_changes = 500,
            },
            -- root_dir = vim.loop.cwd,
         }
      elseif lang == "lua" then
         lspconfig[lang].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
               debounce_text_changes = 500,
            },
            settings = {
               Lua = {
                  diagnostics = {
                     globals = { "vim" },
                  },
                  workspace = {
                     library = {
                        [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                        [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                     },
                     maxPreload = 100000,
                     preloadFileSize = 10000,
                  },
                  telemetry = {
                     enable = false,
                  },
               },
            },
         }
      end
   end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
lspinstall.post_install_hook = function()
   setup_servers() -- reload installed servers
   vim.cmd "bufdo e"
end

-- replace the default lsp diagnostic symbols
local function lspSymbol(name, icon)
   vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefaul" .. name })
end

lspSymbol("Error", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")
lspSymbol("Warning", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = {
      prefix = "",
      spacing = 0,
   },
   signs = true,
   underline = true,
   update_in_insert = false, -- update diagnostics insert mode
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
   border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
   border = "single",
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
   if msg:match "exit code" then
      return
   end
   if log_level == vim.log.levels.ERROR then
      vim.api.nvim_err_writeln(msg)
   else
      vim.api.nvim_echo({ { msg } }, true, {})
   end
end
