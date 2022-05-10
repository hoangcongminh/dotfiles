local actions = require('telescope.actions')

require('telescope').setup {
  igfile_ignore_patterns = { "node_modules" },
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-l>"] = actions.send_to_loclist,
      },
      n = {
        ["<C-w>"] = actions.send_selected_to_qflist,
        ["<C-q>"] = actions.send_to_qflist,
        ["<C-l>"] = actions.send_to_loclist,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    }
  }
}

local dropdown_theme_string = "require('telescope.themes').get_dropdown({})";

local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

keymap('n', '<space>p', "<cmd>lua require('telescope.builtin').find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", opts)
keymap('n', '<space>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", opts)
keymap('n', '<space>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", opts)
keymap('n', '<space>fo', "<cmd>lua require('telescope.builtin').oldfiles()<cr>", opts)
keymap('n', '<space>qf', "<cmd>lua require('telescope.builtin').quickfix()<cr>", opts)
keymap('n', '<space>fr', "<cmd>lua require('telescope.builtin').resume()<cr>", opts)
keymap('n', '<space>lj', "<cmd>lua require('telescope.builtin').jumplist()<cr>", opts)
keymap('n', '<space>ts', "<cmd>lua require('telescope.builtin').treesitter()<cr>", opts)

keymap('n', '<space>qf', string.format("<cmd>lua require('telescope.builtin').quickfix(%s)<cr>", dropdown_theme_string), opts)

keymap('n', '<space>gr', string.format("<cmd>lua require('telescope.builtin').lsp_references(%s)<cr>", dropdown_theme_string), opts)
keymap('n', '<space>gd', string.format("<cmd>lua require('telescope.builtin').lsp_definitions(%s)<cr>", dropdown_theme_string), opts)
keymap('n', '<space>fd', string.format("<cmd>lua require('telescope.builtin').diagnostics(%s)<cr>", dropdown_theme_string), opts)

-- keymap('n','<space>la',"<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>",opts)
-- keymap('n','<space>lw',"<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>",opts)
-- keymap('n','<space>ld',"<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>",opts)


keymap('n', '<space>t', ":Telescope<cr>", opts)
