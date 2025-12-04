-- /------------------------------
-- | Editor
-- -------------------------------/
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.laststatus = 0
vim.opt.cmdheight = 0

if vim.fn.executable("win32yank.exe") == 1 then
	vim.opt.clipboard = 'unnamedplus'
else
	vim.opt.clipboard = 'unnamed'
end

-- Some plugins display signcolumn only when needed
-- that shakes the screen when the signcolumn appears
-- so I always display signcolumn to avoid the shaking
vim.opt.signcolumn = 'yes'

-- /------------------------------
-- | Keymaps
-- -------------------------------/

vim.g.mapleader = ' '
vim.keymap.set('n', '<Esc><Esc>', '<Cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':q<CR>')
vim.keymap.set('n', '<leader>v', ':<C-u>vs<CR>')
vim.keymap.set('n', '<leader>j', ':<C-u>Explore<CR>')
vim.keymap.set('n', '<C-j>', ':bnext<CR>')
vim.keymap.set('n', '<C-k>', ':bprevious<CR>')
vim.keymap.set('n', '[b', ':bprevious<CR>')
vim.keymap.set('n', ']b', ':bnext<CR>')
vim.keymap.set('n', '[c', ':cprevious<CR>')
vim.keymap.set('n', ']c', ':cnext<CR>')
vim.keymap.set('n', 'tt', ':tabnew<CR>')
vim.keymap.set('n', '[t', ':tabprevious<CR>')
vim.keymap.set('n', ']t', ':tabnext<CR>')
vim.keymap.set('t', '<C-w>h', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-w>j', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-w>k', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-w>l', '<C-\\><C-n><C-w>l')


-- /------------------------------
-- | RML
-- -------------------------------/
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.rml",
  callback = function()
    vim.bo.filetype = "xml"
  end,
})

