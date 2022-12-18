-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)

	use 'wbthomason/packer.nvim'

	-- notify
	use {
		'rcarriga/nvim-notify'
	}

	--Tmux

	use {
		"aserowy/tmux.nvim",
	}

	-- Terminal
	use {
		"akinsho/toggleterm.nvim", tag = '*'
	}

	-- own register telescope picker
	use 'git@gitlab.com:fesociety/coll_picker.git'
	-- pres in (n)vim
	use 'sotte/presenting.vim'

	--Colors
	use { 'norcalli/nvim-colorizer.lua' }

	use { 
		"anuvyklack/windows.nvim",
		requires = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim"
		},
	}
	use 'xorid/swap-split.nvim'

	-- Icons
	use {
		'nvim-lualine/lualine.nvim',
		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use 'nvim-tree/nvim-web-devicons'

	-- AutoPair
	use 'windwp/nvim-autopairs'  --add the lua require

	-- keymap autocmd
	use({ 'mrjones2014/legendary.nvim' })
	use { "folke/which-key.nvim" }

	-- Theme
	use {'ellisonleao/gruvbox.nvim'}

	use {
		'mechatroner/rainbow_csv',
		ft = 'csv'
	}

	use ({
		'hrsh7th/nvim-cmp',
		{'hrsh7th/cmp-nvim-lsp', requires = { 'neovim/nvim-lspconfig' }},
		{'hrsh7th/cmp-nvim-lsp-signature-help', requires = { 'neovim/nvim-lspconfig' }},
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lua',
		'ray-x/cmp-treesitter',
		'hrsh7th/cmp-cmdline',
	})

	use {
		'numToStr/Comment.nvim'
	}


	--indent line lua
	use 'lukas-reineke/indent-blankline.nvim'


	use { 'git@github.com:lagachea/norme.nvim.git' }
	-- null ls

	-- lsp support Mason
	use {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",
	}

	use {
		"mfussenegger/nvim-dap",
		"jayp0521/mason-nvim-dap.nvim",
	}
	use { 'nvim-telescope/telescope-dap.nvim'}
	use {'theHamsta/nvim-dap-virtual-text'}
	use { 'jbyuki/one-small-step-for-vimkind'}
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

	use {
		'jose-elias-alvarez/nvim-lsp-ts-utils',
	}

	-- Telescope extension
	use { "nvim-telescope/telescope-file-browser.nvim" }
	use { "nvim-telescope/telescope-fzy-native.nvim" }
	use { "nvim-telescope/telescope-media-files.nvim" }
	use {'nvim-telescope/telescope-ui-select.nvim' }
	use {'LukasPietzschmann/telescope-tabs' }

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = {{ 'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'} }
	}

	-- Git
	use {
		'TimUntersberger/neogit',
		requires = { 'sindrets/diffview.nvim', requires = {'nvim-lua/plenary.nvim'} }
	}

	use {
		'lewis6991/gitsigns.nvim',
	}

	use { 'sindrets/diffview.nvim', requires = {{'nvim-tree/nvim-web-devicons'},{'nvim-lua/plenary.nvim'}} }
	-- Cheat Sheet
	use 'RishabhRD/popfix'
	use 'RishabhRD/nvim-cheat.sh'

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
		  pcall(require('nvim-treesitter.install').update { with_sync = true })
		end
	}


	use {
		'nvim-treesitter/playground',
		-- after = 'nvim-treesitter'
		requires = {"nvim-treesitter/nvim-treesitter"}
	}

	use {
		'JoosepAlviste/nvim-ts-context-commentstring',
		-- after = 'nvim-treesitter'
		requires = {"nvim-treesitter/nvim-treesitter"}
	}

	-- Bracket
	use {
		'p00f/nvim-ts-rainbow',
		after = 'nvim-treesitter'
	}

	use {
		'nvim-treesitter/nvim-treesitter-angular',
		after = 'nvim-treesitter'
	}

	use {
		'windwp/nvim-ts-autotag',
		after = 'nvim-treesitter'
	}

	--Refactor
	use {
		'nvim-treesitter/nvim-treesitter-refactor',
		after = 'nvim-treesitter'
	}

	--Refactor Primegean
	use {
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{"nvim-lua/plenary.nvim"},
			{"nvim-treesitter/nvim-treesitter"}
		}
	}


    if is_bootstrap then
        require('packer').sync()
    end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

function prequire(req_name)
	local status, required = pcall(require, req_name)
	if not status then
		vim.notify("Failed to load " .. req_name)
	end
	return status, required
end

function bufmap(...)
    vim.api.nvim_buf_set_keymap(0, ...)
end

function map(...)
    vim.api.nvim_set_keymap(...)
end

function unmap(...)
	vim.api.nvim_del_keymap(...)
end

function create_command(...)
	vim.api.nvim_create_user_command(...)
end

function getPathOfCurrentFile()
	return vim.fn.expand("%:p:h")
end

local options = {
    termguicolors = true,
    mouse = "a",
    syntax = "on",
    autoindent = true,
    swapfile = false,
    ruler = true,
    number = true,
    relativenumber = true,
    cursorline = true,
    hlsearch = false,
    incsearch = true,
    smartcase = true,
    hidden = true,
    path = ".,./**",
    wrap = false,
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
    expandtab = false,
    wildmenu = true,
    wildmenu = true,
    wildmode = {"longest","list","full" },
    showtabline = 2,
    equalalways = true,
    splitright = true,
    splitbelow = true,
    eadirection = "both",
    scrolloff = 3,
    sidescrolloff = 5,
    foldenable = true,
    foldlevelstart = 9,
    foldmethod = "manual",
    winbar = "%t %m #%n %y", -- [[ filename, state, bufNbr, cursor pos in % of file ]] I want to add a command to query timestamp
    showcmd = true,
    cmdheight = 1,
    -- spell = true,
    updatetime = 50,
    --textwidth = 80,
    colorcolumn = "80",
    background = "dark",
    ls = 3,
    timeoutlen = 300,
}

