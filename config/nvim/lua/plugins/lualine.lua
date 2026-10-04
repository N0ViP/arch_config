return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local cyberpunk = {
      normal = {
        a = { fg = "#090a0f", bg = "#00ffcc", gui = "bold" },
        b = { fg = "#00ffcc", bg = "#1c1e26" },
        c = { fg = "#00ffcc", bg = "NONE" },
      },
      insert = {
        a = { fg = "#090a0f", bg = "#fcee0a", gui = "bold" },
        b = { fg = "#fcee0a", bg = "#1c1e26" },
        c = { fg = "#00ffcc", bg = "NONE" },
      },
      visual = {
        a = { fg = "#ffffff", bg = "#ff00aa", gui = "bold" },
        b = { fg = "#ff00aa", bg = "#1c1e26" },
        c = { fg = "#00ffcc", bg = "NONE" },
      },
      replace = {
        a = { fg = "#ffffff", bg = "#ff0055", gui = "bold" },
        b = { fg = "#ff0055", bg = "#1c1e26" },
        c = { fg = "#00ffcc", bg = "NONE" },
      },
      command = {
        a = { fg = "#090a0f", bg = "#00aaff", gui = "bold" },
        b = { fg = "#00aaff", bg = "#1c1e26" },
        c = { fg = "#00ffcc", bg = "NONE" },
      },
      inactive = {
        a = { fg = "#4e5569", bg = "#12141d" },
        b = { fg = "#4e5569", bg = "#12141d" },
        c = { fg = "#4e5569", bg = "NONE" },
      },
    }

    require("lualine").setup({
      options = {
        theme = cyberpunk,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { "mode", icon = "󰊠" } },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            diff_color = {
              added = { fg = "#00ff99" },
              modified = { fg = "#00aaff" },
              removed = { fg = "#ff0055" },
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true,
            path = 1,
            symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
            diagnostics_color = {
              error = { fg = "#ff0055" },
              warn = { fg = "#fcee0a" },
              info = { fg = "#00ffcc" },
              hint = { fg = "#00ff99" },
            },
          },
          { "encoding" },
          { "filetype", colored = true },
        },
        lualine_y = { { "progress" } },
        lualine_z = { { "location", icon = "" } },
      },
    })
  end,
}
