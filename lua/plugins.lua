local utils = require("utils")
local fn = vim.fn

-- The root dir to install all plugins. Plugins are under opt/ or start/ sub-directory.
vim.g.plugin_home = fn.stdpath("data") .. "/site/pack/packer"

-- Where to install packer.nvim -- the package manager (we make it opt)
local packer_dir = vim.g.plugin_home .. "/opt/packer.nvim"

-- Whether this is a fresh install, i.e., packer itself and plugins have not been installed.
local fresh_install = false

-- Auto-install packer in case it hasn't been installed.
if fn.glob(packer_dir) == "" then
  fresh_install = true

  -- Now we need to install packer.nvim first.
  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local install_cmd = string.format("!git clone --depth=1 %s %s", packer_repo, packer_dir)

  vim.api.nvim_echo({ { "Installing packer.nvim", "Type" } }, true, {})
  vim.cmd(install_cmd)
end

-- Load packer.nvim
vim.cmd("packadd packer.nvim")

local packer = require("packer")
local packer_util = require('packer.util')

packer.startup({
  function(use)
    -- it is recommened to put impatient.nvim before any other plugins
    use {'lewis6991/impatient.nvim', config = [[require('impatient')]]}

    use({"wbthomason/packer.nvim", opt = true})

    use({"onsails/lspkind-nvim", event = "VimEnter"})
    -- auto-completion engine
    use {"hrsh7th/nvim-cmp", after = "lspkind-nvim", config = [[require('config.nvim-cmp')]]}

    -- nvim-cmp completion sources
    use {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"}
    -- use {"hrsh7th/cmp-nvim-lua", after = "nvim-cmp"}
    use {"hrsh7th/cmp-path", after = "nvim-cmp"}
    use {"hrsh7th/cmp-buffer", after = "nvim-cmp"}
    use { "hrsh7th/cmp-omni", after = "nvim-cmp" }

    -- use {"hrsh7th/cmp-cmdline", after = "nvim-cmp"}
    use {"quangnguyen30192/cmp-nvim-ultisnips", after = {'nvim-cmp', 'ultisnips'}}
    if vim.g.is_mac then
      use {"hrsh7th/cmp-emoji", after = 'nvim-cmp'}
    end

    -- nvim-lsp configuration (it relies on cmp-nvim-lsp, so it should be loaded after cmp-nvim-lsp).
    use({ "neovim/nvim-lspconfig", after = "cmp-nvim-lsp", config = [[require('config.lsp')]] })

    if vim.g.is_mac then
      use({ "nvim-treesitter/nvim-treesitter", event = 'BufEnter', run = ":TSUpdate", config = [[require('config.treesitter')]] })
    end

    -- Python indent (follows the PEP8 style)
    use({ "Vimjas/vim-python-pep8-indent", ft = { "python" } })

    -- Python-related text object
    use({ "jeetsukumaran/vim-pythonsense", ft = { "python" } })

    use({"machakann/vim-swap", event = "VimEnter"})

    -- IDE for Lisp
    if utils.executable("sbcl") then
      -- use 'kovisoft/slimv'
      use({ "vlime/vlime", rtp = "vim/", ft = { "lisp" } })
    end

    -- Super fast buffer jump
    use {
      'phaazon/hop.nvim',
      event = "VimEnter",
      config = function()
        vim.defer_fn(function() require('config.nvim_hop') end, 2000)
      end
    }

    -- Clear highlight search automatically for you
    -- use({"romainl/vim-cool", event = "VimEnter"})

    -- Show match number and index for searching
    use {
      'kevinhwang91/nvim-hlslens',
      branch = 'main',
      keys = {{'n', '*'}, {'n', '#'}, {'n', 'n'}, {'n', 'N'}},
      config = [[require('config.hlslens')]]
    }

    -- Stay after pressing * and search selected text
    use({"haya14busa/vim-asterisk", event = 'VimEnter'})

    -- File search, tag search and more
    if vim.g.is_win then
      use({"Yggdroot/LeaderF", cmd = "Leaderf"})
    else
      use({ "Yggdroot/LeaderF", cmd = "Leaderf", run = ":LeaderfInstallCExtension" })
    end

    use {
      'nvim-telescope/telescope.nvim', cmd = 'Telescope',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- search emoji and other symbols
    use {'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim'}

    -- Another similar plugin is command-t
    -- use 'wincent/command-t'

    -- Another grep tool (similar to Sublime Text Ctrl+Shift+F)
    -- use 'dyng/ctrlsf.vim'

    -- A grepping tool
    -- use {'mhinz/vim-grepper', cmd = {'Grepper', '<plug>(GrepperOperator)'}}

    -- A list of colorscheme plugin you may want to try. Find what suits you.
    use({"lifepillar/vim-gruvbox8", opt = true})
    use({"navarasu/onedark.nvim", opt = true})
    use({"sainnhe/edge", opt = true})
    use({"sainnhe/sonokai", opt = true})
    use({"sainnhe/gruvbox-material", opt = true})
    use({"shaunsingh/nord.nvim", opt = true})
    use({"NTBBloodbath/doom-one.nvim", opt = true})
    use({"sainnhe/everforest", opt = true})
    use({"EdenEast/nightfox.nvim", opt = true})
    use({"rebelot/kanagawa.nvim", opt = true})
    use({"catppuccin/nvim", as = "catppuccin", opt = true})

    -- Show git change (change, delete, add) signs in vim sign column
    use({"mhinz/vim-signify", event = 'BufEnter'})
    -- Another similar plugin
    -- use 'airblade/vim-gitgutter'

    use {'kyazdani42/nvim-web-devicons', event = 'VimEnter'}

    use {
      'nvim-lualine/lualine.nvim',
      event = 'VimEnter',
      config = [[require('config.statusline')]]
    }

    use({ "akinsho/bufferline.nvim", event = "VimEnter", config = [[require('config.bufferline')]] })

    -- fancy start screen
    use { 'glepnir/dashboard-nvim', event = "VimEnter", config = [[require('config.dashboard-nvim')]] }

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = 'VimEnter',
      config = [[require('config.indent-blankline')]]
    })

    -- Highlight URLs inside vim
    use({"itchyny/vim-highlighturl", event = "VimEnter"})

    -- notification plugin
    use({
      "rcarriga/nvim-notify",
      event = "BufEnter",
      config = function()
        vim.defer_fn(function() require('config.nvim-notify') end, 2000)
      end
    })

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    if vim.g.is_win or vim.g.is_mac then
      -- open URL in browser
      use({"tyru/open-browser.vim", event = "VimEnter"})
    end

    -- Only install these plugins if ctags are installed on the system
    if utils.executable("ctags") then
      -- show file tags in vim window
      use({"liuchengxu/vista.vim", cmd = "Vista"})
    end

    -- Snippet engine and snippet template
    use({"SirVer/ultisnips", event = 'InsertEnter'})
    use({ "honza/vim-snippets", after = 'ultisnips'})

    -- Automatic insertion and deletion of a pair of characters
    use({"Raimondi/delimitMate", event = "InsertEnter"})

    -- Comment plugin
    use({"tpope/vim-commentary", event = "VimEnter"})

    -- Multiple cursor plugin like Sublime Text?
    -- use 'mg979/vim-visual-multi'

    -- Autosave files on certain events
    use({"907th/vim-auto-save", event = "InsertEnter"})

    -- Show undo history visually
    use({"simnalamburt/vim-mundo", cmd = {"MundoToggle", "MundoShow"}})

    -- Manage your yank history
    if vim.g.is_win or vim.g.is_mac then
      use({"svermeulen/vim-yoink", event = "VimEnter"})
    end

    -- Handy unix command inside Vim (Rename, Move etc.)
    use({"tpope/vim-eunuch", cmd = {"Rename", "Delete"}})

    -- Repeat vim motions
    use({"tpope/vim-repeat", event = "VimEnter"})

    -- Show the content of register in preview window
    -- Plug 'junegunn/vim-peekaboo'
    use({ "jdhao/better-escape.vim", event = { "InsertEnter" } })

    if vim.g.is_mac then
      use({ "lyokha/vim-xkbswitch", event = { "InsertEnter" } })
    elseif vim.g.is_win then
      use({ "Neur1n/neuims", event = { "InsertEnter" } })
    end

    -- Syntax check and make
    -- use 'neomake/neomake'

    -- Auto format tools
    use({ "sbdchd/neoformat", cmd = { "Neoformat" } })
    -- use 'Chiel92/vim-autoformat'

    -- Git command inside vim
    use({ "tpope/vim-fugitive", event = "User InGitRepo" })

    -- Better git log display
    use({ "rbong/vim-flog", requires = "tpope/vim-fugitive", cmd = { "Flog" } })

    use({ "christoomey/vim-conflicted", requires = "tpope/vim-fugitive", cmd = {"Conflicted"}})

    use({ "kevinhwang91/nvim-bqf", ft = "qf", config = [[require('config.bqf')]] })

    -- Better git commit experience
    use({"rhysd/committia.vim", opt = true, setup = [[vim.cmd('packadd committia.vim')]]})

    -- Another markdown plugin
    use({ "plasticboy/vim-markdown", ft = { "markdown" } })

    -- Faster footnote generation
    use({ "vim-pandoc/vim-markdownfootnotes", ft = { "markdown" } })

    -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    use({ "godlygeek/tabular", cmd = { "Tabularize" } })

    -- Markdown JSON header highlight plugin
    use({ "elzr/vim-json", ft = { "json", "markdown" } })

    -- Markdown previewing (only for Mac and Windows)
    if vim.g.is_win or vim.g.is_mac then
      use({
        "iamcco/markdown-preview.nvim",
        run = function()
          fn["mkdp#util#install"]()
        end,
        ft = { "markdown" },
      })
    end

    use({'folke/zen-mode.nvim', cmd = 'ZenMode', config = [[require('config.zen-mode')]]})

    if vim.g.is_mac then
      use({ "rhysd/vim-grammarous", ft = { "markdown" } })
    end

    use({"chrisbra/unicode.vim", event = "VimEnter"})

    -- Additional powerful text object for vim, this plugin should be studied
    -- carefully to use its full power
    use({"wellle/targets.vim", event = "VimEnter"})

    -- Plugin to manipulate character pairs quickly
    -- use 'tpope/vim-surround'
    use({"machakann/vim-sandwich", event = "VimEnter"})

    -- Add indent object for vim (useful for languages like Python)
    use({"michaeljsmith/vim-indent-object", event = "VimEnter"})

    -- Only use these plugin on Windows and Mac and when LaTeX is installed
    if vim.g.is_win or vim.g.is_mac and utils.executable("latex") then
      use({ "lervag/vimtex", ft = { "tex" } })

      -- use {'matze/vim-tex-fold', ft = {'tex', }}
      -- use 'Konfekt/FastFold'
    end

    -- Since tmux is only available on Linux and Mac, we only enable these plugins
    -- for Linux and Mac
    if utils.executable("tmux") then
      -- .tmux.conf syntax highlighting and setting check
      use({ "tmux-plugins/vim-tmux", ft = { "tmux" } })
    end

    -- Modern matchit implementation
    use({"andymass/vim-matchup", event = "VimEnter"})

    -- Smoothie motions
    -- use 'psliwka/vim-smoothie'
    use({
      "karb94/neoscroll.nvim",
      event = "VimEnter",
      config = function()
        vim.defer_fn(function() require('config.neoscroll') end, 2000)
      end
    })

    use({"tpope/vim-scriptease", cmd = {"Scriptnames", "Message", "Verbose"}})

    -- Asynchronous command execution
    use({ "skywind3000/asyncrun.vim", opt = true, cmd = { "AsyncRun" } })
    -- Another asynchronous plugin
    -- Plug 'tpope/vim-dispatch'

    use({ "cespare/vim-toml", ft = { "toml" }, branch = "main" })

    -- Edit text area in browser using nvim
    if vim.g.is_win or vim.g.is_mac then
      use({
        "glacambre/firenvim",
        run = function() fn["firenvim#install"](0) end,
        opt = true,
        setup = [[vim.cmd('packadd firenvim')]],
      })
    end

    -- Debugger plugin
    if vim.g.is_win or vim.g.is_linux then
      use({ "sakhnik/nvim-gdb", run = { "bash install.sh" }, opt = true, setup = [[vim.cmd('packadd nvim-gdb')]] })
    end

    -- Session management plugin
    use({"tpope/vim-obsession", cmd = 'Obsession'})

    if vim.g.is_linux then
      use({"ojroques/vim-oscyank", cmd = {'OSCYank', 'OSCYankReg'}})
    end

    -- The missing auto-completion for cmdline!
    use({"gelguy/wilder.nvim", opt = true, setup = [[vim.cmd('packadd wilder.nvim')]]})

    -- showing keybindings
    use {"folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function() require('config.which-key') end, 2000)
    end
    }

    -- show and trim trailing whitespaces
    use {'jdhao/whitespace.nvim', event = 'VimEnter'}

    -- file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = [[require('config.nvim-tree')]]
    }

    use { 'ii14/emmylua-nvim', ft = 'lua' }

    use { 'j-hui/fidget.nvim', after = 'nvim-lspconfig', config = [[require('config.fidget-nvim')]]}
  end,
  config = {
    max_jobs = 16,
    compile_path = packer_util.join_paths(fn.stdpath('data'), 'site', 'lua', 'packer_compiled.lua'),
  },
})

-- For fresh install, we need to install plugins. Otherwise, we just need to require `packer_compiled.lua`.
if fresh_install then
  -- We can command `PackerSync` here, because only after packer.startup, we can know what plugins to install.
  -- So plugin install should be done after the startup process.
  vim.cmd("PackerSync")
else
  local status, _ = pcall(require, 'packer_compiled')
  if not status then
  vim.notify("Error requiring packer_compiled.lua: run PackerSync to fix!")
  end
end
