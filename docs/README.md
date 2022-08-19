This doc summarizes how to install and use this configuration in detail.

# Pre-requisite

## Terminal emulators

Which [terminal emulator](https://en.wikipedia.org/wiki/Terminal_emulator) we choose to use greatly affects the appearance and features of Nvim.
Since Nvim supports true colors, terminals that support true colors are preferred.
For a list of terminals that support true colors, see [here](https://github.com/termstandard/colors).

For macOS, we can use [kitty](https://sw.kovidgoyal.net/kitty/), [iterm2](https://www.iterm2.com/), [wezterm](https://wezfurlong.org/wezterm/) or [Alacritty](https://github.com/jwilm/alacritty).

If you ssh to Linux server on Windows, I recommend [wsltty](https://github.com/mintty/wsltty) and [Cygwin](https://www.cygwin.com/),
both of them use [mintty](https://github.com/mintty/mintty) as the terminal emulator.
For the latest version of Windows 10, you can also try [Windows Terminal](https://github.com/microsoft/terminal).

## Patched Fonts

Since statusline or file explorer plugins often use Unicode symbols not available in normal font,
we need to install a patched font from the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) project.

# Automatic installation

## Automatic Installation for Linux

To set up a workable Nvim environment on Linux,
I use [a bash script](nvim_setup_linux.sh) to automatically install necessary dependencies, Nvim itself and configs.

Note that the variable `PYTHON_INSTALLED`, `SYSTEM_PYTHON` and `ADD_TO_SYSTEM_PATH` in the script
should be set properly based on your environment.

## Automatic installation for Windows

Run the script [nvim_setup_windows.ps1](nvim_setup_windows.ps1) in PowerShell **with Administrator rights**:

```
.\docs\nvim_setup_windows.ps1
```

# Manual install

There are a few dependencies if we want to use Nvim for efficient editing and development work.

## Dependencies

### Python

A lot of Nvim plugins are mainly written in Python, so we must install Python 3.
The easiest way to install is via [Anaconda](https://docs.anaconda.com/anaconda/install/index.html) or [Miniconda](https://docs.conda.io/en/latest/miniconda.html).

After installation, make sure that you can run `python --version`,
and that the output should be Python 3.x.

### Pynvim

Nvim relies on [pynvim](https://github.com/neovim/pynvim) to communicate with plugins that utilize its Python binding.
Pynvim is required by plugins such as [wilder.nvim](https://github.com/gelguy/wilder.nvim).

```
pip install -U pynvim
```

### python-lsp-server

[python-lsp-server (pylsp)](https://github.com/python-lsp/python-lsp-server) is a Python [Language Server](https://microsoft.github.io/language-server-protocol/) for completion, linting, go to definition, etc.

```
pip install 'python-lsp-server[all]' pylsp-mypy pyls-isort
```

Note the executable for pylsp is also named `pylsp`. You need to set its PATH correctly.
If you use pip from Anaconda, the executable path may be something like `$CONDA_ROOT/bin/pylsp`.
For native python, the path for pylsp may be like `$HOME/.local/bin/pylsp`

### Node

We need to install node.js from [here](https://nodejs.org/en/download/).
For Linux, you can use the following script:

```bash
# Ref: https://johnpapa.net/node-and-npm-without-sudo/
wget https://nodejs.org/dist/v14.15.4/node-v14.15.4-linux-x64.tar.xz

mkdir -p $HOME/tools
# extract node to a custom directory, the directory should exist.
tar xvf node-v14.15.4-linux-x64.tar.xz --directory=$HOME/tools
```

Then add the following config to `.bash_profile` or `.zshrc`

```bash
export PATH="$HOME/tools/node-v14.15.4-linux-x64/bin:$PATH"
```

Source the file:

```bash
source ~/.bash_profile
# source ~/.zshrc
```

### vim-language-server

[vim-language-server](https://github.com/iamcco/vim-language-server) provides completion for vim script. We can install vim-language-server globally:

```bash
npm install -g vim-language-server
```

vim-language-server is installed in the same directory as the node executable.

### Git

Git is required by plugin manager [packer.nvim](https://github.com/wbthomason/packer.nvim) and other git-related plugins.

For Linux and macOS, Git is usually pre-installed.
The version of Git on the Linux system may be too old so that plugins may break.
Check [here](https://jdhao.github.io/2021/03/27/upgrade_git_on_linux/) on how to install and set up the latest version of Git.
For Windows, install [Git for Windows](https://git-scm.com/download/win) and make sure you can run `git` from command line.

### ctags

In order to use tags related plugins such as [vista.vim](https://github.com/liuchengxu/vista.vim), we need to install a ctags distribution.
Universal-ctags is preferred.

To install it on Linux, we need to build it from source. See [here](https://askubuntu.com/a/836521/768311) for the details.
To install ctags on macOS, use [Homebrew](https://github.com/universal-ctags/homebrew-universal-ctags):

```bash
brew install ctags
```

To install it Windows, use [chocolatey](https://chocolatey.org/) or [scoop](https://scoop.sh/)

```
choco install universal-ctags

# scoop bucket add extras
# scoop install universal-ctags
```

Set its PATH properly and make sure you can run `ctags` from command line.

### Ripgrep

[Ripgrep](https://github.com/BurntSushi/ripgrep), aka, `rg`, is a fast grepping tool available for both Linux, Windows and macOS.
It is used by several searching plugins.

For Windows and macOS, we can install it via chocolatey and homebrew respectively.
For Linux, we can download the [binary release](https://github.com/BurntSushi/ripgrep/releases) and install it.

Set its PATH properly and make sure you can run `rg` from command line.

### Linters

A linter is a tool to check the source code for possible style and syntax issues.
Based on the programming languages we use, we may need to install various linters.

+ Python: [pylint](https://github.com/PyCQA/pylint) and [flake8](https://github.com/PyCQA/flake8).
+ Vim script: [vint](https://github.com/Kuniwak/vint).

Set their PATH properly and make sure you can run `pylint`, `flake8` and `vint` from command line.

## Install Nvim

There are various ways to install Nvim depending on your system.
This config is only maintained for [the latest nvim stable release](https://github.com/neovim/neovim/releases/tag/stable).

### Linux

You can directly download the binary release from [here](https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz).
You can also use the system package manager to install nvim,
but that is not reliable since the latest version may not be available.

### Windows

You may download from [nvim release](https://github.com/neovim/neovim/releases/download/stable/nvim-win64.zip) from GitHub and manually extract it.

Another way to install Nvim on Windows is via chocolatey or scoop:

```
choco install neovim

# via scoop
# scoop bucket add versions
# scoop install neovim
```

### macOS

It is recommended to install neovim via [Homebrew](https://brew.sh/) on macOS. Simply run the following command:

```bash
brew install neovim
```

After installing Nvim, we need to set the path to nvim correctly.
**Make sure that you can run `nvim` from the command line after all these setups**.

## Setting up Nvim

After installing nvim and all the dependencies, we will install plugin managers and set up this config.

### Install plugin manager packer.nvim

I use packer.nvim to manage my plugins. We need to install packer.nvim on our system first.

For Windows, if curl is installed, run the following command (on PowerShell):

```
git clone --depth=1 https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\opt\packer.nvim"
```

For macOS and Linux, run the following command:

```bash
git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
```

### How to install this configuration

On Linux and macOS, the directory is `~/.config/nvim`.
On Windows, the config directory is `$HOME/AppData/Local/nvim`[^1].
First, we need to remove all the files under the config directory (including dot files),
then go to this directory, and run the following command:

```
git clone --depth=1 https://github.com/jdhao/nvim-config.git .
```

After that, when we first open nvim, run command `:PackerSync` to install all the plugins.
Since I use quite a lot of plugins (more than 60), it may take some time to install all of them.

[^1]: Use `echo %userprofile%` to see where your `$HOME` is.
