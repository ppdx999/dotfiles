-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.keys.normal_mode["<ESC><ESC>"] = "<CMD>nohlsearch<CR>"
lvim.keys.normal_mode["tt"] = "<CMD>tabnew<CR>"
lvim.keys.normal_mode["t["] = "<CMD>tabprevious<CR>"
lvim.keys.normal_mode["t]"] = "<CMD>tabnext<CR>"
lvim.keys.normal_mode["b["] = "<CMD>bprevious<CR>"
lvim.keys.normal_mode["b]"] = "<CMD>bnext<CR>"
lvim.keys.normal_mode["<leader>v"] = "<CMD>vsplit<CR>"
lvim.keys.normal_mode["<leader>e"] = "<CMD>edit .<CR>"


-- change tab and space display
vim.opt.listchars = { tab = "▸ ", trail = "·", extends = ">", precedes = "<", nbsp = "␣" }
vim.opt.list = true

lvim.colorscheme = 'habamax'

-- close nvimtree when open a file
-- lvim.builtin.nvimtree.setup.actions.open_file.quit_on_open = true

table.insert(lvim.plugins, {
  "zbirenbaum/copilot-cmp",
  event = "InsertEnter",
  dependencies = { "zbirenbaum/copilot.lua" },
  config = function()
    vim.defer_fn(function()
      require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
      require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
    end, 100)
  end,
})
table.insert(lvim.plugins, { "tpope/vim-surround" })

table.insert(lvim.plugins, { "ap/vim-css-color" })
