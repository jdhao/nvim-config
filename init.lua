-- This is my personal Nvim configuration supporting Mac, Linux and Windows, with various plugins configured.
-- This configuration evolves as I learn more about Nvim and become more proficient in using Nvim.
-- Since it is very long (more than 1000 lines!), you should read it carefully and take only the settings that suit you.
-- I would not recommend cloning this repo and replace your own config. Good configurations are personal,
-- built over time with a lot of polish.
--
-- Author: Jiedong Hao
-- Email: jdhao@hotmail.com
-- Blog: https://jdhao.github.io/
-- GitHub: https://github.com/jdhao
-- StackOverflow: https://stackoverflow.com/users/6064933/jdhao
local utils = require("utils")

vim.loader.enable()

local expected_version = "0.12.2"
utils.is_compatible_version(expected_version)

-- some global settings
require("globals")

-- setting options in nvim
require("options")

-- various autocommands
require("custom-autocmd")

-- all the user-defined mappings
require("mappings")

-- all the plugins installed and their configurations
require("plugin_specs")

-- This is done after plugin_specs, since lsp-config is loaded in that step
require("lsp_conf")

-- diagnostic related config
require("diagnostic-conf")

-- colorscheme settings
require("ui")
