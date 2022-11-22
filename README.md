<div align="center">
<p>
    <a>
      <img alt="Linux" src="https://img.shields.io/badge/Linux-%23.svg?style=flat-square&logo=linux&color=FCC624&logoColor=black" />
    </a>
    <a>
      <img alt="macOS" src="https://img.shields.io/badge/macOS-%23.svg?style=flat-square&logo=apple&color=000000&logoColor=white" />
    </a>
    <a>
      <img alt="Windows" src="https://img.shields.io/badge/Windows-%23.svg?style=flat-square&logo=windows&color=0078D6&logoColor=white" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/jdhao/nvim-config" />
    </a>
    <a href="https://github.com/neovim/neovim/releases/tag/stable">
      <img src="https://img.shields.io/badge/Neovim-0.8.1-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=green" alt="Neovim minimum version"/>
    </a>
    <a href="https://github.com/jdhao/nvim-config/search?l=vim-script">
      <img src="https://img.shields.io/github/languages/top/jdhao/nvim-config" alt="Top languages"/>
    </a>
    <a href="https://github.com/jdhao/nvim-config/graphs/commit-activity">
      <img src="https://img.shields.io/github/commit-activity/m/jdhao/nvim-config?style=flat-square" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/releases/tag/v0.8.1">
      <img src="https://img.shields.io/github/commits-since/jdhao/nvim-config/v0.8.1?style=flat-square" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/graphs/contributors">
      <img src="https://img.shields.io/github/contributors/jdhao/nvim-config?style=flat-square" />
    </a>
    <a>
      <img src="https://img.shields.io/github/repo-size/jdhao/nvim-config?style=flat-square" />
    </a>
    <a href="https://github.com/jdhao/nvim-config/blob/master/LICENSE">
      <img src="https://img.shields.io/github/license/jdhao/nvim-config?style=flat-square&logo=GNU&label=License" alt="License"/>
    </a>
</p>
</div>

# Introduction

