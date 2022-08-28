-- This is my personal Nvim configuration supporting Mac, Linux and Windows, with various plugins configured.
-- This configuration evolves as I learn more about Nvim and become more proficient in using Nvim.
-- Since it is very long (more than 1000 lines!), you should read it carefully and take only the settings that suit you.
-- I would not recommend cloning this repo and replace your own config. Good configurations are personal,
-- built over time with a lot of polish.
--
-- Author: Jie-dong Hao
-- Email: jdhao@hotmail.com
-- Blog: https://jdhao.github.io/

  -- check if we have the latest stable version of nvim
local expected_ver = "0.7.2"

local utils = require "utils"
local nvim_ver = utils.get_nvim_version()

if nvim_ver ~= expected_ver then
  local msg = string.format("Unsupported nvim version: expect %s, but got %s instead!", expected_ver, nvim_ver)
  vim.api.nvim_echo({ { msg, "ErrorMsg" } }, false, {})
  return
end

local core_conf_files = {
  "globals.vim",       -- some global settings
  "options.vim",       -- setting options in nvim
  "autocommands.vim",  -- various autocommands
  "mappings.vim",      -- all the user-defined mappings
  "plugins.vim",       -- all the plugins installed and their configurations
  "colorschemes.lua",  -- colorscheme settings
}

-- source all the core config files
for _, name in ipairs(core_conf_files) do
  local path = string.format("%s/core/%s", vim.fn.stdpath('config'), name)
  local source_cmd = "source " .. path
  vim.cmd(source_cmd)
end