-- /------------------------------
-- | Plugins
-- -------------------------------/

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
-- print(lazypath)
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- /------------------------------
  -- | MISC
  -- -------------------------------/
  {
    'github/copilot.vim',
    config = function()
      -- enable yml because it's not enabled by default
      vim.g.copilot_filetypes = {
        yaml = true,
        markdown = true,
      }
    end
  },
  {
   'tpope/vim-commentary'
  },
  {
    'vim-denops/denops.vim'
  },
  -- /------------------------------
  -- | DDU
  -- -------------------------------/
  {
    'Shougo/ddu.vim',
    dependencies = {
      'vim-denops/denops.vim',
      'Shougo/ddu-ui-ff',
      'Shougo/ddu-kind-file',
      'Shougo/ddu-filter-matcher_substring',
      'Shougo/ddu-source-file_rec',
      'Shougo/ddu-source-file_external',
      'shun/ddu-source-buffer',
      'lambdalisue/mr.vim',
      'kuuote/ddu-source-mr',
      'Shougo/ddu-source-register',
      'shun/ddu-source-rg',
      'kuuote/ddu-source-git_diff',
    },
    config = function()
      vim.fn['ddu#custom#patch_global']({
        ui = 'ff',
        sourceOptions = {
          _ = {
            matchers = {'matcher_substring'},
          },
        },
        kindOptions = {
          file = {
            defaultAction = 'open',
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = 'ddu-ff',
        callback = function()
          vim.keymap.set('n', '<CR>', '<Cmd>call ddu#ui#do_action("itemAction")<CR>', { buffer = true })
          vim.keymap.set('n', 'o', '<Cmd>call ddu#ui#do_action("itemAction", {"name": "open"})<CR>', { buffer = true })
          vim.keymap.set('n', 's', '<Cmd>call ddu#ui#do_action("itemAction", {"name": "open", "params": {"command": "split"}})<CR>', { buffer = true })
          vim.keymap.set('n', 'v', '<Cmd>call ddu#ui#do_action("itemAction", {"name": "open", "params": {"command": "vsplit"}})<CR>', { buffer = true })
          vim.keymap.set('n', 'i', '<Cmd>call ddu#ui#do_action("openFilterWindow")<CR>', { buffer = true })
          vim.keymap.set('n', 'q', '<Cmd>call ddu#ui#do_action("quit")<CR>', { buffer = true })
          vim.keymap.set('n', 'p', '<Cmd>call ddu#ui#do_action("preview")<CR>', { buffer = true })
        end
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = 'ddu-ff-filter',
        callback = function()
          vim.keymap.set('i', '<CR>', '<Esc><Cmd>call ddu#ui#do_action("closeFilterWindow")<CR>', { buffer = true })
        end
      })

      local function launch_ddu_file()
        local git_dir = vim.fn.finddir('.git', '.;')
        if git_dir ~= '' then
          vim.fn['ddu#start']({
            sources = {
              {
                name = 'file_external',
              },
            },
            sourceParams = {
              file_external = {
                cmd = {'git', 'ls-files'},
              },
            },
          })
        else
          vim.fn['ddu#start']({
            sources = {
              {
                name = 'file_rec',
              },
            },
          })
        end
      end

      local function launch_ddu_buffer()
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'buffer',
            },
          },
        })
      end

      local function launch_ddu_mr()
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'mr',
            },
          },
        })
      end

      local function launch_ddu_register()
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'register',
            },
          },
        })
      end

      local function launch_ddu_rg_live()
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'rg',
              options = {
                matchers = {},
                volatile = true,
              },
            },
          },
          uiParams = {
            ff = {
              ignoreEmpty = false,
              autoResize = false,
            },
          },
        })
      end

      local function launch_ddu_git_diff()
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'git_diff',
            },
          },
        })
      end

      local function launch_ddu_git_recent()
        vim.fn['ddu#start']({
          sources = {
            {
              name = 'file_external',
            },
          },
          sourceParams = {
            file_external = {
              cmd = {'git', 'diff', 'HEAD~3..HEAD', '--name-only', '--diff-filter=d'},
            },
          },
        })
      end

      -- vim.keymap.set('n', '<leader>f', launch_ddu_file)
      -- vim.keymap.set('n', '<leader>b', launch_ddu_buffer)
      -- vim.keymap.set('n', '<leader>m', launch_ddu_mr)
      -- vim.keymap.set('n', '<leader>r', launch_ddu_register)
      -- vim.keymap.set('n', '<leader>g', launch_ddu_rg_live)
      -- vim.keymap.set('n', '<leader>d', launch_ddu_git_diff)
      -- vim.keymap.set('n', '<leader>h', launch_ddu_git_recent)
    end
  },
  -- /------------------------------
  -- | LSP
  -- -------------------------------/
  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    opts = {},
		version = '^1.0.0',
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      { "williamboman/mason.nvim", version= '^1.0.0' },
      { "neovim/nvim-lspconfig", version= '^1.0.0' },
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/vim-vsnip" },
    },
		version = '^1.0.0',
    config = function()
      local lspconfig = require("lspconfig")
      require('mason').setup({})

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          }
        end,
        ["elixirls"] = function()
          lspconfig.elixirls.setup {
            cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/elixir-ls") },
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            settings = {
              elixirLS = {
                dialyzerEnabled = false,
                fetchDeps = false,
              }
            }
          }
        end,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          vim.keymap.set('n', 'gh',  '<cmd>lua vim.lsp.buf.hover()<CR>')
          vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>')
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
          vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
          vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
          vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
          vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
          vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
      )

      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        },
      })
    end
  },
  -- /------------------------------
  -- | Filer
  -- -------------------------------/
  -- {
  --   'lambdalisue/fern.vim',
  --   dependencies = {
  --     'lambdalisue/fern-git-status.vim',
  --   },
  --   config = function()
  --     local init_fern = function()
  --       vim.g['fern#default_hidden'] = 1
  --       vim.keymap.set('n', 'D', '<Plug>(fern-action-remove)', {noremap = false, buffer = true})
  --     end

  --     vim.api.nvim_create_autocmd("FileType", {
  --       pattern = 'fern',
  --       callback = init_fern
  --     })

  --     vim.keymap.set('n', '<leader>e', ':<C-u>Fern . -reveal=% -drawer -toggle -width=30<CR>')
  --   end
  -- },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup({
        default_file_explorer = true,
        columns = {
          'icon',
        },
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['l'] = 'actions.select',
          ['<C-v>'] = 'actions.select_vsplit',
          ['<C-s>'] = 'actions.select_split',
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-l>'] = 'actions.refresh',
          ['h'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = 'actions.tcd',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
        },
      })
      vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'Open Oil file explorer' })
    end,
  },
  -- /------------------------------
  -- | Color
  -- -------------------------------/
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      if vim.fn.has('termguicolors') == 1 then
        vim.opt.termguicolors = true
      end

      require('vscode').setup({
        transparent = true,
        italic_comments = true,
        disable_nvimtree_bg = true,
      })

      vim.cmd('colorscheme vscode')
    end
  },
  --- /------------------------------
  --  | Treesitter
  --  -------------------------------/
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
        },
      })
    end
  },
  -- /------------------------------
  -- | git
  -- ------------------------------/
  {
		-- Shows git diff in the sign column
    'airblade/vim-gitgutter',
  },
	{
		'kdheepak/lazygit.nvim',
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
			"nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
			{ "<leader>l", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
	},
  -- /------------------------------
  -- | PlantUML
  -- -------------------------------/
	{
		'aklt/plantuml-syntax'
	},
	{
		'weirongxu/plantuml-previewer.vim'
	},
  -- /------------------------------
  -- | Claude
  -- -------------------------------/
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			terminal = {
				split_width_percentage = 0.2,
			},
		},
		keys = {
			{ "<leader>a", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			-- { "<leader>a", nil, desc = "AI/Claude Code" },
			-- { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			-- { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			-- { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			-- { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			-- { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			-- { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			-- { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			-- {
			-- 	"<leader>as",
			-- 	"<cmd>ClaudeCodeTreeAdd<cr>",
			-- 	desc = "Add file",
			-- 	ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
			-- },
			-- -- Diff management
			-- { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			-- { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
  -- /------------------------------
  -- | MISC
  -- -------------------------------/
	{
		'vim-test/vim-test',
	},
  {
    'tpope/vim-surround',
  },
  {
    'mattn/vim-maketable',
  },
  {
    'findango/vim-mdx',
  },
	{
		'akinsho/toggleterm.nvim', version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<leader>\]],
				direction = 'vertical',
				size = 60,
				transparent = true,
			})
		end
	},
	{
		'tyru/open-browser.vim'
	},
	{
		'djoshea/vim-autoread',
	},
	{
		'ppdx999/vim-report-markup-language'
	},
	{
		'iamcco/markdown-preview.nvim',
	},
	-- /------------------------------
	-- | Dashboard
	-- -------------------------------/
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require('dashboard').setup({
				theme = 'doom',
				config = {
					header = {
						'',
						'',
						'  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
						'  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
						'  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
						'  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
						'  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
						'  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
						'',
						'',
					},
					center = {
						{ icon = '  ', desc = 'Find File', key = 'f', action = 'Telescope find_files' },
						{ icon = '  ', desc = 'Recent Files', key = 'r', action = 'Telescope oldfiles' },
						{ icon = '  ', desc = 'Find Word', key = 'g', action = 'Telescope live_grep' },
						{ icon = '  ', desc = 'Explorer', key = 'e', action = 'Oil' },
						{ icon = '  ', desc = 'New File', key = 'n', action = 'enew' },
						{ icon = '  ', desc = 'Config', key = 'c', action = 'edit ~/.config/nvim/init.lua' },
						{ icon = '  ', desc = 'Quit', key = 'q', action = 'quit' },
					},
					footer = { '', '🚀 Happy Coding!' },
				},
			})
		end,
	},
	-- /------------------------------
	-- | UI Enhancements
	-- -------------------------------/
	{
		'b0o/incline.nvim',
		config = function()
			require('incline').setup()
		end
	},
	{
		'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {},
    keys = {
      { '<leader>-', function()
        vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
      end, desc = 'Toggle tabline' },
    },
    version = '^1.0.0',
  },
	-- /------------------------------
	-- | Telescope
	-- -------------------------------/
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local telescope = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', '<leader>fb', telescope.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = 'Telescope help tags' })
		end,
	},
	-- /------------------------------
	-- | which-key
	-- -------------------------------/
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			local wk = require("which-key")
			wk.setup({})
			wk.add({
				-- 基本操作
				{ "<leader>w", desc = "保存" },
				{ "<leader>q", desc = "閉じる" },
				{ "<leader>v", desc = "縦分割" },
				{ "<leader>j", desc = "ファイラー (Explore)" },
				-- DDU
				-- { "<leader>f", desc = "ファイル検索" },
				-- { "<leader>b", desc = "バッファ一覧" },
				-- { "<leader>m", desc = "最近のファイル" },
				-- { "<leader>r", desc = "レジスタ" },
				-- { "<leader>g", desc = "Grep検索" },
				-- { "<leader>d", desc = "Git差分" },
				-- { "<leader>h", desc = "最近の変更ファイル" },
				-- Telescope
				{ "<leader>ff", desc = "ファイル検索" },
				{ "<leader>fg", desc = "Grep検索" },
				{ "<leader>fb", desc = "バッファ一覧" },
				{ "<leader>fh", desc = "ヘルプタグ検索" },
				-- Fern
				{ "<leader>e", desc = "ファイルツリー" },
				-- Git
				{ "<leader>l", desc = "LazyGit" },
				-- Claude
				{ "<leader>a", desc = "Claude Code" },
				-- UI
				{ "<leader>-", desc = "タブライン切替" },
				-- Terminal
				{ "<leader>\\", desc = "ターミナル切替" },
				-- which-key
				{ "<leader>?", function() require("which-key").show({ global = false }) end, desc = "キーマップ表示" },
			})
		end,
	},
})
