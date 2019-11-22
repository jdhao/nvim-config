![](images/demo_look.jpg)

# Introduction

This is my Neovim configuration for all the platforms I use (Linux, Windows and
MacOS). `init.vim` is the config file for terminal Neovim, and `ginit.vim` is
the additional config file for GUI client of Neovim (I am using
[neovim-qt](https://github.com/equalsraf/neovim-qt) for now on Windows).

My configurations are heavily documented to make it as clear as possible. While
you can download the whole configuration and replace yours, it is not
recommended to do so. Good configurations are personal. Everyone should have
his or her unique configuration. You are encouraged to copy from this
configuration the part you feel useful and add it to your own configuration.

See [this wiki page](https://github.com/jdhao/nvim-config/wiki/Nvim-setup-in-Linux) on
how to install Nvim dependencies as well as nvim on Linux environment.

## Features ##

+ Auto-completion for Python via [Deoplete](https://github.com/Shougo/deoplete.nvim).
+ Source code linting via [Neomake](https://github.com/neomake/neomake).
+ Beautiful status line via [vim-airline](https://github.com/vim-airline/vim-airline).
+ Powerful sidebar via [Nerdtree](https://github.com/scrooloose/nerdtree).
+ Tags navigation via [tagbar](https://github.com/majutsushi/tagbar).
+ Fast buffer jump via [vim-sneak](https://github.com/justinmk/vim-sneak).
+ Open a file in current project quickly via [LeaderF](https://github.com/Yggdroot/LeaderF).
+ ......

# Pre-requisite

There are a few requirements if you want to use Neovim for efficient editing.

## Python

To use auto-completion and other features, you must install Python 3. The
easiest way to install Python 3 is via
[Anaconda](https://www.anaconda.com/distribution/#download-section). Make sure
that the output of `python --version` shows that Python 3.x is installed.

## Pynvim

Neovim relies on [pynvim](https://github.com/neovim/pynvim) to communicate with
plugins which utilizes its Python binding. Pynvim is required by plugin such as
Deoplete.

## Jedi

For Python code auto-completion to work, you need to install
[Jedi](https://github.com/davidhalter/jedi):

```
pip install jedi
```

## Git

Git is used by plugin manager vim-plug to download plugins from GitHub or
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
[here](https://askubuntu.com/questions/796408/installing-and-using-universal-ctags-instead-of-exuberant-ctags/836521#836521).

Set its PATH properly and make sure you can call `ctags` from command line.

## Ripgrep

Ripgrep is fast grep tool available for both Linux, Windows and Mac. It is used
by several searching plugins.

For Windows and Mac, you can install it via chocolatey and homebrew. For Linux,
you can download from its [release
page](https://github.com/BurntSushi/ripgrep/releases) and install it.

## Linters

A linter is a tool to check your code for possible issues or errors. Based on
your programming languages, you may need to install various linters.

+ Python: [pylint](https://github.com/PyCQA/pylint) and
  [flake8](https://github.com/PyCQA/flake8).
+ Vim script: [vint](https://github.com/Kuniwak/vint) (You may need to install
  the pre-release versions because of [this issue](https://github.com/Kuniwak/vint/issues/290)).

For other linters, please consult the plugin documentation. For Neomake (which
is the linting plugin I currently use), a list of makers (i.e., linters) for
different languages is listed
[here](https://github.com/neomake/neomake/wiki/Makers).

## Terminal emulators

Which [terminal emulator](https://en.wikipedia.org/wiki/Terminal_emulator) you
are using greatly affects the appearance and functionalities of Neovim. Since
Neovim supports true colors, terminals which support true colors are
recommended. For a list of terminals which support true colors, see
[here](https://github.com/termstandard/colors).

For Mac, you can use [iterm2](https://www.iterm2.com/). If you connect to Linux
server on Windows, I recommend [wsltty](https://github.com/mintty/wsltty) and
[Cygwin](https://www.cygwin.com/), both of them use
[mintty](https://github.com/mintty/mintty) as the terminal emulator.

## Font

Since Vim-airline uses several symbols not available in normal font, you need
to install [fonts here](https://github.com/powerline/fonts) to make vim-airline
look pretty. I am using
[Hack](https://github.com/powerline/fonts/tree/master/Hack), and it looks
great.

# How to Install Neovim

There are various ways to install Neovim based on your system.

## Linux

Follow the official guide and download the appimage from the [release
page](https://github.com/neovim/neovim/releases/nightly).

For some Linux systems, you may not be able to run the appimage. You can
directly download the tar ball from
[here](https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz)
and extract it to run Neovim.

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
release from GitHub and manually extract it.

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

# Nvim settings

# How to install this configuration

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

# Trouble shooting

If you come across an issue, you can first use `:checkhealth` command provided
by `nvim` to trouble-shoot yourself. Please read carefully the messages
provided by health check.

If you still have an issue, you may
[open a new issue](https://github.com/jdhao/nvim-config/issues).

# Further readings

+ [Config nvim on Linux for Python development](https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/)
+ [Nvim config on Windows 10](https://jdhao.github.io/2018/11/15/neovim_configuration_windows/)
+ [Nvim-qt config on Windows 10](https://jdhao.github.io/2019/01/17/nvim_qt_settings_on_windows/)

[^1]: Use `echo %userprofile%` to see where your `$HOME` is.
