# Pre-requisite

There are a few requirements if you want to use Neovim for efficient editing
and development work.

## Python

A lot of Neovim plugins are mainly written in Python. To use auto-completion
and other features, you must install Python 3. The easiest way to install is
via [Anaconda](https://www.anaconda.com/distribution/#download-section). Make
sure that the output of `python --version` on the command line shows that
Python 3.x is installed.

## Pynvim

Neovim relies on [pynvim](https://github.com/neovim/pynvim) to communicate with
plugins which utilizes its Python binding. Pynvim is required by plugin such as
[Deoplete](https://github.com/Shougo/deoplete.nvim).

## Jedi

For Python code auto-completion to work, you need to install
[Jedi](https://github.com/davidhalter/jedi):

```
pip install jedi
```

## Git

Git is used by the plugin manager vim-plug to download plugins from GitHub or
other Git repositories.

Since Git is usually pre-installed on Linux and Mac, you do not need to worry
if you are on these two platforms. For Windows, install [Git for
Windows](https://git-scm.com/download/win) and make sure you can call `git`
from the command line.

## ctags

In order to use tags related plugins such as
[tagbar](/github.com/majutsushi/tagbar) and
[gutentags](https://github.com/ludovicchabant/vim-gutentags), you need to
install a ctags distribution. Universal ctags is preferred.

To install ctags on Mac, [use Homebrew](https://github.com/universal-ctags/homebrew-universal-ctags).
To install it Windows, [use chocolatey](https://chocolatey.org/packages/universal-ctags):

```
choco install universal-ctags
```

To install it on Linux, you need to build it yourself. See
[here](https://askubuntu.com/questions/796408/installing-and-using-universal-ctags-instead-of-exuberant-ctags/836521#836521)
for the details.

Set its PATH properly and make sure you can call `ctags` from command line.

## Ripgrep

[Ripgrep](https://github.com/BurntSushi/ripgrep), aka, rg, is fast grep tool
available for both Linux, Windows and Mac. It is used by several searching
plugins.

For Windows and Mac, you can install it via chocolatey and homebrew
respectively. For Linux, you can download the executable file from its [release
page](https://github.com/BurntSushi/ripgrep/releases) and install it.

## Linters

A linter is a tool to check your code for possible style issues or errors.
Based on your programming languages, you may need to install various linters.

+ Python: [pylint](https://github.com/PyCQA/pylint) and [flake8](https://github.com/PyCQA/flake8).
+ Vim script: [vint](https://github.com/Kuniwak/vint) (You may need to install
  the pre-release versions because of [this issue](https://github.com/Kuniwak/vint/issues/290)).

For other linters, please consult the plugin documentation. For Neomake (which
is the linting plugin I currently use), a list of makers (i.e., linters) for
different languages is listed
[here](https://github.com/neomake/neomake/wiki/Makers).

## Terminal emulators

Which [terminal emulator](https://en.wikipedia.org/wiki/Terminal_emulator) you
choose to use greatly affects the appearance and functionalities of Neovim.
Since Neovim supports true colors, terminals which support true colors are
preferred. For a list of terminals which support true colors, see
[here](https://github.com/termstandard/colors).

For Mac, you can use [iterm2](https://www.iterm2.com/),
[kitty](https://sw.kovidgoyal.net/kitty/) or
[Alacritty](https://github.com/jwilm/alacritty). If you connect to Linux server
on Windows, I recommend [wsltty](https://github.com/mintty/wsltty) and
[Cygwin](https://www.cygwin.com/), both of them use
[mintty](https://github.com/mintty/mintty) as the terminal emulator.

## Font

Since Vim-airline uses several symbols not available in normal font, you need
to install [fonts here](https://github.com/powerline/fonts) to make vim-airline
look pretty. I am using
[Hack](https://github.com/powerline/fonts/tree/master/Hack), and it looks
great. Another great resource for programming font is the
[nerd-font](https://github.com/ryanoasis/nerd-fonts) project.

# Install Neovim

There are various ways to install Neovim based on your system.

## Linux

Follow the official guide and download the appimage from the [release
page](https://github.com/neovim/neovim/releases/nightly).

For some Linux systems, you may not be able to run the appimage. You can
directly download the binary release from
[here](https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz) and extract it to run Neovim.

## Windows

The easiest way to install Neovim on Windows is via
[chocolatey](https://chocolatey.org/install). First, install chocolatey. Then
you can install neovim easily with

```
# install latest version of neovim
# choco install neovim --pre

choco install neovim
```

The Neovim that chocolatey installs may not the latest version. To keep
up-to-date with the latest features of Neovim, you may download the latest
[binary release](https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip)
from GitHub and manually extract it.

## Mac

It is recommended to install neovim via [Homebrew](https://brew.sh/) on MacOS.
Simply run the following command:

```
brew install neovim
# If you want to install latest version of neovim, use the following command
# instead.
# brew install --HEAD neovim
```

After installing Neovim, you may need to add the directory where the Neovim
executable (`nvim` on Linux and Mac, `nvim.exe` on Windows) resides to your
system `PATH`.

Make sure that you can call `nvim` from the command line after all these setup.

# Setting up Nvim

## How to install this configuration

On Windows, the config directory is `$HOME/AppData/Local/nvim`[^1]. On Linux
and Mac, the directory is `~/.config/nvim`. First, you need to remove all the
files under the config directory (including dot files), then use the following
command to install this configuration:

```
git clone https://github.com/jdhao/nvim-config.git .
```

After that, when you first open nvim, all the plugins included in this
configuration will be installed automatically for you. Since I use quite a lot
of plugins (around 60 plugins), it may take some time to install all of them,
depending on your network connection speed.

# Automatic Installation #

To set up a workable Neovim environment in Linux, I use the script
[`Nvim_setup.sh`](Nvim_setup.sh) to automatically install necessary
dependencies, Neovim itself and Nvim configs in this repo.

Note that the variable `PYTHON_INSTALLED`, `SYSTEM_PYTHON` and
`ADD_TO_SYSTEM_PATH` in the script should be set properly based on your
environment.
