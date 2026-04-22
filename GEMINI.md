# pTS Neovim Configuration

This is a modular and highly customized Neovim configuration powered by Lua and `lazy.nvim`. It is designed to provide a modern IDE-like experience with a focus on performance, aesthetics, and developer productivity.

## Project Overview

- **Core Language:** Lua
- **Plugin Manager:** [Lazy.nvim](https://github.com/folke/lazy.nvim)
- **Target Neovim Version:** v0.11.2+
- **Key Technologies:**
    - **UI/Aesthetics:** Catppuccin theme, Lualine for statusline, Barbar for tab management, and Dashboard for the start screen.
    - **IDE Features:** Native LSP (via `lspconfig` and `mason.nvim`), `nvim-cmp` for autocompletion, and `nvim-treesitter` for advanced syntax highlighting.
    - **Navigation:** `Telescope` for fuzzy finding, `ChadTree` for file browsing, and `Flash.nvim` for quick jumping.
    - **AI Assistance:** Avante, GitHub Copilot, and Copilot Chat.
    - **Specialized Support:** C# (Roslyn/OmniSharp), TypeScript, Flutter, and Markdown.

## Project Structure

- `init.lua`: The entry point that bootstraps the entire configuration.
- `global_vars.lua`: Defines global aliases (e.g., `GOpts`, `GKeymap`) and helper functions used throughout the config.
- `initialization/`: Core configuration logic.
    - `generals.lua`: General Neovim options and autocommands.
    - `key_mapping.lua`: Global keybindings and custom mappings.
    - `lazy.lua`: Plugin declarations and setup via `lazy.nvim`.
- `settings/`: Plugin-specific configuration files. Each file typically handles the setup for one or more related plugins.
- `wiki/`: Documentation and cheat sheets for the configuration.

## Key Commands & Workflows

### Plugin Management
- **Update Plugins:** Open Neovim and run `:Lazy update`.
- **Install/Check Plugins:** Run `:Lazy`.

### Navigation & Search
- **Fuzzy Finder:** `<Leader>sf` (diagnostics), and other Telescope commands.
- **File Explorer:** `ChadTree` is the primary file manager.
- **Fast Travel:** Use `Flash.nvim` with mappings like `M-right`.

### IDE Features
- **Formatting:** `<Leader>fb` (Format Buffer) using `conform.nvim`.
- **LSP Actions:** Standard LSP mappings are supported (Go to definition, references, etc.).
- **Diagnostics:** `[d` and `]d` to navigate diagnostics.

## Development Conventions

- **Global Aliases:** Use the provided global aliases in `global_vars.lua` for a cleaner syntax:
    - `GOpts` -> `vim.opt`
    - `GKeymap` -> `vim.keymap`
    - `GGlobal` -> `vim.g`
    - `GCmd` -> `vim.cmd`
- **Modularization:** Plugin settings should be placed in `settings/` and loaded via `settings/init.lua`.
- **Key Mappings:** Use `qnmap`, `qimap`, etc., defined in `global_vars.lua` for defining new mappings with descriptions for `which-key`.
- **Indentation:** The configuration uses 4 spaces for indentation as defined in `initialization/generals.lua`.
