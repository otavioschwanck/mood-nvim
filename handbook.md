## Welcome to the mood handbook

# First of all

You need to learn vim before start using this configuration.

Some ways to learn:

- https://www.youtube.com/watch?v=RZ4p-saaQkc
- Type vimtutor on terminal

# Customizing

To access your personal configuration, press `SPC f p`.  To install extra plugins, press `SPC f P`

On your personal configuration you can configure stuff like commands to run with `SPC o`, per folder, theme, etc.

# Quick Tips

- To navigate on telescope use C-j and C-k.
- To command history on harpoon, use C-n and C-p.
- M-c means Alt + c or Option + c

# Buffer Navigation and Management

| Command                | Description                                        |
|------------------------|----------------------------------------------------|
| H                      | Previous Buffer                                    |
| L                      | Next Buffer                                        |
| SPC ,                  | Find Buffer in Project                             |
| SPC TAB                | Find All Buffers                                   |
| SPC .                  | File Browser                                       |
| SPC e                  | Open Tree                                          |
| SPC k                  | Kill current buffer                                |
| SPC A                  | Go to Test (and vsplit)                            |
| SPC a                  | Go to test                                         |
| SPC a                  | Go to test                                         |
| SPC l                  | List All Terminals (cool for opening closed tests) |
| SPC L                  | Mark Terminal to Send Text                         |
| SPC l (On visual mode) | Send text to marked terminal                       |
|------------------------|----------------------------------------------------|
| ]g                     | Next git hunk                                      |
| [g                     | Previous git hunk                                  |
|------------------------|----------------------------------------------------|
| ]e                     | Next Error                                         |
| [e                     | Previous Error                                     |
|------------------------|----------------------------------------------------|
| ]q                     | Next Quickfix                                      |
| [q                     | Previous Quickfix                                  |
|------------------------|----------------------------------------------------|

# Window Navigation

| Command | Description                |
|---------|----------------------------|
| M-h     | Focus Window in the left   |
| M-l     | Focus Window in the right  |
| M-j     | Focus Window in the bottom |
| M-k     | Focus Window in the top    |
| C-q     | Pick Window                |
| ;       | Go to next window          |
| ,       | Go to prev window          |
|---------|----------------------------|
| C-w u   | Undo a window closed       |
| C-w o   | Maximize window            |
|---------|----------------------------|

`<C-w>u` will undo a closed window.

# Searching

## Common search

| Command        | Description                                      |
|----------------|--------------------------------------------------|
| SPC SPC        | Find Files in Project                            |
| SPC s g        | Git Modified Files                               |
| SPC s i        | Search Document Symbols (Just love this command) |
| spc s j        | Search Workspace Symbols                         |
| SPC s s or C-s | Fuzzy find in current buffer                     |
| SPC s p        | Search text on project                           |
| SPC s P        | Search text on project using CocSearch           |
| SPC *          | Search text at point on project                  |
| C-j            | Go to next section                               |
| C-k            | Go to previous section                           |
|----------------|--------------------------------------------------|
| C-SPC          | Toggle Harpoon                                   |
| M              | Add file to harpoon                              |
| SPC 1 to SPC 4 | Change harpoon by order                          |
|----------------|--------------------------------------------------|

Quick Tip: You can come back to any telescope search with `SPC RET`.

## Search and Replace on file

| Command     | Mode            | Description                                                                        |
|-------------|-----------------|------------------------------------------------------------------------------------|
| gq          | normal          | Search and replace word at point                                                   |
| gQ          | normal          | Search and replace word at point keeping case                                      |
|-------------|-----------------|------------------------------------------------------------------------------------|
| gq          | visual          | Search and replace selection                                                       |
| gQ          | visual          | Search and replace selection keeping case                                          |
|-------------|-----------------|------------------------------------------------------------------------------------|
| gq          | visual line (V) | Search and replace some word in selected lines                                     |
| gQ          | visual line (V) | Search and replace some word in selected lines keeping case                        |
|-------------|-----------------|------------------------------------------------------------------------------------|
| X           | Visual          | Mark some text to be swap, then, select another text and press X to swap both      |
| cx + motion | Normal          | Mark motion to be swaped, then, select another text and press X or cx to swap both |
|-------------|-----------------|------------------------------------------------------------------------------------|

## Search and Replace on Project

Quick tip:

`:%s/old/new/gr` = Will change all occurrence of old to new
`:%S/old/new/gr` = Will change all occurrence of old to new and keep the case
`:%S/bount{y,ies}/prize{,s}/gr` = Will change bounty / bounties to prize / prizes

Extra tip: \0 = text that you searched.

You can:

1. use `SPC s p`, and then, press `C-q` to create a quickfix list.  You can navigate on quickfix with `]q` and `[q`.

To execute some command in all items of the quickfix list, just run `:cfdo S/old_text/new_text/gr | :w`

2. use `SPC s P`, find, and then edit the search result like a file. (i find this way easier)

# Using the tree like a boss

| Command | Description                                    |
|---------|------------------------------------------------|
| TAB     | Preview / expand                               |
| P       | Go to parent node (useful)                     |
| A       | Create new file or folder                      |
| r       | Rename the file                                |
| x       | Add or Remove current file to cut clipboard    |
| c       | Add or Remove current file to copy clipboard   |
| y       | Copy name to system clipboard                  |
| p       | Paste itens from the clipboard                 |
| d       | Delete file                                    |
| -       | Navigate to parent directory                   |
| s       | Open with default system application or folder |
| C-v     | Open in a vertical split                       |
| I       | Toggle Ignored Files                           |
| H       | Toggle Hidden FIles                            |
| R       | Refresh tree                                   |
| S       | Prompt a path and go to path                   |
|---------|------------------------------------------------|

# Editing

| Command | Description                                                                         |
|---------|-------------------------------------------------------------------------------------|
| SPC u   | Undo Tree (love this plugin)                                                        |
|---------|-------------------------------------------------------------------------------------|
| gh      | Move argument to left                                                               |
| gl      | Move argument to right                                                              |
|---------|-------------------------------------------------------------------------------------|
| gcc     | Comment (insert mode)                                                               |
| gc      | Comment (viaul mode)                                                                |
|---------|-------------------------------------------------------------------------------------|
| daa     | Delete argument                                                                     |
| gS      | Split to multiline method / args                                                    |
| gJ      | Join multiline method \ args                                                        |
| gs      | Toggle thing at point.  `:foo` to `foo =>` to `'foo'` and `do ... end` to `{ ... }` |
|---------|-------------------------------------------------------------------------------------|

# On the SPC . (file browser)

| Insert / Normal         | / Action                                                                    |
|-------------------------|-----------------------------------------------------------------------------|
| Most Important commands |                                                                             |
|-------------------------|-----------------------------------------------------------------------------|
| tab                     | Select item to move / copy / Rename                                         |
| C-a                     | Create file/folder at current path (trailing path separator creates folder) |
| C-v                     | Paste (multi-)selected files/folders to current path                        |
| C-r                     | Rename multi-selected files/folders                                         |
| C-e                     | Move multi-selected files/folders to current path                           |
| C-space                 | Delete (multi-)selected files/folders                                       |
| C-c/c                   | Go to parent directory                                                      |
|-------------------------|-----------------------------------------------------------------------------|
| Other commands          |                                                                             |
|-------------------------|-----------------------------------------------------------------------------|
| C-o/o                   | Open file/folder with default system application                            |
| C-w/w                   | Go to current working directory (cwd)                                       |
| C-t/t                   | Change nvim's cwd to selected folder/file(parent)                           |
| C-f/f                   | Toggle between file and folder browser                                      |
| C-h/h                   | Toggle hidden files/folders                                                 |
| C-s/s                   | Toggle all entries ignoring ./ and ../                                      |
|-------------------------|-----------------------------------------------------------------------------|

# Snippets and autocomplete

To use snippets, just press <tab> to expand and <tab> to move forward and <S-tab> to move backward.

I deactivated the TAB for go forward and backward on the list.  Use C-j and C-k or C-n and C-p.

To select, just press ENTER.  To close the suggestions pop-up, press C-e.

# Multiple Cursors

| Command | Description                         |
|---------|-------------------------------------|
| M-d     | Start multiple cursors / go forward |
| gq      | Select all occurrences              |
|---------|-------------------------------------|

# Ruby Stuff

| Commands | Description                                                    |
|----------|----------------------------------------------------------------|
| SPC m d  | Disable byebug at point.  use ]e [e to navigate between errors |
| SPC m l  | Extract let                                                    |
| SPC m v  | Extract local variable                                         |
| SPC m a  | Add Parameter                                                  |
|----------|----------------------------------------------------------------|

# Running stuff

## Test

| Command | Description          |
|---------|----------------------|
| SPC t v | Run current file     |
| SPC t s | Run nearest tests    |
| SPC t a | Run all tests        |
|---------|----------------------|

## Toggle Case

| Command | Description          |
|---------|----------------------|
| SPC n s | Toggle snake case    |
| SPC t s | Toggle CamelCase     |
| SPC t a | TOggle camelCaseB    |
|---------|----------------------|


## Terminal

`SPC v` open a blank terminal
`SPC !` rerun last terminal
`:Term command` open a terminal with the command

Go to your personal settings `SPC f p` and add terminal commands.  There is a bunch of examples there!

# Command mode

On command mode `:`, you can press C-v to paste, `C-a` to go back one word, and `C-e` to go forward one word.

## Additional Lsp Servers
To install additional servers, look for the plugin CoC


## Some useful plugins

`:TableModeEnable` will facilitate your life when creating tables

`:markdownPreview` is awesome to create markdown files.

### For additional commands, just press SPC and follow your heart.
