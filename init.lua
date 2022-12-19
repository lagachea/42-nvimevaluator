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

	-- Bracket
	use {
		'p00f/nvim-ts-rainbow',
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
	}
}

telescope.load_extension('fzy_native')
telescope.load_extension('file_browser')
telescope.load_extension('media_files')
telescope.load_extension('dap')
telescope.load_extension('ui-select')
telescope.load_extension('telescope-tabs')
telescope.load_extension('notify')

M = {}

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
		{ '<leader>reg', function() require("telescope.builtin").registers() end, description = 'telescope register', opts = telescopts},
		{ '<leader>rg', function() require("telescope.builtin").live_grep() end, description = 'telescope live_grep', opts = telescopts},
		{ '<leader>dot', function() M.search_dotfiles() end, description = 'dotfiles' , opts = telescopts},
		{ '<leader>cfg', function() M.search_config() end, description = 'config' , opts = telescopts},
		{ '<leader>cd', function() M.file_browser() end, description = 'file browser', opts = telescopts},
		{ '<leader>ang', function() M.angular() end, description = 'telescope angular' , opts = telescopts},
		{ '<leader>gb', function() M.git_branches() end, description = 'git banches', opts = telescopts},
		{ '<leader>ggs', function() M.git_status() end, description = 'git git statuses', opts = telescopts},
		{ '<C-f>', function() require("telescope.builtin").find_files() end, description = 'find files', opts = telescopts},
		{ '<C-g>', function() M.git_files() end, description = 'git files', opts = telescopts},
		{ '<leader>man', function() require("telescope.builtin").man_pages() end, description = 'man pages', opts = telescopts},
		{ '<leader>ff', function() require("telescope.builtin").current_buffer_fuzzy_find() end, description = 'buffer fuzzy', opts = telescopts},
		{ '<leader>btn', function() require("telescope.builtin").builtin() end, description = 'telescope builtins' , opts = telescopts},
		{ '<leader>pks', function() require("telescope.builtin").pickers() end, description = 'telescope pickers' , opts = telescopts},
		{ '<leader>rsm', function() require("telescope.builtin").resume() end, description = 'telescope resume' , opts = telescopts},
		{ '<leader>mf', function() require("telescope").extensions.media_files.media_files() end, description = 'media files', opts = telescopts},
		{ '<leader>not', function() require("telescope").extensions.notify.notify() end, description = 'notifications', opts = telescopts},
		{ '<leader>tab', function() require("telescope-tabs").list_tabs() end, description = 'open tabs', opts = telescopts},
		{ '<leader>*', function() require("telescope.builtin").grep_string() end, description = 'grep cword', opts = telescopts},
		{ '<leader>bu', function() require("telescope.builtin").buffers() end, description = 'open buffers', opts = telescopts},
		{ '<leader>of', function() require("telescope.builtin").oldfiles() end, description = 'oldfiles', opts = telescopts},
		{ '<leader>cmd', function() require("telescope.builtin").commands() end, description = 'commands', opts = telescopts},
		{ '<leader>his', function() require("telescope.builtin").command_history() end, description = 'commands history', opts = telescopts},
		{ '<leader>gh', function() require("telescope.builtin").help_tags() end, description = 'help tags', opts = telescopts},
		{ '<leader>qf', function() require("telescope.builtin").quickfix() end, description = 'quickfix', opts = telescopts},
		{ '<leader>qlh', function() require("telescope.builtin").quickfixhistory() end, description = 'quickfixhistory', opts = telescopts},
		{ '<leader>ll', function() require("telescope.builtin").loclist() end, description = 'location list', opts = telescopts},
		{ '<leader>ftp', function() require("telescope.builtin").filetypes() end, description = 'filetypes', opts = telescopts},
		{ '<leader>sp', function() require("telescope.builtin").spell_suggest() end, description = 'spell suggest', opts = telescopts},
		-- Visual Mode
		{ '<leader>vg', 'y<cmd>lua require("plugins.telescop_setvp").live_grep("v")<cr>', description = 'grep visual selection', mode = { 'v'}, opts = telescopts},
		-- Insert Mode
		{ '<c-r>', function() require("telescope.builtin").registers() end, description = 'registers', mode = { 'i'}, opts = telescopts},
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
		{ '<F2>', function() require'osv'.launch() end, description = 'osv launch'},
		{ '<F3>', function() require'osv'.run_this() end, description = 'osv run this'},
		{ '<F5>', function() require'dap'.continue() end, description = 'dap continue'},
		{ '<F6>', function() require'dapui'.toggle() end, description = 'toogle dap ui'},
		{ '<F7>', function() require'dap'.step_over() end, description = 'dap step over'},
		{ '<F8>', function() require'dap'.step_into() end, description = 'dap step into'},
		{ '<F9>', function() require'dap'.step_out() end, description = 'dap step out'},
		{ '<leader>dtb', '<cmd>AddConditionalBreakPoint<cr>', description = 'dap toggle breakpoint'},
		{ '<leader>dcmd', function() require"telescope".extensions.dap.commands() end, description = 'show dap commands'},
		{ '<leader>dcfg', function() require"telescope".extensions.dap.configurations() end, description = 'show dap configurations'}
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
				{'<leader>rn', function() vim.lsp.buf.rename() end, opts = bufopts, description = 'rename symbol'},
				{'<leader>ds', function() require('telescope.builtin').lsp_document_symbols() end, opts = bufopts, description = 'document symbols'},
				{'<leader>fd', function() require('telescope.builtin').diagnostics() end, opts = bufopts, description = 'document diagnostics'},
				{'<leader>dsl', function() vim.diagnostic.setqflist() end, opts = bufopts, description = 'add err to location list'},
				{'<leader>ld', function() vim.diagnostic.open_float() end, opts = bufopts, description = 'line diagnostics'},
				{'<leader>pe', function() vim.diagnostic.goto_prev() end, opts = bufopts, description = 'previous error'},
				{'<leader>ne', function() vim.diagnostic.goto_next() end, opts = bufopts, description = 'next error'},
				{"<leader>hov", function() vim.lsp.buf.hover() end, opts = bufopts, description = 'hover'},
				{'<leader>shp', function() vim.lsp.buf.signature_help() end, opts = bufopts, description = 'signature help'},
				{'<leader>ca', function() vim.lsp.buf.code_action() end, opts = bufopts, description = 'code actions'},
				{'<leader>ca', function() vim.lsp.buf.code_action() end, opts = bufopts, description = 'code actions', mode = { 'v'}},
				{"<leader>fmt", function() vim.lsp.buf.format({async = true}) end, opts = bufopts, description = 'format'},
				{'<leader>gr', function() require('telescope.builtin').lsp_references() end, opts = bufopts, description = 'references'},
				{'<leader>gc', function() require('telescope.builtin').lsp_incoming_calls() end, opts = bufopts, description = 'incoming_calls'},
				{'<leader>gi',  function() require('telescope.builtin').lsp_implementations() end, opts = bufopts, description = 'implementations'},
				{'<leader>gd',  function() require('telescope.builtin').lsp_definitions() end, opts = bufopts, description = 'definitions'},
				{'<leader>gtd', function() require('telescope.builtin').lsp_type_definitions() end, opts = bufopts, description = 'type definitions'},
			}
		}
	}
	mapper.keymaps(keymaps)