vim.opt.shortmess:append "c"
vim.g.mapleader = " "
vim.g.presenting_top_margin = 2
vim.b.presenting_slide_separator = '----'

for k, v in pairs(options) do
  vim.opt[k] = v
end

--hightline line longer than 80 chars
vim.cmd [[
call matchadd('ColorColumn', '\%80v', 100)
]]

local has_notify, notify = prequire("notify")

if has_notify then
	notify.setup({
		background_colour = "#000000",
	})
	vim.notify = notify
end

local hastelescope, telescope = prequire('telescope')
local hasactions, actions = prequire('telescope.actions')
local hasthemes, themes = prequire('telescope.themes')
local hasbuiltin, builtin = prequire('telescope.builtin')
local haspreviewers, previewers = prequire('telescope.previewers')
local hassorters, sorters = prequire('telescope.sorters')

if not hastelescope or not hasactions or not hasbuiltin or not haspreviewers or not hassorters then
	return false
end
telescope.setup{
	defaults = {

		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},

		prompt_prefix = "$>",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "bottom_pane",
		layout_config = {
			height = {
				padding = 0
			},
			width = {
				padding = 0
			}
		},
		prompt_position = "top",
		border = false,
		winblend = 0,
		color_devicons = true,
		use_less = true,
		set_env = {['COLORTERM'] = 'truecolor' },

		file_ignore_patterns = { "node_modules/", ".git/", ".mypy_cache/"},
		file_sorter =  sorters.get_fzy_sorter,
		generic_sorter =  sorters.get_fzy_sorter,

		file_previewer = previewers.vim_buffer_cat.new,
		grep_previewer = previewers.vim_buffer_vimgrep.new,
		qflist_previewer = previewers.vim_buffer_qflist.new,

		mappings = {
			n = {
			},
			i = {
				['<c-s>'] = actions.select_horizontal,
				['<c-k>'] = actions.move_selection_previous,
				['<c-j>'] = actions.move_selection_next,
				['<c-space>'] = actions.toggle_selection + actions.move_selection_next
			}
		},

		cache_picker = {
			num_pickers = -1,
			limit_entries = 1000
		}
	},
	pickers = {
		keymaps = {
			mappings = {
				n = {
				},
				i = {
					['<c-s>'] = actions.select_horizontal,
					['<c-k>'] = actions.move_selection_previous,
					['<c-j>'] = actions.move_selection_next,
					-- ['<c-e>'] = actions.toggle_selection,
					-- ['<CR>'] = actions.select_default,
					['<CR>'] = actions.file_edit,
				}
			},
		},
		current_buffer_fuzzy_find = {
			skip_empty_lines = true
		},
		man_pages = {
			sections = {"ALL"}
		},
		find_files = {
			hidden = true
		},
		git_files = {
			show_untracked = true,
		}
	},
	extensions = {
		media_files = {
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = {"png", "webp", "jpg", "jpeg"},
			find_cmd = "rg" -- find command (defaults to `fd`)
		},
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		file_browser = {
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			cwd_to_path = true,
		},
		coll_picker = {},
	}
}

telescope.load_extension('fzy_native')
telescope.load_extension('file_browser')
telescope.load_extension('media_files')
telescope.load_extension('dap')
telescope.load_extension('coll_picker')
telescope.load_extension('ui-select')
telescope.load_extension('telescope-tabs')
telescope.load_extension('notify')

local M = {}

M.angular = function()
    local path = getPathOfCurrentFile()
    local default_text = vim.fn.expand("%:t:r")

    local opts = {}
    opts.prompt_title = "angular"
    opts.cwd = path
    opts.default_text = default_text

    builtin.find_files(opts)
end

M.search_dotfiles = function()
    local opts = {}
    opts.prompt_title = "< DOTFILES >"
    opts.cwd = "~/config/dotfiles/"

    builtin.git_files(opts)
end

M.search_config = function()
    local opts = {}
    opts.prompt_title = "< CONFIG >"
    opts.cwd = "~/config"

    builtin.git_files(opts)
end

M.file_browser = function()
    local opts = {
		cwd = getPathOfCurrentFile()
	}
    telescope.extensions.file_browser.file_browser(opts)
end

M.git_branches = function()
    local opts = {
		cwd = getPathOfCurrentFile()
	}
    builtin.git_branches(opts)
end
M.git_status = function()
    local opts = {
		cwd = getPathOfCurrentFile()
	}
    builtin.git_status(opts)
end
M.git_files = function()
    local opts = {
		cwd = getPathOfCurrentFile()
	}
    builtin.git_files(opts)
end

M.picker_name= function()
    local opts = {
		use_register_content = true
	}
    require("telescope").extensions.coll_picker.picker_name(opts)
end

M.live_grep = function(mode)
    local opts = {}
	if mode == "v" then
		local text = vim.fn.getreg('0')
		opts.default_text = text
	end
    builtin.live_grep(opts)
end

local telescopts = {
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
}

