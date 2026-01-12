--Neo Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  lazy = true,
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },
  cmd = "Neotree",
  keys = {
    { "\\", "<cmd>Neotree toggle<CR>", { desc = "NeoTree Toggle" } },
  },
  opts = {
    filesystem = {
      enable_refresh_on_write = true,
      use_libuv_file_watcher = true,
      follow_current_file = {
        enabled = false,
        leave_dirs_open = true,
      },
      hijack_netrw_behavior = "open_default",
      filtered_items = {
        always_show = {
          ".vscode",
        },
      },
    },
    default_component_configs = {
      file_size = {
        enabled = false,
      },
      type = {
        enabled = false,
      },
      last_modified = {
        enabled = false,
      },
    },
    window = {
      max_width = { 50, 0.3 },
      width = 28,
      -- auto_expand_width = true,
      mappings = {
        ["<space>"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local relative_path = vim.fn.fnamemodify(path, ":.")
            vim.fn.setreg("+", relative_path, "c")
            vim.notify("Path Copied: " .. relative_path, "info", { title = "NeoTree" })
          end,
          desc = "Copy Realative Path to Clipboard",
        },
        ["<c-Y>"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
            vim.notify("Path Copied: " .. path, "info", { title = "NeoTree" })
          end,
          desc = "Copy Absolute Path to Clipboard",
        },
        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
        ["P"] = { "toggle_preview", config = { use_float = true } },
      },
    },
  },
  -- init = function()
  --   -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
  --   -- because `cwd` is not set up properly.
  --   vim.api.nvim_create_autocmd("BufEnter", {
  --     group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
  --     desc = "Start Neo-tree with directory",
  --     once = true,
  --     callback = function()
  --       if package.loaded["neo-tree"] then
  --         return
  --       else
  --         local stats = vim.uv.fs_stat(vim.fn.argv(0))
  --         if stats and stats.type == "directory" then
  --           require("neo-tree")
  --         end
  --       end
  --     end,
  --   })
  -- end,
}
