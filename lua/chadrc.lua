-- IMPORTANT NOTE : This is the user config, can be edited. Will be preserved if updated with internal updater

local M = {}
M.ui, M.options, M.plugin_status, M.mappings, M.custom = {}, {}, {}, {}, {}

-- non plugin ui configs, available without any plugins
M.ui = {
   italic_comments = false,

   -- theme to be used, to see all available themes, open the theme switcher by <leader> + th
   theme = "javacafe",

   -- theme toggler, toggle between two themes, see theme_toggleer mappings
   theme_toggler = {
      enabled = false,
      fav_themes = {
         "onedark",
         "gruvchad",
      },
   },

   -- Enable this only if your terminal has the colorscheme set which nvchad uses
   -- For Ex : if you have onedark set in nvchad , set onedark's bg color on your terminal
   transparency = false,
}

-- plugin related ui options
M.ui.plugin = {
   -- statusline related options
   statusline = {
      -- these are filetypes, not pattern matched
      -- if a filetype is present in shown, it will always show the statusline, irrespective of filetypes in hidden
      hidden = {},
      shown = { "ruby" },
      -- default, round , slant , block , arrow
      style = "default",
   },
}

-- non plugin normal, available without any plugins
M.options = {
   clipboard = "",
   cmdheight = 1,
   copy_cut = false, -- copy cut text ( x key ), visual and normal mode
   copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
   expandtab = true,
   hidden = true,
   ignorecase = true,
   insert_nav = false, -- navigation in insertmode
   mapleader = "\\",
   mouse = "",
   number = false,
   -- relative numbers in normal mode tool at the bottom of options.lua
   numberwidth = 2,
   permanent_undo = true,
   shiftwidth = 2,
   smartindent = true,
   tabstop = 2, -- Number of spaces that a <Tab> in the file counts for
   timeoutlen = 400,
   relativenumber = false,
   ruler = false,
   updatetime = 250,
   -- used for updater
   update_url = "https://github.com/NvChad/NvChad",
   update_branch = "main",
}

-- these are plugin related options
M.options.plugin = {
   autosave = false, -- autosave on changed text or insert mode leave
   -- timeout to be used for using escape with a key combination, see mappings.plugin.better_escape
   esc_insertmode_timeout = 300,
}

-- enable and disable plugins (false for disable)
M.plugin_status = {
   autosave = false, -- to autosave files
   blankline = false, -- beautified blank lines
   bufferline = false, -- buffer shown as tabs
   cheatsheet = true, -- fuzzy search your commands/keymappings
   colorizer = true,
   comment = true, -- universal commentor
   dashboard = false, -- a nice looking dashboard
   esc_insertmode = false, -- escape from insert mode using custom keys
   feline = true, -- statusline
   gitsigns = true, -- gitsigns in statusline
   lspsignature = true, -- lsp enhancements
   neoformat = true, -- universal formatter
   neoscroll = false, -- smooth scroll
   telescope_media = false, -- see media files in telescope picker
   truezen = false, -- no distraction mode for nvim
   vim_fugitive = false, -- git in nvim
   vim_matchup = true, -- % magic, match it but improved
}

-- mappings -- don't use a single keymap twice --
-- non plugin mappings
M.mappings = {
   -- close current focused buffer
   close_buffer = "<leader>x",
   copy_whole_file = "<C-a>", -- copy all contents of the current buffer

   -- navigation in insert mode, only if enabled in options
   insert_nav = {
      backward = "<C-h>",
      end_of_line = "<C-e>",
      forward = "<C-l>",
      next_line = "<C-k>",
      prev_line = "<C-j>",
      top_of_line = "<C-a>",
   },

   line_number_toggle = "<leader>n", -- show or hide line number
   new_buffer = "<S-t>", -- open a new buffer
   new_tab = "<C-t>b", -- open a new vim tab
   save_file = "<C-s>", -- save file using :w
   theme_toggler = "<leader>tt", -- for theme toggler, see in ui.theme_toggler

   -- terminal related mappings
   terminal = {
      -- multiple mappings can be given for esc_termmode and esc_hide_termmode
      -- get out of terminal mode
      esc_termmode = { "jk" }, -- multiple mappings allowed
      -- get out of terminal mode and hide it
      -- it does not close it, see pick_term mapping to see hidden terminals
      esc_hide_termmode = { "JK" }, -- multiple mappings allowed
      -- show hidden terminal buffers in a telescope picker
      pick_term = "<leader>W",
      -- below three are for spawning terminals
      new_horizontal = "<leader>h",
      new_vertical = "<leader>v",
      new_window = "<leader>w",
   },

   -- update nvchad from nvchad, chadness 101
   update_nvchad = "<leader>uu",
}