local telescopemaps = {
	itemgroup = 'telescope',
	description = 'telescope mappings',
	keymaps = {
		{ '<leader>reg', '<cmd>lua require("plugins.telescop_setvp").picker_name()<cr>', description = 'telescope register', opts = telescopts},
		{ '<leader>rg', '<cmd>lua require("plugins.telescop_setvp").live_grep("n")<cr>', description = 'telescope live_grep', opts = telescopts},
		{ '<leader>dot', '<cmd>lua require("plugins.telescop_setvp").search_dotfiles()<cr>', description = 'dotfiles' , opts = telescopts},
		{ '<leader>cfg', '<cmd>lua require("plugins.telescop_setvp").search_config()<cr>', description = 'config' , opts = telescopts},
		{ '<leader>cd', '<cmd>lua require("plugins.telescop_setvp").file_browser()<cr>', description = 'file browser', opts = telescopts},
		{ '<leader>ang', '<cmd>lua require("plugins.telescop_setvp").angular()<cr>', description = 'telescope angular' , opts = telescopts},
		{ '<leader>gb', '<cmd>lua require("plugins.telescop_setvp").git_branches()<cr>', description = 'git banches', opts = telescopts},
		{ '<leader>ggs', '<cmd>lua require("plugins.telescop_setvp").git_status()<cr>', description = 'git git statuses', opts = telescopts},
		{ '<C-f>', '<cmd>lua require("telescope.builtin").find_files()<cr>', description = 'find files', opts = telescopts},
		{ '<C-g>', '<cmd>lua require("plugins.telescop_setvp").git_files()<cr>', description = 'git files', opts = telescopts},
		{ '<leader>man', '<cmd>lua require("telescope.builtin").man_pages()<cr>', description = 'man pages', opts = telescopts},
		{ '<leader>ff', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>', description = 'buffer fuzzy', opts = telescopts},
		{ '<leader>btn', '<cmd>lua require("telescope.builtin").builtin()<cr>', description = 'telescope builtins' , opts = telescopts},
		{ '<leader>pks', '<cmd>lua require("telescope.builtin").pickers()<cr>', description = 'telescope pickers' , opts = telescopts},
		{ '<leader>rsm', '<cmd>lua require("telescope.builtin").resume()<cr>', description = 'telescope resume' , opts = telescopts},
		{ '<leader>mf', '<cmd>lua require("telescope").extensions.media_files.media_files()<cr>', description = 'media files', opts = telescopts},
		{ '<leader>not', '<cmd>lua require("telescope").extensions.notify.notify()<cr>', description = 'notifications', opts = telescopts},
		{ '<leader>tab', '<cmd>lua require("telescope-tabs").list_tabs()<cr>', description = 'open tabs', opts = telescopts},
		{ '<leader>*', '<cmd>lua require("telescope.builtin").grep_string()<cr>', description = 'grep cword', opts = telescopts},
		{ '<leader>bu', '<cmd>lua require("telescope.builtin").buffers()<cr>', description = 'open buffers', opts = telescopts},
		{ '<leader>of', '<cmd>lua require("telescope.builtin").oldfiles()<cr>', description = 'oldfiles', opts = telescopts},
		{ '<leader>cmd', '<cmd>lua require("telescope.builtin").commands()<cr>', description = 'commands', opts = telescopts},
		{ '<leader>his', '<cmd>lua require("telescope.builtin").command_history()<cr>', description = 'commands history', opts = telescopts},
		{ '<leader>gh', '<cmd>lua require("telescope.builtin").help_tags()<cr>', description = 'help tags', opts = telescopts},
		{ '<leader>qf', '<cmd>lua require("telescope.builtin").quickfix()<cr>', description = 'quickfix', opts = telescopts},
		{ '<leader>qlh', '<cmd>lua require("telescope.builtin").quickfixhistory()<cr>', description = 'quickfixhistory', opts = telescopts},
		{ '<leader>ll', '<cmd>lua require("telescope.builtin").loclist()<cr>', description = 'location list', opts = telescopts},
		{ '<leader>ftp', '<cmd>lua require("telescope.builtin").filetypes()<cr>', description = 'filetypes', opts = telescopts},
		{ '<leader>sp', '<cmd>lua require("telescope.builtin").spell_suggest()<cr>', description = 'spell suggest', opts = telescopts},
		-- Visual Mode
		{ '<leader>vg', 'y<cmd>lua require("plugins.telescop_setvp").live_grep("v")<cr>', description = 'grep visual selection', mode = { 'v'}, opts = telescopts},
		-- Insert Mode
		{ '<c-r>', '<cmd>lua require("plugins.telescop_setvp").picker_name()<cr>', description = 'registers', mode = { 'i'}, opts = telescopts},
	}
}
local mapper = require"legendary"
mapper.keymaps(telescopemaps)

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true
})

local dap = require'dap'
local mapper = require'legendary'


local addConditionalBreakPoint = function()
	local condition = vim.fn.input('Breakpoint condition: ')
	require'dap'.toggle_breakpoint(condition)
end
create_command("AddConditionalBreakPoint", addConditionalBreakPoint, {})

