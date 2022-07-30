local function Split(s, delimiter)
  local result = {};

  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
    table.insert(result, match);
  end
  return result;
end

return { Split = Split }
