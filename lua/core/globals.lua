local M = {}

function M.setup()
  vim.g.camelsnek_i_am_an_old_fart_with_no_sense_of_humour_or_internet_culture = 1
  vim.g.closetag_filenames = '*.html,*.xhtml,*.phtml,*.erb'
  vim.g.multi_cursor_use_default_mapping = 0
  vim.g.multi_cursor_start_word_key      = 'M'
  vim.g.multi_cursor_next_key            = 'M'
  vim.g.multi_cursor_quit_key            = '<Esc>'
  vim.g.yoinkSavePersistently = 1
  vim.g.yoinkIncludeDeleteOperations = 1
  vim.g.yoinkMaxItems = 20
  vim.g.ruby_debugger = "byebug"
  vim.g.last_term_command = {}
  vim.g.term_as_full_screen_tabs = 1
  vim.g.any_jump_disable_default_keybindings = 1
  vim.g.ruby_refactoring_map_keys = 0
  vim.g['test#strategy'] = 'splitterm'
  vim.g.dashboard_default_executive ='telescope'
  vim.g.table_mode_disable_tableize_mappings = 1
  vim.g.table_mode_disable_mappings = 1
  vim.g.HowMuch_no_mappings = 1
  vim.g.send_disable_mapping = 1
  vim.g.folder_to_ignore = {".*.git/.*", "node_modules/.*"}

  vim.g.UltiSnipsSnippetDirectories = {"UltiSnips", "user-snippets"}
  vim.g.choosewin_overlay_enable = 1

  vim.cmd("let test#ruby#rspec#options = { 'file': '--format documentation' }")
  vim.cmd("let g:test#custom_strategies = {'splitterm': function('SplitTermStrategy')}")

end

M.setup()

return M
