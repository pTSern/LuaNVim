```
                                _________   ______  ____   ____  _                
                               |  _   _  |.' ____ \|_  _| |_  _|(_)               
                         _ .--.|_/ | | \_|| (___ \_| \ \   / /  __   _ .--..--.   
                        [ '/'`\ \  | |     _.____`.   \ \ / /  [  | [ `.-. .-. |  
                         | \__/ | _| |_   | \____) |   \ ' /    | |  | | | | | |  
                         | ;.__/ |_____|   \______.'    \_/    [___][___||__||__] 
                        [__|                                                      
```

# pTS Neovim Configuration

A modular, high-performance, and aesthetically pleasing Neovim configuration built for modern software engineering. This setup transforms Neovim into a powerful, IDE-like environment while maintaining the speed and flexibility of a terminal-based editor.

---

## ✨ Features at a Glance

- **⚡ Blazing Fast:** Powered by [Lazy.nvim](https://github.com/folke/lazy.nvim) for optimized plugin loading.
- **🛠️ Robust IDE Features:** Native LSP support with auto-completion, diagnostics, and advanced code navigation.
- **🤖 AI-Integrated:** Built-in support for GitHub Copilot, Copilot Chat, and Avante for intelligent coding assistance.
- **🎨 Modern Aesthetics:** Beautifully themed with **Catppuccin**, featuring a polished UI with a custom dashboard and statusline.
- **🔍 Advanced Navigation:** Fuzzy find anything with **Telescope**, browse files with **CHADTree**, and jump around code instantly with **Flash**.
- **📦 Multi-Language Ready:** Optimized configurations for C# (Roslyn/OmniSharp), TypeScript, Flutter, Lua, and Markdown.

---

## 🛠️ Core Stack

### 🧩 IDE Features
- **LSP Support:** [LspConfig](https://github.com/neovim/nvim-lspconfig) managed via [Mason](https://github.com/williamboman/mason.nvim).
- **Completion:** [Nvim-CMP](https://github.com/hrsh7th/nvim-cmp) for smooth, snippet-aware autocompletion.
- **Syntax:** [Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter) for advanced highlighting and structural understanding.
- **Formatting:** [Conform.nvim](https://github.com/stevearc/conform.nvim) for lightning-fast buffer formatting.

### 🧭 Navigation & Productivity
- **Fuzzy Finder:** [Telescope](https://github.com/nvim-telescope/telescope.nvim) (files, grep, git, symbols).
- **File Explorer:** [CHADTree](https://github.com/ms-jpq/chadtree) — a fast, feature-rich alternative to NERDTree.
- **Movement:** [Flash.nvim](https://github.com/folke/flash.nvim) for rapid, intuitive cursor jumping.
- **Project Management:** [Telescope Projects](https://github.com/nvim-telescope/telescope-project.nvim) to switch workspaces instantly.

### 💄 UI & Aesthetics
- **Theme:** [Catppuccin](https://github.com/catppuccin/nvim) (Mocha variant).
- **Statusline:** [Lualine](https://github.com/nvim-lualine/lualine.nvim) for a clean, informative bottom bar.
- **Tabs:** [Barbar.nvim](https://github.com/romgrk/barbar.nvim) for sleek, interactive buffer tabs.
- **Dashboard:** [Dashboard-nvim](https://github.com/nvimdev/dashboard-nvim) for a beautiful start screen.

---

## 🖥️ System Requirements

- **Neovim:** `v0.12+` (highly recommended)
- **Runtime:** [LuaJIT](https://luajit.org/)
- **Nerd Font:** [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads) is required for icons.

### 🛠️ Required External Tools
These tools are used to supercharge Neovim's performance (finding files, searching text, sorting):

| Tool | Purpose | Use Case |
| :--- | :--- | :--- |
| **`ripgrep` (`rg`)** | Ultra-fast search | Telescope Grep, Spectre |
| **`fd`** | Fast file finder | Telescope Find Files |
| **`fzf`** | Fuzzy finder | Telescope sorting, FZF integration |
| **`cmake`** | Build tool | Compiling `fzf-native` for max speed |
| **`git`** | Version control | Plugin management, Git features |
| **`Python 3`** | Scripting | Required for CHADTree |

### 📦 Optional (Enhanced Experience)
- `bat`: Syntax highlighting for Telescope previews.
- `delta`: Better git diffs.
- `jq`: JSON processing.
- `tokei`: Code statistics.
- `xh`: HTTP client for API testing.

---

## 🚀 Installation & Setup

### 1. Automated Setup (Windows)
We provide a script to automatically install all required terminal tools via [Chocolatey](https://chocolatey.org/).

1. Open the project folder.
2. Right-click `install_tools.bat` and select **"Run as Administrator"**.
3. The script will install Chocolatey (if missing) and all the tools listed above.
4. Restart your terminal.

### 2. Manual Installation
If you prefer manual setup, ensure the tools in the table above are in your system `PATH`.

### 3. Clone the Config
```bash
git clone https://github.com/your-repo/nvim.git %USERPROFILE%\AppData\Local\nvim
```

---

## ⌨️ Key Bindings

To learn about the customized keybindings and how to navigate this configuration efficiently, please refer to our detailed guides:

- **[📖 Comprehensive Key Bindings Guide](KEY_BINDS.md)** - *Start here!*
- **[📝 Nvim CheatSheet](wiki/cheatsheet.md)**
- **[🌐 General Wiki](wiki/wiki.md)**

### Quick Commands
- `<Leader>ff` - Find files
- `<Leader>fg` - Live grep (search text)
- `<Alt-1>` - Toggle File Explorer
- `<Leader>fb` - Format current buffer

---

*This configuration is continuously evolving. Check the `settings/` directory to explore individual plugin configurations.*
