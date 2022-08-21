local db = require('dashboard')

db.default_executive = 'telescope'
db.custom_header = {
  [[                            ,-.',                              ]],
  [[       ___,---.__          /'|`\          __,---,___',         ]],
  [[    ,-'    \`    `-.____,-'  |  `-.____,-'    //    `-.',      ]],
  [[  ,'        |           ~'\     /`~           |        `.',    ]],
  [[ /      ___//              `. ,'          ,  , \___      \',   ]],
  [[|    ,-'   `-.__   _         |        ,    __,-'   `-.    |',  ]],
  [[|   /          /\_  `   .    |    ,      _/\          \   |',  ]],
  [[\  |           \ \`-.___ \   |   / ___,-'/ /           |  /',  ]],
  [[ \  \           | `._   `\\  |  //'   _,' |           /  /',   ]],
  [[  `-.\         /'  _ `---'' , . ``---' _  `\         /,-'',    ]],
  [[     ``       /     \    ,='/ \`=.    /     \       ''',       ]],
  [[             |__   /|\_,--.,-.--,--._/|\   __|',               ]],
  [[             /  `./  \\`\ |  |  | /,//' \,'  \',               ]],
  [[            /   /     ||--+--|--+-/-|     \   \',              ]],
  [[           |   |     /'\_\_\ | /_/_/`\     |   |',             ]],
  [[            \   \__, \_     `~'     _/ .__/   /',              ]],
  [[             `-._,-'   `-._______,-'   `-._,-'',               ]],
  [[                                                               ]],
}
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

db.custom_footer = { 'Custom footer message ' }
