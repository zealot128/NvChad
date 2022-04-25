local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      "lua",
   },
   highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
   },
   incremental_selection = {
      enable = true,
   },
   matchup = {
      enable = false,
   },
   context_commentstring = {
     enable = true
   }
}
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.vue.install_info.url = "https://github.com/zealot128/tree-sitter-vue.git"
-- parser_config.vue.install_info.url = "/home/local/PDC01/swi/OpenSource/tree-sitter-vue"
parser_config.pug = {
   install_info = {
      -- url = "https://github.com/zealot128/tree-sitter-pug", -- local path or git repo
      url = "/Users/stefan/LocalProjects/tree-sitter-pug",
      files = { "src/parser.c", "src/scanner.cc" },
   },
   -- filetype = "pug", -- if filetype does not agrees with parser name
   -- used_by = { "vue" }, -- additional filetypes that use this parser
}
