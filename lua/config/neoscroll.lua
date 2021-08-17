require("neoscroll").setup({
  easing_function = "quadratic",
})

local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
-- Use the "sine" easing function
t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "20", [['cubic']] } }
t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "20", [['cubic']] } }
-- Use the "circular" easing function
t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "50", [['cubic']] } }
-- Pass "nil" to disable the easing animation (constant scrolling speed)
t["<C-y>"] = { "scroll", { "-0.10", "false", "100", nil } }
t["<C-e>"] = { "scroll", { "0.10", "false", "100", nil } }
-- When no easing function is provided the default easing function (in this case "quadratic") will be used
t["zt"] = { "zt", { "10" } }
t["zz"] = { "zz", { "10" } }
t["zb"] = { "zb", { "10" } }

require("neoscroll.config").set_mappings(t)