-- Mappings
local keymaps = {
	itemgroup = 'dap',
	description = 'debugger mappings',
	keymaps = {
		{ '<F2>', "<cmd>lua require'osv'.launch()<CR>", description = 'osv launch'},
		{ '<F3>', "<cmd>lua require'osv'.run_this()<CR>", description = 'osv run this'},
		{ '<F5>', "<cmd>lua require'dap'.continue()<CR>", description = 'dap continue'},
		{ '<F6>', "<cmd>lua require('dapui').toggle()<CR>", description = 'toogle dap ui'},
		{ '<F7>', "<cmd>lua require'dap'.step_over()<CR>", description = 'dap step over'},
		{ '<F8>', "<cmd>lua require'dap'.step_into()<CR>", description = 'dap step into'},
		{ '<F9>', "<cmd>lua require'dap'.step_out()<CR>", description = 'dap step out'},
		{ '<leader>dtb', '<cmd>AddConditionalBreakPoint<cr>', description = 'dap toggle breakpoint'},
		{ '<leader>dcmd', '<cmd>lua require"telescope".extensions.dap.commands()<cr>', description = 'show dap commands'},
		{ '<leader>dcfg', '<cmd>lua require"telescope".extensions.dap.configurations()<cr>', description = 'show dap configurations'}
	}
}
mapper.keymaps(keymaps)

-- plugins
-- UI
require("dapui").setup({
	layouts = {
		{
			elements = {
				"stacks",
				"scopes",
				"breakpoints",
			},
			size = 0.20,
			position = "left",
		},
		{
			elements = {
				"repl",
				"watches",
			},
			size = 0.33, -- 25% of total lines
			position = "bottom",
		},
	},
})

-- debug text
require("nvim-dap-virtual-text").setup {
	enabled = true,                        -- enable this plugin (the default)
	enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
	highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
	highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
	show_stop_reason = true,               -- show stop reason when stopped for exceptions
	commented = false,                     -- prefix virtual text with comment string
	only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
	-- all_references = true,                -- show virtual text on all all references of the variable (not only definitions)
	virt_text_win_col = 80                -- position the virtual text at a fixed window column (starting from the first text column) ,
	-- filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
	-- experimental features:
	-- virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
	-- all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
	-- virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
	--                                        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}


-- Configurations + Adapters

-- Utils get args
local getArgs = function()
	local args_string = vim.fn.input('Arguments: ')
	return vim.split(args_string, " +")
end

-- Python
dap.adapters.python = {
	type = "executable",
	command = 'debugpy-adapter'
}

dap.configurations.python = {
	{
		type = 'python',
		request = 'launch',
		name = 'Launch file with arguments',
		program = '${file}',
		args = getArgs,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}", -- This configuration will launch the current file if used.
	},
}

-- nlua
dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = "Attach to running Neovim instance",
  }
}

dap.adapters.nlua = function(callback, config)
    callback({ type = 'server', host = config.host, port = config.port })
end

-- C.
dap.adapters.lldb = {
	-- type = 'executable',
	-- command = 'codelldb', -- adjust as needed, must be absolute path
	name = 'lldb',
	type = 'server',
	port = "1234",
	executable = {
		command = 'codelldb',
		args = { "--port", "1234" },
	}
}

dap.configurations.c = {
  {
    name = 'Launch with arguments',
    type = 'lldb',
    request = 'launch',

    args = getArgs,

    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,

    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  }
}
dap.configurations.cpp = dap.configurations.c
dap.configurations.rust = dap.configurations.c


-- Mason
require("mason-nvim-dap").setup({
	automatic_installation = true,
})

-- Custom function attached to server
local nvim_lsp = require'lspconfig'
local mapper = require"legendary"

vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		spacing = 2,
		prefix = '',
	},
	float = {
		-- source = "if_many"
		source = "always"
	},
	severity_sort = true,
	update_in_insert = true,
	signs = true,
	underline = true,
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.offsetEncoding = { "utf-16" }