-- all plugins related mappings
-- to get short info about a plugin, see the respective string in plugin_status, if not present, then info here
M.mappings.plugin = {
   bufferline = {
      next_buffer = "<TAB>", -- next buffer
      prev_buffer = "<S-Tab>", -- previous buffer
      --better window movement
      moveLeft = "<C-h>",
      moveRight = "<C-l>",
      moveUp = "<C-k>",
      moveDown = "<C-j>",
   },
   chadsheet = {
      default_keys = "<leader>dk",
      user_keys = "<leader>uk",
   },
   comment = {
      toggle = "<leader>/", -- trigger comment on a single/selected lines/number prefix
   },
   dashboard = {
      bookmarks = "<leader>bm",
      new_file = "<leader>fn", -- basically create a new buffer
      -- open = "<leader>db", -- open dashboard
      -- session_load = "<leader>l", -- load a saved session
      -- session_save = "<leader>s", -- save a session
   },
   -- note: this is an edditional mapping to escape, escape key will still work
   better_escape = {
      esc_insertmode = { "jk" }, -- multiple mappings allowed
   },
   nvimtree = {
      toggle = "<C-n>", -- file manager
   },
   neoformat = {
      format = "<leader>fm",
   },
   telescope = {
      buffers = "<C-b>",
      find_files = "<C-p>",
      git_commits = "<leader>cm",
      git_status = "<leader>gt",
      help_tags = "<leader>fh",
      live_grep = "<leader>fw",
      oldfiles = "<leader>fo",
      themes = "<leader>th",
   },
   telescope_media = {
      media_files = "<leader>fp",
   },
   truezen = { -- distraction free modes mapping, hide statusline, tabline, line numbers
      ataraxis_mode = "<leader>zz", -- center
      focus_mode = "<leader>zf",
      minimalistic_mode = "<leader>zm", -- as it is
   },
   vim_fugitive = {
      -- diff_get_2 = "<leader>gh",
      -- diff_get_3 = "<leader>gl",
      -- git = "<leader>gs",
      -- git_blame = "<leader>gb",
   },
}

-- user custom mappings
-- e.g: name = { "mode" , "keys" , "cmd" , "options"}
-- name: can be empty or something unique with repect to other custom mappings
--    { mode, key, cmd } or name = { mode, key, cmd }
-- mode: usage: mode or { mode1, mode2 }, multiple modes allowed, available modes => :h map-modes,
-- keys: multiple keys allowed, same synxtax as modes
-- cmd:  for vim commands, must use ':' at start and add <CR> at the end if want to execute
-- options: see :h nvim_set_keymap() opts section
M.custom.mappings = {
   -- clear_all = {
   --    "n",
   --    "<leader>cc",
   --    "gg0vG$d",
   -- },
}

M.plugins = {
   lspconfig = {
      -- servers = {"html", "cssls"}
      servers = {},
   },
}

vim.opt.wildignorecase = true
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"
vim.opt.gdefault = true
vim.opt.wildignorecase = true

-- Save on enter
vim.api.nvim_exec(
[[
  nnoremap <silent><expr> <CR> &buftype is# '' ? ":w\<CR>" : "\<CR>"
]], false)
vim.api.nvim_exec([[command! ReplaceRuby19Hash :%s/:\([a-z_]\+\) *=> */\1: /]], true)
vim.api.nvim_exec([[command! Ruby19HashConvert :%s/:\([a-z_]\+\) *=> */\1: /]], true)
vim.api.nvim_exec([[command! RubyHashToSym :%s/["']\([^"']\+\)["'] *=> */\1: /]], true)
local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>'")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
function CopyRspecForLine()
   local row = vim.fn.line "."
   local file = vim.fn.expand "%"
   local testcommand = "R " .. file .. ":" .. row
   print(testcommand)
   local tmuxcmd = "echo '" .. testcommand .. "' | tmux loadb -"
   local _error = vim.fn.system(tmuxcmd)
   return testcommand
