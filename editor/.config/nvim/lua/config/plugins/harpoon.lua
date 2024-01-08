return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup({
      settings = {
        save_on_toggle = true,
      },
    })

    -- Different ways to open a file
    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "<C-x>", function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "<C-t>", function()
          harpoon.ui:select_menu_item({ tabedit = true })
        end, { buffer = cx.bufnr })
      end,
    })

    -- Telescope integration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new({}, {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table({
            results = file_paths,
          }),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
        })
        :find()
    end

    local function select_item(n)
      return function()
        harpoon:list():select(n)
      end
    end

    local wk = require("which-key")
    wk.register({
      name = "Harpoon",
      prefix = "<leader>h",
      a = {
        function()
          harpoon:list():append()
        end,
        "Append file to list",
      },
      t = {
        function()
          toggle_telescope(harpoon:list())
        end,
        "Open list in telescope",
      },
      h = {
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        "Toggle quick menu",
      },
      p = {
        function()
          harpoon:list():prev()
        end,
        "Toggle previous item",
      },
      n = {
        function()
          harpoon:list():next()
        end,
        "Toggle next item",
      },
      ["1"] = {
        select_item(1),
        "Select item 1",
      },
      ["2"] = {
        select_item(2),
        "Select item 2",
      },
      ["3"] = {
        select_item(3),
        "Select item 3",
      },
      ["4"] = {
        select_item(4),
        "Select item 4",
      },
      ["5"] = {
        select_item(5),
        "Select item 5",
      },
      ["6"] = {
        select_item(6),
        "Select item 6",
      },
      ["7"] = {
        select_item(7),
        "Select item 7",
      },
      ["8"] = {
        select_item(8),
        "Select item 8",
      },
      ["9"] = {
        select_item(9),
        "Select item 9",
      },
    })
  end,
}
