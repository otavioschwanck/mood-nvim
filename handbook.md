# Welcome to the mood handbook

# First of all

You need to learn vim before start using this configuration.

Some ways to learn:

- https://www.youtube.com/watch?v=RZ4p-saaQkc
- Type vimtutor on terminal

# Quick Tips

- To navigate on telescope use ]] and [[
- To command history on telescope, use C-n and C-p.
- C-c means Ctrl + c
- SPC = Space
- M-c means Alt + c or Command + c
- To open / close the panel at right, press SPC f o


# TMUX & Alacritty [!important]

To use this configuration at your full potential, you need to use it with TMUX and Alacritty.

Make sure TPM is installed on your home folder (Tmux Plugin Manager) (mood-installer installs automatically)

After your tmux first open, press `C-x I` to install the packages.

I also recommend `tmuxinator` to manage your projects.

This configuration uses `tmux-awesome-manager` to manage multiple terminals.  You can configure your own commands on `SPC f p` and go to the Keybindings.

To see the already configured commands, press `SPC l f`.

## Codeium IA Autocomplete (like copilot / whisperer)

Run :Codeium Auth and follow the instructions.

To expand the suggestion, press `<C-j>`

To go to next suggestion, press `<C-f>`

To clear suggestions, press `<C-]>`

Use C-f and C-b to cycle on codeium suggestions.

## Tmux Awesome Manager

| Command              | Description                                               |
|----------------------|-----------------------------------------------------------|
| SPC l l              | List open terminals                                       |
| SPC l f              | List all mapped commands                                  |
| SPC l k              | Kill all terminals                                        |
| SPC l p              | Switch: Open new terminals at window / pane               |
| SPC l o              | Switch: Orientation of new panes to horizontal / vertical |
| SPC l on visual mode | Send text terminal window                                 |

## TMUX integration with alacritty

Tmux prefix: C-x.  See more of tmux by accessing your ~/.tmux.conf
Alacritty Configuration: SPC f p -> Alacritty.

Every command inside tmux is called using a prefix.  Alacritty allows to bypass the prefix, like: To switch tabs on tmux, is C-x 1,  with
alacritty, is possible to map alt/cmd + 1 to call C-x 1 inside terminal.  Every major command is already mapped. 

Explaining the commands (keybindings):
M-o = Alt or Command + o
M-S-v = Alt or command + shift + v

Explaining tmux structure:

Tmux: has many sessions
Session = has many windows
Window = is like a tab on common terminals
Pane = A split inside a window

Movimentation and Navigation:

| Command         | Description                                                                                    |
|-----------------|------------------------------------------------------------------------------------------------|
| M-/             | Search on tmux                                                                                 |
| M-o             | Go to next pane                                                                                |
| M-1 to M-9      | Switch window                                                                                  |
| M-S-a           | See all sessions (Press x to close one)                                                        |
| M-S-n and M-S-p | Next / Previous session                                                                        |
| M-Esc           | Go to next pane and maximize                                                                   |
| M-Esc           | Go to next pane and maximize                                                                   |
| M-a             | Alternate between current window and last window                                               |
| M-,             | Go to previous pane / nvim pane                                                                |
| M-;             | Go to next pane / nvim pane                                                                    |
| M-S-f           | Search text in your terminal and copy / insert, super useful to copy id or some command output |

Obs: C-; C-, works for neovim splits too (thanks for a script)

## Window / Tab Management inside Tmux:

| Command  | Description                                   |
|----------|-----------------------------------------------|
| M-RET    | Maximize pane                                 |
| M-S-v    | Split vertically                              |
| M-S-s    | Split horizontally                            |
| M-S-hjkl | Resize pane to direction                      |
| M-t      | New window                                    |
| M-S-t    | New session                                   |
| M-j      | Join current window to another window as pane |
| M-k      | Detach current pane as new window             |
| M-S-d    | Detach tmux session                           |
| M-x      | Close window / pane                           |
| M-i      | Switch orientation of panes                   |
| M-S-i    | Switch windows                                |

## Copy / search / Navigate:

| Command | Description                                                                                              |
|---------|----------------------------------------------------------------------------------------------------------|
| M-/     | Search on terminal (Use n and N to go next / previous, you can press any vim motion after and y to copy)
| M-[     | Go to cim mode inside terminal                                                                        |

# On the SPC . (file browser)

I Consider this way the most efficient way to create files and find files on current file folder.  
Also, is very good to move files between folders.

| insert keybinding |  Action                                     |
|-------------------|---------------------------------------------|
| tab               |  Select a file (to move, delete, copy, etc) |
| C-f               |  Go to a folder (search folders)            |
| C-d               |  Delete selected files                      |
| C-v               |  Paste selected files (make a copy)         |
| C-x               |  Paste selected files (move / cut)          |
| C-Space           |  Create a new file from text in prompt      |
| C-r               |  Rename file / selected files               |
| C-b               |  Go to project root                         |

- Example of usage: https://imgur.com/BNK1JCt

# Arrow (File bookmarks)

Arrow is awesome and you should use.  Add boomarks for you files.

|-----------------|--------------------------------------------------------|
| Command         | Description                                            |
|-----------------|--------------------------------------------------------|
| ;               | Save file on arrow                                     |
| H and L         | Next / Previous bookmark                               | 
|-----------------|--------------------------------------------------------|

# Buffer Navigation and Management

| Command                  | Description                                          |
| ------------------------ | ---------------------------------------------------- |
| H                        | Previous Buffer (Tab)                                |
| L                        | Next Buffer (Tab)                                    |
| SPC ,                    | Find Buffer in Project                               |
| SPC TAB                  | Git Status                                           |
| SPC .                    | File Browser                                         |
| SPC e                    | Open Tree                                            |
| SPC k                    | Kill current buffer                                  |
| SPC K                    | Kill current buffer (Force)                          |
| SPC b D                  | Close All Buffers But Current                        |
| SPC A                    | Go to Test (and vsplit)                              |
| SPC a                    | Go to test                                           |
| ------------------------ | ---------------------------------------------------- |
| ]g                       | Next git hunk                                        |
| [g                       | Previous git hunk                                    |
| ------------------------ | ---------------------------------------------------- |
| ]d                       | Next Error                                           |
| [d                       | Previous Error                                       |
| ------------------------ | ---------------------------------------------------- |
| ]q                       | Next Quickfix                                        |
| [q                       | Previous Quickfix                                    |
| ------------------------ | ---------------------------------------------------- |

# Bookmarks

| Command                  | Description                                          |
| ------------------------ | ---------------------------------------------------- |
| SPC h l                  | Load last session for this project                   |
| SPC 1 to SPC 9           | Navigate Tabs                                        |


# LSP (Language Server Protocol)

| Command | Description                                                      |
|---------|------------------------------------------------------------------|
| gd      | Go to definition                                                 |
| gr      | See references                                                   |
| gt      | Type Definition                                                  |
| SPC c x | List all diagnostics                                             |
| SPC c a | Code Actions                                                     |
| SPC c f | Format document with LSP                                         |
| SPC s i | Document Symbols                                                 |
| SPC s j | Workspace Symbols                                                |

To configure your LSP: SPC f p + lsp

# Window Navigation

| Command  | Description                                              |
|----------|----------------------------------------------------------|
| M-, or , | Focus Previous Window                                    |
| M-; or ; | Focus Next window                                        |
|----------|----------------------------------------------------------|
| C-w o    | Maximize window                                          |

# Searching

## Common search

| Command | Description                                                                                     |
|---------|-------------------------------------------------------------------------------------------------|
| SPC SPC | Find Files in Project (Based on git)                                                            |
| SPC f f | Find files in current cwd (slower but more cmoplete)                                            |
| SPC TAB | Git Modified Files                                                                              |
| SPC s i | Search Document Symbols (Just love this command)                                                |
| spc s j | Search Workspace Symbols                                                                        |
| SPC s s | Fuzzy find in current buffer                                                                    |
| SPC s p | Search text on project, keep pressing shift + enter (requires tmux + alacritty) to chain search |
| SPC *   | Search text at point on project                                                                 |
| SPC f
|---------|-------------------------------------------------------------------------------------------------|

Quick Tip: You can come back to any telescope search with `SPC RET` (Resume).

## Search and Replace on Project

Quick tip:

`:%s/old/new/gr` = Will change all occurrence of old to new
`:%S/old/new/gr` = Will change all occurrence of old to new and keep the case
`:%S/bount{y,ies}/prize{,s}/gr` = Will change bounty / bounties to prize / prizes

Extra tip: \0 = text that you searched.

You can:

1. Just type SPC s r

2. use `SPC s p`, and then, press `C-q` to create a quickfix list from all results or `C-e` to create from the selected only (press tab to select).  You can navigate on quickfix with `]q` and `[q`.

To execute some command in all items of the quickfix list, just run `:cfdo S/old_text/new_text/gr | :wq` (or /grc if you want confirmation)

1. use `SPC s f`, find, and then edit the search result like a file. (i find this way easier most of the time)

# Using the tree like a boss

| Command     | Description                      |
|-------------|----------------------------------|
| TAB         | Preview / expand                 |
| SPC e       | Open the tree                    |
| SPC E       | Open the tree on current file    |
| g?          | See all possible commands        |
|-------------|----------------------------------|

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
| daa     | Delete argument (foo, <cursor here>bar, foo) -> (foo, foo)                          |
| gS      | Split to multiline method / args                                                    |
| gJ      | Join multiline method \ args                                                        |
| gs      | Toggle thing at point.  `:foo` to `foo =>` to `'foo'` and `do ... end` to `{ ... }` |
|---------|-------------------------------------------------------------------------------------|

# Snippets and autocomplete

But just press C-n after a snippet and you go forward! trust me. (Check your lsp.lua to see if is C-n), it was changed recently

To open/close the autocomplete, just press C-e.

95% of time you can use just `M` to do it.

# Ruby Stuff

| Commands | Description                                                    |
|----------|----------------------------------------------------------------|
| SPC m d  | Disable byebug at point.  use ]e [e to navigate between errors |
| SPC m l  | Extract let                                                    |
| SPC m v  | Extract local variable                                         |
| SPC m a  | Add Parameter                                                  |
| SPC m f  | On visual mode, extract the function                           |
| SPC m f  | On normal mode, create function from the text at cursor.       |
|----------|----------------------------------------------------------------|

# Running stuff

## TestS

| Command | Description                                                                                   |
|---------|-----------------------------------------------------------------------------------------------|
| SPC t v | Run current file                                                                              |
| SPC t s | Run nearest tests                                                                             |
| SPC t a | Run all tests                                                                                 |
| SPC t o | Open the failed tests on a quick fix list (only rspec)                                        |
| SPC t b | Open backtrace of failed test on cursor (only rspec)                                          |
| SPC t w | Focus test window (after ]e and [e, SUPER USEFUL to copy the test result. Use SPC k to close. |
| SPC t r | Rerun last test                                                                               |
| SPC t f | Rerun only failures                                                                           |
|---------|-----------------------------------------------------------------------------------------------|

## Toggle Case

| Command | Description          |
|---------|----------------------|
| SPC n s | Toggle snake case    |
| SPC t s | Toggle CamelCase     |
| SPC t a | TOggle camelCaseB    |
|---------|----------------------|

## Templates

mooD has some awesome templates that you can add.  To see how to use, just go: https://github.com/otavioschwanck/new-file-template.nvim

## Some useful plugins

`:Tableize` will facilitate your life when creating tables.  Change from this:

|editor|awesomeness|
|-|
|nvim|10|
|emacs|9|
|vscode|0|

to this:

| editor | awesomeness |
|--------|-------------|
| nvim   | 10          |
| emacs  | 9           |
| vscode | 0           |


### Reseting configs

After while, i add some new features on the base configs (like tmux, alacritty, lsp, etc).  You can:

:CleanConfigsExceptBaseConfig = Clean everything, except config.lua (recommended)
:CleanConfigs = Clean everything, including config.lua
:CleanConfigsExceptUsers = Clean tmux, alacritty and lazygit.

### For additional commands, just press SPC and follow your heart.
