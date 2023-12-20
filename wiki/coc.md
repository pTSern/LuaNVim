# COC Wiki
- How to get here: `<L>?coc`

- Key Mapping
    - Navigate diagnostics
        + [Normal] `[g` : Navigate previous dianostics.
        + [Normal] `]g` : Navigate next dianostics.

    - GoTo code navigation
        + [Normal] `gd` : Go to the definition.
        + [Normal] `gy` : Go to the type definition.
        + [Normal] `gi` : Go to the implementation.
        + [Normal] `gr` : Go to the references.

    - Others
        + [Normal] `<L>k` : Show documentation in preview window. 

        + [Normal] `<L>rn` : Symbol renaming.
        + [Visual] `<L>f` : Formatting selected code.
        + [Normal] `<L>f` : Formatting selected code.

        + [Visual] `<L>ca` : Applying code actions to the selected code block.
        + [Normal] `<L>ca` : Applying code actions to the selected code block.

        + [Normal] `<L>ac` : Remap keys for apply code actions at the cursor position.
        + [Normal] `<L>as` : Remap the most apply code actions affect whole buffer.
        + [Normal] `<L>qf` : Quickfix action to fix diagnostic on the current line.
        + [Normal] `<ALT><ENTER>` : Quickfix action to fix diagnostic on the current line. 

        + [Normal] `<L>re` : Remap keys for apply refactor code actions.
        + [Visual] `<L>r` : Remap keys for selected code.
        + [Normal] `<L>r` : Remap keys for selected code.

        + [Normal] `<L>cl` : Run the Code Lens action on the current line.

    - Map function and class text objects
        + [Visual] `<L>cif`
        + [Operator] `<L>cif`

        + [Visual] `<L>caf`
        + [Operator] `<L>cif`

        + [Visual] `<L>cic`
        + [Operator] `<L>cic`

        + [Visual] `<L>cac`
        + [Operator] `<L>cac`

    - Others:
        + [Normal] `<CTR>s` : Selections ranges.
        + [Visual] `<CTR>s` : Selections ranges.

    - CocList: 
        + [Normal] `<L>cla` : Show all diagnostics.
        + [Normal] `<L>cle` : Manage extenstions.
        + [Normal] `<L>clc` : Show commands.
        + [Normal] `<L>clf` : Find symbol of current document.
        + [Normal] `<L>cls` : Search workspace symbols.
        + [Normal] `<L>cln` : Do default aciton for next item.
        + [Normal] `<L>clp` : Do default action for previous item.
        + [Normal] `<L>clr` : Resume latest coc list.

- Sysmbol breakdown.
    + [Normal] : Execute at normal mode. [Pressing `ESC` at other mode to enter normal mode]
    + [Visual] : Execute at visual mode. [Pressing `v` at normal mode]
    + [Operator] : Execute at operator-pending mode. [When doing `d` or `c` for delete or change, this the cursor be in half of it, that is Operator mode]

    + `<L>` : Leader key, can change at `init.vim` or `int.lua`,...
    + `<CTR>` : The control key.
    + `<ALT>` : The alt key.
    + `<Enter>` : The enter key.