local custom_on_attach = function(_, bufnr)
	local bufopts = { noremap=true, silent=true, buffer = bufnr}
	
	local keymaps =  {
		{
			itemgroup = 'lsp',
			description = 'lsp',
			keymaps = { 
				{'<leader>rn', "<cmd>lua vim.lsp.buf.rename()<CR>", opts = bufopts, description = 'rename symbol'},
				{'<leader>ds', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts = bufopts, description = 'document symbols'},
				{'<leader>fd', "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts = bufopts, description = 'document diagnostics'},
				{'<leader>dsl', "<cmd>lua vim.diagnostic.setqflist()<CR>", opts = bufopts, description = 'add err to location list'},
				{'<leader>ld', "<cmd>lua vim.diagnostic.open_float()<CR>", opts = bufopts, description = 'line diagnostics'},
				{'<leader>pe', "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts = bufopts, description = 'previous error'},
				{'<leader>ne', "<cmd>lua vim.diagnostic.goto_next()<CR>", opts = bufopts, description = 'next error'},
				{"<leader>hov", "<cmd>lua vim.lsp.buf.hover()<CR>", opts = bufopts, description = 'hover'},
				{'<leader>shp', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts = bufopts, description = 'signature help'},
				{'<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts = bufopts, description = 'code actions'},
				{'<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts = bufopts, description = 'code actions', mode = { 'v'}},
				{"<leader>fmt", "<cmd>lua vim.lsp.buf.format({async = true})<CR>", opts = bufopts, description = 'format'},
				{'<leader>gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts = bufopts, description = 'references'},
				{'<leader>gc', "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<CR>", opts = bufopts, description = 'incoming_calls'},
				{'<leader>gi',  "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts = bufopts, description = 'implementations'},
				{'<leader>gd',  "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts = bufopts, description = 'definitions'},
				{'<leader>gtd', "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts = bufopts, description = 'type definitions'},
				-- {'<leader><C-p>', "<cmd>lua require('telescope.builtin').lsp_outgoing_calls()<CR>", opts = bufopts, description = 'outgoing_calls'},
				-- gci gco
			}
		}
	}
	mapper.keymaps(keymaps)
end

local typescript_on_attach = function(client, bufnr)
	local ts_utils = require("nvim-lsp-ts-utils")
	ts_utils.setup({})
	ts_utils.setup_client(client)

	local bufopts = { noremap=true, silent=true, buffer = bufnr}
	local typescript_keymaps = {
		itemgroup = 'lsp',
		description = 'lsp',
		keymaps = {
			{"<leader>org", ":TSLspOrganize<CR>", description = 'angular organize imports', opts = bufopts},
			{"<leader>frn", ":TSLspRenameFile<CR>", description = 'angular rename file', opts = bufopts},
		}
	}
	mapper.keymaps(typescript_keymaps)

	custom_on_attach(client, bufnr)
end

local angular_on_attach = function(client, bufnr)
	client.server_capabilities.rename = false
	custom_on_attach(client, bufnr)
end


-- SERVER REGISTER AND LOAD
local servers = {'clangd', 'pyright', 'jsonls'} 
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
    }
end

nvim_lsp['tsserver'].setup {
    on_attach = typescript_on_attach,
    capabilities = capabilities
}

nvim_lsp['angularls'].setup{
    on_attach = angular_on_attach,
    filetypes = { "typescript", "html", "css" },
    root_dir = nvim_lsp.util.root_pattern('angular.json','.git'),
    capabilities = capabilities
}

nvim_lsp['cssls'].setup {
    filetypes = { "css", "scss", "less" },
    settings = {
        css = {
            validate = true
        },
        less = {
            validate = true
        },
        scss = {
            validate = true
        }
    },
    on_attach = custom_on_attach,
    capabilities = capabilities
}

nvim_lsp['html'].setup {
    init_options = {
        -- configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        }
    },
    on_attach = custom_on_attach,
    capabilities = capabilities
}


nvim_lsp['omnisharp'].setup {
    on_attach = custom_on_attach,
    capabilities = capabilities,
    cmd = { "omnisharp" },
}

local null_ls = require('null-ls')
local norme = require('norme')

null_ls.setup({
    sources = {
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.code_actions.gitsigns,
		-- null_ls.builtins.diagnostics.gitlint,
		-- null_ls.builtins.diagnostics.codespell,
		null_ls.builtins.diagnostics.clang_check,
		norme.diagnostics.with({
			command = 'norminette',
		}),
		null_ls.builtins.completion.tags,
		null_ls.builtins.completion.spell
    },
	-- on_attach = function(client, bufnr)
	-- end
})

require("mason-null-ls").setup({
	automatic_installation = true,
})

vim.g.cheat_default_window_layout ='split'

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require 'nvim-treesitter.configs'.setup {

    ensure_installed = { "c", "bash", "typescript", "html", "css", "python", "lua", "c_sharp", "json"},

    highlight = {
        enable = true,
    },
    rainbow = {
        enable = true
    },
    indent = {
        enable = false
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            node_incremental = "<leader>k",
            node_decremental = "<leader>j",
            scope_incremental = "<leader>h",
        },
    },
    autotag = {
        enable = true,
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false
    },
    refactor = {
        highlight_definitions = { enable = true },
        highlight_current_scope = { enable = false },
        smart_rename = {
            enable = true,
            keymaps = {
                smart_rename = "<leader>rn",
            },
        },
        navigation = {
            enable = true,
            keymaps = {
                goto_definition_lsp_fallback = "<leader>gd",
            },
        },
    },

}



local Mod = {}

local tbl = {}

function tbl.contains(_tbl, value)
  for _, current in pairs(_tbl) do
    if current == value then
      return true
    end
  end

  return false
end

function Mod.directives()
  local function is_one_line(range)
    return range[1] == range[3]
  end

  local function is_range_empty_or_invalid(range)
    if range[3] < range[1] or (is_one_line(range) and range[4] <= range[2]) then
      return true
    end

    return false
  end

  local function make_subranges_between_children_like(node, predicate)
    local content = { { node:range() } }

    for child in node:iter_children() do
      if predicate(child) then
        local child_range = { child:range() }
        local last_content_range = content[#content]
        local first_part = {
          last_content_range[1],
          last_content_range[2],
          child_range[1],
          child_range[2],
        }
        local second_part = {
          child_range[3],
          child_range[4],
          last_content_range[3],
          last_content_range[4],
        }
        if is_range_empty_or_invalid(first_part) then
          if not is_range_empty_or_invalid(second_part) then
            content[#content] = second_part
          end
        elseif is_range_empty_or_invalid(second_part) then
          content[#content] = first_part
        else
          content[#content] = first_part
          content[#content + 1] = second_part
        end
      end
    end

    return content
  end

  local directives = vim.treesitter.query.list_directives()
  if not tbl.contains(directives, "inject_without_named_children!") then
    vim.treesitter.query.add_directive(
      "inject_without_named_children!",
      function(
        match,
        _, --[[ pattern ]]
        _, --[[ bufnr ]]
        predicate,
        metadata
      )
        local node = match[predicate[2]]
        metadata.content = make_subranges_between_children_like(
          node,
          function(child)
            return child:named()
          end
        )
      end
    )
  end

  if not tbl.contains(directives, "inject_without_children!") then
    vim.treesitter.query.add_directive("inject_without_children!", function(
      match,
      _, --[[ pattern ]]
      _, --[[ bufnr ]]
      predicate,
      metadata
    )
      local node = match[predicate[2]]
      metadata.content = make_subranges_between_children_like(node, function(_)
        return true
      end)
    end)
  end
end

require('lualine').setup{
    options = {
        theme = 'gruvbox',
        section_separators = {'', ''},
        component_separators = {'|', '|'},
        icons_enabled = true,
        globalstatus = true,
    },
    sections = {
        lualine_a = { {'mode', upper = true} },
        lualine_b = { {'branch', icon = ''} },
        lualine_c = { {'filename', file_status = true} },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location'  },
    },
    inactive_sections = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {   }
    },
    extensions = { 'fzf' }
}

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
    formatting = {
        format = function(entry, vim_item)
            -- set a name for each source
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[Lua]",
                treesitter = "[Treesitter]",
                path = "[Path]",
                calc = "[Calc]",
            })[entry.source.name]
            return vim_item
        end,
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert({
		-- ['<C-e>'] = cmp.mapping.abort(),
		['<C-e>'] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		['<CR>'] = cmp.mapping.confirm(),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		-- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
		-- ['<C-f>'] = cmp.mapping.scroll_docs(4),
	}),
    sources = cmp.config.sources({
		-- { name = 'luasnip' },
		{ name = 'treesitter', max_item_count = 7  },
		{ name = 'path', max_item_count = 5},
		{ name = 'buffer', keyword_length = 4, max_item_count = 5 },
	}),
	performance = {
	}
})


local filetypes = {'c', 'cpp', 'ts', 'html', 'css', 'json', 'python', 'cs'} 
for _, ft in ipairs(filetypes) do
	cmp.setup.filetype(ft, {
		sources = cmp.config.sources({
			{ name = 'nvim_lsp_signature_help', max_item_count = 15 },
			{ name = 'nvim_lsp', max_item_count = 10 },
			{ name = 'treesitter', max_item_count = 7  },
			{ name = 'path', max_item_count = 5},
			{ name = 'buffer', keyword_length = 4, max_item_count = 5 },
		})
	})
end
  -- Set configuration for specific filetype.
cmp.setup.filetype('lua', {
  sources = cmp.config.sources({
		{ name = 'nvim_lua', max_item_count = 10 },
		{ name = 'treesitter', max_item_count = 7  },
		{ name = 'path', max_item_count = 5},
		{ name = 'buffer', keyword_length = 4, max_item_count = 5 },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'buffer', keyword_length = 2 },
    },
    {
        { name = 'treesitter', max_item_count = 7  }
    })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
			{name = 'cmdline', max_item_count = 7, keyword_pattern = [=[[^!]+]=], keyword_length = 3 }
		},{
			{ name = 'path' }, 
		})
    }
)
cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
			{name = 'cmdline', max_item_count = 7, keyword_pattern = [[\!\@<!\w*]]}
		},{
			{ name = 'path' }, 
		})
    }
)

