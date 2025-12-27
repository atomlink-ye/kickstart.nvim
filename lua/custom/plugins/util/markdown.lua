return {
  "iamcco/markdown-preview.nvim",
  lazy = true,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  ft = { "markdown" },
  keys = {
    { "<leader>OM", "<Cmd>MarkdownPreview<CR>", desc = "[O]pen [M]arkdown Preview" },
  },
  init = function()
    vim.g.mkdp_auto_close = 0
  end,
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
}
