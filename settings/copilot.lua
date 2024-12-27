
local qkn = _G.qnmap
local qkx = _G.qxmap

local _opt = { expr = true, replace_keycodes = false }
local _mec = 'copilot#Accept("\\<CR>")'

vim.keymap.set('i', '<C-TAB>', _mec, _opt)
--vim.keymap.set('i', '<TAB>', _mec, _opt)

-- ︻┳デ═—
require('CopilotChat').setup {
  --window = {
  --  layout = "float", -- "vertical" | "horizontal" | "float"
  --  width = 0.5,
  --  height = 1,
  --  col = vim.o.columns - math.floor(vim.o.columns * 0.5),
  --  relative = "win", -- "editor" | "cursor" | "win"
  --  border = "single", -- "none" | "single" | "double" | "shadow"
  --  title = " ︻┳デpTSCopilot]═—— ",
  --  zindex = 50,
  --},

  question_header = '⫎ pTSern ', -- Header to use for user questions
  answer_header = '⫎ Copilot ', -- Header to use for AI answers
  error_header = '⫎ Error ', -- Header to use for errors

  mappings = {
    complete = {
      insert = '<C-Tab>',
    },
    close = {
      normal = 'q',
      insert = '<C-c>',
    },
    reset = {
      normal = '<C-l>',
      insert = '<C-l>',
    },
    submit_prompt = {
      normal = '<CR>',
      insert = '<C-s>',
    },
    toggle_sticky = {
      detail = 'Makes line under cursor sticky or deletes sticky line.',
      normal = 'gr',
    },
    accept_diff = {
      normal = '<C-y>',
      insert = '<C-y>',
    },
    jump_to_diff = {
      normal = 'gj',
    },
    quickfix_diffs = {
      normal = 'gq',
    },
    yank_diff = {
      normal = 'gy',
      register = '"',
    },
    show_diff = {
      normal = 'gd',
    },
    show_info = {
      normal = 'gi',
    },
    show_context = {
      normal = 'gc',
    },
    show_help = {
      normal = '?',
    },
  },
}

local chat = require('CopilotChat')
local selection = require('CopilotChat.select')

local function quick_ask()
  local input = vim.fn.input(" ☛ ")
  if input ~= "" then
    vim.cmd('CopilotChatBuffer ' .. input)
  end
end

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = "copilot-*",
  callback = function()
    vim.opt_local.relativenumber = false
    vim.keymap.set('n', '<C-h>', function()
      print(require("CopilotChat").response())
    end, { buffer = true, remap = true }
    )
  end
})
vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
  chat.ask(args.args, { selection = selection.visual })
end, { nargs = "*", range = true })

vim.api.nvim_create_user_command('CopilotChatInline', function(args)
  chat.ask(args.args, {
    selection = selection.visual,
    window = {
      layout = "float",
      width = 0.75,
      height = 0.25,
      relative = "cursor",
      row = 1,
    }
  })
end, { nargs = "*", range = true })

local function telescope()
  local actions = require('CopilotChat.actions')
  require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
end

qkn('<F2>', quick_ask, "Quick Copilot")
qkn('<Leader>aq', quick_ask, "[A]sk [Q]ick Copilot");
qkn('<Leader>ap', telescope, "[A]ction [P]rompt Telescope")
qkx('<Leader>ai', [[:CopilotChatInline<CR>]], "[A]ction [I]nline")
qkn('<Leader>aa', [[:CopilotChatOpen<CR>]], "[A]ction [A]sk Copilot")
qkx('<Leader>av', [[:CopilotChatVisual<CR>]], "[A]ction [V]isual ")
qkn('<Leader>ao', [[:CopilotChatOptimize<CR>]], "[A]ction [O]ptime")
qkn('<Leader>am', [[:CopilotChatModels<CR>]], "[A]ction [M]odels Changing")


