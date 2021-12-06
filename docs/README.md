# Pre-requisite

There are a few dependencies if we want to use Nvim for efficient editing and
development work.

## Python

A lot of Nvim plugins are mainly written in Python. To use auto-completion and
other features, we must install Python 3. The easiest way to install is via
[Anaconda](https://www.anaconda.com/distribution/#download-section) or [Miniconda](https://docs.conda.io/en/latest/miniconda.html). Make sure that
you can run `python --version`, and that the output should be Python 3.x.

## Pynvim

Nvim relies on [pynvim](https://github.com/neovim/pynvim) to communicate with
plugins that utilize its Python binding. Pynvim is required by plugins such as
[Semshi](https://github.com/numirias/semshi).

```
pip install -U pynvim
```

## python-lsp-server

[python-lsp-server](https://github.com/python-lsp/python-lsp-server) is the community-fork of [pyls](https://github.com/palantir/python-language-server), and it is a Python Language Server for completion,
linting, go to definition, etc.

```
pip install 'python-lsp-server[all]' pylsp-mypy pyls-isort
```

## Node

We need to install node.js from [here](https://nodejs.org/en/download/):

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

## vim-language-server

[vim-language-server](https://github.com/iamcco/vim-language-server) provides
completion for vim script. We can install vim-language-server globally and set
its path:

```bash
npm install -g vim-language-server

export PATH="$HOME/.npm-packages/bin:$PATH"
```

## Git

Git is used by the plugin manager [packer.nvim](https://github.com/wbthomason/packer.nvim) to clone plugins from GitHub or
other Git repositories.

Since Git is usually pre-installed on Linux and macOS, we do not need to worry
if we are on these two platforms. For Windows, install [Git for Windows](https://git-scm.com/download/win)
and make sure you can call `git` from the command line.

## ctags

In order to use tags related plugins such as [vista.vim](https://github.com/liuchengxu/vista.vim), we need to
install a ctags distribution. Universal-ctags is preferred.

To install ctags on macOS, use [Homebrew](https://github.com/universal-ctags/homebrew-universal-ctags):

```bash
brew install ctags
```

To install it Windows, use [chocolatey](https://chocolatey.org/) or [scoop](https://scoop.sh/)

```
choco install universal-ctags

# scoop bucket add extras
# scoop install univeral-ctags
```

To install it on Linux, we need to build it from source. See [here](https://askubuntu.com/a/836521/768311)
for the details.

Set its PATH properly and make sure you can call `ctags` from command line.

## Ripgrep

[Ripgrep](https://github.com/BurntSushi/ripgrep), aka, `rg`, is a fast grepping
tool available for both Linux, Windows and macOS. It is used by several
searching plugins.

For Windows and macOS, we can install it via chocolatey and homebrew
respectively. For Linux, we can download the executable file from its [release
page](https://github.com/BurntSushi/ripgrep/releases) and install it.

## Linters

A linter is a tool to check the source code for possible style and syntax
issues. Based on the programming languages we use, we may need to install
various linters.

+ Python: [pylint](https://github.com/PyCQA/pylint) and [flake8](https://github.com/PyCQA/flake8).
+ Vim script: [vint](https://github.com/Kuniwak/vint).

## Terminal emulators

Which [terminal emulator](https://en.wikipedia.org/wiki/Terminal_emulator) we
choose to use greatly affects the appearance and functionalities of Nvim.
Since Nvim supports true colors, terminals that support true colors are
preferred. For a list of terminals that support true colors, see [here](https://github.com/termstandard/colors).

For macOS, we can use [kitty](https://sw.kovidgoyal.net/kitty/), [iterm2](https://www.iterm2.com/), or [Alacritty](https://github.com/jwilm/alacritty).
If you connect to Linux server on Windows, I recommend [wsltty](https://github.com/mintty/wsltty) and
[Cygwin](https://www.cygwin.com/), both of them use [mintty](https://github.com/mintty/mintty) as the terminal emulator.

For the latest version of Windows 10, you can also try the new [Windows
Terminal](https://github.com/microsoft/terminal).

## Font

Since statusline or file explorer plugins often use Unicode symbols not
available in normal font, we need to install a patched font from the [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) project.

# Install Nvim

There are various ways to install Nvim depending on your system. Current
configuration is tested against nvim v0.6.0.

## Linux

We can directly download the binary release from [here](https://github.com/neovim/neovim/releases/download/v0.6.0/nvim-linux64.tar.gz).

## Windows

The easiest way to install Nvim on Windows is via chocolatey:

```
choco install neovim
```

You may download from [nvim release](https://github.com/neovim/neovim/releases/download/v0.6.0/nvim-win64.zip) from GitHub and manually extract it.

## macOS

It is recommended to install neovim via [Homebrew](https://brew.sh/) on macOS.
Simply run the following command:

```bash
brew install neovim
```

After installing Nvim, we need to add the directory where the Nvim executable
(`nvim` on Linux and macOS, `nvim.exe` on Windows) resides to the system `PATH`.

Make sure that you can call `nvim` from the command line after all these
setups.

# Setting up Nvim

## Install plugin manager packer.nvim

I use packer.nvim to manage my plugins. We need to install packer.nvim on our
system first.

For Windows, if curl is installed, use the following command (on PowerShell):

```
git clone --depth=1 https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\opt\packer.nvim"
```

For macOS and Linux, use the following command:

```bash
git clone --depth=1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/opt/packer.nvim
```

## How to install this configuration

On Windows, the config directory is `$HOME/AppData/Local/nvim`[^1]. On Linux
and macOS, the directory is `~/.config/nvim`. First, we need to remove all the
files under the config directory (including dot files), then go to this
directory, and run the following command to install this configuration:

```
git clone --depth=1 https://github.com/jdhao/nvim-config.git .
```

After that, when we first open nvim, run command `:PackerSync` to install all
the plugins and generate `packer_compiled.lua`. Since I use quite a lot of
plugins (more than 60), it may take some time to install all of them, depending
on your network condition.

# Automatic installation

## Automatic Installation for Linux #

To set up a workable Nvim environment on Linux, I use [this bash script](nvim_setup_linux.sh) to automatically install necessary
dependencies, Nvim itself and Nvim configs in this repo.

Note that the variable `PYTHON_INSTALLED`, `SYSTEM_PYTHON` and
`ADD_TO_SYSTEM_PATH` in the script should be set properly based on your
environment.

## Automatic installation for Windows

Run script [nvim_setup_windows.ps1](nvim_setup_windows.ps1) under PowerShell.

[^1]: Use `echo %userprofile%` to see where your `$HOME` is.
