local actions = require("diffview.actions")
local wk = require('which-key')

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "DiffviewFilePanel",
  callback = function(ctx)
    local leader_mapping = {
      g = {
        f = { actions.goto_file_tab, "Open the file in a a new tabpage" }
      },
      h = {
        s = { actions.toggle_stage_entry, "Stage / unstage the selected entry." },
        S = { actions.stage_all, "Stage all entries." },
        U = { actions.unstage_all, "Unstage all entries." },
      },
      X = { actions.restore_entry, "Restore entry to the state on the left side." },
      R = { actions.refresh_files, "Update stats and entries in the file list." },
      L = { actions.open_commit_log, "Open the commit log panel." },
      t = { actions.listing_style, "Toggle between 'list' and 'tree' views" },
      f = { actions.toggle_flatten_dirs, "Flatten empty subdirectories in tree listing style." },
    }

    local mapping = {
      ["<tab>"]   = { actions.select_next_entry, "Open the diff for the next file" },
      ["<s-tab>"] = { actions.select_prev_entry, "Open the diff for the previous file" },
      ["<cr>"]    = { actions.select_entry, "Open the diff for the selected entry." },
      j           = { actions.next_entry, "Bring the cursor to the next file entry" },
      k           = { actions.prev_entry, "Bring the cursor to the previous file entry." },
      o           = { actions.select_entry, "Open the diff for the selected entry." },
    }

    local leader_opts = {
      mode = "n", -- NORMAL mode
      prefix = "<leader>",
      buffer = ctx.buf, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    local opts = {
      mode = "n", -- NORMAL mode
      prefix = "",
      buffer = ctx.buf, -- Global mappings. Specify a buffer number for buffer local mappings
      silent = true, -- use `silent` when creating keymaps
      noremap = true, -- use `noremap` when creating keymaps
      nowait = true, -- use `nowait` when creating keymaps
    }

    wk.register(leader_mapping, leader_opts)
    wk.register(mapping, opts)
  end,
})

require("diffview").setup({
  diff_binaries = false, -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  git_cmd = { "git" }, -- The git executable followed by default args.
  use_icons = true, -- Requires nvim-web-devicons
  icons = { -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
    done = "✓",
  },
  view = {
    -- Configure the layout and behavior of different types of views.
    -- Available layouts:
    --  'diff1_plain'
    --    |'diff2_horizontal'
    --    |'diff2_vertical'
    --    |'diff3_horizontal'
    --    |'diff3_vertical'
    --    |'diff3_mixed'
    --    |'diff4_mixed'
    -- For more info, see ':h diffview-config-view.x.layout'.
    default = {
      -- Config for changed files, and staged files in diff views.
      layout = "diff2_horizontal",
    },
    merge_tool = {
      -- Config for conflicted files in diff views during a merge or rebase.
      layout = "diff3_horizontal",
      disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
    },
    file_history = {
      -- Config for changed files in file history views.
      layout = "diff2_horizontal",
    },
  },
  file_panel = {
    listing_style = "tree", -- One of 'list' or 'tree'
    tree_options = { -- Only applies when listing_style is 'tree'
      flatten_dirs = true, -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
    },
    win_config = { -- See ':h diffview-config-win_config'
      position = "left",
      width = 35,
      win_opts = {}
    },
  },
  file_history_panel = {
    log_options = { -- See ':h diffview-config-log_options'
      git = {
        single_file = {
          diff_merges = "combined",
        },
        multi_file = {
          diff_merges = "first-parent",
        },
      }
    },
    win_config = { -- See ':h diffview-config-win_config'
      position = "bottom",
      height = 16,
      win_opts = {}
    },
  },
  commit_log_panel = {
    win_config = { -- See ':h diffview-config-win_config'
      win_opts = {},
    }
  },
  default_args = { -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {
    diff_buf_read = function(bufnr)
      local leader_mapping = {
        g = {
          f = { actions.goto_file_tab, "Open the file in a new split in the previous tabpage" }
        },
        c = {
          name = "Conflict",
          o = { actions.conflict_choose("ours"), "Choose the OURS version of a conflict" },
          t = { actions.conflict_choose("theirs"), "Choose the THEIRS version of a conflict" },
          b = { actions.conflict_choose("base"), "Choose the BASE version of a conflict" },
          a = { actions.conflict_choose("all"), "Choose all the versions of a conflict" },
          d = { actions.conflict_choose("none"), "Delete the conflict region" },
        },
      }
      local mapping = {
        ["<tab>"]   = { actions.select_next_entry, "Open the diff for the next file" },
        ["<s-tab>"] = { actions.select_prev_entry, "Open the diff for the previous file" },
        ["[c"]      = { actions.prev_conflict, "In the merge_tool: jump to the previous conflict" },
        ["]c"]      = { actions.next_conflict, "In the merge_tool: jump to the next conflict" },
      }

      local leader_opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local opts = {
        mode = "n", -- NORMAL mode
        prefix = "",
        buffer = bufnr, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      wk.register(leader_mapping, leader_opts)
      wk.register(mapping, opts)
    end,
  }, -- See ':h diffview-config-hooks'
  keymaps = {
    disable_defaults = true, -- Disable the default keymaps
    diff1 = { --[[ Mappings in single window diff layouts ]] },
    diff2 = { --[[ Mappings in 2-way diff layouts ]] },
    diff3 = {
      -- Mappings in 3-way diff layouts
      { { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
      { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
    },
    diff4 = {
      -- Mappings in 4-way diff layouts
      { { "n", "x" }, "1do", actions.diffget("base") }, -- Obtain the diff hunk from the BASE version of the file
      { { "n", "x" }, "2do", actions.diffget("ours") }, -- Obtain the diff hunk from the OURS version of the file
      { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
    },
    file_history_panel = {
      ["g!"]            = actions.options, -- Open the option panel
      ["<C-A-d>"]       = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
      ["y"]             = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
      ["L"]             = actions.open_commit_log,
      ["zR"]            = actions.open_all_folds,
      ["zM"]            = actions.close_all_folds,
      ["j"]             = actions.next_entry,
      ["<down>"]        = actions.next_entry,
      ["k"]             = actions.prev_entry,
      ["<up>"]          = actions.prev_entry,
      ["<cr>"]          = actions.select_entry,
      ["o"]             = actions.select_entry,
      ["<2-LeftMouse>"] = actions.select_entry,
      ["<c-b>"]         = actions.scroll_view(-0.25),
      ["<c-f>"]         = actions.scroll_view(0.25),
      ["<tab>"]         = actions.select_next_entry,
      ["<s-tab>"]       = actions.select_prev_entry,
      ["gf"]            = actions.goto_file,
      ["<C-w><C-f>"]    = actions.goto_file_split,
      ["<C-w>gf"]       = actions.goto_file_tab,
      ["<leader>e"]     = actions.focus_files,
      ["<leader>b"]     = actions.toggle_files,
      ["g<C-x>"]        = actions.cycle_layout,
    },
    option_panel = {
      ["<tab>"] = actions.select_entry,
      ["q"]     = actions.close,
    },
  },
})
