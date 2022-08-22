local db = require('dashboard')

db.default_executive = 'telescope'
db.custom_header = {
	[[`MM\     `M'                    MM     `Mb(     )d' 68b                 ]],
	[[ MMM\     M                     MM      YM.     ,P  Y89                 ]],
	[[ M\MM\    M   _____     _____   MM____  `Mb     d'  ___ ___  __    __   ]],
	[[ M \MM\   M  6MMMMMb   6MMMMMb  MMMMMMb  YM.   ,P   `MM `MM 6MMb  6MMb  ]],
	[[ M  \MM\  M 6M'   `Mb 6M'   `Mb MM'  `Mb `Mb   d'    MM  MM69 `MM69 `Mb ]],
	[[ M   \MM\ M MM     MM MM     MM MM    MM  YM. ,P     MM  MM'   MM'   MM ]],
	[[ M    \MM\M MM     MM MM     MM MM    MM  `Mb d'     MM  MM    MM    MM ]],
	[[ M     \MMM MM     MM MM     MM MM    MM   YM,P      MM  MM    MM    MM ]],
	[[ M      \MM YM.   ,M9 YM.   ,M9 MM.  ,M9   `MM'      MM  MM    MM    MM ]],
	[[_M_      \M  YMMMMM9   YMMMMM9 _MYMMMM9     YP      _MM__MM_  _MM_  _MM_]],
}
db.header_pad = 10
db.center_pad = 10
db.footer_pad = 5

db.custom_center = {
	{ icon = ' ',
		desc = 'Recently closed session                   ',
		action = function()
			require("persistence").load({ last = true })
		end,
		shortcut = '   ' },
	{ icon = ' ',
		desc = 'Find File                                 ',
		action = 'Telescope find_files find_command=rg,--hidden,--files',
		shortcut = 'C+p' },
	{ icon = ' ',
		desc = 'File Browser                              ',
		action = 'NvimTreeOpen',
		shortcut = 'A+b' },
	{ icon = ' ',
		desc = 'Find word                                 ',
		action = 'Telescope live_grep',
		shortcut = 'C+F' },
	{ icon = ' ',
		desc = 'Update packages                           ',
		action = 'PackerSync',
		shortcut = '   ' },
	{ icon = 'X ',
		desc = 'Exit                                      ',
		action = 'qall',
		shortcut = '   ' },
}

db.custom_footer = { 'Nvim config for beginners' }