-- The Primegean is awesome
local refactoring = require("refactoring")
refactoring.setup()

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" },
})

require("cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = false, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = false,  -- auto select first item
  map_char = { -- modifies the function or method delimiter by filetypes
    all = {'(','{','['},
  }
})

require("tmux").setup({
    copy_sync = {
        -- enables copy sync. by default, all registers are synchronized.
        -- to control which registers are synced, see the `sync_*` options.
        enable = true,

        -- ignore specific tmux buffers e.g. buffer0 = true to ignore the
        -- first buffer or named_buffer_name = true to ignore a named tmux
        -- buffer with name named_buffer_name :)
        ignore_buffers = { empty = false },

        -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
        -- clipboard by tmux
        redirect_to_clipboard = true,

        -- offset controls where register sync starts
        -- e.g. offset 2 lets registers 0 and 1 untouched
        register_offset = 0,

        -- overwrites vim.g.clipboard to redirect * and + to the system
        -- clipboard using tmux. If you sync your system clipboard without tmux,
        -- disable this option!
        sync_clipboard = true,

        -- synchronizes registers *, +, unnamed, and 0 till 9 with tmux buffers.
        sync_registers = true,

        -- syncs deletes with tmux clipboard as well, it is adviced to
        -- do so. Nvim does not allow syncing registers 0 and 1 without
        -- overwriting the unnamed register. Thus, ddp would not be possible.
        sync_deletes = true,

        -- syncs the unnamed register with the first buffer entry from tmux.
        sync_unnamed = true,
    },
    navigation = {
        -- cycles to opposite pane while navigating into the border
        cycle_navigation = true,

        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = true,

        -- prevents unzoom tmux when navigating beyond vim border
        persist_zoom = false,
    },
    resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = true,

        -- sets resize steps for x axis
        resize_step_x = 2,

        -- sets resize steps for y axis
        resize_step_y = 2,
    }
})

require'colorizer'.setup()

vim.o.winwidth = 2
vim.o.winminwidth = 2
vim.o.equalalways = false

local hasWindows, windows = prequire("windows")

local opts = {
   autowidth = {			--		     |windows.autowidth|
      enable = true,
      winwidth = 2,			--		      |windows.winwidth|
      filetype = {			--	    |windows.autowidth.filetype|
         help = 2,
      },
   },
   ignore = {				--			|windows.ignore|
      buftype = { "quickfix" },
      filetype = { "NvimTree", "neo-tree", "undotree", "gundo" }
   },
   animation = {
      enable = false,
      duration = 100,
      fps = 60,
      easing = "in_out_sine"
   }
}
windows.setup(opts)

