# Neovim Key Binds & Configuration Guide

This document provides a comprehensive overview of the keybindings and the configuration philosophy of this Neovim setup.

## 🔑 The Leader Key

The **Leader key** is a special prefix key used to trigger custom commands without conflicting with Neovim's built-in keybindings. In this configuration, the Leader key is set to **`Space`**.

- **Notation:** In this document and within the code, it is represented as `<Leader>` or `[Leader]`.
- **Why Space?** It's the most accessible key on the keyboard, allowing for fast, ergonomic command execution.

## ⌨️ Key Notations

To understand the keybindings table below, familiarize yourself with these common notations:

| Notation | Meaning | Example |
|---|---|---|
| `<C-key>` | **Ctrl** + key | `<C-s>` (Ctrl+S) |
| `<M-key>` | **Alt** (Meta) + key | `<M-j>` (Alt+J) |
| `<S-key>` | **Shift** + key | `<S-Tab>` (Shift+Tab) |
| `<CR>` | **Enter** (Carriage Return) | |
| `<ESC>` | **Escape** | |
| `<BS>` | **Backspace** | |

## 🕹️ Modes

Keybindings can behave differently depending on which "mode" Neovim is in:

- **Normal (`n`):** The default mode for navigation and manipulation. Most custom commands start here.
- **Insert (`i`):** For typing text. Some helpers (like line movement or AI completions) are available here.
- **Visual (`v`/`x`):** For selecting blocks of text. Mappings here usually operate on the selection.
- **Command (`c`):** For typing `:` commands.

---

## 🚀 Keybinding Reference Table