This repo hosts my Nvim configuration for Linux, macOS, and Windows.
`init.lua` is the config entry point for terminal Nvim,
and `ginit.vim` is the additional config file for [GUI client of Nvim](https://github.com/neovim/neovim/wiki/Related-projects#gui).

My configurations are heavily documented to make it as clear as possible.
While you can clone the whole repository and use it, it is not recommended though.
Good configurations are personal. Everyone should have his or her unique config file.
You are encouraged to copy from this repo the part you want and add it to your own config.

To reduce the possibility of breakage, **this config is only maintained for [the latest nvim stable release](https://github.com/neovim/neovim/releases/tag/stable).
No effort is spent on maintaining backward compatibility.**

# Install and setup

See [doc here](docs/README.md) on how to install Nvim's dependencies, Nvim itself,
and how to set up on different platforms (Linux, macOS, and Windows).

# Features #

+ Plugin management via [Packer.nvim](https://github.com/wbthomason/packer.nvim).
+ Code, snippet, word auto-completion via [nvim-cmp](https://github.com/hrsh7th/nvim-cmp).
+ Language server protocol (LSP) support via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
+ Git integration via [vim-fugitive](https://github.com/tpope/vim-fugitive).
+ Better escaping from insert mode via [better-escape.vim](https://github.com/nvim-zh/better-escape.vim).
+ Ultra-fast project-wide fuzzy searching via [LeaderF](https://github.com/Yggdroot/LeaderF).
+ Faster code commenting via [vim-commentary](https://github.com/tpope/vim-commentary).
+ Faster matching pair insertion and jump via [delimitMate](https://github.com/Raimondi/delimitMate).
+ Smarter and faster matching pair management (add, replace or delete) via [vim-sandwich](https://github.com/machakann/vim-sandwich).
+ Fast buffer jump via [hop.nvim](https://github.com/phaazon/hop.nvim).
+ Powerful snippet insertion via [Ultisnips](https://github.com/SirVer/ultisnips).
+ Beautiful statusline via [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
+ File tree explorer via [nvim-tree.lua](https://github.com/kyazdani42/nvim-tree.lua).
+ Better quickfix list with [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf).
+ Show search index and count with [nvim-hlslens](https://github.com/kevinhwang91/nvim-hlslens).
+ Command line auto-completion via [wilder.nvim](https://github.com/gelguy/wilder.nvim).
+ User-defined mapping hint via [which-key.nvim](https://github.com/folke/which-key.nvim).
+ Asynchronous code execution via [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim).
+ Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
+ Code editing using true nvim inside browser via [firenvim](https://github.com/glacambre/firenvim).
+ Beautiful colorscheme via [sainnhe/gruvbox-material](https://github.com/sainnhe/gruvbox-material) and other colorschemes.
+ Markdown writing and previewing via [vim-markdown](https://github.com/preservim/vim-markdown) and [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).
+ LaTeX editing and previewing via [vimtex](https://github.com/lervag/vimtex)
+ Animated GUI style notification via [nvim-notify](https://github.com/rcarriga/nvim-notify).
+ Tags navigation via [vista](https://github.com/liuchengxu/vista.vim).
+ Code formatting via [Neoformat](https://github.com/sbdchd/neoformat).
+ Undo management via [vim-mundo](https://github.com/simnalamburt/vim-mundo)
+ ......

# UI Demo

For more UI demos, check [here](https://github.com/jdhao/nvim-config/issues/15).

## Start screen with dashboard-nvim

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/183256752-fb23b215-a6b8-4646-beed-9999f52d53f1.png" width="800">
</p>

## File fuzzy finding using LeaderF

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/183257017-2d9d7605-3c4b-4e1d-8955-30998f9b6f28.gif" width="800">
</p>

## Code autocompletion with nvim-cmp

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128590006-0fc1451f-fac1-49b2-bb95-8aba21bfa44e.gif" width="800">
</p>

## Git add, commit and push via fugitive.vim

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128590833-aaa05d53-19ef-441d-a5a9-ba1bbd3936c1.gif" width="800">
</p>

## Command-line autocompletion with wilder.nvim

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/147677787-8e5d229a-a16a-420e-98f5-88f2a1be84a2.gif" width="800">
</p>

## Tags

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128589584-4036a1a2-2e0a-4bbe-8aaf-ff8b91644648.jpg" width="800">
</p>

## Cursor jump via hop.nvim

Go to a string starting with `se`

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/139459219-8a7e6ac4-1d24-4008-a370-b56773d7cb85.gif" width="800">
</p>

## GUI-style notification with nvim-notify

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128589873-aadb8264-1098-4834-9876-fa66a309be05.gif" width="800">
</p>

# Shortcuts

Some of the shortcuts I use frequently are listed here. In the following shortcuts, `<leader>` represents ASCII character `,`.

| Shortcut          | Mode          | platform        | Description                                                              |
|-------------------|---------------|-----------------|--------------------------------------------------------------------------|
| `<leader>ff`      | Normal        | Linux/macOS/Win | Fuzzy file searching in a floating window                                |
| `<leader>fh`      | Normal        | Linux/macOS/Win | Fuzzy help file grepping in a floating window                            |
| `<leader>fg`      | Normal        | Linux/macOS/Win | Fuzzy project-wide grepping in a floating window                         |
| `<leader>ft`      | Normal        | Linux/macOS/Win | Fuzzy buffer tag searching in a floating window                          |
| `<leader>fb`      | Normal        | Linux/macOS/Win | Fuzzy buffer switching in a floating window                              |
| `<leader><Space>` | Normal        | Linux/macOS/Win | Remove trailing white spaces                                             |
| `<leader>v`       | Normal        | Linux/macOS/Win | Reselect last pasted text                                                |
| `<leader>ev`      | Normal        | Linux/macOS/Win | Edit Nvim config in a new tabpage                                        |
| `<leader>sv`      | Normal        | Linux/macOS/Win | Reload Nvim config                                                       |
| `<leader>st`      | Normal        | Linux/macOS/Win | Show highlight group for cursor text                                     |
| `<leader>q`       | Normal        | Linux/macOS/Win | Quit current window                                                      |
| `<leader>Q`       | Normal        | Linux/macOS/Win | Quit all window and close Nvim                                           |
| `<leader>w`       | Normal        | Linux/macOS/Win | Save current buffer content                                              |
| `<leader>y`       | Normal        | Linux/macOS/Win | Copy the content of entire buffer to default register                    |
| `<leader>cl`      | Normal        | Linux/macOS/Win | Toggle cursor column                                                     |
| `<leader>cd`      | Normal        | Linux/macOS/Win | Change current working directory to to the dir of current buffer         |
| `<space>t`        | Normal        | Linux/macOS/Win | Toggle tag window (show project tags in the right window)                |
| `<leader>gs`      | Normal        | Linux/macOS/Win | Show Git status result                                                   |
| `<leader>gw`      | Normal        | Linux/macOS/Win | Run Git add for current file                                             |
| `<leader>gd`      | Normal        | Linux/macOS/Win | Run git diff for current file                                            |
| `<leader>gc`      | Normal        | Linux/macOS/Win | Run git commit                                                           |
| `<leader>gpl`     | Normal        | Linux/macOS/Win | Run git pull                                                             |
| `<leader>gpu`     | Normal        | Linux/macOS/Win | Run git push                                                             |
| `<leader>gl`      | Normal/Visual | Linux/macOS/Win | Get perm link for current/visually-select lines
| `<leader>gb`      | Normal        | macOS           | Browse current git repo in browser
| `<F9>`            | Normal        | Linux/macOS/Win | Compile&run current source file (for C++, LaTeX, Lua, Python)            |
| `<F11>`           | Normal        | Linux/macOS/Win | Toggle spell checking                                                    |
| `<F12>`           | Normal        | Linux/macOS/Win | Toggle paste mode                                                        |
| `\x`              | Normal        | Linux/macOS/Win | Close location or quickfix window                                        |
| `\d`              | Normal        | Linux/macOS/Win | Close current buffer and go to previous buffer                           |
| `{count}gb`       | Normal        | Linux/macOS/Win | Go to buffer `{count}` or next buffer in the buffer list.                |
| `{operator}iB`    | Normal        | Linux/macOS/Win | Operate in the whole buffer, `{operator}` can be `v`, `y`, `c`, `d` etc. |
| `Alt-k`           | Normal        | Linux/macOS/Win | Move current line or selected lines up                                   |
| `Alt-j`           | Normal        | Linux/macOS/Win | Move current line or selected lines down                                 |
| `Alt-m`           | Normal        | macOS/Win       | Markdown previewing in system browser                                    |
| `Alt-Shift-m`     | Normal        | macOS/Win       | Stopping Markdown previewing in system browser                           |
| `ob`              | Normal/Visual | macOS/Win       | Open link under cursor or search visual selection                        |
| `ctrl-u`          | Insert        | Linux/macOS/Win | Turn word under cursor to upper case                                     |
| `ctrl-t`          | Insert        | Linux/macOS/Win | Turn word under cursor to title case                                     |
| `jk`              | Insert        | Linux/macOS/Win | Return to Normal mode without lagging                                    |

# Custom commands

In addition to commands provided by various plugins, I have also created some custom commands for personal use.

| command    | description                                                             | example                        |
|------------|-------------------------------------------------------------------------|--------------------------------|
| `Redir`    | capture command output to a tabpage for easier inspection.              | `Redir hi`                     |
| `Edit`     | edit multiple files at the same time, supports globing                  | `Edit *.vim`                   |
| `Datetime` | print current date and time or convert Unix time stamp to date and time | `Datetime 12345` or `Datetime` |

# Contributing

If you find anything that needs improving, do not hesitate to point it out or create a PR.

If you come across an issue, you can first use `:checkhealth` command provided by `nvim` to trouble-shoot yourself.
Please read carefully the messages provided by health check.

If you still have an issue, [open a new issue](https://github.com/jdhao/nvim-config/issues).

# Further readings

Some of the resources that I find helpful in mastering Nvim is documented [here](docs/nvim_resources.md).
You may also be interested in my posts on configuring Nvim:

+ My nvim notes can be found [here](https://jdhao.github.io/categories/Nvim/)
+ [Using Neovim for Three years](https://jdhao.github.io/2021/12/31/using_nvim_after_three_years/)
+ [Config nvim on Linux for Python development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
+ [Nvim config on Windows 10](https://jdhao.github.io/2018/11/15/neovim_configuration_windows/)
+ [Nvim-qt config on Windows 10](https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/)