-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"
--
-- require("indent_blankline").setup {
--     space_char_blankline = " ",
--     show_current_context = true,
--     show_current_context_start = true,
-- }
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent1 guibg=#282828 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineIndent2 guibg=#3c3836 gui=nocombine]]

require("indent_blankline").setup {
    show_trailing_blankline_indent = false,
	use_treesitter = true,
    show_current_context = true,
    char = "",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
    space_char = "",
    space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
    },
}

local presets = require("which-key.plugins.presets")
presets.operators["v"] = nil

local options = {
  plugins = {
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    marks = true, -- shows a list of your marks on ' and `
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  --[[ operators = { gc = "Comments" }, ]]
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}
require("which-key").setup(options)

local hasneogit, neogit = prequire("neogit")

if not hasneogit then
	return false
end
neogit.setup {
  disable_signs = false,
  disable_hint = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size. 
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = false,
  disable_builtin_notifications = false,
  use_magit_keybindings = false,
  -- Change the default way of opening neogit
  kind = "tab",
  -- Change the default way of opening the commit popup
  commit_popup = {
    kind = "split",
  },
  -- Change the default way of opening popups
  popup = {
    kind = "split",
  },
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = { ">", "v" },
    item = { ">>", "vv" },
    hunk = { "", "" },
  },
  integrations = {
    diffview = true  
  },
  -- Setting any section to `false` will make the section not render at all
  sections = {
    untracked = {
      folded = false
    },
    unstaged = {
      folded = false
    },
    staged = {
      folded = false
    },
    stashes = {
      folded = true
    },
    unpulled = {
      folded = true
    },
    unmerged = {
      folded = false
    },
    recent = {
      folded = true
    },
  },
  -- override/add mappings
  mappings = {
    -- modify status buffer mappings
    status = {
      -- Adds a mapping with "B" as key that does the "BranchPopup" command
      -- ["B"] = "BranchPopup",
      -- Removes the default mapping of "s"
      -- ["s"] = "",
    }
  }
}
local hasdv, diffview = prequire("diffview")

if hasdv then
	diffview.setup({
		use_icons = false
	})
end
require'nvim-web-devicons'.setup({
    default = true;
})

local mapper = require"legendary"
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 42
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
  end,
  -- on_create = fun(t: Terminal), -- function to run when the terminal is first created
  -- on_open = fun(t: Terminal), -- function to run when the terminal opens
  -- on_close = fun(t: Terminal), -- function to run when the terminal closes
  -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string), -- callback for processing output on stdout
  -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string), -- callback for processing output on stderr
  -- on_exit = fun(t: Terminal, job: number, exit_code: number, name: string), -- function to run when terminal process exits
  hide_numbers = true, -- hide the number column in toggleterm buffers
  -- shade_filetypes = {},
  autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = false,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  terminal_mappings = false, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'vertical',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}

local stdout = function(t, job, data, name)
	vim.notify(name .. ' ' .. job .. ' ')
end
local stderr = function(t, job, data, name)
	vim.notify(name .. ' ' .. job .. ' ')
end
local Terminal  = require('toggleterm.terminal').Terminal
local custom_term = Terminal:new({
	count = 42,
	direction = 'vertical',
	on_stdout = stdout,
	on_stderr = stderr,
})
--[[ Terminal:new {
  cmd = string -- command to execute when creating the terminal e.g. 'top'
  close_on_exit = bool -- close the terminal window when the process exits
  highlights = table -- a table with highlights
  env = table -- key:value table with environmental variables passed to jobstart()
  clear_env = bool -- use only environmental variables from `env`, passed to jobstart()
  on_open = fun(t: Terminal) -- function to run when the terminal opens
  on_close = fun(t: Terminal) -- function to run when the terminal closes
  auto_scroll = boolean -- automatically scroll to the bottom on terminal output
  -- callbacks for processing the output
  on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
  on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
  on_exit = fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
} ]]

function _custom_term_toggle()
	custom_term:toggle()
end

local togtermopts = { noremap=true, silent=true}

local ttkeymaps =  {
	{
		itemgroup = 'terminal',
		description = 'toogle term and terminal sepecific options',
		keymaps = {
			{ '<leader>sh', '<cmd>ToggleTerm direction=vertical<CR>', description = 'split terminal'},
			{ '<leader>fsh', '<cmd>ToggleTerm direction=float dir=%:p:h<CR>', description = 'float terminal'},
			{ '<leader>tsh', '<cmd>ToggleTerm direction=tab<CR>', description = 'tab terminal'},
			{ '<leader>lsh', '<cmd>ToggleTermSendCurrentLine<CR>', description = 'send line to terminal'},
			{ '<leader><leader>sh', '<cmd>ToggleTermToggleAll<CR>', description = 'toggle terminal'},
			-- { '<leader>csh', '<cmd>lua _custom_term_toggle()<CR>', description = 'toggle custom terminal'}
		}
	}
}

mapper.keymaps(ttkeymaps)
require('gitsigns').setup({
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or { silent = true, noremap = true}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end
		-- Navigation
		map('n', '<leader>nd', function()
			if vim.wo.diff then return '<leader>nd' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, {expr=true})

		map('n', '<leader>pd', function()
			if vim.wo.diff then return '<leader>pd' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, {expr=true})
		map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>')
	end
})

local hasgruvbox, gruvbox = prequire("gruvbox")
if not hasgruvbox then
	return
