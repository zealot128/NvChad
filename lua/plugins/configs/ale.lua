vim.g.ale_disable_lsp = 1
vim.g.ale_sign_error = '☞ '
vim.g.ale_sign_warning = '☞ '
vim.g.ale_sign_column_always = 1
vim.g.ale_ruby_rubocop_options = '--except Lint/Debugger -D'
vim.g.ale_lint_delay = 1000
vim.g.ale_lint_on_text_changed='normal'
vim.g.ale_fixers = {
  ['javascript'] = { 'prettier', 'eslint' },
  ['ruby'] = { 'rubocop' },
  ['terraform'] = { 'terraform' },
  ['vue'] = { 'eslint', 'prettier' },
  ['dart'] = { 'dartfmt' },
  ['svelte'] = { 'eslint', 'prettier' },
}
vim.g.ale_linters = {
  ['ruby']= { 'brakeman', 'ruby', 'solargraph', 'rubocop' },
  ['terraform']= { 'terraform' },
  ['javascript']= { 'eslint' },
  ['svelte']= { 'eslint', 'prettier' },
  ['vue'] = {},
  ['html']= {}
}
-- vim.api.nvim_set_keymap("n", "<F7>", "<Plug>(ale_fix)", { noremap = true, silent = true })

