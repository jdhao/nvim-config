<p align="center">
<img src="images/demo_look.jpg" width="600">
</p>

# Introduction

This is my Neovim configuration for all the platforms I use (Linux, Windows and
MacOS). `init.vim` is the config file for terminal Neovim, and `ginit.vim` is
the additional config file for GUI client of Neovim (I am using
[neovim-qt](https://github.com/equalsraf/neovim-qt) for now on Windows).

My configurations are heavily documented to make it as clear as possible. While
you can download the whole repository and use it, it is not recommended to do
so. Good configurations are personal. Everyone should have his or her unique
config file. You are encouraged to copy from this this repo the part you feel
useful and add it to your own Nvim config.

See [doc here](docs/README.md) on how to install Nvim's dependencies, Nvim
itself and the configuration on different platforms (Linux, MacOS and Windows).

# Features #

+ Auto-completion for Python via [Deoplete](https://github.com/Shougo/deoplete.nvim).
+ Source code linting via [Neomake](https://github.com/neomake/neomake).
+ Code formatting via [Neoformat](https://github.com/sbdchd/neoformat).
+ Markdown writing and syntax highlighting via [vim-markdown](https://github.com/plasticboy/vim-markdown) and [vim-pandoc-syntax](https://github.com/vim-pandoc/vim-pandoc-syntax).
+ LaTeX editing via [vimtex](https://github.com/lervag/vimtex).
+ Git integration via [vim-fugitive](https://github.com/tpope/vim-fugitive).
+ Fast buffer jump via [vim-sneak](https://github.com/justinmk/vim-sneak).
+ Open a file in current project quickly via [LeaderF](https://github.com/Yggdroot/LeaderF).
+ Beautiful status line via [vim-airline](https://github.com/vim-airline/vim-airline).
+ Powerful sidebar via [Nerdtree](https://github.com/scrooloose/nerdtree).
+ Tags navigation via [tagbar](https://github.com/majutsushi/tagbar).
+ ......

# Shortcuts

In the following shortcuts, `<leader>` represents `,` character.

| Shortcut     | Description                                                   |
|--------------|---------------------------------------------------------------|
| `<leader>s`  | Toggle the sidebar (show project tree view)                   |
| `<leader>f`  | Open file fuzzy search in floating window and starting search |
| `<leader>s`  | Remove trailing whitespaces                                   |
| `<leader>t`  | Toggle tag window (show project tags in the right window)     |
| `<leader>v`  | Reselect last pasted text                                     |
| `<leader>ev` | Edit Neovim config in a new tabpage                           |
| `<leader>sv` | Reload Neovim config                                          |
| `<leader>q`  | Quit current window                                           |
| `<leader>Q`  | Quit all window and close Neovim                              |
| `<leader>w`  | Save current buffer content                                   |

# Trouble shooting

If you come across an issue, you can first use `:checkhealth` command provided
by `nvim` to trouble-shoot yourself. Please read carefully the messages
provided by health check.

If you still have an issue, you may [open a new issue](https://github.com/jdhao/nvim-config/issues).

# Further readings

+ [Config nvim on Linux for Python development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
+ [Nvim config on Windows 10](https://jdhao.github.io/2018/11/15/neovim_configuration_windows/)
+ [Nvim-qt config on Windows 10](https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/)

[^1]: Use `echo %userprofile%` to see where your `$HOME` is.
