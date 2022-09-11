local M = {}

function M.show_message(expected, instead, goToInsert, hasCtrl)
  if goToInsert and hasCtrl then
    require('notify')('Use Ctrl-' .. expected .. ' or go to insert and use ' .. expected .. ' instead of ' .. instead .. '.', 'warn', { title = 'Bycicle without small whells' })
  elseif goToInsert then
    require('notify')('Go to insert and use ' .. expected .. ' instead of ' .. instead .. '.', 'warn', { title = 'Bycicle without small whells' })
  else
    require('notify')('Use ' .. expected .. ' instead of ' .. instead .. '.', 'warn', { title = 'Bycicle without small whells' })
  end
end

function M.remove_bicycle_small_whells(opts)
  local set = vim.keymap.set

  set('i', '<Left>', function() M.show_message("H", "Left Arrow", true, true) end)
  set('i', '<Right>', function() M.show_message("L", "Right Arrow", true, true) end)
  set('i', '<Up>', function() M.show_message("K", "Up Arrow", true) end)
  set('i', '<Down>', function() M.show_message("J", "Down Arrow", true) end)

  if opts.includeNormalMode then
    set({ 'n', 'v' }, '<Left>', function() M.show_message("H", "Left Arrow") end)
    set({ 'n', 'v' }, '<Right>', function() M.show_message("L", "Right Arrow") end)
    set({ 'n', 'v' }, '<Up>', function() M.show_message("K", "Up Arrow") end)
    set({ 'n', 'v' }, '<Down>', function() M.show_message("J", "Down Arrow") end)
  end
end

return M
