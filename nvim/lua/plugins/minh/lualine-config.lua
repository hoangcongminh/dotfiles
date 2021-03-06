-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

-- Color table for highlights
local colors = {
  -- bg = '#202328',
  bg = 'none',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

-- Config
local config = {
  options = {
    globalstatus = true,
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } }
    }
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {}
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

-- Inserts a component in lualine_c at left inactive_sections
local function ins_left_inactive_section(component)
  table.insert(config.inactive_sections.lualine_c, component)
end

-- Inserts a component in lualine_c at left inactive_sections
local function ins_right_inactive_section(component)
  table.insert(config.inactive_sections.lualine_x, component)
end

ins_left_inactive_section {
  'filename',
  condition = conditions.buffer_not_empty,
  path = 1,
  color = { fg = colors.magenta, gui = 'bold' }
}

ins_right_inactive_section {
  'o:encoding', -- option component same as &encoding in viml
  upper = true, -- I'm not sure why it's upper case either ;)
  condition = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' }
}

ins_right_inactive_section {
  'fileformat',
  upper = true,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' }
}

ins_left {
  function() return '???' end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  left_padding = 0 -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red
    }
    vim.api.nvim_command(
      'hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. " guibg=" ..
      colors.bg)
    -- return '???'
    return vim.fn.mode()
  end,
  color = "LualineMode",
  left_padding = 0
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  condition = conditions.buffer_not_empty,
  -- path = 1,
  path = 0,
  color = { fg = colors.magenta, gui = 'bold' }
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_lsp' },
  symbols = { error = '??? ', warn = '??? ', info = '??? ' },
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left { function() return '%=' end }

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = '??? LSP:',
  color = { fg = colors.fg, gui = 'bold' }
}

-- Add components to right sections
ins_right { 'lsp_progress', color = { fg = colors.blue, gui = 'bold' } }

ins_right {
  function()
    return vim.g.flutter_tools_decorations.app_version
  end,
  icon = 'version:',
  color = { fg = colors.orange, gui = 'bold' },
}

ins_right {
  'o:encoding', -- option component same as &encoding in viml
  upper = true, -- I'm not sure why it's upper case either ;)
  condition = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' }
}

ins_right {
  'fileformat',
  upper = true,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' }
}

ins_right {
  'branch',
  icon = '???',
  condition = conditions.check_git_workspace,
  color = { fg = colors.violet, gui = 'bold' }
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = '??? ', modified = '??? ', removed = '??? ' },
  color_added = colors.green,
  color_modified = colors.blue,
  color_removed = colors.red,
  condition = conditions.hide_in_width
}

ins_right {
  function() return '???' end,
  color = { fg = colors.blue },
  right_padding = 0
}

-- Now don't forget to initialize lualine
lualine.setup(config)
