require('lspsaga').setup({
	finder = {
		default = 'tyd+ref+imp+def',
		keys = {
			edit = "e",
      toggle_or_open = "<cr>",
			vsplit = "v",
			split = "s",
			tabe = "t",
			tabnew = "r",
			quit = "<esc>"
		},
	},
	code_action = {
		num_shortcut = true,
		keys = {
			quit = "<esc>",
			exec = "<cr>"
		}
	},
	diagnostic = {
		show_code_action = true,
		show_source = true,
		jump_num_shortcut = true,
		custom_fix = nil,
		custom_msg = nil,
		keys = {
			exec_action = "<cr>",
			quit = "<esc>",
			go_action = "g"
		},
	},
	rename = {
		quit = "<esc>",
		exec = "<CR>",
		mark = "x",
		confirm = "<CR>",
		in_select = true,
	},
	outline = {
		keys = {
			jump = "o",
			expand_collapse = "u",
			quit = "<esc>",
		},
	},
	symbol_in_winbar = {
		enable = true,
		separator = "  ",
		hide_keyword = true,
		show_file = true,
		folder_level = 2,
		respect_root = false,
		color_mode = true,
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	buffer = bufnr,
	callback = function()
		local opts = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = 'rounded',
			source = 'always',
			prefix = ' ',
			scope = 'cursor',
		}
		vim.diagnostic.open_float(nil, opts)
	end
})
