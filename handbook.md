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

This configuration uses `tmux-awesome-manager` to manage multiple terminals.  You can configure your own commands on `SPC f p`.

To see the already configured commands, press `SPC l f`.

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

Tmux prefix: C-x.  See more of tmux pressing `SPC o d t`
Alacritty Configuration: `SPC o d a`.  (You can change here your font size, terminal theme, etc)

Every command inside tmux is called using a prefix.  Alacritty allows to bypass the prefix, like: To switch tabs on tmux, is C-x 1,  with
alacritty, is possible to map alt/cmd + 1 to call C-x 1 inside terminal.  Every major command is already mapped.  See your alacritty config at: `SPC o d a`.

Explaining the commands (keybindings):
M-o = Alt or Command + o
M-S-v = Alt or command + shift + v

Explaining tmux structure:

Tmux: has many sessions
Session = has many windows
Window = is like a tab on common terminals
Pane = A split inside a window

Movimentation and Navigation:

| Command         | Description                                      |
|-----------------|--------------------------------------------------|
| M-o             | Go to next pane                                  |
| M-1 to M-9      | Switch window                                    |
| M-S-a           | See all sessions (Press x to close one)          |
| M-S-n and M-S-p | Next / Previous session                          |
| M-Esc           | Go to next pane and maximize                     |
| M-Esc           | Go to next pane and maximize                     |
| M-a             | Alternate between current window and last window |
| C-,             | Go to previous pane / nvim pane                  |
| C-;             | Go to next pane / nvim pane                      |

Obs: C-; C-, works for neovim splits too (thanks for a script)
Obs2: Maybe you need to upgrade your alacritty.yml and tmux.conf.  Press SPC f d and delete those files.

Management:

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

Copy / search / Navigate:

| Command | Description                                                                                              |
|---------|----------------------------------------------------------------------------------------------------------|
| M-/     | Search on terminal (Use n and N to go next / previous, you can press any vim motion after and y to copy)
| M-,     | Copy a text from the terminal                                                                            |
| M-;     | Switch orientation of panes                                                                              |
| M-[     | Go to normal mode inside terminal                                                                        |

# Harpoon

Just press `;` and follow your heart.

# Quick Consult

| Command   | MODE   | Description                                 |
|-----------|--------|---------------------------------------------|
| C-g       | Visual | Save selection to quick consult             |
| C-g       | Normal | Open Saved text from quick consult          |
| SPC C-g   | Visual | Append Selection to quick consult           |
| SPC C-g a | Normal | Append Text from clipboard to quick consult |
| SPC C-g s | Normal | Save Text from clpiboard to quick consult   |
|-----------|--------|---------------------------------------------|

OBS: This list persist between vim sections

# Buffer Navigation and Management

| Command                | Description                                        |
|------------------------|----------------------------------------------------|
| H                      | Previous Visited Buffer (History)                  |
| L                      | Next Visit Buffer (History)                        |
| SPC ,                  | Find Buffer in Project                             |
| SPC TAB                | Git Status                                         |
| SPC .                  | File Browser                                       |
| SPC e                  | Open Tree                                          |
| SPC k                  | Kill current buffer                                |
| SPC A                  | Go to Test (and vsplit)                            |
| SPC a                  | Go to test                                         |
| SPC 1 to SPC 9         | Go to harpoons                                     |
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

# LSP (Language Server Protocol)

| Command                | Description                                        |
|------------------------|----------------------------------------------------|
| gd                     | Go to definition                                   |
| gr                     | See references                                     |
| gt                     | Type Definition                                    |
| SPC c x                | List all diagnostics                               |
| SPC c a                | Code Actions (Awesome for JS/TS)                   |
| SPC c f                | Format document with LSP                           |
| SPC s i                | Document Symbols                                   |
| SPC s j                | Workspace Symbols                                  |

To learn more about the LSP used on mooD:
https://github.com/VonHeikemen/lsp-zero.nvim

To configure your LSP: SPC f p + lsp

# Window Navigation

| Command | Description                                              |
|---------|----------------------------------------------------------|
| C-,     | Focus Previous Window                                    |
| C-;     | Focus Next window                                        |
|---------|----------------------------------------------------------|
| C-w o   | Maximize window                                          |
| ENTER   | Maximize window temporary (press ENTER again to restore)

`<C-w>u` will undo a closed window.

# Searching

## Common search

| Command | Description                                                                                     |
|---------|-------------------------------------------------------------------------------------------------|
| SPC SPC | Find Files in Project                                                                           |
| SPC TAB | Git Modified Files                                                                              |
| SPC s i | Search Document Symbols (Just love this command)                                                |
| spc s j | Search Workspace Symbols                                                                        |
| SPC s s | Fuzzy find in current buffer                                                                    |
| SPC s p | Search text on project, keep pressing shift + enter (requires tmux + alacritty) to chain search |
| SPC *   | Search text at point on project                                                                 |
|---------|-------------------------------------------------------------------------------------------------|

Quick Tip: You can come back to any telescope search with `SPC RET`.

## Search and Replace on Project

Quick tip:

`:%s/old/new/gr` = Will change all occurrence of old to new
`:%S/old/new/gr` = Will change all occurrence of old to new and keep the case
`:%S/bount{y,ies}/prize{,s}/gr` = Will change bounty / bounties to prize / prizes

Extra tip: \0 = text that you searched.

You can:

1. use `SPC s p`, and then, press `C-q` to create a quickfix list from all results or `C-e` to create from the selected only (press tab to select).  You can navigate on quickfix with `]q` and `[q`.

To execute some command in all items of the quickfix list, just run `:cfdo S/old_text/new_text/gr | :wq` (or /grc if you want confirmation)

2. use `SPC s f`, find, and then edit the search result like a file. (i find this way easier most of the time)

# Using the tree like a boss

| Command | Description               |
|---------|---------------------------|
| TAB     | Preview / expand          |
| SPC e   | Open the tree             |
| SPC E   | Git Status on tree        |
| ?       | See all possible commands |
|---------|---------------------------|

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

I Consider this way the most efficient way to create files and find files on current file folder.

| Insert / Normal              | / Action                                                            |
|------------------------------|---------------------------------------------------------------------|
| Most Important commands      |                                                                     |
|------------------------------|---------------------------------------------------------------------|
| tab                          | Mark item to item to move / copy / Rename                           |
| C-f                          | Go to a folder on project (super useful to create new files / move) |
| C-space or S-RET (alacritty) | Create file/folder from what you typed on prompt                    |
| C-p                          | Paste Stuff that will marked with tab                               |
| C-r                          | Rename multi-selected files/folders                                 |
| C-e                          | Move multi-selected files/folders to current path                   |
| C-c/c                        | Go to parent directory                                              |
| C-o/o                        | Delete selected file(s)                                             |
| C-g                          | Go to current working directory (cwd)                               |
|------------------------------|---------------------------------------------------------------------|
| Other commands               |                                                                     |
|------------------------------|---------------------------------------------------------------------|
| C-o/o                        | Open file/folder with default system application                    |
| C-t/t                        | Change nvim's cwd to selected folder/file(parent)                   |
| C-f/f                        | Toggle between file and folder browser                              |
| C-h/h                        | Toggle hidden files/folders                                         |
| C-s/s                        | Toggle all entries ignoring ./ and ../                              |
|------------------------------|---------------------------------------------------------------------|

# Snippets and autocomplete

See: https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/#snippets

But just press C-d after a snippet and you go forward! trust me.

To open / close the autocomplete, just press C-e.

# Emmet
Just press C-p to expand.

# Multiple Cursors (Cool Substitute)

| Command  | Description                                                                        |
|----------|------------------------------------------------------------------------------------|
| gM       | start multiple cursor and edit current word                                        |
| gm       | start multiple cursor but doesn't edit current word                                |
| g!M      | start multiple cursor and edit current word, only edit full word                   |
| g!m      | start multiple cursor but doesn't edit current word, only edit full word           |
| M        | start multiple cursors and edit cw / finish multiple cursor / Apply and go to next |
| Ctrl + b | Same as M but backwards                                                            |
| ENTER    | Skip current editing and go next                                                   |
| ga       | Apply editing to all                                                               |
|----------|------------------------------------------------------------------------------------|

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

| Command | Description                                                                                   |
|---------|-----------------------------------------------------------------------------------------------|
| SPC t v | Run current file                                                                              |
| SPC t s | Run nearest tests                                                                             |
| SPC t a | Run all tests                                                                                 |
| ]e      | Go to next test                                                                               |
| [e      | Go to prev test                                                                               |
| SPC t w | Focus test window (after ]e and [e, SUPER USEFUL to copy the test result. Use SPC k to close. |
| SPC t r | Rerun last test                                                                               |
| SPC t f | Rerun only failures                                                                           |
| SPC t k | Clear tests from buffer                                                                       |
|---------|-----------------------------------------------------------------------------------------------|

## Toggle Case

| Command | Description          |
|---------|----------------------|
| SPC n s | Toggle snake case    |
| SPC t s | Toggle CamelCase     |
| SPC t a | TOggle camelCaseB    |
|---------|----------------------|


# Command mode

On command mode `:`, you can press C-v to paste, `C-j` to go back one word, and `C-k` to go forward one word.

## Some useful plugins

`:TableModeEnable` will facilitate your life when creating tables

### Reseting configs

After while, i add some new features on the base configs (like tmux, alacritty, lsp, etc).  You can:

:CleanConfigsExceptBaseConfig = Clean everything, except config.lua (recommended)
:CleanConfigs = Clean everything, including config.lua
:CleanConfigsExceptUsers = Clean tmux, alacritty and lazygit.

### For additional commands, just press SPC and follow your heart.