end

function CopyRealPath()
   local file = vim.fn.resolve(vim.fn.expand "%:p")
   local testcommand = "echo " .. file
   local tmuxcmd = testcommand .. " | tmux loadb -"
   print(file)
   local _error = vim.fn.system(tmuxcmd)
   return testcommand
end
map("n", "<leader>rr", "<cmd>lua CopyRspecForLine()<CR>")
map("n", "<leader>rp", "<cmd>lua CopyRealPath()<CR>")
map("n", "<F3>", ":nohls<CR>")
map("n", "<F2>", ":set invpaste paste?<CR>")
map("n", "<F7>", ":ALEFix<CR>")
map("n", "<C-f>", [[:Telescope find_files<CR>]])

function openDirOfFile()
   local file = vim.fn.resolve(vim.fn.expand "%:h")
   local cmd = ":e " .. file
   print(cmd)

   vim.cmd(cmd)
end
map("n", "-", [[<cmd>lua openDirOfFile()<CR>]])

vim.api.nvim_exec(
   [[
  augroup yaml
    autocmd Filetype yaml set fdm=indent
    autocmd BufRead,BufNewFile *de.yml silent setl spell spelllang=de
  augroup END
]],
   false
)
vim.api.nvim_exec(
   [[
  augroup jsopen
   au BufNewFile,BufRead app/javascript/*.js setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.js setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.js setl suffixesadd+=.vue,.json,.scss,.svelte,.ts
 augroup END
]],
   false
)

vim.api.nvim_exec(
   [[
  augroup tsopen
   au BufNewFile,BufRead  app/javascript/*.ts  setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead  app/javascript/*.ts  setl isfname+=@-@
   au BufNewFile,BufRead  app/javascript/*.ts  setl suffixesadd+=.vue,.json,.scss,.svelte
 augroup END
]],
   false
)
vim.api.nvim_exec(
   [[
  augroup vueopen
   au BufNewFile,BufRead app/javascript/*.vue setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.vue setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.vue setl suffixesadd+=.js,.json,.scss,.ts,.vue
 augroup END
]],
   false
)
vim.api.nvim_exec(
   [[
  augroup svelteopen
   au BufNewFile,BufRead app/javascript/*.svelte setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.svelte setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.svelte setl suffixesadd+=.js,.json,.scss,.ts
 augroup END
]],
   false
)

vim.cmd [[
 au BufNewFile,BufRead app/javascript/*.scss |
       setl path+=app/javascript/,node_modules |
       setl suffixesadd+=.css,.scss,.sass |
       setl isfname+=@-@ |
       setl inex=substitute(v:fname,'^\\~','','')
]]

vim.cmd [[
 au BufNewFile,BufRead */*.lua setl path+=lua
]]

vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'

vim.api.nvim_exec(
[[
  set wildignore+=*.exe,*.swp,.DS_Store,*~,*.o
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  set wildignore+=*/log/*
  set wildignore+=*/coverage/*
  set wildignore+=*/public/system/*  " Rails images
]], false)

-- " Automatically re-read files changed outside
vim.opt.autoread = true
vim.opt.wrap = true
vim.api.nvim_exec([[autocmd CmdwinEnter * nnoremap <buffer> <esc> :q<cr>]], true)
vim.opt.foldlevelstart = 5

-- " Delete every useless whitespace
vim.api.nvim_exec([[autocmd BufWritePre * :%s/\s\+$//e]], true)

vim.opt.includeexpr = [[substitute(v:fname, '^[/\~@]\+', '', '')]]

vim.api.nvim_exec([[
  iabbrev vbase <template lang='pug'><CR>div<CR></template><CR><CR><script lang='ts'><CR>import Vue from 'vue'<CR><CR>export default Vue.extend({<CR>props: {}<CR>})<CR></script><CR><style scoped><CR></style>
]], true)
vim.api.nvim_exec([[
  iabbrev v3base <template><CR><div></div><CR></template><CR><CR><script lang='ts' setup><CR>import { ref, computed } from 'vue'<CR><CR>const props = defineProps<{}>()<CR></script><CR><CR><style scoped><CR></style>
]], true)

return M
