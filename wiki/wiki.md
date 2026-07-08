# Table of contents
- [Normal Mode](#Normal)
- [Visual Mode](#Visual)
- [Insert Mode](#Insert)

# Normal
    
| Type     |    Binding            |  Replace                                     |  Description                                                           |
| -------- | --------------------- | -------------------------------------------- | ---------------------------------------------------------------------- |
| Editor   | `[Leader]d`           | `:bd[CR]`                                    | Delete entire the current line                                         |
|          | `[Leader]ve`          | `v$`                                         |                                                                        |
|          | `[Leader]vl`          | `v>`                                         | Shift text right                                                       |
|          | `[Leader]vh`          | `v<`                                         | Shift text left                                                        |
|          | `[Leader]vL`          | `v>$a`                                       | Shift text right, go to the end of line, switch to `Insert` mode       |
|          | `[Leader]vH`          | `v<0i`                                       | Shift text left, go to the start of the  line, switch to `Insert` mode |
|          | `ds`                  | `lbde`                                       | Delete a word wherever your curosr is                                  |
|          | `[C][Up]` | `[C]k`    | `cc[ESC]2kp2jdd2k`                           | Move the entire current line up                                        |
|          | `[C][Down]` | `[C]j`  | `cc<ESC>jp2kddj`                             | Move the entire current line down                                      |
|          | `[Leader]-`           | `bi_[ESC]ea_[ESC]`                           | Adding `_` to the begin and the end of a word                          |
|          | `[Leader]_`           | `Bi_[ESC]Ea_[ESC]`                           | Adding `_` to the begin and the end of a word                          |
|          | `[Leader]o`           | `jI[CR][ESC]ka`                              | Append a new line below the current line without                       |
| -------- | ----------------      | -----------------------                      | -----------------------------                                          |
| File     | `[Leader]w`           | `:w[CR]`                                     | Save file                                                              |
|          | `[Leader]W`           | `:wq[CR]`                                    | Save then quit the file                                                |
|          | `[Leader]q`           | `:q[CR]`                                     | Quit the file                                                          |
|          | `[Leader]Q`           | `:q!`                                        | Force quit the file                                                    |
|          | `[Leader]h`           | `:noh[CR]`                                   | Turn off the highligh search                                           |
| -------- | ----------------      | -----------------------                      | -----------------------------                                          |
| Buffer   | `[Tab]`               | `:bn[CR]`                                    | Jump to the next buffer                                                |
|          | `[Leader][Tab]`       | `:bp[CR]`                                    | Jump to the previous buffer                                            |
|          | `[Leader]l`           | `:ls[CR]`                                    | List all open buffer                                                   |
|          | `[Leader]tv`          | `:vs[CR][C-w][C-w]`                          | Open and jump to the file in a new buffer, verically split window      |
|          | `[Leader]ts`          | `[C-w][C-w]`                                 | Switch windows                                                         |
|          | `[Leader]tq`          | `[C-w][C-q]`                                 | Quit the current window                                                |
| Terminal | `[Leader][Leader]t`   | `:ter[CR]`                                   | Open a terminal window                                                 |
|          | `[Leader]am`          | `:AgyPopup` (or toggle)                      | Toggle Antigravity (agy) CLI popup window                               |
|          | `[Leader]an`          | `new agy path input`                         | Open a new Antigravity (agy) session at path                           |
|          | `[Leader]ak`          | `kill agy session`                           | Kill the current Antigravity (agy) session                             |
| -------- | ----------------      | -----------------------                      | -----------------------------                                          |
| Help     | `[Leader]?coc`        | `:call ShowWiki('coc')[CR][CR]`              | Open `Coc` plugin wiki. Press `[ESC]` to exit                          |
|          | `[Leader]?fzf`        | `:call ShowWiki('fzf')[CR][CR]`              | Open `Fuzzy` plugin wiki. Press `[ESC]` to exit                        |
|          | `[Leader]?cs`         | `:call ShowWiki('cheatsheet')[CR][CR]`       | Open `CheatSheet` wiki, which contain all the default key mapping      |
|          | `[Leader]?wiki`       | `:call ShowWiki('wiki')[CR][CR]`             | Open this                                                              |
|          | `[Loader]??`          | `:map[CR]`                                   | Show all key mapping                                                   |
| -------- | ----------------      | -----------------------                      | -----------------------------                                          |
| Func     | `[Leader][Leader]c`   | `Toggle cursor column`                       | Toggle the cursor column                                               |
|          | `[Leader][Leader]l`   | `Toggle cursor line`                         | Toggle the cursor line                                                 |
|          | `[Leader][Leader]w`   | `Toggle wrap line mode`                      | Toggle wrap line mode                                                  |
|          | `[Leader]qg/qm/qp`    | `Insert public/protected/private`            | Quick Coding shortcuts for Access Modifiers                            |
|          | `[Leader][Leader]cp`  | `Insert @property()`                         | Cocos Creator property decorator                                       |
|          | `[Leader]fa`          | `insert_cocos_component`                     | Create Cocos Creator Component via popup                               |
|          | `[Leader]ri`          | `rename_word_popup`                          | Rename word under cursor via popup                                     |
|          |                       |                                              |                                                                        |

# Visual
