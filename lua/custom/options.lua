local unsynced = require("custom.unsynced")
-- Check if the platform is Windows
if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = "pwsh"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command "
  vim.opt.shellquote = ""
  vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
  vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"
  vim.opt.shellxquote = ""
end

vim.g.default_proxy = unsynced.default_proxy
vim.o.tabstop = 4      -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4   -- Number of spaces inserted when indenting

vim.o.pumwidth = 15
vim.o.conceallevel = 2

-- Set the command-line height to 2 lines (default is 1)
vim.o.cmdheight = 2

-- Set the height of the command-line window when opened with q:
vim.o.cmdwinheight = 10

-- Set autoread
vim.o.autoread = true
vim.opt.swapfile = false
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI", "FocusGained", "BufEnter"}, {
  command = "checktime",
})
