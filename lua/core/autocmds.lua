-- uncomment this if you want to open nvim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd[[ au InsertEnter * set norelativenumber ]]
-- vim.cmd[[ au InsertLeave * set relativenumber ]]

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- Don't show status line on certain windows
vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require("core.utils").hide_statusline() ]]

--auto close file exploer when quiting incase a single buffer is left
-- vim.cmd([[ autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'nvimtree') | q | endif ]])

-- Open a file from its last left off position
-- vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]


vim.api.nvim_exec([[
  augroup yaml
    autocmd Filetype yaml set fdm=indent
    autocmd BufRead,BufNewFile *de.yml silent setl spell spelllang=de
  augroup END
]], false)
vim.api.nvim_exec([[
  augroup jsopen
   au BufNewFile,BufRead app/javascript/*.js setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.js setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.js setl suffixesadd+=.vue,.json,.scss,.svelte,.ts
 augroup END
]], false)

vim.api.nvim_exec([[
  augroup tsopen
   au BufNewFile,BufRead  app/javascript/*.ts  setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead  app/javascript/*.ts  setl isfname+=@-@
   au BufNewFile,BufRead  app/javascript/*.ts  setl suffixesadd+=.vue,.json,.scss,.svelte
 augroup END
]], false)
vim.api.nvim_exec([[
  augroup vueopen
   au BufNewFile,BufRead app/javascript/*.vue setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.vue setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.vue setl suffixesadd+=.js,.json,.scss,.ts
 augroup END
]], false)
vim.api.nvim_exec([[
  augroup svelteopen
   au BufNewFile,BufRead app/javascript/*.svelte setl path+=app/javascript/,node_modules
   au BufNewFile,BufRead app/javascript/*.svelte setl isfname+=@-@
   au BufNewFile,BufRead app/javascript/*.svelte setl suffixesadd+=.js,.json,.scss,.ts
 augroup END
]], false)

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
