local dir = vim.fn.expand("~/.local/state/amane")
local file = dir .. "/nvim-colors.lua"

local function apply()
  local ok, c = pcall(dofile, file)

  if not ok or type(c) ~= "table" then
    return
  end

  local function hl(group, spec)
    vim.api.nvim_set_hl(0, group, spec)
  end

  -- the editor background stays see-through, so the terminal's blur shows
  hl("Normal", { fg = c.text, bg = "NONE" })
  hl("NormalNC", { fg = c.text, bg = "NONE" })
  hl("SignColumn", { bg = "NONE" })
  hl("NormalFloat", { fg = c.text, bg = c.surface })
  hl("FloatBorder", { fg = c.accent, bg = c.surface })
  hl("CursorLine", { bg = c.surface })
  hl("CursorLineNr", { fg = c.accent, bold = true })
  hl("LineNr", { fg = c.muted })
  hl("Visual", { bg = c.hover })
  hl("Search", { fg = c.surface, bg = c.yellow })
  hl("IncSearch", { fg = c.surface, bg = c.accent })
  hl("Pmenu", { fg = c.text, bg = c.surface })
  hl("PmenuSel", { fg = c.text, bg = c.hover })
  hl("WinSeparator", { fg = c.hover })
  hl("StatusLine", { fg = c.text, bg = c.surface })
  hl("StatusLineNC", { fg = c.muted, bg = c.surface })

  local syntax = {
    Comment = { fg = c.muted, italic = true },
    Keyword = { fg = c.accent },
    Statement = { fg = c.accent },
    Function = { fg = c.blue },
    String = { fg = c.green },
    Number = { fg = c.yellow },
    Constant = { fg = c.yellow },
    Type = { fg = c.cyan },
    Identifier = { fg = c.text },
    Operator = { fg = c.text },
    Special = { fg = c.magenta },
    PreProc = { fg = c.magenta },
  }

  for group, spec in pairs(syntax) do
    hl(group, spec)
  end

  local treesitter = {
    ["@comment"] = syntax.Comment,
    ["@keyword"] = syntax.Keyword,
    ["@function"] = syntax.Function,
    ["@function.call"] = syntax.Function,
    ["@string"] = syntax.String,
    ["@number"] = syntax.Number,
    ["@constant"] = syntax.Constant,
    ["@type"] = syntax.Type,
    ["@variable"] = syntax.Identifier,
    ["@property"] = { fg = c.cyan },
    ["@operator"] = syntax.Operator,
  }

  for group, spec in pairs(treesitter) do
    hl(group, spec)
  end
end

apply()

vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, { callback = apply })

-- an open neovim recolors itself when amane writes a new file
local uv = vim.uv or vim.loop
local watcher = uv.new_fs_event()

if watcher then
  watcher:start(dir, {}, vim.schedule_wrap(function(_, name)
    if name == "nvim-colors.lua" then
      apply()
    end
  end))
end
