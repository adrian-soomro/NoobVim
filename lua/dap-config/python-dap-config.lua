local path_to_debugpy = '~/.local/share/nvim/mason/packages/debugpy/venv/bin/python'

require('dap-python').setup(path_to_debugpy)
require("dap").configurations['python'] = {
  {
    type = "python",
    request = "launch",
    name = "Vanilla python",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
}
