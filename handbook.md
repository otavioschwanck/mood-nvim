## Welcome to the nvim-rails handbook

# First of all

You need to learn vim before start using this configuration.

Some ways to learn:

- https://www.youtube.com/watch?v=RZ4p-saaQkc
- Type vimtutor on terminal

# Customizing

To access your personal configuration, press `SPC f p`

On your personal configuration you can configure stuff like commands to run with `SPC o`, per folder, theme, etc.

# Quick Tips

- To navigate on telescope use C-j and C-k.
- To command history on harpoon, use C-n and C-p.

# Buffer Navigation and Management

| Command | Description             |
|---------|-------------------------|
| H       | Previous Buffer         |
| L       | Next Buffer             |
| SPC ,   | Find Buffer             |
| SPC e   | Open Tree               |
| SPC k   | Kill current buffer     |
| SPC A   | Go to Test (and vsplit) |
| SPC a   | Go to test              |
| SPC a   | Go to test              |
|---------|-------------------------|
| ]g      | Next git hunk           |
| [g      | Previous git hunk       |
|---------|-------------------------|
| ]e      | Next Error              |
| [e      | Previous Error          |
|---------|-------------------------|
| ]q      | Next Quickfix           |
| [q      | Previous Quickfix       |
|---------|-------------------------|

# Window Navigation

Just C-h C-j C-k C-l

`<C-w>u` will undo a closed window.

# Searching

## Common search

| Command        | Description                                      |
|----------------|--------------------------------------------------|
| SPC SPC        | Find Files in Project                            |
| SPC s g        | Git Modified Files                               |
| SPC s i        | Search Document Symbols (Just love this command) |
| spc s j        | Search Workspace Symbols                         |
| SPC s s        | Fuzzy find in current buffer                     |
| SPC s p        | Search text on project                           |
| SPC s P        | Search text on project using CocSearch           |
| SPC *          | Search text at point on project                  |
|----------------|--------------------------------------------------|
| C-SPC          | Toggle Harpoon                                   |
| C-s            | Add file to harpoon                              |
| SPC 1 to SPC 4 | Change harpoon by order                          |
|----------------|--------------------------------------------------|

Quick Tip: You can come back to any telescope search with `SPC RET`.

## Search and Replace on Project

Quick tip:

`:%s/old/new/gr` = Will change all occurrence of old to new
`:%S/old/new/gr` = Will change all occurrence of old to new and keep the case
`:%S/bount{y,ies}/prize{,s}/gr` = Will change bounty / bounties to prize / prizes

You can:

1. use `SPC s p`, and then, press `C-q` to create a quickfix list.  You can navigate on quickfix with `]q` and `[q`.

To execute some command in all items of the quickfix list, just run `:cfdo S/old_text/new_text/gr | :w`

2. use `SPC s P`, find, and then edit the search result like a file. (i find this way easier)

# Using the tree like a boss

| Command | Description                                    |
|---------|------------------------------------------------|
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

# Snippets and autocomplete

To use snippets, just press <tab> to expand and <tab> to move forward and <S-tab> to move backward.

I deactivated the TAB for go forward and backward on the list.  Use C-j and C-k or C-n and C-p.

To select, just press ENTER.  To close the suggestions pop-up, press C-e.

# Multiple Cursors

| Command | Description                         |
|---------|-------------------------------------|
| C-q     | Start multiple cursors / go forward |
| gq      | Select all occurrences              |
|---------|-------------------------------------|

# Running stuff

## Test

| Command | Description       |
|---------|-------------------|
| SPC t v | Run current file  |
| SPC t s | Run nearest tests |
| SPC t a | Run all tests     |
|---------|-------------------|

## Terminal

`SPC v` open a blank terminal
`:Term command` open a terminal with the command

## Additional Lsp Servers
To install additional servers, look for the plugin CoC


## Some useful plugins

`:TableModeEnable` will facilitate your life when creating tables

### For additional commands, just press SPC and follow your heart.
