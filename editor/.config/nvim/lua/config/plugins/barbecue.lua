return {
  "utilyre/barbecue.nvim",
  name = "barbecue",
  version = "*",
  dependencies = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("barbecue").setup({
      create_autocmd = false,
      show_modified = true,
      theme = {
        basename = { bold = true, italic = true },
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "Navic Attacher",
      group = vim.api.nvim_create_augroup("barbecue.navic_attacher", {}),
      callback = function(a)
        local client = vim.lsp.get_client_by_id(a.data.client_id)
        if client.server_capabilities["documentSymbolProvider"] then
          require("nvim-navic").attach(client, a.buf)
        end
      end,
    })

    -- This will have better performance when moving the cursor than the default
    -- autocommand, because we're not running it on every CursorMoved event.
    vim.api.nvim_create_autocmd({
      "WinResized",
      "BufWinEnter",
      "CursorHold",
      "InsertLeave",
      "BufModifiedSet",
    }, {
      group = vim.api.nvim_create_augroup("barbecue.updater", {}),
      callback = function()
        require("barbecue.ui").update()
      end,
    })
  end,
}