end
local hascolors, colors = prequire("gruvbox.palette")
if not hascolors then
	return
end

local borderColors = { bg = colors.dark0, fg = colors.dark0 }
local titleColors = { bg = colors.dark0, fg = colors.gray }
local normalColors = { bg = colors.dark0, fg = colors.light1 }
local invertedBorderColors = { fg = colors.dark0, bg = colors.dark0 }
local invertedNormalColors = { fg = colors.dark0, bg = colors.light1 }

local overrides = {
	TelescopeNormal = { fg = colors.gray },

	TelescopePreviewBorder = borderColors,
	TelescopePreviewNormal = normalColors,
	-- TelescopePreviewTitle = titleColors,
	TelescopePreviewTitle = borderColors,

	TelescopePromptBorder = invertedBorderColors,
	TelescopePromptNormal = invertedNormalColors,
	-- TelescopePromptTitle = titleColors,
	TelescopePromptTitle = borderColors,
	TelescopePromptPrefix = invertedNormalColors,

	TelescopeResultsBorder = borderColors,
	TelescopeResultsNormal = normalColors,
	-- TelescopeResultsTitle = titleColors,
	TelescopeResultsTitle = borderColors,
}

local options = {
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = true,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = true,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  dim_inactive = true,
  transparent_mode = false,
  overrides = overrides
}

-- setup must be called before loading the colorscheme
gruvbox.setup(options)

vim.cmd("colorscheme gruvbox")

local haslegendary, legendary = prequire("legendary")
if not haslegendary then
	return
end
local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

legendary.setup({
	-- Initial keymaps to bind
	keymaps = {
		-- Normal Mode
		{ '<leader>map', '<cmd>lua require("legendary").find({ filters = { require("legendary.filters").keymaps() } })<cr>', description = 'find keymaps'},
		{ '<leader><leader><CR>', '<cmd>so ~/.config/nvim/init.lua<CR>', description = 'reload config'},
		{ 'n', 'nzz', description = 'center on jump'},
		{ 'N', 'Nzz', description = 'center on jump'},
		{ 'H', 'Hzz', description = 'center on jump'},
		{ 'M', 'Mzz', description = 'center on jump'},
		{ 'L', 'Lzz', description = 'center on jump'},
		{ '<leader>mm', '<cmd>WindowsMaximize<CR>', description = 'maximizer toogle'},
		{ '<C-w>=', '<cmd>WindowsEqualize<CR>', description = 'equalize windows'},
		{ '<leader>cht', '<cmd>Cheat<cr>', description = 'open cheat query' },
		{ '<leader>gss', '<cmd>lua require("neogit").open({ cwd = vim.fn.expand("%:p:h") })<cr>', description = 'open neogit'},
		{ '<leader>cb', '<cmd>lcd %:p:h<cr>', description = 'lcd to buffer'},
		{ '<leader>sws', '<cmd>lua require("swap-split").swap()<cr>', description = 'spell suggest'},
		{ '<leader>zsh', '<cmd>lua require"f_seashell".command_prompt()<CR>', description = 'shell++'},
		-- Terminal Mode
		{ '<esc>', termcodes('<C-\\><C-N>'), description = 'escape terminal', mode = { 't'}},
	},
	-- default opts to merge with the `opts` table
	-- of each individual item
	default_opts = {
		keymaps = {
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
		},
		commands = {},
		autocmds = {},
	},
	-- Customize the prompt that appears on your vim.ui.select() handler
	-- Can be a string or a function that returns a string.
	select_prompt = ' legendary.nvim ',
	-- Character to use to separate columns in the UI
	col_separator_char = '│',
	-- Optionally pass a custom formatter function. This function
	-- receives the item as a parameter and the mode that legendary
	-- was triggered from (e.g. `function(item, mode): string[]`)
	-- and must return a table of non-nil string values for display.
	-- It must return the same number of values for each item to work correctly.
	-- The values will be used as column values when formatted.
	-- See function `default_format(item)` in
	-- `lua/legendary/ui/format.lua` to see default implementation.
	default_item_formatter = nil,
	-- Include builtins by default, set to false to disable
	include_builtin = true,
	-- Include the commands that legendary.nvim creates itself
	-- in the legend by default, set to false to disable
	include_legendary_cmds = true,
	-- Sort most recently used items to the top of the list
	-- so they can be quickly re-triggered when opening legendary again
	sort = {
		most_recent_first = true,
	},
	which_key = {
		-- Automatically add which-key tables to legendary
		-- see ./doc/WHICH_KEY.md for more details
		auto_register = false,
		-- you can put which-key.nvim tables here,
		-- or alternatively have them auto-register,
		-- see ./doc/WHICH_KEY.md
		mappings = {},
		opts = {},
		-- controls whether legendary.nvim actually binds they keymaps,
		-- or if you want to let which-key.nvim handle the bindings.
		-- if not passed, true by default
		do_binding = false,
	},
	scratchpad = {
		-- How to open the scratchpad buffer,
		-- 'current' for current window, 'float'
		-- for floating window
		view = 'float',
		-- How to show the results of evaluated Lua code.
		-- 'print' for `print(result)`, 'float' for a floating window.
		results_view = 'float',
		-- Border style for floating windows related to the scratchpad
		float_border = 'rounded',
		-- Whether to restore scratchpad contents from a cache file
		keep_contents = true,
	},
	-- Directory used for caches
	cache_path = string.format('%s/legendary/', vim.fn.stdpath('cache')),
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
