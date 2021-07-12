local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local plug_url_format = ''
if vim.g.is_linux > 0 then
  plug_url_format = 'https://hub.fastgit.org/%s'
else
  plug_url_format = 'https://github.com/%s'
end

local packer_repo = string.format(plug_url_format, 'wbthomason/packer.nvim')
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', packer_repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  vim.api.nvim_echo({{'Installing packer.nvim', 'Type'}}, true, {})
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(
{
  function(use)
    use 'wbthomason/packer.nvim'

    -- nvim-lsp configuration
    use {'neovim/nvim-lspconfig', event = 'VimEnter', config = [[require('config.lsp')]]}

    -- auto-completion engine
    use { 'hrsh7th/nvim-compe', event = 'InsertEnter *', config = [[require('config.compe')]] }

    -- Python syntax highlighting and more
    if (vim.g.is_mac == 1) or (vim.g.is_win == 1) then
      use {'numirias/semshi', ft = 'python', config = 'vim.cmd [[UpdateRemotePlugins]]'}
    end

    -- Python indent (follows the PEP8 style)
    use {'Vimjas/vim-python-pep8-indent', ft = {'python', }}

    -- Python-related text object
    use {'jeetsukumaran/vim-pythonsense', ft = {'python'}}

    use 'machakann/vim-swap'
    -- IDE for Lisp
    if fn.executable('sbcl') > 0 then
      -- use 'kovisoft/slimv'
      use {'vlime/vlime', rtp = 'vim/', ft={'lisp', }}
    end

    -- Super fast movement with vim-sneak
    use 'justinmk/vim-sneak'

    -- Clear highlight search automatically for you
    use 'romainl/vim-cool'

    -- Show current search term in different color
    use 'PeterRincker/vim-searchlight'

    -- Show match number for incsearch
    use 'osyo-manga/vim-anzu'

    -- Stay after pressing * and search selected text
    use 'haya14busa/vim-asterisk'

    -- File search, tag search and more
    if vim.g.is_win == 1 then
      use 'Yggdroot/LeaderF'
    else
      use {'Yggdroot/LeaderF', run = ':LeaderfInstallCExtension'}
    end

    -- Another similar plugin is command-t
    -- use 'wincent/command-t'

    -- Another grep tool (similar to Sublime Text Ctrl+Shift+F)
    -- use 'dyng/ctrlsf.vim'

    -- A greping tool
    -- use {'mhinz/vim-grepper', cmd = {'Grepper', '<plug>(GrepperOperator)'}}

    -- A list of colorscheme plugin you may want to try. Find what suits you.
    use 'lifepillar/vim-gruvbox8'
    use 'ajmwagar/vim-deus'
    use 'lifepillar/vim-solarized8'
    use {'joshdick/onedark.vim', branch = 'main'}
    use 'KeitaNakamura/neodark.vim'
    use 'sainnhe/edge'
    use 'sainnhe/sonokai'
    use 'sainnhe/gruvbox-material'
    use 'shaunsingh/nord.nvim'

    -- colorful status line and theme
    use {'vim-airline/vim-airline-themes', event = 'VimEnter'}
    use {'vim-airline/vim-airline', after = 'vim-airline-themes'}

    -- fancy start screen
    use {'mhinz/vim-startify', event = 'VimEnter'}
    use {'lukas-reineke/indent-blankline.nvim'}

    -- Highlight URLs inside vim
    use 'itchyny/vim-highlighturl'

    -- For Windows and Mac, we can open an URL in the browser. For Linux, it may
    -- not be possible since we maybe in a server which disables GUI.
    if (vim.g.is_win == 1) or (vim.g.is_mac == 1) then
      -- open URL in browser
      use 'tyru/open-browser.vim'
    end

    -- Only install these plugins if ctags are installed on the system
    if fn.executable('ctags') > 0 then
      -- plugin to manage your tags
      use 'ludovicchabant/vim-gutentags'
      -- show file tags in vim window
      use 'liuchengxu/vista.vim'
    end

    -- Snippet engine and snippet template
    use {'SirVer/ultisnips', event = {'InsertEnter'}}
    use {'honza/vim-snippets', event = {'InsertEnter'}}

    -- Automatic insertion and deletion of a pair of characters
    use 'jiangmiao/auto-pairs'

    -- Comment plugin
    use 'tpope/vim-commentary'

    -- Multiple cursor plugin like Sublime Text?
    -- use 'mg979/vim-visual-multi'

    -- Title character case
    use 'christoomey/vim-titlecase'

    -- Autosave files on certain events
    use '907th/vim-auto-save'

    -- Show undo history visually
    use 'simnalamburt/vim-mundo'

    -- Manage your yank history
    if (vim.g.is_win == 1) or (vim.g.is_mac == 1) then
      use 'svermeulen/vim-yoink'
    end

    -- Handy unix command inside Vim (Rename, Move etc.)
    use 'tpope/vim-eunuch'

    -- Repeat vim motions
    use 'tpope/vim-repeat'

    -- Show the content of register in preview window
    -- Plug 'junegunn/vim-peekaboo'
    use {'jdhao/better-escape.vim', event = {'InsertEnter', }}

    if vim.g.is_mac == 1 then
      use {'lyokha/vim-xkbswitch', event = {'InsertEnter', }}
    elseif vim.g.is_win == 1 then
      use {'Neur1n/neuims', event = {'InsertEnter', }}
    end

    -- Syntax check and make
    -- use 'neomake/neomake'

    -- Another linting plugin
    use 'dense-analysis/ale'

    -- Auto format tools
    use {'sbdchd/neoformat', cmd = {'Neoformat', }}
    -- use 'Chiel92/vim-autoformat'

    -- Show git change (change, delete, add) signs in vim sign column
    use 'mhinz/vim-signify'
    -- Another similar plugin
    -- use 'airblade/vim-gitgutter'

    -- Git command inside vim
    use 'tpope/vim-fugitive'

    -- Another markdown plugin
    use {'plasticboy/vim-markdown', ft = {'markdown', }}

    -- Faster footnote generation
    use {'vim-pandoc/vim-markdownfootnotes', ft = {'markdown', }}

    -- Vim tabular plugin for manipulate tabular, required by markdown plugins
    use {'godlygeek/tabular', cmd = {'Tabularize'}}

    -- Markdown JSON header highlight plugin
    use {'elzr/vim-json', ft = {'json', 'markdown'}}

    -- Markdown previewing (only for Mac and Windows)
    if (vim.g.is_win == 1) or (vim.g.is_mac == 1) then
      use {'iamcco/markdown-preview.nvim', run = function() fn['mkdp#util#install']() end, ft = {'markdown'}}
    end

    if vim.g.is_mac == 1 then
      use {'rhysd/vim-grammarous', ft = {'markdown', }}
    end

    use 'chrisbra/unicode.vim'

    -- Additional powerful text object for vim, this plugin should be studied
    -- carefully to use its full power
    use 'wellle/targets.vim'

    -- Plugin to manipulate characer pairs quickly
    -- use 'tpope/vim-surround'
    use 'machakann/vim-sandwich'

    -- Add indent object for vim (useful for languages like Python)
    use 'michaeljsmith/vim-indent-object'

    -- Only use these plugin on Windows and Mac and when LaTeX is installed
    if ( vim.g.is_win == 1 or vim.g.is_mac ==1 ) and fn.executable('latex') > 0 then
      -- vimtex use autoload feature of Vim, so it is not necessary to use `for`
      -- keyword of vim-plug to try to lazy-load it,
      -- see https://github.com/junegunn/vim-plug/issues/785
      use {'lervag/vimtex', ft = {'tex', }}

      -- use {'matze/vim-tex-fold', ft = {'tex', }}
      -- use 'Konfekt/FastFold'
    end

    -- Since tmux is only available on Linux and Mac, we only enable these plugins
    -- for Linux and Mac
    if fn.executable('tmux') > 0 then
      -- Let vim detect tmux focus event correctly, see
      -- https://github.com/neovim/neovim/issues/9486 and
      -- https://vi.stackexchange.com/q/18515/15292
      use 'tmux-plugins/vim-tmux-focus-events'

      -- .tmux.conf syntax highlighting and setting check
      use {'tmux-plugins/vim-tmux', ft = {'tmux', }}
    end

    -- Modern matchit implementation
    use {'andymass/vim-matchup', event = {'VimEnter',}}

    -- Smoothie motions
    use 'psliwka/vim-smoothie'

    use 'tpope/vim-scriptease'

    -- Asynchronous command execution
    use {'skywind3000/asyncrun.vim', opt = true, cmd = {'AsyncRun', }}
    -- Another asynchronous plugin
    -- Plug 'tpope/vim-dispatch'
    use {'cespare/vim-toml', ft = {'toml',}}

    -- Edit text area in browser using nvim
    if (vim.g.is_win == 1) or (vim.g.is_mac == 1) then
      use {'glacambre/firenvim', run = function() fn['firenvim#install'](0) end}
    end

    -- Debugger plugin
    if (vim.g.is_win == 1) or (vim.g.is_linux == 1) then
      use {'sakhnik/nvim-gdb', run = {'bash install.sh'}}
    end

    -- Session management plugin
    use 'tpope/vim-obsession'

    -- Calculate statistics for visual selection
    use 'wgurecky/vimSum'

    if vim.g.is_linux == 1 then
      use 'ojroques/vim-oscyank'
    end

    -- REPL for nvim
    use {'hkupty/iron.nvim', config = [[require('config.iron')]]}

    -- Show register content
    use "tversteeg/registers.nvim"
  end,
  config = {
    max_jobs = 16,
    git = {
      default_url_format = plug_url_format
    }
  }
})

vim.api.nvim_exec([[
  augroup packer_auto_compile
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile | unsilent echomsg 'Packer.nvim settings recompiled!'
  augroup END
]], false)