| Mode | Key | Description | Category/Plugin |
|---|---|---|---|
| Normal | `[Leader]w` | Write (save) current file | General |
| Normal | `[Leader]W` | Write and quit | General |
| Normal | `[Leader]Q` | Force quit without saving | General |
| Normal | `[Leader]nh` | Clear search highlight (`:noh`) | General |
| Normal | `[Leader]tv` | Vertical split and focus | Layout |
| Normal | `[Leader]tl` | List open buffers | Buffers |
| Normal | `[Leader]ts` | Switch between windows | Windows |
| Normal | `[Shift-Tab]` | Cycle between windows | Windows |
| Normal | `[Leader]tq` | Close current window | Windows |
| Normal | `df` | Forward word edit motion (custom) | Text Edit |
| Normal | `[Leader]ve` | Visual select to end of line | Text Edit |
| Normal | `[Leader]sn` | Search word under cursor (forward) | Search |
| Normal | `[Leader]sN` | Search word under cursor + clear highlight | Search |
| Normal | `[Leader]sp` | Search word under cursor (backward) | Search |
| Normal | `[Leader]sP` | Search word under cursor (backward) + clear highlight | Search |
| Normal | `[Leader][Leader]-` | Wrap word with `_..._` | Text helper |
| Normal | `[Leader][Leader]_` | Force-wrap WORD with `_..._` | Text helper |
| Normal | `[Leader][Leader][` | Wrap word with `[...]` | Text helper |
| Normal | `[Leader][Leader]]` | Force-wrap WORD with `[...]` | Text helper |
| Normal | `[Leader][Leader]'` | Wrap word with `'...'` | Text helper |
| Normal | `[Leader][Leader]<` | Wrap word with `<...>` | Text helper |
| Normal | `[Leader][Leader]>` | Force-wrap WORD with `<...>` | Text helper |
| Normal | `[Leader]o` | Smart open line (insert newline and indent) | Text helper |
| Normal | `[Leader][Enter]` | Remove CRLF `\r` characters (file normalization) | File Ops |
| Normal | `[Ctrl-Up/Down]` | Move current line Up/Down | Text Edit |
| Normal | `[Ctrl-k/j]` | Move current line Up/Down | Text Edit |
| Insert | `[Ctrl-Up/Down]` | Move current line Up/Down (stay in Insert) | Text Edit |
| Visual | `[Ctrl-k/j]` | Move selection Up/Down | Text Edit |
| Normal | `[Leader]vy` | Yank (copy) line to system clipboard | Clipboard |
| Normal | `[Leader]vp` | Paste from system clipboard then yank | Clipboard |
| Normal | `[Leader]//` | Insert block comment skeleton | Comments |
| Normal | `[Ctrl-/]` | Toggle line comment `//` | Comments |
| Visual | `[Ctrl-/]` | Toggle selection comment `//` | Comments |
| Normal | `[Leader]bn` | Open a new empty buffer | Buffers |
| Normal | `gb` | Jump back to previous context mark | Navigation |
| Normal | `[Alt-Up/Down]` | Scroll **other** window without leaving current | Multi-window |
| Insert | `[Alt-Up/Down]` | Scroll **other** window (stay in Insert) | Multi-window |
| Normal | `[Leader]ef` | Echo absolute path of current file | File Ops |
| Normal | `[Ctrl-=/-]` | Increase/Decrease window width | Windows |
| Normal | `[Ctrl-0]` | Equalize window widths | Windows |
| Normal | `[d / ]d` | Previous / Next Diagnostic | LSP |
| Normal | `[Leader]sf` | Show diagnostic in floating window | LSP |
| Normal | `[Leader]qf` | Send diagnostics to Quickfix list | LSP |
| Normal | `[Leader]ff` | Find Files | Telescope |
| Normal | `[Leader]fg` | Live Grep (search text in project) | Telescope |
| Normal | `[Leader]fb` | Find Buffers | Telescope |
| Normal | `z=` | Spell suggestions | Telescope |
| Normal | `[Leader]fh` | Help tags | Telescope |
| Normal | `[Leader]fk` | Keymaps explorer | Telescope |
| Normal | `[Leader]fr` | Resume last Telescope search | Telescope |
| Normal | `[Leader]fs` | List Telescope builtin pickers | Telescope |
| Normal | `[Leader]fw` | Grep word under cursor | Telescope |
| Normal | `[Leader]fd` | Diagnostics picker | Telescope |
| Normal | `[Leader]fo` | Recent files (Oldfiles) | Telescope |
| Normal | `[Leader]fu` | LSP References | Telescope |
| Normal | `[Leader]fm` | Marks | Telescope |
| Normal | `` ` `` | Search Marks | Telescope |
| Normal | `[Leader]fi` | Search History | Telescope |
| Normal | `[Leader]fj` | Jump List | Telescope |
| Normal | `[Leader]fx` | Quickfix List | Telescope |
| Normal | `[Leader]fz` | Quickfix History | Telescope |
| Normal | `[Leader]gc` | Git Commits | Telescope |
| Normal | `[Leader]gs` | Git Status | Telescope |
| Normal | `[Leader]gh` | Git Stash | Telescope |
| Normal | `[Leader]gb` | Git Branches | Telescope |
| Normal | `[Leader]gf` | Git Files | Telescope |
| Normal | `[Leader]\` | Fuzzy search in current buffer | Telescope |
| Normal | `?` | Fuzzy search in current buffer | Telescope |
| Normal | `[Leader]fG` | Live Grep in currently open files | Telescope |
| Normal | `[Leader]fv` | Find files in Neovim configuration | Telescope |
| Normal | `[Leader]vc` | Search config files with `rg` | Telescope |
| Normal | `[Leader]pm / fp`| Project Manager | Telescope |
| Normal | `[Alt-1] / [F1]`| Toggle CHADTree (File Explorer) | CHADTree |
| Normal | `z` | Zip selected item(s) (inside CHADTree) | CHADTree |
| Normal | `Z` | Unzip selected zip file(s) (inside CHADTree) | CHADTree |
| Normal | `[Leader]/...` | Various NERDCommenter actions | NERDCommenter |
| Normal/Terminal | `[F8]` | Toggle Floating Terminal | ToggleTerm |
| Terminal | `[C-t]` | Create New Terminal | ToggleTerm |
| Terminal | `[Tab]` | Next Terminal | ToggleTerm |
| Terminal | `[S-Tab]` | Previous Terminal | ToggleTerm |
| Terminal | `[Shift-Right/Left]`| Switch to next/previous terminal buffer | ToggleTerm |
| Terminal | `[Ctrl-h/j/k/l]`| Move window focus out of terminal | ToggleTerm |
| Normal/Insert/Terminal | `[Ctrl-Shift-T]`| Toggle exclusive shell terminal | ToggleTerm |
| Normal | `[Leader]am`| Toggle Antigravity (agy) CLI popup | AGY |
| Normal | `[Leader]an`| New Antigravity (agy) session at path | AGY |
| Normal | `[Leader]ak`| Kill the current Antigravity session | AGY |
| Normal/Visual | `[Alt-k]` | Highlight word under cursor | InterestingWords |
| Normal | `[Alt-K]` | Clear all highlights | InterestingWords |
| Normal | `[Alt-h / l]` | Jump between highlighted words | InterestingWords |
| Normal | `[Leader]lss / q`| Start / Stop Live Server | LiveServer |
| Normal | `[Leader]lm...` | Markdown Preview actions | Markdown |
| Normal | `[Leader][Leader]c`| Toggle Cursor Column | UI |
| Normal | `[Leader][Leader]l`| Toggle Cursor Line | UI |
| Normal | `[Leader][Leader]w`| Toggle Line Wrap | UI |
| Normal | `[Leader]qg/m/p` | Insert `public`/`protected`/`private` | Coding |
| Normal | `[Leader][Leader]cp`| Insert `@property()` decorator | Coding (Cocos Creator) |
| Normal | `[Leader]fa` | Create Cocos Creator Component via popup | Coding (Cocos Creator) |
| Insert | `[Ctrl-CR]` / `[Ctrl-Enter]`| Create Cocos Creator Component via popup | Coding (Cocos Creator) |
| Normal | `[Leader]ri` | Rename word under cursor via popup (using search/substitute) | Refactor / Rename |
| Normal | `zR / zM` | Open all / Close all folds | UFO |
| Normal | `[Leader]gp` | Neogit Popup | Neogit |
| Normal | `-o / -t` | Git Conflict: Choose Ours / Theirs | GitConflict |
| Normal | `[Tab]j / k` | Previous / Next Buffer (Tab) | Barbar |
| Normal | `[Tab]h / l` | Move Buffer (Tab) Left / Right | Barbar |
| Normal | `\1..\9` | Jump to Buffer 1..9 | Barbar |
| Normal | `\0` | Jump to Last Buffer | Barbar |
| Normal | `[Leader][Tab]` | Pin/Unpin Buffer | Barbar |
| Normal | `[Tab]d / c` | Delete / Close Buffer | Barbar |
| Insert | `[Ctrl-Tab]` | Accept Copilot suggestion | Copilot |
| Insert | `[Ctrl-j] / [Ctrl-k]`| Select next/previous autocomplete item | Autocomplete (cmp) |
| Insert | `[Ctrl-b] / [Ctrl-f]`| Scroll documentation inside completion popup | Autocomplete (cmp) |
| Insert | `[Ctrl-y]` | Confirm autocomplete selection | Autocomplete (cmp) |
| Insert | `[Ctrl-l] / [Ctrl-h]`| Snippet expand or jump forward/backward | Autocomplete (cmp) |
| Normal | `[F2]` | Copilot Chat Quick Prompt | CopilotChat |
| Normal | `[Leader]aa` | Open Copilot Chat window | CopilotChat |
| Normal | `gd / gr / gi` | Go to Definition / References / Impl | LSP |
| Normal | `[Leader]rn` | Rename symbol | LSP |
| Normal | `[Leader]ca / [Alt-Enter]`| Code Action | LSP |
| Normal | `K` | Hover Documentation | LSP |
| Normal | `[Ctrl-Right]` | Flash Jump | Flash.nvim |
| Normal | `[Ctrl-Left]` | Flash Treesitter Jump | Flash.nvim |

## Notes

- Inactive mapping files in current startup: `settings/coc.lua`, `settings/fzf.lua`, `settings/GPTModel.lua` (commented out in `settings/init.lua`).
- Potential conflict: `<Leader>fb` is mapped in both `settings/_telescope.keymap.lua` and `conform.nvim` lazy `keys`; whichever loads last wins.
- Some plugin-internal default keys (for example full Neogit popup/status keysets) are plugin defaults and not fully redefined here.