end

-- SERVER REGISTER AND LOAD
local servers = {'clangd', 'pyright'} 
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = custom_on_attach,
        capabilities = capabilities
    }
end

local null_ls = require('null-ls')

null_ls.setup({
    sources = {
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.diagnostics.clang_check,
		null_ls.builtins.completion.tags,
		null_ls.builtins.completion.spell
    },
})

require("mason-null-ls").setup({
	automatic_installation = true,
})

vim.g.cheat_default_window_layout ='split'

require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

require 'nvim-treesitter.configs'.setup {

    ensure_installed = { "c", "python", "lua", "cpp"},

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
		{ name = 'treesitter', max_item_count = 7  },
		{ name = 'path', max_item_count = 5},
		{ name = 'buffer', keyword_length = 4, max_item_count = 5 },
	}),
	performance = {
	}
})


local filetypes = {'c', 'cpp', 'python'} 
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
		{ '<leader>map', function() require("legendary").find({ filters = { require("legendary.filters").keymaps() } }) end, description = 'find keymaps'},
		{ '<leader><leader><CR>', '<cmd>so ~/.config/nvim/init.lua<CR>', description = 'reload config'},
		{ 'n', 'nzz', description = 'center on jump'},
		{ 'N', 'Nzz', description = 'center on jump'},
		{ 'H', 'Hzz', description = 'center on jump'},
		{ 'M', 'Mzz', description = 'center on jump'},
		{ 'L', 'Lzz', description = 'center on jump'},
		{ '<leader>mm', '<cmd>WindowsMaximize<CR>', description = 'maximizer toogle'},
		{ '<C-w>=', '<cmd>WindowsEqualize<CR>', description = 'equalize windows'},
		{ '<leader>cht', '<cmd>Cheat<cr>', description = 'open cheat query' },
		{ '<leader>gss', function() require("neogit").open({ cwd = vim.fn.expand("%:p:h") }) end, description = 'open neogit'},
		{ '<leader>cb', '<cmd>lcd %:p:h<cr>', description = 'lcd to buffer'},
		{ '<leader>sws', function() require("swap-split").swap() end, description = 'spell suggest'},
		{ '<leader>zsh', function() require"f_seashell".command_prompt() end, description = 'shell++'},
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

return M
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
