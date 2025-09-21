local default_proxy = vim.g.default_proxy
local function mask_password(url)
  if url == nil then
    return ""
  end
  return string.gsub(url, "(https?://.-:)(.-)(@)", "%1********%3")
end

local function set_proxy()
  vim.env.http_proxy = default_proxy
  vim.env.https_proxy = default_proxy
  vim.env.all_proxy = default_proxy
  vim.notify("Proxy has been set to: " .. mask_password(default_proxy), "info")
end

-- Function to unset proxy
local function unset_proxy()
  vim.env.http_proxy = nil
  vim.env.https_proxy = nil
  vim.env.all_proxy = nil
  vim.notify("Proxy has been unset.", "info")
end

-- Create commands to set and unset proxy
vim.api.nvim_create_user_command("SetProxy", set_proxy, {})
vim.api.nvim_create_user_command("UnsetProxy", unset_proxy, {})

vim.api.nvim_create_augroup("TerminalCommands", { clear = true })

local function activate_conda_env()
  -- local venv = os.getenv("CONDA_DEFAULT_ENV")
  -- local cmd = ""
  -- if venv ~= "base" then
  --   cmd = "conda activate " .. venv
  -- end
  -- -- Get the terminal job ID
  -- local term_job_id = vim.b.terminal_job_id
  -- -- Send the conda activate command to the terminal
  -- if term_job_id then
  --   vim.fn.chansend(term_job_id, cmd)
  -- end
end
vim.api.nvim_create_autocmd("TermOpen", {
  group = "TerminalCommands",
  pattern = "*",
  callback = activate_conda_env,
})

vim.api.nvim_create_user_command("ClearShada", function()
  local shada_path = vim.fn.expand(vim.fn.stdpath("data") .. "/shada")
  local files = vim.fn.glob(shada_path .. "/*", false, true)
  local all_success = 0
  for _, file in ipairs(files) do
    local file_name = vim.fn.fnamemodify(file, ":t")
    if file_name == "main.shada" then
      -- skip your main.shada file
      goto continue
    end
    local success = vim.fn.delete(file)
    all_success = all_success + success
    if success ~= 0 then
      vim.notify("Couldn't delete file '" .. file_name .. "'", vim.log.levels.WARN)
    end
    ::continue::
  end
  if all_success == 0 then
    vim.print("Successfully deleted all temporary shada files")
  end
end, { desc = "Clears all the .tmp shada files" })

function ToggleDiagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end
vim.api.nvim_create_user_command("ToggleDiagnostic", ToggleDiagnostics, {})
