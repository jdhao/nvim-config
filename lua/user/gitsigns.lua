local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end
require('gitsigns').setup()