<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128589722-322bb97f-f460-4fc2-ba50-a707225d8adc.gif" width="800">
</p>

# Introduction

This repo hosts my Nvim configuration for all the platforms I am using (Linux,
Windows and macOS). `init.vim` is the config entry point for terminal Neovim,
and `ginit.vim` is the additional config file for GUI client of Neovim (I am
using [neovim-qt](https://github.com/equalsraf/neovim-qt) for now on Windows).

My configurations are heavily documented to make it as clear as possible. While
you can download the whole repository and use it, it is not recommended though.
Good configurations are personal. Everyone should have his or her unique config
file. You are encouraged to copy from this repo the part you feel useful and
add it to your own Nvim config.

See [doc here](docs/README.md) on how to install Nvim's dependencies, Nvim
itself, and how to set up on different platforms (Linux, macOS and Windows).

**This config is always tested against the latest nvim master release. No
backward compatibility is guaranteed.**

# Features #

+ Plugin management via [Packer.nvim](https://github.com/wbthomason/packer.nvim).
+ Code auto-completion via [nvim-compe](https://github.com/hrsh7th/nvim-compe) and [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
+ Fuzzy searching in current project quickly via [LeaderF](https://github.com/Yggdroot/LeaderF).
+ Faster code commenting via [vim-commentary](https://github.com/tpope/vim-commentary).
+ Smarter and faster matching pair management (add, replace or delete) via [vim-sandwich](https://github.com/machakann/vim-sandwich).
+ Fast buffer jump via [vim-sneak](https://github.com/justinmk/vim-sneak).
+ Ultra fast snippet insertion via [Ultisnips](https://github.com/SirVer/ultisnips).
+ Git integration via [vim-fugitive](https://github.com/tpope/vim-fugitive).
+ Faster matching pair insertion and jump via [auto-pairs](https://github.com/jiangmiao/auto-pairs).
+ Beautiful status line via [vim-airline](https://github.com/vim-airline/vim-airline).
+ Asynchronous code execution via [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim).
+ Code highlighting via [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
+ Code editing using true nvim inside browser via [firenvim](https://github.com/glacambre/firenvim).
+ Color theme via [vim-gruvbox8](https://github.com/lifepillar/vim-gruvbox8) and other beautiful themes.
+ Markdown writing and syntax highlighting via [vim-markdown](https://github.com/plasticboy/vim-markdown),
  Markdown Previewing via [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim).
+ Command line auto-completion via [wilder.nvim](https://github.com/gelguy/wilder.nvim).
+ Animated GUI style notification via [nvim-notify](https://github.com/rcarriga/nvim-notify).
+ Tags navigation via [vista](https://github.com/liuchengxu/vista.vim).
+ Source code linting via [Ale](https://github.com/dense-analysis/ale).
+ Code formatting via [Neoformat](https://github.com/sbdchd/neoformat).
+ Undo management via [vim-mundo](https://github.com/simnalamburt/vim-mundo)
+ LaTeX editing via [vimtex](https://github.com/lervag/vimtex)[^1].
+ Smooth scroll experience via [vim-smoothie](https://github.com/psliwka/vim-smoothie).
+ ......

# Demo

## Autocompletion

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128590006-0fc1451f-fac1-49b2-bb95-8aba21bfa44e.gif" width="800">
</p>

## Tags

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128589584-4036a1a2-2e0a-4bbe-8aaf-ff8b91644648.jpg" width="800">
</p>

## Cursor jump via vim-sneak

Go to a string starting with `se`

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128590570-71dd82b1-b99d-4e82-9a29-aadd9d6ec300.gif" width="800">
</p>

## GUI-style notification

<p align="center">
<img src="https://user-images.githubusercontent.com/16662357/128589873-aadb8264-1098-4834-9876-fa66a309be05.gif" width="800">
</p>

# Shortcuts

Some of the shortcuts I use frequently. In the following shortcuts, `<leader>`
represents ASCII character `,`.

| Shortcut          | Mode          | platform        | Description                                                                                          |
|-------------------|---------------|-----------------|------------------------------------------------------------------------------------------------------|
| `<leader>f`       | Normal        | Linux/macOS/Win | Fuzzy file search in a floating window                                                               |
| `<leader>h`       | Normal        | Linux/macOS/Win | Fuzzy help search in a floating window                                                               |
| `<leader>t`       | Normal        | Linux/macOS/Win | Fuzzy buffer tag search in a floating window                                                         |
| `<leader><Space>` | Normal        | Linux/macOS/Win | Remove trailing white spaces                                                                         |
| `<leader>v`       | Normal        | Linux/macOS/Win | Reselect last pasted text                                                                            |
| `<leader>ev`      | Normal        | Linux/macOS/Win | Edit Neovim config in a new tabpage                                                                  |
| `<leader>sv`      | Normal        | Linux/macOS/Win | Reload Neovim config                                                                                 |
| `<leader>q`       | Normal        | Linux/macOS/Win | Quit current window                                                                                  |
| `<leader>Q`       | Normal        | Linux/macOS/Win | Quit all window and close Neovim                                                                     |
| `<leader>w`       | Normal        | Linux/macOS/Win | Save current buffer content                                                                          |
| `<leader>cd`      | Normal        | Linux/macOS/Win | Change current directory to where current file is                                                    |
| `<leader>y`       | Normal        | Linux/macOS/Win | Copy the content of entire buffer to default register                                                |
| `<leader>cl`      | Normal        | Linux/macOS/Win | Toggle cursor column                                                                                 |
| `<leader>cd`      | Normal        | Linux/macOS/Win | Change current working directory to to the dir of current buffer                                     |
| `<space>t`        | Normal        | Linux/macOS/Win | Toggle tag window (show project tags in the right window)                                            |
| `<F9>`            | Normal        | Linux/macOS/Win | Run current source file (for Python, C++)                                                            |
| `<F11>`           | Normal        | Linux/macOS/Win | Toggle spell checking                                                                                |
| `<F12>`           | Normal        | Linux/macOS/Win | Toggle paste mode                                                                                    |
| `\x`              | Normal        | Linux/macOS/Win | Close location or quickfix window                                                                    |
| `\d`              | Normal        | Linux/macOS/Win | Close current buffer and go to previous buffer                                                       |
| `{count}gb`       | Normal        | Linux/macOS/Win | Go to buffer {count}  or next buffer in the buffer list.                                             |
| `Alt-M`           | Normal        | macOS/Win       | Render Markdown to HTML and open it in system browser                                                |
| `ob`              | Normal/Visual | macOS/Win       | Open link under cursor or search visual selection                                                    |
| `ctrl-u`          | Insert        | Linux/macOS/Win | Turn word under cursor to upper case                                                                 |
| `ctrl-t`          | Insert        | Linux/macOS/Win | Turn word under cursor to title case                                                                 |
| `jk`              | Insert        | Linux/macOS/Win | Return to Normal mode [without lagging](https://github.com/jdhao/better-escape.vim) (faster `<ESC>`) |

# Trouble shooting

If you come across an issue, you can first use `:checkhealth` command provided
by `nvim` to trouble-shoot yourself. Please read carefully the messages
provided by health check.

If you still have an issue, [open a new issue](https://github.com/jdhao/nvim-config/issues).

# Further readings

Some of the resources that I find helpful in mastering Vim is documented [here](docs/vim_resources.md).
You may also be interested in my post in configuring Vim on different platforms:

+ [Config nvim on Linux for Python development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
+ [Nvim config on Windows 10](https://jdhao.github.io/2018/11/15/neovim_configuration_windows/)
+ [Nvim-qt config on Windows 10](https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/)

[^1]: Not enabled by default for Linux, see [this issue](https://github.com/jdhao/nvim-config/issues/4) on how to enable vimtex on Linux.
